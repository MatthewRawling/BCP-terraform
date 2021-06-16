# PROD Key Setup

resource "aws_kms_key" "prod-kms-co" {
  description              = "Prod-KMS-co"
  deletion_window_in_days  = 10
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
}

# PROD Bucket Setup

data "aws_canonical_user_id" "current_user" {}

#resource "aws_s3_bucket" "prod-bce-documents-co" {
#  bucket = "prod-bce-documents-co"
#  acl = "private"
#logging {
#  target_bucket = "prod-bcp-logs-co"
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
#        kms_master_key_id = aws_kms_key.prod-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#} 

resource "aws_s3_bucket" "prod-bce-logs-co" {
  bucket = "prod-bce-logs-co"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#resource "aws_s3_bucket" "prod-bce-response-co" {
#  bucket = "prod-bce-response-co"
#  acl = "private"
#  logging {
#  target_bucket = "prod-bcp-logs-co"
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
#        kms_master_key_id = aws_kms_key.prod-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

#resource "aws_s3_bucket" "prod-bcs-documents-co" {
#  bucket = "prod-bcs-documents-co"
#  acl = "private"
#  logging {
#  target_bucket = "prod-bcp-logs-co"
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
#        kms_master_key_id = aws_kms_key.prod-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

resource "aws_s3_bucket" "prod-bcs-logs-co" {
  bucket = "prod-bcs-logs-co"
  acl = "private"
  logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#resource "aws_s3_bucket" "prod-bcs-response-co" {
#  bucket = "prod-bcs-response-co"
#  acl = "private"
#  logging {
#  target_bucket = "prod-bcp-logs-co"
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
#        kms_master_key_id = aws_kms_key.prod-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

#resource "aws_s3_bucket" "prod-bcw-documents-co" {
#  bucket = "prod-bcw-documents-co"
#  acl = "private"
#  logging {
#  target_bucket = "prod-bcp-logs-co"
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
#        kms_master_key_id = aws_kms_key.prod-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

resource "aws_s3_bucket" "prod-bcw-logs-co" {
  bucket = "prod-bcw-logs-co"
  acl = "private"
  logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#resource "aws_s3_bucket" "prod-bcw-response-co" {
#  bucket = "prod-bcw-response-co"
#  acl = "private"
#  logging {
#  target_bucket = "prod-bcp-logs-co"
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
#        kms_master_key_id = aws_kms_key.prod-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

#resource "aws_s3_bucket" "prod-cffg-documents-co" {
#  bucket = "prod-cffg-documents-co"
#  acl = "private"
#  logging {
#  target_bucket = "prod-bcp-logs-co"
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
#        kms_master_key_id = aws_kms_key.prod-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

resource "aws_s3_bucket" "prod-cffg-logs-co" {
  bucket = "prod-cffg-logs-co"
  acl = "private"
  logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#resource "aws_s3_bucket" "prod-cffg-response-co" {
#  bucket = "prod-cffg-response-co"
#  acl = "private"
#  logging {
#  target_bucket = "prod-bcp-logs-co"
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
#        kms_master_key_id = aws_kms_key.prod-kms-co.arn
#        sse_algorithm = "aws:kms"
#      }
#    }
#  }
#}

# create prod cloudtrail bucket and policy
resource "aws_s3_bucket" "bcp-prod-cloudtrail-co" {
  bucket        = "bcp-prod-cloudtrail-co"
  acl = "private"
  logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# Create PROD cloudWatch bucket
resource "aws_s3_bucket" "prod-bcp-cloudwatch-co" {
  bucket = "prod-bcp-cloudwatch-co"
  acl = "private"
  logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#general log bucket
resource "aws_s3_bucket" "prod-bcp-logs-co" {
  bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#block all public access

resource "aws_s3_bucket_public_access_block" "prod-bcp-logs-co" {
  bucket = aws_s3_bucket.prod-bcp-logs-co.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "prod-bcp-cloudwatch-co" {
  bucket = aws_s3_bucket.prod-bcp-cloudwatch-co.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}


resource "aws_s3_bucket_public_access_block" "bcp-prod-cloudtrail-co" {
  bucket = aws_s3_bucket.bcp-prod-cloudtrail-co.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

#resource "aws_s3_bucket_public_access_block" "prod-bce-documents-co" {
#  bucket = aws_s3_bucket.prod-bce-documents-co.id
#
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#
#}

#resource "aws_s3_bucket_public_access_block" "prod-bce-response-co" {
#  bucket = aws_s3_bucket.prod-bce-response-co.id
#
#  block_public_acls   = true
#  block_public_policy = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

resource "aws_s3_bucket_public_access_block" "prod-bce-logs-co" {
  bucket = aws_s3_bucket.prod-bce-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#resource "aws_s3_bucket_public_access_block" "prod-bcs-documents-co" {
#  bucket = aws_s3_bucket.prod-bcs-documents-co.id
#
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#
#}

#resource "aws_s3_bucket_public_access_block" "prod-bcs-response-co" {
#  bucket = aws_s3_bucket.prod-bcs-response-co.id
#
#  block_public_acls   = true
#  block_public_policy = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

resource "aws_s3_bucket_public_access_block" "prod-bcs-logs-co" {
  bucket = aws_s3_bucket.prod-bcs-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#resource "aws_s3_bucket_public_access_block" "prod-bcw-documents-co" {
#  bucket = aws_s3_bucket.prod-bcw-documents-co.id
#
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#
#}

#resource "aws_s3_bucket_public_access_block" "prod-bcw-response-co" {
#  bucket = aws_s3_bucket.prod-bcw-response-co.id
#
#  block_public_acls   = true
#  block_public_policy = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

resource "aws_s3_bucket_public_access_block" "prod-bcw-logs-co" {
  bucket = aws_s3_bucket.prod-bcw-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#resource "aws_s3_bucket_public_access_block" "prod-cffg-documents-co" {
#  bucket = aws_s3_bucket.prod-cffg-documents-co.id
#
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#
#}

#resource "aws_s3_bucket_public_access_block" "prod-cffg-response-co" {
#  bucket = aws_s3_bucket.prod-cffg-response-co.id
#
#  block_public_acls   = true
# block_public_policy = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

resource "aws_s3_bucket_public_access_block" "prod-cffg-logs-co" {
  bucket = aws_s3_bucket.prod-cffg-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bce-cloudfront-logs-co" {
  bucket = aws_s3_bucket.prod-bce-cloudfront-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bcs-cloudfront-logs-co" {
  bucket = aws_s3_bucket.prod-bcs-cloudfront-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bcw-cloudfront-logs-co" {
  bucket = aws_s3_bucket.prod-bcw-cloudfront-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-cffg-cloudfront-logs-co" {
  bucket = aws_s3_bucket.prod-cffg-cloudfront-logs-co.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# Buckets for CloudFront

resource "aws_s3_bucket" "prod-bce-cloudfront-logs-co" {
  bucket = "prod-bce-cloudfront-logs-co"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-bcs-cloudfront-logs-co" {
  bucket = "prod-bcs-cloudfront-logs-co"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-bcw-cloudfront-logs-co" {
  bucket = "prod-bcw-cloudfront-logs-co"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-cffg-cloudfront-logs-co" {
  bucket = "prod-cffg-cloudfront-logs-co"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs-co"
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
        kms_master_key_id = aws_kms_key.prod-kms-co.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# PROD maintenance bucket

resource "aws_s3_bucket" "prod-bcp-maintenance-co" {
  bucket = "prod-bcp-maintenance-co"
  acl = "public-read"
  logging {
  target_bucket = "prod-bcp-logs-co"
}
#  policy = aws_s3_bucket_policy.prod-public-read
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

resource "aws_s3_bucket_policy" "prod-public-read-co" {
  bucket = aws_s3_bucket.prod-bcp-maintenance-co.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.prod-bcp-maintenance-co.arn,
          "${aws_s3_bucket.prod-bcp-maintenance-co.arn}/*",
        ]
      },
    ]
  })
}

