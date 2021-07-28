# DEV Lambda function and role permissions for cloudwatch transfer to S3 
 
data "archive_file" "dev_log_exporter" {
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

resource "aws_iam_role" "dev_log_exporter" {
  name = "dev-log-exporter-${random_string.random.result}"

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

resource "aws_iam_role_policy" "dev_log_exporter" {
  name = "dev-log-exporter-${random_string.random.result}"
  role = aws_iam_role.dev_log_exporter.id

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

resource "aws_lambda_function" "dev_log_exporter" {
  filename         = data.archive_file.dev_log_exporter.output_path
  function_name    = "dev-log-exporter-${random_string.random.result}"
  role             = aws_iam_role.dev_log_exporter.arn
  handler          = "cloudwatch-to-s3.lambda_handler"
  source_code_hash = data.archive_file.dev_log_exporter.output_base64sha256
  timeout          = 300

  runtime = "python3.8"

  environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.dev-bcp-cloudwatch.bucket
    }
  }
}

resource "aws_cloudwatch_event_rule" "dev_log_exporter" {
  name                = "dev-log-exporter-${random_string.random.result}"
  description         = "periodically sends DEV cloudwatch log groups to S3"
  schedule_expression = "rate(4 hours)"
}

resource "aws_cloudwatch_event_target" "dev_log_exporter" {
  rule      = aws_cloudwatch_event_rule.dev_log_exporter.name
  target_id = "dev-log-exporter-${random_string.random.result}"
  arn       = aws_lambda_function.dev_log_exporter.arn
}

resource "aws_lambda_permission" "dev_log_exporter" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dev_log_exporter.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.dev_log_exporter.arn
}

# cf auth

data "archive_file" "bcp-auth" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.js"
  output_path = "${path.module}/lambda/tmp/basic-auth3.zip"
}

resource "aws_iam_role" "bcp-auth" {
  name = "bcp-auth-${random_string.random.result}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
             "lambda.amazonaws.com",
             "edgelambda.amazonaws.com"
          ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "bcp-auth" {
  name = "bcp-auth-${random_string.random.result}"
  role = aws_iam_role.bcp-auth.id

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

resource "aws_lambda_function" "bcp-auth" {
  filename         = data.archive_file.bcp-auth.output_path
  function_name    = "bcp-auth-${random_string.random.result}"
  role             = aws_iam_role.bcp-auth.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.bcp-auth.output_base64sha256
  timeout          = 300

  runtime = "nodejs14.x"

#  environment {
#    variables = {
#      S3_BUCKET = aws_s3_bucket.dev-bcp-cloudwatch.bucket
#    }
#  }
}
