# ALB DNS Name
output "applicationLoadBalancerDNSName" {
  value = aws_lb.applicationLoadBalancer.dns_name
}

# ALB ID
output "albID" {
  value = aws_lb.applicationLoadBalancer.id
}

# ALB ARN
output "albARN" {
  value = aws_lb.applicationLoadBalancer.arn
}

# Target Group ARN
output "targetGroupARN" {
  value = aws_lb_target_group.albTargetGroup.arn
}