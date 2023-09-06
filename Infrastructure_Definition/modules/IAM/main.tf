# Creating IAM Admin Policy
resource "aws_iam_policy" "adminPolicy" {
  name        = "AdminPolicy"
  description = "Administrative access for all services"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

# Creating IAM Admin Role
resource "aws_iam_role" "adminRole" {
  name               = "admin-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Policy attachment 
resource "aws_iam_role_policy_attachment" "adminAttachment" {
  role       = aws_iam_role.adminRole.name
  policy_arn = aws_iam_policy.adminPolicy.arn
}

# Attach role to instance profile 
resource "aws_iam_instance_profile" "adminInstanceProfile" {
  name = "admin-instance-profile"
  role = aws_iam_role.adminRole.name
}