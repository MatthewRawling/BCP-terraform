# PROD Key Setup

resource "aws_kms_key" "prod-kms" {
  description              = "Prod-KMS"
  deletion_window_in_days  = 10
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
}

# PROD Bucket Setup

resource "aws_s3_bucket" "prod-bce-documents" {
  bucket = "prod-bce-documents"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
} 

data "aws_canonical_user_id" "current_user" {}
resource "aws_s3_bucket" "prod-bce-logs" {
  bucket = "prod-bce-logs"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }

replication_configuration {
          role = aws_iam_role.prod-bcp-rep.arn

          rules {
              id       = "prod-bce-logs-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "416173853406"
                  bucket             = "arn:aws:s3:::prod-bce-logs-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:416173853406:key/c2a60189-801b-41f9-953e-ec3efcffc819"
                      access_control_translation {
                        owner = "Destination"
                    }

               }

              filter {}

              source_selection_criteria {
                  sse_kms_encrypted_objects {
                      enabled = true
                    }
                }
            }
        }

}

resource "aws_s3_bucket" "prod-bce-response" {
  bucket = "prod-bce-response"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-bcs-documents" {
  bucket = "prod-bcs-documents"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-bcs-logs" {
  bucket = "prod-bcs-logs"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
replication_configuration {
          role = aws_iam_role.prod-bcp-rep.arn

          rules {
              id       = "prod-bcs-logs-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "416173853406"
                  bucket             = "arn:aws:s3:::prod-bcs-logs-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:416173853406:key/c2a60189-801b-41f9-953e-ec3efcffc819"
                      access_control_translation {
                        owner = "Destination"
                    }

               }

              filter {}

              source_selection_criteria {
                  sse_kms_encrypted_objects {
                      enabled = true
                    }
                }
            }
        }

}

resource "aws_s3_bucket" "prod-bcs-response" {
  bucket = "prod-bcs-response"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-bcw-documents" {
  bucket = "prod-bcw-documents"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-bcw-logs" {
  bucket = "prod-bcw-logs"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
replication_configuration {
          role = aws_iam_role.prod-bcp-rep.arn

          rules {
              id       = "prod-bcw-logs-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "416173853406"
                  bucket             = "arn:aws:s3:::prod-bcw-logs-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:416173853406:key/c2a60189-801b-41f9-953e-ec3efcffc819"
                      access_control_translation {
                        owner = "Destination"
                    }

               }

              filter {}

              source_selection_criteria {
                  sse_kms_encrypted_objects {
                      enabled = true
                    }
                }
            }
        }

}

resource "aws_s3_bucket" "prod-bcw-response" {
  bucket = "prod-bcw-response"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-cffg-documents" {
  bucket = "prod-cffg-documents"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-cffg-logs" {
  bucket = "prod-cffg-logs"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
replication_configuration {
          role = aws_iam_role.prod-bcp-rep.arn

          rules {
              id       = "prod-cffg-logs-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "416173853406"
                  bucket             = "arn:aws:s3:::prod-cffg-logs-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:416173853406:key/c2a60189-801b-41f9-953e-ec3efcffc819"
                      access_control_translation {
                        owner = "Destination"
                    }

               }

              filter {}

              source_selection_criteria {
                  sse_kms_encrypted_objects {
                      enabled = true
                    }
                }
            }
        }

}

resource "aws_s3_bucket" "prod-cffg-response" {
  bucket = "prod-cffg-response"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# create prod cloudtrail bucket and policy
resource "aws_s3_bucket" "bcp-prod-cloudtrail" {
  bucket        = "bcp-prod-cloudtrail"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
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
            "Resource": "arn:aws:s3:::bcp-prod-cloudtrail"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::bcp-prod-cloudtrail/prefix/AWSLogs/${data.aws_caller_identity.current1.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
replication_configuration {
          role = aws_iam_role.prod-bcp-rep.arn

          rules {
              id       = "prod-bcp-cloudtrail-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "416173853406"
                  bucket             = "arn:aws:s3:::bcp-prod-cloudtrail-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:416173853406:key/c2a60189-801b-41f9-953e-ec3efcffc819"
                      access_control_translation {
                        owner = "Destination"
                    }

               }

              filter {}

              source_selection_criteria {
                  sse_kms_encrypted_objects {
                      enabled = true
                    }
                }
            }
        }

}

# Create PROD cloudWatch bucket
resource "aws_s3_bucket" "prod-bcp-cloudwatch" {
  bucket = "prod-bcp-cloudwatch"
  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
replication_configuration {
          role = aws_iam_role.prod-bcp-rep.arn

          rules {
              id       = "prod-bcp-cloudwatch-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "416173853406"
                  bucket             = "arn:aws:s3:::prod-bcp-cloudwatch-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:416173853406:key/c2a60189-801b-41f9-953e-ec3efcffc819"
                      access_control_translation {
                        owner = "Destination"
                    }

               }

              filter {}

              source_selection_criteria {
                  sse_kms_encrypted_objects {
                      enabled = true
                    }
                }
            }
        }

}

#general log bucket
resource "aws_s3_bucket" "prod-bcp-logs" {
  bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#block all public access

resource "aws_s3_bucket_public_access_block" "prod-bcp-logs" {
  bucket = aws_s3_bucket.prod-bcp-logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "prod-bcp-cloudwatch" {
  bucket = aws_s3_bucket.prod-bcp-cloudwatch.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "bcp-prod-cloudtrail" {
  bucket = aws_s3_bucket.bcp-prod-cloudtrail.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "prod-bce-documents" {
  bucket = aws_s3_bucket.prod-bce-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "prod-bce-response" {
  bucket = aws_s3_bucket.prod-bce-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bce-logs" {
  bucket = aws_s3_bucket.prod-bce-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bcs-documents" {
  bucket = aws_s3_bucket.prod-bcs-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "prod-bcs-response" {
  bucket = aws_s3_bucket.prod-bcs-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bcs-logs" {
  bucket = aws_s3_bucket.prod-bcs-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bcw-documents" {
  bucket = aws_s3_bucket.prod-bcw-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "prod-bcw-response" {
  bucket = aws_s3_bucket.prod-bcw-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bcw-logs" {
  bucket = aws_s3_bucket.prod-bcw-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-cffg-documents" {
  bucket = aws_s3_bucket.prod-cffg-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "prod-cffg-response" {
  bucket = aws_s3_bucket.prod-cffg-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-cffg-logs" {
  bucket = aws_s3_bucket.prod-cffg-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bce-cloudfront-logs" {
  bucket = aws_s3_bucket.prod-bce-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bcs-cloudfront-logs" {
  bucket = aws_s3_bucket.prod-bcs-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-bcw-cloudfront-logs" {
  bucket = aws_s3_bucket.prod-bcw-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "prod-cffg-cloudfront-logs" {
  bucket = aws_s3_bucket.prod-cffg-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Buckets for CloudFront

resource "aws_s3_bucket" "prod-bce-cloudfront-logs" {
  bucket = "prod-bce-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-bcs-cloudfront-logs" {
  bucket = "prod-bcs-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-bcw-cloudfront-logs" {
  bucket = "prod-bcw-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "prod-cffg-cloudfront-logs" {
  bucket = "prod-cffg-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "prod-bcp-logs"
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
        kms_master_key_id = aws_kms_key.prod-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# PROD maintenance bucket

resource "aws_s3_bucket" "prod-bcp-maintenance" {
  bucket = "prod-bcp-maintenance"
  acl = "public-read"
logging {
  target_bucket = "prod-bcp-logs"
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

resource "aws_s3_bucket_policy" "prod-public-read" {
  bucket = aws_s3_bucket.prod-bcp-maintenance.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.prod-bcp-maintenance.arn,
          "${aws_s3_bucket.prod-bcp-maintenance.arn}/*",
        ]
      },
    ]
  })
}


