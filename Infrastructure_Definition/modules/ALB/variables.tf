# Environment
variable "env" {
  type = string
}

# Type
variable "type" {
  type = string
}

# Customer name
variable "projectName" {
  type = string
}

# Security group for ALB
variable "nodeSecurityGroup" {
  type = string
}

# ID of public subnet in AZ1 
variable "publicSubnetAz1ID" {
  type = string
}

# ID of public subnet in AZ2
variable "publicSubnetAz2ID" {
  type = string
}

# ID of pblic subnet in AZ3
variable "publicSubnetAz3ID" {
  type = string
}

# VPC ID
variable "vpcID" {
  type = string
}

# Healthcheck will be done on port 8000
variable "health_check" {
  type = map(string)
  default = {
    "timeout"             = "10"
    "interval"            = "20"
    "path"                = "/"
    "port"                = "8000"
    "unhealthy_threshold" = "2"
    "healthy_threshold"   = "3"
  }
}