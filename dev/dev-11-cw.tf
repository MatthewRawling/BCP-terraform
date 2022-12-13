## add DEV topic and subscription

resource "aws_sns_topic" "dev-cloudwatch-alerts" {
  name = "DEV-CloudWatch-Alerts"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "dev_sns_subsctiption" {
  topic_arn = aws_sns_topic.dev-cloudwatch-alerts.arn
  protocol  = "email"
  endpoint  = "m.rawling@outlook.com"
}

# Create DEV CW alarm to scale up application
resource "aws_cloudwatch_metric_alarm" "dev-app-cpu-high" {
    count = "1"
    alarm_name = "dev-app-cpu-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    #evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = var.dev-cw-threshold
    datapoints_to_alarm       = var.dev-cw-data
    evaluation_periods        = var.dev-cw-eval
    alarm_description = "This metric monitors ec2 cpu for high utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.dev-app-scale-up[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.DEV-APP-ASG[count.index].name}"
    }
}

# Create DEV CW alarm to scale down application
resource "aws_cloudwatch_metric_alarm" "dev-app-cpu-low" {
    count = "1"
    alarm_name = "dev-app-cpu-low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 cpu for low utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.dev-app-scale-down[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.DEV-APP-ASG[count.index].name}"
    }
}

# Create DEV CW alarm to scale up mapping
resource "aws_cloudwatch_metric_alarm" "dev-map-cpu-high" {
    count = "1"
    alarm_name = "dev-map-cpu-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    #evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = var.dev-cw-threshold
    datapoints_to_alarm       = var.dev-cw-data
    evaluation_periods        = var.dev-cw-eval
    alarm_description = "This metric monitors ec2 cpu for high utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.dev-map-scale-up[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.DEV-MAP-ASG[count.index].name}"
    }
}

# Create DEV CW alarm to scale down mapping
resource "aws_cloudwatch_metric_alarm" "dev-map-cpu-low" {
    count = "1"
    alarm_name = "dev-map-cpu-low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 cpu for low utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.dev-map-scale-down[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.DEV-MAP-ASG[count.index].name}"
    }
}

# Create DEV CW alarm to alert on low RDS storage
resource "aws_cloudwatch_metric_alarm" "dev-rds-storage" {
  alarm_name = "dev-rds-low-storage"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "FreeStorageSpace"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "10"
  alarm_description = "Alarm at less than 10GB free storage "
  alarm_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn] 
dimensions = {
        DBInstanceIdentifier = aws_db_instance.dev-bcp-db.id
      }
}

# Create DEV CW alarm to alert on high RDS CPU
resource "aws_cloudwatch_metric_alarm" "dev-rds-cpu" {
  alarm_name = "dev-rds-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/RDS"
  period = "120"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "50"
  alarm_description = "Alarm at more than 50% CPU"
  alarm_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.dev-bcp-db.id
      }
}

# Create DEV CW alarm to alert on high RDS queue
resource "aws_cloudwatch_metric_alarm" "dev-rds-queue" {
  alarm_name = "dev-rds-high-queue"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "DiskQueueDepth"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "20"
  alarm_description = "Alarm at more 20 queue"
  alarm_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.dev-bcp-db.id
      }
}

# Create DEV CW alarm to alert on high RDS write latency
resource "aws_cloudwatch_metric_alarm" "dev-rds-latency" {
  alarm_name = "dev-rds-high-latency"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "WriteLatency"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "10"
  alarm_description = "Alarm at more 10 latency"
  alarm_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.dev-bcp-db.id
      }
}

# Create DEV CW alarm to alert on low freeable memory
resource "aws_cloudwatch_metric_alarm" "dev-rds-freemem" {
  alarm_name = "dev-rds-low-freemem"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "FreeableMemory"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "1000"
  alarm_description = "Alarm at less than 1000MB freeable"
  alarm_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.dev-bcp-db.id
      }
}

# Create DEV CW alarm to alert on high database connections
resource "aws_cloudwatch_metric_alarm" "dev-rds-connections" {
  alarm_name = "dev-rds-high-connections"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "DatabaseConnections"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "25"
  alarm_description = "Alarm at more than 25 concurrent connections"
  alarm_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.dev-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.dev-bcp-db.id
      }
}

#create drupal log groups
resource "aws_cloudwatch_log_group" "dev-apache" {
  name = "DevApacheLogGroup"
  retention_in_days = "0"
}

resource "aws_cloudwatch_log_group" "dev-drupal" {
  name = "DevDrupalLogGroup"
  retention_in_days = "0"
}

resource "aws_cloudwatch_log_group" "dev-geoserver" {
  name = "DevGeoserverLogGroup"
  retention_in_days = "0"
}

resource "aws_cloudwatch_log_group" "dev-vpclogs" {
  name = "DevVPCLogGroup"
  retention_in_days = "0"
}

