# Creating VPC
module "vpc" {
  source      = "./Infrastructure_Definition/modules/VPC"
  env         = var.env
  type        = var.type
  projectName = var.projectName
}

# Creating IAM resources
module "iam" {
  source = "./Infrastructure_Definition/modules/IAM"
}

# Creating Security Groups
module "security-group" {
  source      = "./Infrastructure_Definition/modules/Security-Groups"
  vpcID       = module.vpc.vpcID
  env         = var.env
  type        = var.type
  projectName = var.projectName
  sshAccess   = var.sshAccess
  uiAccess    = var.uiAccess
}

# Creating ALB
module "alb" {
  source            = "./Infrastructure_Definition/modules/ALB"
  env               = var.env
  type              = var.type
  projectName       = var.projectName
  nodeSecurityGroup = module.security-group.nodeSecurityGroupID
  publicSubnetAz1ID = module.vpc.publicSubnetAz1
  publicSubnetAz2ID = module.vpc.publicSubnetAz2
  publicSubnetAz3ID = module.vpc.publicSubnetAz3
  vpcID             = module.vpc.vpcID
}

# Creating ASG
module "asg" {
  source              = "./Infrastructure_Definition/modules/Auto-Scaling"
  env                 = var.env
  type                = var.type
  projectName         = var.projectName
  keyName             = var.keyName
  nodeInstanceType    = var.nodeInstanceType
  publicSubnetAz1ID   = module.vpc.publicSubnetAz1
  publicSubnetAz2ID   = module.vpc.publicSubnetAz2
  publicSubnetAz3ID   = module.vpc.publicSubnetAz3
  nodeDesiredCapacity = var.nodeDesiredCapacity
  targetGroupARN      = module.alb.targetGroupARN
  nodeSecurityGroup   = module.security-group.nodeSecurityGroupID
  nodeVolumeSize      = var.nodeVolumeSize
  instanceProfile     = module.iam.instanceProfile
}

# Creating Key Pair
module "key_pair" {
  source  = "./Infrastructure_Definition/modules/Key-Pair"
  keyName = var.keyName
}

# Creating Cloud Watch Alarms
module "alarms" {
  source                          = "./Infrastructure_Definition/modules/CloudWatch-Alarms"
  instanceCount                   = var.nodeDesiredCapacity
  instancesIds                    = module.asg.instanceIds
  cpuUsageAlarmPeriod             = var.cpuUsageAlarmPeriod
  cpuUsageAlarmThreshold          = var.cpuUsageAlarmThreshold
  statusFailedAlarmPeriod         = var.statusFailedAlarmPeriod
  statusFailedAlarmThreshold      = var.statusFailedAlarmThreshold
  memoryUtilizationTimePeriod     = var.memoryUtilizationTimePeriod
  memoryUtilizationTimeThreshold  = var.memoryUtilizationTimeThreshold
  highCpuUtilizationPeriod        = var.highCpuUtilizationPeriod
  highCpuUtilizationThreshold     = var.highCpuUtilizationThreshold
  lowCpuUtilizationPeriod         = var.lowCpuUtilizationPeriod
  lowCpuUtilizationThreshold      = var.lowCpuUtilizationThreshold
  lowCpuCreditBalancePeriod       = var.lowCpuCreditBalancePeriod
  lowCpuCreditBalanceThroshold    = var.lowCpuCreditBalanceThroshold
  loadBalancerARN                 = module.alb.albARN
  targetGroupARN                  = module.alb.targetGroupARN
  instanceAvailableCountPeriod    = var.instanceAvailableCountPeriod
  instanceAvailableCountThreshold = var.instanceAvailableCountThreshold
  estimatedChargesPeriod          = var.estimatedChargesPeriod
  estimatedChargesThreshold       = var.estimatedChargesThreshold
}

