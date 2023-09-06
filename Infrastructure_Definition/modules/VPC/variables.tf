# Environment
variable "env" {
  type = string
}

# Type
variable "type" {
  type = string
}

# Stack name
variable "projectName" {
  type = string
}

# Vpc cidr
variable "vpcCIDR" {
  type    = string
  default = "10.0.0.0/16"
}

# CIDR of public subet in AZ1 
variable "publicSubnetAz1CIDR" {
  type    = string
  default = "10.0.1.0/24"
}

# CIDR of public subet in AZ2
variable "publicSubnetAz2CIDR" {
  type    = string
  default = "10.0.2.0/24"
}

# CIDR of public subet in AZ3
variable "publicSubnetAz3CIDR" {
  type    = string
  default = "10.0.3.0/24"
}
