# Environment
variable "env" {
  type    = string
  default = "Production"
}

# Region
variable "region" {
  type = string
}

# Type
variable "type" {
  type    = string
  default = "Prod"
}

# Customer name
variable "projectName" {
  type = string
}

# Key 
variable "keyName" {
  type    = string
  default = "Demo-key"
}

# Instance type for Indexers
variable "nodeInstanceType" {
  type = string
}

# Desire capacity for Indexers
variable "nodeDesiredCapacity" {
  type = number
}

# Indexers Volume Size
variable "nodeVolumeSize" {
  type = string
}

variable "cpuUsageAlarmPeriod" {
  type    = string
  default = "300"
}

variable "cpuUsageAlarmThreshold" {
  type    = string
  default = "80"
}

variable "statusFailedAlarmPeriod" {
  type    = string
  default = "60"
}

variable "statusFailedAlarmThreshold" {
  type    = string
  default = "1"
}

variable "memoryUtilizationTimePeriod" {
  type    = string
  default = "60"
}

variable "memoryUtilizationTimeThreshold" {
  type    = string
  default = "80"
}

variable "highCpuUtilizationPeriod" {
  type    = string
  default = "60"
}

variable "highCpuUtilizationThreshold" {
  type    = string
  default = "80"
}

variable "lowCpuUtilizationPeriod" {
  type    = string
  default = "300"
}

variable "lowCpuUtilizationThreshold" {
  type    = string
  default = "0"
}

variable "lowCpuCreditBalancePeriod" {
  type    = string
  default = "300"
}

variable "lowCpuCreditBalanceThroshold" {
  type    = string
  default = "0"
}
# SSH Access
variable "sshAccess" {
  type = list(string)
}

# UI Access
variable "uiAccess" {
  type = list(string)
}
