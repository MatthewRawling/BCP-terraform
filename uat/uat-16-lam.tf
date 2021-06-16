
data "archive_file" "uat_log_exporter" {
  type        = "zip"
  source_file = "${path.module}/lambda/cloudwatch-to-s3.py"
  output_path = "${path.module}/lambda/tmp/cloudwatch-to-s3.zip"
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
  number  = false
}

resource "aws_iam_role" "uat_log_exporter" {
  name = "uat-log-exporter-${random_string.random.result}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "uat_log_exporter" {
  name = "uat-log-exporter-${random_string.random.result}"
  role = aws_iam_role.uat_log_exporter.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateExportTask",
        "logs:Describe*",
        "logs:ListTagsLogGroup",
        "ssm:DescribeParameters",
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:GetParametersByPath",
        "ssm:PutParameter",
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "uat_log_exporter" {
  filename         = data.archive_file.uat_log_exporter.output_path
  function_name    = "uat-log-exporter-${random_string.random.result}"
  role             = aws_iam_role.uat_log_exporter.arn
  handler          = "cloudwatch-to-s3.lambda_handler"
  source_code_hash = data.archive_file.uat_log_exporter.output_base64sha256
  timeout          = 300

  runtime = "python3.8"

  environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.uat-bcp-cloudwatch.bucket
    }
  }
}

resource "aws_cloudwatch_event_rule" "uat_log_exporter" {
  name                = "uat-log-exporter-${random_string.random.result}"
  description         = "periodically sends UAT cloudwatch log groups to S3"
  schedule_expression = "rate(4 hours)"
}

resource "aws_cloudwatch_event_target" "uat_log_exporter" {
  rule      = aws_cloudwatch_event_rule.uat_log_exporter.name
  target_id = "uat-log-exporter-${random_string.random.result}"
  arn       = aws_lambda_function.uat_log_exporter.arn
}

resource "aws_lambda_permission" "dev_log_exporter" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.uat_log_exporter.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.uat_log_exporter.arn
}
