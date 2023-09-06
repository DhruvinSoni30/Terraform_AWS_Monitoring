# VPC ID
output "vpcID" {
  value = aws_vpc.demoVpc.id
}

# ID of subnet in AZ1 
output "publicSubnetAz1" {
  value = aws_subnet.publicSubnetAz1.id
}

# ID of subnet in AZ2
output "publicSubnetAz2" {
  value = aws_subnet.publicSubnetAz2.id
}

# ID of subnet in AZ3
output "publicSubnetAz3" {
  value = aws_subnet.publicSubnetAz3.id
}

# Internet Gateway ID
output "internetGateway" {
  value = aws_internet_gateway.demoInternetGateway.id
}
