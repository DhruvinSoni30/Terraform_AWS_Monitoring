# Creating Security Group for the Nodes
resource "aws_security_group" "nodeSecurityGroup" {
  name   = "Node security group"
  vpc_id = var.vpcID

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.sshAccess
  }

  ingress {
    description = "UI access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.uiAccess
  }

  ingress {
    description = "UI access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.uiAccess
  }

  egress {
    description = "outbound access"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.projectName}-node-security-group"
    Env  = var.env
    Type = var.type
  }
}
