# Node Security Group ID
output "nodeSecurityGroupID" {
  value = aws_security_group.nodeSecurityGroup.id
}
