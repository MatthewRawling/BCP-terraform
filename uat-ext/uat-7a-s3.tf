# UAT EXT Key Setup

resource "aws_kms_key" "uat-kms-co" {
  description              = "Uat-KMS-co"
  deletion_window_in_days  = 10
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
}

#UAT Bucket Setup

resource "aws_s3_bucket" "uat-bce-test-co" {
  bucket = "uat-bce-test-co"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
         sse_algorithm = "aws:kms"
      }
    }
  }
}

data "aws_canonical_user_id" "current_user" {}
#resource "aws_s3_bucket" "uat-bce-documents-co" {
#  bucket = "uat-bce-documents-co"
#  acl = "private"
#logging {
#  target_bucket = "uat-bcp-logs-co"
#}
#  versioning {
#    enabled = true
#  }
#force_destroy = true
#  lifecycle {
#    prevent_destroy = false
#  }
#server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = aws_kms_key.uat-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#} 

resource "aws_s3_bucket" "uat-bce-logs-co" {
  bucket = "uat-bce-logs-co"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#resource "aws_s3_bucket" "uat-bce-response-co" {
#  bucket = "uat-bce-response-co"
#  acl = "private"
#logging {
#  target_bucket = "uat-bcp-logs-co"
#}
#  versioning {
#    enabled = true
#  }
#force_destroy = true
#  lifecycle {
#    prevent_destroy = false
#  }
#server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = aws_kms_key.uat-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

#resource "aws_s3_bucket" "uat-bcs-documents-co" {
#  bucket = "uat-bcs-documents-co"
#  acl = "private"
#logging {
#  target_bucket = "uat-bcp-logs-co"
#}
#  versioning {
#    enabled = true
#  }
#force_destroy = true
#  lifecycle {
#    prevent_destroy = false
#  }
#server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = aws_kms_key.uat-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

resource "aws_s3_bucket" "uat-bcs-logs-co" {
  bucket = "uat-bcs-logs-co"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#resource "aws_s3_bucket" "uat-bcs-response-co" {
#  bucket = "uat-bcs-response-co"
#  acl = "private"
#logging {
#  target_bucket = "uat-bcp-logs-co"
#}
#  versioning {
#    enabled = true
#  }
#force_destroy = true
#  lifecycle {
#    prevent_destroy = false
#  }
#server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = aws_kms_key.uat-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

#resource "aws_s3_bucket" "uat-bcw-documents-co" {
#  bucket = "uat-bcw-documents-co"
#  acl = "private"
#logging {
#  target_bucket = "uat-bcp-logs-co"
#}
#  versioning {
#    enabled = true
#  }
#force_destroy = true
#  lifecycle {
#    prevent_destroy = false
#  }
#server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = aws_kms_key.uat-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

resource "aws_s3_bucket" "uat-bcw-logs-co" {
  bucket = "uat-bcw-logs-co"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#resource "aws_s3_bucket" "uat-bcw-response-co" {
#  bucket = "uat-bcw-response-co"
#  acl = "private"
#logging {
#  target_bucket = "uat-bcp-logs-co"
#}
#  versioning {
#    enabled = true
#  }
#force_destroy = true
#  lifecycle {
#    prevent_destroy = false
#  }
#server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = aws_kms_key.uat-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

#resource "aws_s3_bucket" "uat-cffg-documents-co" {
#  bucket = "uat-cffg-documents-co"
#  acl = "private"
#logging {
#  target_bucket = "uat-bcp-logs-co"
#}
#  versioning {
#    enabled = true
#  }
#force_destroy = true
#  lifecycle {
#    prevent_destroy = false
#  }
#server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = aws_kms_key.uat-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}
#
resource "aws_s3_bucket" "uat-cffg-logs-co" {
  bucket = "uat-cffg-logs-co"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#resource "aws_s3_bucket" "uat-cffg-response-co" {
#  bucket = "uat-cffg-response-co"
#  acl = "private"
#logging {
#  target_bucket = "uat-bcp-logs-co"
#}
#  versioning {
#    enabled = true
#  }
#force_destroy = true
#  lifecycle {
#    prevent_destroy = false
#  }
#server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = aws_kms_key.uat-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

# create uat cloudtrail bucket and policy
resource "aws_s3_bucket" "bcp-uat-cloudtrail-co" {
  bucket        = "bcp-uat-cloudtrail-co"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# Create UAT cloudWatch bucket
resource "aws_s3_bucket" "uat-bcp-cloudwatch-co" {
  bucket = "uat-bcp-cloudwatch-co"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#general log bucket
resource "aws_s3_bucket" "uat-bcp-logs-co" {
  bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#block all public access

resource "aws_s3_bucket_public_access_block" "uat-bce-test-co" {
  bucket = aws_s3_bucket.uat-bce-test-co.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "uat-bcp-logs-co" {
  bucket = aws_s3_bucket.uat-bcp-logs-co.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "uat-bcp-cloudwatch-co" {
  bucket = aws_s3_bucket.uat-bcp-cloudwatch-co.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}


resource "aws_s3_bucket_public_access_block" "bcp-uat-cloudtrail-co" {
  bucket = aws_s3_bucket.bcp-uat-cloudtrail-co.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

#resource "aws_s3_bucket_public_access_block" "uat-bce-documents-co" {
#  bucket = aws_s3_bucket.uat-bce-documents-co.id
#
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#
#}

#resource "aws_s3_bucket_public_access_block" "uat-bce-response-co" {
#  bucket = aws_s3_bucket.uat-bce-response-co.id
#
#  block_public_acls   = true
#  block_public_policy = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

resource "aws_s3_bucket_public_access_block" "uat-bce-logs-co" {
  bucket = aws_s3_bucket.uat-bce-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#resource "aws_s3_bucket_public_access_block" "uat-bcs-documents-co" {
#  bucket = aws_s3_bucket.uat-bcs-documents-co.id
#
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#
#}

#resource "aws_s3_bucket_public_access_block" "uat-bcs-response-co" {
#  bucket = aws_s3_bucket.uat-bcs-response-co.id
#
#  block_public_acls   = true
#  block_public_policy = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

resource "aws_s3_bucket_public_access_block" "uat-bcs-logs-co" {
  bucket = aws_s3_bucket.uat-bcs-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#resource "aws_s3_bucket_public_access_block" "uat-bcw-documents-co" {
#  bucket = aws_s3_bucket.uat-bcw-documents-co.id
#
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#
#}

#resource "aws_s3_bucket_public_access_block" "uat-bcw-response-co" {
#  bucket = aws_s3_bucket.uat-bcw-response-co.id
#
#  block_public_acls   = true
#  block_public_policy = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

resource "aws_s3_bucket_public_access_block" "uat-bcw-logs-co" {
  bucket = aws_s3_bucket.uat-bcw-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#resource "aws_s3_bucket_public_access_block" "uat-cffg-documents-co" {
#  bucket = aws_s3_bucket.uat-cffg-documents-co.id
#
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#
#}

#resource "aws_s3_bucket_public_access_block" "uat-cffg-response-co" {
#  bucket = aws_s3_bucket.uat-cffg-response-co.id
#
#  block_public_acls   = true
#  block_public_policy = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

resource "aws_s3_bucket_public_access_block" "uat-cffg-logs-co" {
  bucket = aws_s3_bucket.uat-cffg-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bce-cloudfront-logs-co" {
  bucket = aws_s3_bucket.uat-bce-cloudfront-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bcs-cloudfront-logs-co" {
  bucket = aws_s3_bucket.uat-bcs-cloudfront-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bcw-cloudfront-logs-co" {
  bucket = aws_s3_bucket.uat-bcw-cloudfront-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-cffg-cloudfront-logs-co" {
  bucket = aws_s3_bucket.uat-cffg-cloudfront-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# Buckets for CloudFront

resource "aws_s3_bucket" "uat-bce-cloudfront-logs-co" {
  bucket = "uat-bce-cloudfront-logs-co"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-bcs-cloudfront-logs-co" {
  bucket = "uat-bcs-cloudfront-logs-co"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-bcw-cloudfront-logs-co" {
  bucket = "uat-bcw-cloudfront-logs-co"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-cffg-cloudfront-logs-co" {
  bucket = "uat-cffg-cloudfront-logs-co"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.uat-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# UAT maintenance bucket

resource "aws_s3_bucket" "uat-bcp-maintenance-co" {
  bucket = "uat-bcp-maintenance-co"
  acl = "public-read"
logging {
  target_bucket = "uat-bcp-logs-co"
}
#  policy = aws_s3_bucket_policy.uat-public-read
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

resource "aws_s3_bucket_policy" "uat-public-read-co" {
  bucket = aws_s3_bucket.uat-bcp-maintenance-co.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.uat-bcp-maintenance-co.arn,
          "${aws_s3_bucket.uat-bcp-maintenance-co.arn}/*",
        ]
      },
    ]
  })
}

