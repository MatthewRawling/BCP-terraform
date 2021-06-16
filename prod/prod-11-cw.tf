# add PROD topic and subscription

resource "aws_sns_topic" "prod-cloudwatch-alerts" {
  name = "PROD-CloudWatch-Alerts"
}

resource "aws_sns_topic_subscription" "prod_sns_subsctiption" {
  topic_arn = aws_sns_topic.prod-cloudwatch-alerts.arn
  protocol  = "email"
  endpoint  = "issupport-co@informed.com"
}

# Create PROD CW alarm to scale up application
resource "aws_cloudwatch_metric_alarm" "prod-app-cpu-high" {
    count = "1"
    alarm_name = "prod-app-cpu-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    #evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = var.prod-cw-threshold
    datapoints_to_alarm       = var.prod-cw-data
    evaluation_periods        = var.prod-cw-eval
    alarm_description = "This metric monitors ec2 cpu for high utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.prod-app-scale-up[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.PROD-APP-ASG[count.index].name}"
    }
}

# Create PROD CW alarm to scale down application
resource "aws_cloudwatch_metric_alarm" "prod-app-cpu-low" {
    count = "1"
    alarm_name = "prod-app-cpu-low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 cpu for low utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.prod-app-scale-down[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.PROD-APP-ASG[count.index].name}"
    }
}

# Create PROD CW alarm to scale up mapping
resource "aws_cloudwatch_metric_alarm" "prod-map-cpu-high" {
    count = "1"
    alarm_name = "prod-map-cpu-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    #evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = var.prod-cw-threshold
    datapoints_to_alarm       = var.prod-cw-data
    evaluation_periods        = var.prod-cw-eval
    alarm_description = "This metric monitors ec2 cpu for high utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.prod-map-scale-up[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.PROD-MAP-ASG[count.index].name}"
    }
}

# Create PROD CW alarm to scale down mapping
resource "aws_cloudwatch_metric_alarm" "prod-map-cpu-low" {
    count = "1"
    alarm_name = "prod-map-cpu-low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 cpu for low utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.prod-map-scale-down[count.index].arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.PROD-MAP-ASG[count.index].name}"
    }
}

# Create PROD CW alarm to alert on low RDS storage
resource "aws_cloudwatch_metric_alarm" "prod-rds-storage" {
  alarm_name = "prod-rds-low-storage"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "FreeStorageSpace"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "10"
  alarm_description = "Alarm at less than 10GB free storage "
  alarm_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn] 
dimensions = {
        DBInstanceIdentifier = aws_db_instance.prod-bcp-db.id
      }
}

# Create PROD CW alarm to alert on high RDS CPU
resource "aws_cloudwatch_metric_alarm" "prod-rds-cpu" {
  alarm_name = "prod-rds-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/RDS"
  period = "120"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "50"
  alarm_description = "Alarm at more than 50% CPU"
  alarm_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.prod-bcp-db.id
      }
}

# Create PROD CW alarm to alert on high RDS queue
resource "aws_cloudwatch_metric_alarm" "prod-rds-queue" {
  alarm_name = "prod-rds-high-queue"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "DiskQueueDepth"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "20"
  alarm_description = "Alarm at more 20 queue"
  alarm_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.prod-bcp-db.id
      }
}

# Create PROD CW alarm to alert on high RDS write latency
resource "aws_cloudwatch_metric_alarm" "prod-rds-latency" {
  alarm_name = "prod-rds-high-latency"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "WriteLatency"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "10"
  alarm_description = "Alarm at more 10 latency"
  alarm_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.prod-bcp-db.id
      }
}

# Create PROD CW alarm to alert on low freeable memory
resource "aws_cloudwatch_metric_alarm" "prod-rds-freemem" {
  alarm_name = "prod-rds-low-freemem"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "FreeableMemory"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "1000"
  alarm_description = "Alarm at less than 1000MB freeable"
  alarm_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.prod-bcp-db.id
      }
}

# Create PROD CW alarm to alert on high database connections
resource "aws_cloudwatch_metric_alarm" "prod-rds-connections" {
  alarm_name = "prod-rds-high-connections"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "DatabaseConnections"
  namespace = "AWS/RDS"
  period = "60"
  statistic = "Average"
  treat_missing_data = "missing"
  threshold = "25"
  alarm_description = "Alarm at more than 25 concurrent connections"
  alarm_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
  ok_actions = [aws_sns_topic.prod-cloudwatch-alerts.arn]
dimensions = {
        DBInstanceIdentifier = aws_db_instance.prod-bcp-db.id
      }
}

#create drupal log groups
resource "aws_cloudwatch_log_group" "prod-apache" {
  name = "ProdApacheLogGroup"
  retention_in_days = "0"
}

resource "aws_cloudwatch_log_group" "prod-drupal" {
  name = "ProdDrupalLogGroup"
  retention_in_days = "0"
}

resource "aws_cloudwatch_log_group" "prod-geoserver" {
  name = "ProdGeoserverLogGroup"
  retention_in_days = "0"
}


