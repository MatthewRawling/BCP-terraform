# add UAT topic and subscription

resource "aws_sns_topic" "uat-cloudwatch-alerts" {
  name = "UAT-CloudWatch-Alerts"
}

resource "aws_sns_topic_subscription" "uat_sns_subsctiption" {
  topic_arn = aws_sns_topic.uat-cloudwatch-alerts.arn
  protocol  = "email"
  endpoint  = "m.rawling@outlook.com"
}

# Create UAT CW alarm to scale up application
resource "aws_cloudwatch_metric_alarm" "uat-app-cpu-high" {
    count = "1"
    alarm_name = "uat-app-cpu-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    #evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = var.uat-cw-threshold
    datapoints_to_alarm       = var.uat-cw-data
    evaluation_periods        = var.uat-cw-eval
    alarm_description = "This metric monitors ec2 cpu for high utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.uat-app-scale-up[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.UAT-APP-ASG[count.index].name}"
    }
}

# Create UAT CW alarm to scale down application
resource "aws_cloudwatch_metric_alarm" "uat-app-cpu-low" {
    count = "1"
    alarm_name = "uat-app-cpu-low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 cpu for low utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.uat-app-scale-down[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.UAT-APP-ASG[count.index].name}"
    }
}

# Create UAT CW alarm to scale up mapping
resource "aws_cloudwatch_metric_alarm" "uat-map-cpu-high" {
    count = "1"
    alarm_name = "uat-map-cpu-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    #evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = var.uat-cw-threshold
    datapoints_to_alarm       = var.uat-cw-data
    evaluation_periods        = var.uat-cw-eval
    alarm_description = "This metric monitors ec2 cpu for high utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.uat-map-scale-up[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.UAT-MAP-ASG[count.index].name}"
    }
}

# Create UAT CW alarm to scale down mapping
resource "aws_cloudwatch_metric_alarm" "uat-map-cpu-low" {
    count = "1"
    alarm_name = "uat-map-cpu-low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 cpu for low utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.uat-map-scale-down[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.UAT-MAP-ASG[count.index].name}"
    }
}

# Create UAT CW alarm to alert on low RDS storage
resource "aws_cloudwatch_metric_alarm" "uat-rds-storage" {
  alarm_name = "uat-rds-low-storage"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "FreeStorageSpace"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "10"
  alarm_description = "Alarm at less than 10GB free storage "
  alarm_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn] 
dimensions = {
        DBInstanceIdentifier = aws_db_instance.uat-bcp-db.id
      }
}

# Create UAT CW alarm to alert on high RDS CPU
resource "aws_cloudwatch_metric_alarm" "uat-rds-cpu" {
  alarm_name = "uat-rds-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/RDS"
  period = "120"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "50"
  alarm_description = "Alarm at more than 50% CPU"
  alarm_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.uat-bcp-db.id
      }
}

# Create UAT CW alarm to alert on high RDS queue
resource "aws_cloudwatch_metric_alarm" "uat-rds-queue" {
  alarm_name = "uat-rds-high-queue"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "DiskQueueDepth"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "20"
  alarm_description = "Alarm at more 20 queue"
  alarm_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.uat-bcp-db.id
      }
}

# Create UAT CW alarm to alert on high RDS write latency
resource "aws_cloudwatch_metric_alarm" "uat-rds-latency" {
  alarm_name = "uat-rds-high-latency"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "WriteLatency"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "10"
  alarm_description = "Alarm at more 10 latency"
  alarm_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.uat-bcp-db.id
      }
}

# Create UAT CW alarm to alert on low freeable memory
resource "aws_cloudwatch_metric_alarm" "uat-rds-freemem" {
  alarm_name = "uat-rds-low-freemem"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "FreeableMemory"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "1000"
  alarm_description = "Alarm at less than 1000MB freeable"
  alarm_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.uat-bcp-db.id
      }
}

# Create UAT CW alarm to alert on high database connections
resource "aws_cloudwatch_metric_alarm" "uat-rds-connections" {
  alarm_name = "uat-rds-high-connections"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "DatabaseConnections"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "25"
  alarm_description = "Alarm at more than 25 concurrent connections"
  alarm_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.uat-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.uat-bcp-db.id
      }
}

#create drupal log groups
resource "aws_cloudwatch_log_group" "uat-apache" {
  name = "UatApacheLogGroup"
  retention_in_days = "0"
}

resource "aws_cloudwatch_log_group" "uat-drupal" {
  name = "UatDrupalLogGroup"
  retention_in_days = "0"
}

resource "aws_cloudwatch_log_group" "uat-geoserver" {
  name = "UatGeoserverLogGroup"
  retention_in_days = "0"
}


