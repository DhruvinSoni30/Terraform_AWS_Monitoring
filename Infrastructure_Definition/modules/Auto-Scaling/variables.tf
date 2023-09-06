# Environment
variable "env" {
  type = string
}

# Type
variable "type" {
  type = string
}

# Key 
variable "keyName" {
  type = string
}

# Instance type for Indexers
variable "nodeInstanceType" {
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

# ID of public subnet in AZ3
variable "publicSubnetAz3ID" {
  type = string
}

# Desire capacity for Indexers
variable "nodeDesiredCapacity" {
  type = number
}

# Stack name
variable "projectName" {
  type = string
}

# Target Group ARN
variable "targetGroupARN" {
  type = string
}

# Search Head Security Group
variable "nodeSecurityGroup" {
  type = string
}

# Indexers Volume Size
variable "nodeVolumeSize" {
  type = string
}

# IAM Instance Profile
variable "instanceProfile" {
  type = string
}
