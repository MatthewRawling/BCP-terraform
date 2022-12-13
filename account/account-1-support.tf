# Setup block

provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}

resource "aws_ebs_encryption_by_default" "dev-encryption" {
  enabled = true
}

terraform {
   required_providers {    
    aws = {
         source = "hashicorp/aws"
         version =  "~> 3.74.2"
    }
    consul = {
      source = "hashicorp/consul"
    }
  }
  required_version = ">= 0.13"
}

################################################## Account level settings #################################################

resource "aws_iam_account_password_policy" "strict" {
  allow_users_to_change_password = true
  max_password_age               = 90
  minimum_password_length        = 14
  password_reuse_prevention      = 24
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
}

# IAM setup

resource "aws_iam_role" "sns_success_feedback" {
  name = "SNSSuccessFeedback"
  path = "/service-role/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "sns_failure_feedback" {
  name = "SNSFailureFeedback"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "sns_success_cloudwatch" {
  name = "default"
  role = aws_iam_role.sns_success_feedback.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "sns_failure_cloudwatch" {
  name = "default"
  role = aws_iam_role.sns_failure_feedback.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

###########################################################################################################################

##################################################### Support Account ###################################################

resource "aws_iam_user" "support_user" {
  name = "support-user"
#  path = "/system/"
}

######################################################## Support group ####################################################

resource "aws_iam_group" "aws_support_group" {
  name = "AWSSupportAccessGroup"
}

data "aws_iam_policy_document" "support_assume_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.support_user.arn]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "support" {
  name               = "AwsSupportRole"
  assume_role_policy = data.aws_iam_policy_document.support_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "support_policy" {
  role       = aws_iam_role.support.id
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
}

resource "aws_iam_group_membership" "support-group-members" {
  name = "support-user-group-members"

  users = [
    aws_iam_user.support_user.name,
  ]

  group = aws_iam_group.aws_support_group.name
}

resource "aws_iam_group_policy_attachment" "deploy_policy_support_attachment" {
  group      = aws_iam_group.aws_support_group.name
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
}



###########################################################################################################################
