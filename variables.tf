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

# cpuUsageAlarmPeriod
variable "cpuUsageAlarmPeriod" {
  type    = string
  default = "300"
}

# cpuUsageAlarmThreshold
variable "cpuUsageAlarmThreshold" {
  type    = string
  default = "80"
}

# statusFailedAlarmPeriod
variable "statusFailedAlarmPeriod" {
  type    = string
  default = "60"
}

# statusFailedAlarmThreshold
variable "statusFailedAlarmThreshold" {
  type    = string
  default = "1"
}

# memoryUtilizationTimePeriod
variable "memoryUtilizationTimePeriod" {
  type    = string
  default = "60"
}

# memoryUtilizationTimeThreshold
variable "memoryUtilizationTimeThreshold" {
  type    = string
  default = "80"
}

# highCpuUtilizationPeriod
variable "highCpuUtilizationPeriod" {
  type    = string
  default = "60"
}

# highCpuUtilizationThreshold
variable "highCpuUtilizationThreshold" {
  type    = string
  default = "80"
}

# lowCpuUtilizationPeriod
variable "lowCpuUtilizationPeriod" {
  type    = string
  default = "300"
}

# lowCpuUtilizationThreshold
variable "lowCpuUtilizationThreshold" {
  type    = string
  default = "0"
}

# lowCpuCreditBalancePeriod
variable "lowCpuCreditBalancePeriod" {
  type    = string
  default = "300"
}

# lowCpuCreditBalanceThroshold
variable "lowCpuCreditBalanceThroshold" {
  type    = string
  default = "0"
}

# instanceAvailableCountPeriod
variable "instanceAvailableCountPeriod" {
  type    = string
  default = "60"
}

# instanceAvailableCountThreshold
variable "instanceAvailableCountThreshold" {
  type    = string
  default = "0"
}

# estimatedChargesPeriod
variable "estimatedChargesPeriod" {
  type    = string
  default = "86400"
}

# estimatedChargesThreshold
variable "estimatedChargesThreshold" {
  type    = string
  default = "100"
}

# SSH Access
variable "sshAccess" {
  type = list(string)
}

# UI Access
variable "uiAccess" {
  type = list(string)
}
