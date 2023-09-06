# Using Data Source to get all Avalablility Zones in the Region
data "aws_availability_zones" "availableZones" {}

# Fetching Ubuntu 20.04 AMI ID
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Creating Launch Template for Node
resource "aws_launch_template" "nodeCustomLaunchTemplate" {
  name                    = "${var.projectName}-node-config"
  image_id                = data.aws_ami.amazon_linux_2.id
  instance_type           = var.nodeInstanceType
  vpc_security_group_ids  = [var.nodeSecurityGroup]
  key_name                = var.keyName
  update_default_version  = true
  disable_api_termination = true

  monitoring {
    enabled = true
  }

  iam_instance_profile {
    name = var.instanceProfile
  }
}

# Creating Auto Scaling group for IDX
resource "aws_autoscaling_group" "nodeCustomAutoscalingGroup" {
  name                = "${var.projectName}-node-auto-scalling-group"
  vpc_zone_identifier = [var.publicSubnetAz1ID, var.publicSubnetAz2ID, var.publicSubnetAz3ID]
  launch_template {
    id      = aws_launch_template.nodeCustomLaunchTemplate.id
    version = aws_launch_template.nodeCustomLaunchTemplate.latest_version
  }
  max_size          = var.nodeDesiredCapacity
  min_size          = var.nodeDesiredCapacity
  desired_capacity  = var.nodeDesiredCapacity
  target_group_arns = [var.targetGroupARN]

  tag {
    key                 = "role"
    value               = "node"
    propagate_at_launch = true
  }
  tag {
    key                 = var.env
    value               = var.type
    propagate_at_launch = true
  }
}

# DLM Service Policy Document
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["dlm.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# DLM Policy Role
resource "aws_iam_role" "dlm_lifecycle_role" {
  name               = "dlm-lifecycle-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# DLM Lifecycle Policy for creating auto backup of EBS volumes
data "aws_iam_policy_document" "dlm_lifecycle" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateSnapshot",
      "ec2:CreateSnapshots",
      "ec2:DeleteSnapshot",
      "ec2:DescribeInstances",
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateTags"]
    resources = ["arn:aws:ec2:*::snapshot/*"]
  }
}

# IAM role for DLM Lifecycle
resource "aws_iam_role_policy" "dlm_lifecycle" {
  name   = "dlm-lifecycle-policy"
  role   = aws_iam_role.dlm_lifecycle_role.id
  policy = data.aws_iam_policy_document.dlm_lifecycle.json
}

# IAM policy for Snapshot Creation that will remain for 14 days 
resource "aws_dlm_lifecycle_policy" "example" {
  description        = "example DLM lifecycle policy"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = "ENABLED"
  tags = {
    Name = "DLM Policy"
  }

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "2 weeks of daily snapshots"

      create_rule {
        interval      = 24
        interval_unit = "HOURS"
        times         = ["23:45"]
      }

      retain_rule {
        count = 14
      }

      tags_to_add = {
        SnapshotCreator = "DLM"
      }

      copy_tags = false
    }

    target_tags = {
      Snapshot = "true"
    }
  }
}

# Creating EIPs for Nodes
resource "aws_eip" "nodeEIPs" {
  count  = aws_autoscaling_group.nodeCustomAutoscalingGroup.desired_capacity
  domain = "vpc"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "Node-EIP"
  }
}

# Fetching Nodes
data "aws_instances" "nodeInstance" {
  filter {
    name   = "tag:role"
    values = ["node"]
  }

  filter {
    name   = "availability-zone"
    values = [data.aws_availability_zones.availableZones.names[0], data.aws_availability_zones.availableZones.names[1], data.aws_availability_zones.availableZones.names[2]]
  }

  filter {
    name   = "instance-state-name"
    values = ["running", "pending"]
  }
  depends_on = [aws_autoscaling_group.nodeCustomAutoscalingGroup]
}

# Associating EIP to Nodes
resource "aws_eip_association" "nodeEIPAssociation" {
  count               = var.nodeDesiredCapacity
  instance_id         = data.aws_instances.nodeInstance.ids[count.index]
  allocation_id       = aws_eip.nodeEIPs[count.index].id
  allow_reassociation = true
}

# Creating volume for Indexers
resource "aws_ebs_volume" "nodeVolume" {
  count             = var.nodeDesiredCapacity
  availability_zone = data.aws_availability_zones.availableZones.names[count.index]
  size              = var.nodeVolumeSize
  type              = "gp2"
  tags = {
    Snapshot = "true"
    Name     = "Node Volume"
  }
}

# Attaching volume to Indexers
resource "aws_volume_attachment" "ebsNode" {
  count        = var.nodeDesiredCapacity
  device_name  = "/dev/sdf"
  volume_id    = aws_ebs_volume.nodeVolume.*.id[count.index]
  instance_id  = data.aws_instances.nodeInstance.ids[count.index]
  force_detach = true
}