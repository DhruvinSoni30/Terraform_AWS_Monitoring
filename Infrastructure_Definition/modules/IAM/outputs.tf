# IAM Instance Profile 
output "instanceProfile" {
  value = aws_iam_instance_profile.adminInstanceProfile.name
}
