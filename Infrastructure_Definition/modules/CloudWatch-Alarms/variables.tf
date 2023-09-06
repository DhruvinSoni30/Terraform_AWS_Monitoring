# Instance count 
variable "instanceCount" {
  type = string
}

# Instance IDs
variable "instancesIds" {
  type = string
}

# cpuUsageAlarmPeriod
variable "cpuUsageAlarmPeriod" {
  type = string
}

# cpuUsageAlarmThreshold
variable "cpuUsageAlarmThreshold" {
  type = string
}

# statusFailedAlarmPeriod
variable "statusFailedAlarmPeriod" {
  type = string
}

# statusFailedAlarmThreshold
variable "statusFailedAlarmThreshold" {
  type = string
}

# memoryUtilizationTimePeriod
variable "memoryUtilizationTimePeriod" {
  type = string
}

# memoryUtilizationTimeThreshold
variable "memoryUtilizationTimeThreshold" {
  type = string
}

# highCpuUtilizationPeriod
variable "highCpuUtilizationPeriod" {
  type = string
}

# highCpuUtilizationThreshold
variable "highCpuUtilizationThreshold" {
  type = string
}

# lowCpuUtilizationPeriod
variable "lowCpuUtilizationPeriod" {
  type = string
}

# lowCpuUtilizationThreshold
variable "lowCpuUtilizationThreshold" {
  type = string
}

# lowCpuCreditBalancePeriod
variable "lowCpuCreditBalancePeriod" {
  type = string
}

# lowCpuCreditBalanceThroshold
variable "lowCpuCreditBalanceThroshold" {
  type = string
}

# Load Balancer ARN
variable "loadBalancerARN" {
  type = string
}

# Target Group ARN
variable "targetGroupARN" {
  type = string
}

# instanceAvailableCountPeriod
variable "instanceAvailableCountPeriod" {
  type = string
}

# instanceAvailableCountThreshold
variable "instanceAvailableCountThreshold" {
  type = string
}

# estimatedChargesPeriod
variable "estimatedChargesPeriod" {
  type = string
}

# estimatedChargesThreshold
variable "estimatedChargesThreshold" {
  type = string
}