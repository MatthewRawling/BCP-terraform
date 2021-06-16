data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_elb_service_account" "main" {}
resource "aws_s3_bucket_policy" "s3-dev-bce-policy" {
  bucket = aws_s3_bucket.dev-bce-logs.id

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
            "Resource": "${aws_s3_bucket.dev-bce-logs.arn}/devbce/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.dev-bce-logs.arn}/devbce/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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
            "Resource": "${aws_s3_bucket.dev-bce-logs.arn}"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-dev-bcs-policy" {
  bucket = aws_s3_bucket.dev-bcs-logs.id

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
            "Resource": "${aws_s3_bucket.dev-bcs-logs.arn}/devbcs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.dev-bcs-logs.arn}/devbcs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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
            "Resource": "${aws_s3_bucket.dev-bcs-logs.arn}"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-dev-bcw-policy" {
  bucket = aws_s3_bucket.dev-bcw-logs.id

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
            "Resource": "${aws_s3_bucket.dev-bcw-logs.arn}/devbcw/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.dev-bcw-logs.arn}/devbcw/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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
            "Resource": "${aws_s3_bucket.dev-bcw-logs.arn}"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-dev-cffg-policy" {
  bucket = aws_s3_bucket.dev-cffg-logs.id

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
            "Resource": "${aws_s3_bucket.dev-cffg-logs.arn}/devcffg/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.dev-cffg-logs.arn}/devcffg/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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
            "Resource": "${aws_s3_bucket.dev-cffg-logs.arn}"
        }
    ]
}
POLICY
}

# policy to allow s3 iam user to write to buckets

resource "aws_s3_bucket_policy" "s3-dev-bce-response-policy" {
  bucket = aws_s3_bucket.dev-bce-response.id

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
            "Resource": "arn:aws:s3:::dev-bce-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::dev-bce-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-dev-bce-documents-policy" {
  bucket = aws_s3_bucket.dev-bce-documents.id

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
            "Resource": "arn:aws:s3:::dev-bce-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::dev-bce-documents/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-dev-bcs-response-policy" {
  bucket = aws_s3_bucket.dev-bcs-response.id

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
            "Resource": "arn:aws:s3:::dev-bcs-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::dev-bcs-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-dev-bcs-documents-policy" {
  bucket = aws_s3_bucket.dev-bcs-documents.id

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
            "Resource": "arn:aws:s3:::dev-bcs-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::dev-bcs-documents/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-dev-bcw-response-policy" {
  bucket = aws_s3_bucket.dev-bcw-response.id

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
            "Resource": "arn:aws:s3:::dev-bcw-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::dev-bcw-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-dev-bcw-documents-policy" {
  bucket = aws_s3_bucket.dev-bcw-documents.id

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
            "Resource": "arn:aws:s3:::dev-bcw-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::dev-bcw-documents/*"
        }
    ]
}
POLICY
}

# policy to allow s3 iam user to write to buckets

resource "aws_s3_bucket_policy" "s3-dec-cffg-response-policy" {
  bucket = aws_s3_bucket.dev-cffg-response.id

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
            "Resource": "arn:aws:s3:::dev-cffg-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::dev-cffg-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-dev-cffg-documents-policy" {
  bucket = aws_s3_bucket.dev-cffg-documents.id

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
            "Resource": "arn:aws:s3:::dev-cffg-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::dev-cffg-documents/*"
        }
    ]
}
POLICY
}

