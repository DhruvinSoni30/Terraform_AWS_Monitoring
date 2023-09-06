# VPC ID
variable "vpcID" {
  type = string
}

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

# SSH Access
variable "sshAccess" {
  type = list(string)
}

# UI Access
variable "uiAccess" {
  type = list(string)
}
