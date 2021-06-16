# DEV Key Setup

resource "aws_kms_key" "dev-kms" {
  description              = "Dev-KMS"
  deletion_window_in_days  = 10
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
}

#DEV Bucket Setup

resource "aws_s3_bucket" "dev-bce-test" {
  bucket = "dev-bce-test"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
         sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bce-documents" {
  bucket = "dev-bce-documents"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
         sse_algorithm = "aws:kms"
      }
    }
  }
} 

data "aws_canonical_user_id" "current_user" {}
resource "aws_s3_bucket" "dev-bce-logs" {
  bucket = "dev-bce-logs"
#  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
}
grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
grant {
    type        = "Group"
    permissions = ["FULL_CONTROL"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bce-response" {
  bucket = "dev-bce-response"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bcs-documents" {
  bucket = "dev-bcs-documents"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bcs-logs" {
  bucket = "dev-bcs-logs"
#  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
grant {
    type        = "Group"
    permissions = ["FULL_CONTROL"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bcs-response" {
  bucket = "dev-bcs-response"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bcw-documents" {
  bucket = "dev-bcw-documents"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bcw-logs" {
  bucket = "dev-bcw-logs"
#  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
grant {
    type        = "Group"
    permissions = ["FULL_CONTROL"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bcw-response" {
  bucket = "dev-bcw-response"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-cffg-documents" {
  bucket = "dev-cffg-documents"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-cffg-logs" {
  bucket = "dev-cffg-logs"
#  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
grant {
    type        = "Group"
    permissions = ["FULL_CONTROL"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-cffg-response" {
  bucket = "dev-cffg-response"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# create dev cloudtrail bucket and policy
resource "aws_s3_bucket" "bcp-dev-cloudtrail" {
  bucket        = "bcp-dev-cloudtrail"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::bcp-dev-cloudtrail"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::bcp-dev-cloudtrail/prefix/AWSLogs/${data.aws_caller_identity.current1.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

# Create DEV cloudWatch bucket
resource "aws_s3_bucket" "dev-bcp-cloudwatch" {
  bucket = "dev-bcp-cloudwatch"
  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#general log bucket
resource "aws_s3_bucket" "dev-bcp-logs" {
  bucket = "dev-bcp-logs"
#  acl = "private"
  versioning {
    enabled = true
  }
grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
grant {
  permissions = ["FULL_CONTROL"]
      type        = "Group"
      uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
}
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#block all public access

resource "aws_s3_bucket_public_access_block" "dev-bce-test" {
  bucket = aws_s3_bucket.dev-bce-test.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "dev-bcp-logs" {
  bucket = aws_s3_bucket.dev-bcp-logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "dev-bcp-cloudwatch" {
  bucket = aws_s3_bucket.dev-bcp-cloudwatch.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "bcp-dev-cloudtrail" {
  bucket = aws_s3_bucket.bcp-dev-cloudtrail.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "dev-bce-documents" {
  bucket = aws_s3_bucket.dev-bce-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "dev-bce-response" {
  bucket = aws_s3_bucket.dev-bce-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-bce-logs" {
  bucket = aws_s3_bucket.dev-bce-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-bcs-documents" {
  bucket = aws_s3_bucket.dev-bcs-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "dev-bcs-response" {
  bucket = aws_s3_bucket.dev-bcs-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-bcs-logs" {
  bucket = aws_s3_bucket.dev-bcs-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-bcw-documents" {
  bucket = aws_s3_bucket.dev-bcw-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "dev-bcw-response" {
  bucket = aws_s3_bucket.dev-bcw-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-bcw-logs" {
  bucket = aws_s3_bucket.dev-bcw-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-cffg-documents" {
  bucket = aws_s3_bucket.dev-cffg-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "dev-cffg-response" {
  bucket = aws_s3_bucket.dev-cffg-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-cffg-logs" {
  bucket = aws_s3_bucket.dev-cffg-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-bce-cloudfront-logs" {
  bucket = aws_s3_bucket.dev-bce-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-bcs-cloudfront-logs" {
  bucket = aws_s3_bucket.dev-bcs-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-bcw-cloudfront-logs" {
  bucket = aws_s3_bucket.dev-bcw-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "dev-cffg-cloudfront-logs" {
  bucket = aws_s3_bucket.dev-cffg-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Buckets for CloudFront

resource "aws_s3_bucket" "dev-bce-cloudfront-logs" {
  bucket = "dev-bce-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
grant {
    type        = "Group"
    permissions = ["FULL_CONTROL"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bcs-cloudfront-logs" {
  bucket = "dev-bcs-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
grant {
    type        = "Group"
    permissions = ["FULL_CONTROL"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-bcw-cloudfront-logs" {
  bucket = "dev-bcw-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
grant {
    type        = "Group"
    permissions = ["FULL_CONTROL"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "dev-cffg-cloudfront-logs" {
  bucket = "dev-cffg-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "dev-bcp-logs"
}
  versioning {
    enabled = true
  }
grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
grant {
    type        = "Group"
    permissions = ["FULL_CONTROL"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.dev-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# DEV maintenance bucket

resource "aws_s3_bucket" "dev-bcp-maintenance" {
  bucket = "dev-bcp-maintenance"
  acl = "public-read"
logging {
  target_bucket = "dev-bcp-logs"
}
#  policy = aws_s3_bucket_policy.dev-public-read
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
  versioning {
    enabled = true
  }
force_destroy = true
  lifecycle {
    prevent_destroy = false
  }

#server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
}

resource "aws_s3_bucket_policy" "dev-public-read" {
  bucket = aws_s3_bucket.dev-bcp-maintenance.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.dev-bcp-maintenance.arn,
          "${aws_s3_bucket.dev-bcp-maintenance.arn}/*",
        ]
      },
    ]
  })
}

