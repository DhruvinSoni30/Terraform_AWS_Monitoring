# SNS Topic
resource "aws_sns_topic" "cwAlarmsTopic" {
  name = "tf-cw-alarms-topic"
}

# SNS Subscription
resource "aws_sns_topic_subscription" "alarmSubscription" {
  topic_arn = aws_sns_topic.cwAlarmsTopic.arn
  protocol  = "email"
  endpoint  = "dksoni4530@gmail.com"
}

# CPU usage of instance
resource "aws_cloudwatch_metric_alarm" "cpu-alarms" {
  count               = var.instanceCount
  alarm_name          = "CPU-Alarm-${element(split(",", var.instancesIds), count.index)}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.cpuUsageAlarmPeriod #300
  statistic           = "Average"
  threshold           = var.cpuUsageAlarmThreshold #80
  alarm_description   = "Alarm when CPU usage of instance ${element(split(",", var.instancesIds), count.index)} exceeds ${var.cpuUsageAlarmThreshold} percent for ${var.cpuUsageAlarmPeriod} seconds."
  dimensions = {
    InstanceId = "${element(split(",", var.instancesIds), count.index)}"
  }
  alarm_actions = [aws_sns_topic.cwAlarmsTopic.arn]
}

# Status Failed
resource "aws_cloudwatch_metric_alarm" "status-failed-alarms" {
  count               = var.instanceCount
  alarm_name          = "CheckStatusFailed-Alarm-${element(split(",", var.instancesIds), count.index)}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = var.statusFailedAlarmPeriod #60
  statistic           = "Maximum"
  threshold           = var.statusFailedAlarmThreshold #1
  alarm_description   = "Alarm when the instance ${element(split(",", var.instancesIds), count.index)} doesn't respond for ${(var.statusFailedAlarmPeriod * 2) / 60} minutes."
  dimensions = {
    InstanceId = "${element(split(",", var.instancesIds), count.index)}"
  }
  alarm_actions = [aws_sns_topic.cwAlarmsTopic.arn]
}

# When CPU Utilization >= 80% for more than 300 seconds.
resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization_alarm" {
  count               = var.instanceCount
  alarm_name          = "HighCpuUtilization-Alarm-${element(split(",", var.instancesIds), count.index)}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.highCpuUtilizationPeriod
  statistic           = "Average"
  threshold           = var.highCpuUtilizationThreshold
  alarm_description   = "Alarm when CPU usage of instance ${element(split(",", var.instancesIds), count.index)} exceeds ${var.highCpuUtilizationThreshold} percent for ${var.highCpuUtilizationPeriod} seconds."

  dimensions = {
    InstanceId = "${element(split(",", var.instancesIds), count.index)}"
  }
  alarm_actions = [aws_sns_topic.cwAlarmsTopic.arn]
}

# When CPU Usage is less than 0% (happens when the instance is unavailable/unstable)
resource "aws_cloudwatch_metric_alarm" "low_cpu_utilization_alarm" {
  count               = var.instanceCount
  alarm_name          = "LowCpuUtilization-Alarm-${element(split(",", var.instancesIds), count.index)}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.lowCpuUtilizationPeriod
  statistic           = "Average"
  threshold           = var.lowCpuUtilizationThreshold
  alarm_description   = "Alarm when CPU usage of instance ${element(split(",", var.instancesIds), count.index)} exceeds ${var.lowCpuUtilizationThreshold} percent for ${var.lowCpuUtilizationPeriod} seconds - Instance may be not available."

  dimensions = {
    InstanceId = "${element(split(",", var.instancesIds), count.index)}"
  }
  alarm_actions = [aws_sns_topic.cwAlarmsTopic.arn]
}

# When CPU Credit Balance <= 0 
resource "aws_cloudwatch_metric_alarm" "cpu_credit_alarm" {
  count               = var.instanceCount
  alarm_name          = "LowCpuCreditBalance-Alarm-${element(split(",", var.instancesIds), count.index)}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUCreditBalance"
  namespace           = "AWS/EC2"
  period              = var.lowCpuCreditBalancePeriod
  statistic           = "Minimum"
  threshold           = var.lowCpuCreditBalanceThroshold
  alarm_description   = "Alarm when CPU credit of instance ${element(split(",", var.instancesIds), count.index)} is less than or equal to 0"

  dimensions = {
    InstanceId = "${element(split(",", var.instancesIds), count.index)}"
  }
  alarm_actions = [aws_sns_topic.cwAlarmsTopic.arn]
}

# When Target Group Instance Count goes to 0
resource "aws_cloudwatch_metric_alarm" "instance_count_alarm" {
  count               = var.instanceCount
  alarm_name          = "TargetGroupInstances-Alarm-${element(split(",", var.instancesIds), count.index)}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = var.instanceAvailableCountPeriod
  statistic           = "Maximum"
  threshold           = var.instanceAvailableCountThreshold
  alarm_description   = "Alarm when target group instance count goes to 0"

  dimensions = {
    LoadBalancer = var.loadBalancerARN
    TargetGroup  = var.targetGroupARN
  }
  alarm_actions = [aws_sns_topic.cwAlarmsTopic.arn]
}

# When AWS charges go above $100
resource "aws_cloudwatch_metric_alarm" "estimated_charges_100" {
  alarm_name          = "estimated-charges-100"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = var.estimatedChargesPeriod
  statistic           = "Maximum"
  threshold           = var.estimatedChargesThreshold
  alarm_description   = "Alarm when AWS charges go above $100"
  alarm_actions       = [aws_sns_topic.cwAlarmsTopic.arn]

  dimensions = {
    Currency = "USD"
  }
}
