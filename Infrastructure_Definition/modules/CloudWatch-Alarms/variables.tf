# Instance count 
variable "instanceCount" {
  type = string
}

# Instance IDs
variable "instancesIds" {
  type = string
}

variable "cpuUsageAlarmPeriod" {
  type = string
}

variable "cpuUsageAlarmThreshold" {
  type = string
}

variable "statusFailedAlarmPeriod" {
  type = string
}

variable "statusFailedAlarmThreshold" {
  type = string
}

variable "memoryUtilizationTimePeriod" {
  type = string
}

variable "memoryUtilizationTimeThreshold" {
  type = string
}

variable "highCpuUtilizationPeriod" {
  type = string
}

variable "highCpuUtilizationThreshold" {
  type = string
}

variable "lowCpuUtilizationPeriod" {
  type = string
}

variable "lowCpuUtilizationThreshold" {
  type = string
}

variable "lowCpuCreditBalancePeriod" {
  type = string
}

variable "lowCpuCreditBalanceThroshold" {
  type = string
}