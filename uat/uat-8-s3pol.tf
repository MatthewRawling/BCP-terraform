# policy to allow ALB logs to S3

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_elb_service_account" "main" {}
resource "aws_s3_bucket_policy" "s3-uat-bce-policy" {
  bucket = aws_s3_bucket.uat-bce-logs.id

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
            "Resource": "${aws_s3_bucket.uat-bce-logs.arn}/uatbce/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.uat-bce-logs.arn}/uatbce/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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
            "Resource": "${aws_s3_bucket.uat-bce-logs.arn}"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-bcs-policy" {
  bucket = aws_s3_bucket.uat-bcs-logs.id

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
            "Resource": "${aws_s3_bucket.uat-bcs-logs.arn}/uatbcs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.uat-bcs-logs.arn}/uatbcs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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
            "Resource": "${aws_s3_bucket.uat-bcs-logs.arn}"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-bcw-policy" {
  bucket = aws_s3_bucket.uat-bcw-logs.id

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
            "Resource": "${aws_s3_bucket.uat-bcw-logs.arn}/uatbcw/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.uat-bcw-logs.arn}/uatbcw/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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
            "Resource": "${aws_s3_bucket.uat-bcw-logs.arn}"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-cffg-policy" {
  bucket = aws_s3_bucket.uat-cffg-logs.id

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
            "Resource": "${aws_s3_bucket.uat-cffg-logs.arn}/uatcffg/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.uat-cffg-logs.arn}/uatcffg/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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
            "Resource": "${aws_s3_bucket.uat-cffg-logs.arn}"
        }
    ]
}
POLICY
}


# policy to allow s3 iam user to write to buckets

resource "aws_s3_bucket_policy" "s3-uat-bce-response-policy" {
  bucket = aws_s3_bucket.uat-bce-response.id

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
            "Resource": "arn:aws:s3:::uat-bce-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::uat-bce-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-bce-documents-policy" {
  bucket = aws_s3_bucket.uat-bce-documents.id

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
            "Resource": "arn:aws:s3:::uat-bce-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::uat-bce-documents/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-bcs-response-policy" {
  bucket = aws_s3_bucket.uat-bcs-response.id

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
            "Resource": "arn:aws:s3:::uat-bcs-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::uat-bcs-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-bcs-documents-policy" {
  bucket = aws_s3_bucket.uat-bcs-documents.id

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
            "Resource": "arn:aws:s3:::uat-bcs-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::uat-bcs-documents/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-bcw-response-policy" {
  bucket = aws_s3_bucket.uat-bcw-response.id

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
            "Resource": "arn:aws:s3:::uat-bcw-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::uat-bcw-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-bcw-documents-policy" {
  bucket = aws_s3_bucket.uat-bcw-documents.id

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
            "Resource": "arn:aws:s3:::uat-bcw-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::uat-bcw-documents/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-cffg-response-policy" {
  bucket = aws_s3_bucket.uat-cffg-response.id

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
            "Resource": "arn:aws:s3:::uat-cffg-response"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::uat-cffg-response/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "s3-uat-cffg-documents-policy" {
  bucket = aws_s3_bucket.uat-cffg-documents.id

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
            "Resource": "arn:aws:s3:::uat-cffg-documents"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::975971611990:user/S3USER"
            },
            "Action": ["s3:DeleteObject", "s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::uat-cffg-documents/*"
        }
    ]
}
POLICY
}

#UAT S3 replication role

resource "aws_iam_role" "uat-s3-replication" {
  name = "uat-s3-replication"

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

resource "aws_iam_policy" "uat-s3-replication" {
  name        = "uat-s3-rep-policy"
  description = "UAT S3 Replication Policy"

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

resource "aws_iam_role_policy_attachment" "uat-s3-replication" {
  role       = aws_iam_role.uat-s3-replication.name
  policy_arn = aws_iam_policy.uat-s3-replication.arn
}
