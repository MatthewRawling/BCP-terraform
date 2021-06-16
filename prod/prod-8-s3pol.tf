# policy to allow ALB logs to S3

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_elb_service_account" "main" {}
resource "aws_s3_bucket_policy" "s3-prod-bce-policy" {
  bucket = aws_s3_bucket.prod-bce-logs.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "${data.aws_elb_service_account.main.arn}"
                ]
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.prod-bce-logs.arn}/prodbce/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.prod-bce-logs.arn}/prodbce/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:GetBucketAcl"
            ],
            "Resource": "${aws_s3_bucket.prod-bce-logs.arn}"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-bcs-policy" {
  bucket = aws_s3_bucket.prod-bcs-logs.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "${data.aws_elb_service_account.main.arn}"
                ]
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.prod-bcs-logs.arn}/prodbcs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.prod-bcs-logs.arn}/prodbcs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:GetBucketAcl"
            ],
            "Resource": "${aws_s3_bucket.prod-bcs-logs.arn}"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-bcw-policy" {
  bucket = aws_s3_bucket.prod-bcw-logs.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "${data.aws_elb_service_account.main.arn}"
                ]
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.prod-bcw-logs.arn}/prodbcw/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.prod-bcw-logs.arn}/prodbcw/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:GetBucketAcl"
            ],
            "Resource": "${aws_s3_bucket.prod-bcw-logs.arn}"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-cffg-policy" {
  bucket = aws_s3_bucket.prod-cffg-logs.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "${data.aws_elb_service_account.main.arn}"
                ]
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.prod-cffg-logs.arn}/prodcffg/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.prod-cffg-logs.arn}/prodcffg/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:GetBucketAcl"
            ],
            "Resource": "${aws_s3_bucket.prod-cffg-logs.arn}"
        }
    ]
}
POLICY
}


# policy to allow s3 iam user to write to buckets

resource "aws_s3_bucket_policy" "s3-prod-bce-response-policy" {
  bucket = aws_s3_bucket.prod-bce-response.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::prod-bce-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::prod-bce-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-bce-documents-policy" {
  bucket = aws_s3_bucket.prod-bce-documents.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::prod-bce-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::prod-bce-documents/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-bcs-response-policy" {
  bucket = aws_s3_bucket.prod-bcs-response.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::prod-bcs-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::prod-bcs-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-bcs-documents-policy" {
  bucket = aws_s3_bucket.prod-bcs-documents.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::prod-bcs-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::prod-bcs-documents/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-bcw-response-policy" {
  bucket = aws_s3_bucket.prod-bcw-response.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::prod-bcw-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::prod-bcw-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-bcw-documents-policy" {
  bucket = aws_s3_bucket.prod-bcw-documents.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::prod-bcw-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::prod-bcw-documents/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-cffg-response-policy" {
  bucket = aws_s3_bucket.prod-cffg-response.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::prod-cffg-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::prod-cffg-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-prod-cffg-documents-policy" {
  bucket = aws_s3_bucket.prod-cffg-documents.id

  policy = <<POLICY
{
    "Id": "Policy",
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::prod-cffg-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::prod-cffg-documents/*"
        }
    ]
}
POLICY
}

#PROD S3 replication role

resource "aws_iam_role" "prod-s3-replication" {
  name = "prod-s3-replication"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "prod-s3-replication" {
  name        = "prod-s3-rep-policy"
  description = "PROD S3 Replication Policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "prod-s3-replication" {
  role       = aws_iam_role.prod-s3-replication.name
  policy_arn = aws_iam_policy.prod-s3-replication.arn
}
