# UAT Key Setup

resource "aws_kms_key" "uat-kms" {
  description              = "Uat-KMS"
  deletion_window_in_days  = 10
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  bypass_policy_lockout_safety_check = false
  enable_key_rotation                = true
}

#UAT Bucket Setup

resource "aws_s3_bucket" "uat-bce-test" {
  bucket = "uat-bce-test"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
         sse_algorithm = "aws:kms"
      }
    }
  }
replication_configuration {
          role = aws_iam_role.uat-bcp-rep.arn

          rules {
              id       = "uat-bce-test-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "181623394163"
                  bucket             = "arn:aws:s3:::uat-bce-test-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:181623394163:key/197bbe36-b994-4665-97f8-87e58fdb8836"
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

resource "aws_s3_bucket" "uat-bce-documents" {
  bucket = "uat-bce-documents"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
} 

data "aws_canonical_user_id" "current_user" {}
resource "aws_s3_bucket" "uat-bce-logs" {
  bucket = "uat-bce-logs"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }

replication_configuration {
          role = aws_iam_role.uat-bcp-rep.arn

          rules {
              id       = "uat-bce-logs-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "181623394163"
                  bucket             = "arn:aws:s3:::uat-bce-logs-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:181623394163:key/197bbe36-b994-4665-97f8-87e58fdb8836"
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

resource "aws_s3_bucket" "uat-bce-response" {
  bucket = "uat-bce-response"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-bcs-documents" {
  bucket = "uat-bcs-documents"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-bcs-logs" {
  bucket = "uat-bcs-logs"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
replication_configuration {
          role = aws_iam_role.uat-bcp-rep.arn

          rules {
              id       = "uat-bcs-logs-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "181623394163"
                  bucket             = "arn:aws:s3:::uat-bcs-logs-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:181623394163:key/197bbe36-b994-4665-97f8-87e58fdb8836"
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

resource "aws_s3_bucket" "uat-bcs-response" {
  bucket = "uat-bcs-response"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-bcw-documents" {
  bucket = "uat-bcw-documents"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-bcw-logs" {
  bucket = "uat-bcw-logs"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
replication_configuration {
          role = aws_iam_role.uat-bcp-rep.arn

          rules {
              id       = "uat-bcw-logs-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "181623394163"
                  bucket             = "arn:aws:s3:::uat-bcw-logs-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:181623394163:key/197bbe36-b994-4665-97f8-87e58fdb8836"
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

resource "aws_s3_bucket" "uat-bcw-response" {
  bucket = "uat-bcw-response"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-cffg-documents" {
  bucket = "uat-cffg-documents"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-cffg-logs" {
  bucket = "uat-cffg-logs"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
replication_configuration {
          role = aws_iam_role.uat-bcp-rep.arn

          rules {
              id       = "uat-cffg-logs-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "181623394163"
                  bucket             = "arn:aws:s3:::uat-cffg-logs-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:181623394163:key/197bbe36-b994-4665-97f8-87e58fdb8836"
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

resource "aws_s3_bucket" "uat-cffg-response" {
  bucket = "uat-cffg-response"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# create uat cloudtrail bucket and policy
resource "aws_s3_bucket" "bcp-uat-cloudtrail" {
  bucket        = "bcp-uat-cloudtrail"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
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
            "Resource": "arn:aws:s3:::bcp-uat-cloudtrail"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::bcp-uat-cloudtrail/prefix/AWSLogs/${data.aws_caller_identity.current1.account_id}/*",
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
          role = aws_iam_role.uat-bcp-rep.arn

          rules {
              id       = "bcp-uat-cloudtrail-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "181623394163"
                  bucket             = "arn:aws:s3:::bcp-uat-cloudtrail-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:181623394163:key/197bbe36-b994-4665-97f8-87e58fdb8836"
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

# Create UAT cloudWatch bucket
resource "aws_s3_bucket" "uat-bcp-cloudwatch" {
  bucket = "uat-bcp-cloudwatch"
  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
replication_configuration {
          role = aws_iam_role.uat-bcp-rep.arn

          rules {
              id       = "uat-bcp-cloudwatch-rep"
              priority = 0
              status   = "Enabled"
              destination {
                  account_id         = "181623394163"
                  bucket             = "arn:aws:s3:::uat-bcp-cloudwatch-co"
                  replica_kms_key_id = "arn:aws:kms:eu-west-2:181623394163:key/197bbe36-b994-4665-97f8-87e58fdb8836"
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
resource "aws_s3_bucket" "uat-bcp-logs" {
  bucket = "uat-bcp-logs"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
}
  versioning {
    enabled = true
  }
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

#block all public access

resource "aws_s3_bucket_public_access_block" "uat-bce-test" {
  bucket = aws_s3_bucket.uat-bce-test.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "uat-bcp-logs" {
  bucket = aws_s3_bucket.uat-bcp-logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "uat-bcp-cloudwatch" {
  bucket = aws_s3_bucket.uat-bcp-cloudwatch.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "bcp-uat-cloudtrail" {
  bucket = aws_s3_bucket.bcp-uat-cloudtrail.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "uat-bce-documents" {
  bucket = aws_s3_bucket.uat-bce-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "uat-bce-response" {
  bucket = aws_s3_bucket.uat-bce-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bce-logs" {
  bucket = aws_s3_bucket.uat-bce-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bcs-documents" {
  bucket = aws_s3_bucket.uat-bcs-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "uat-bcs-response" {
  bucket = aws_s3_bucket.uat-bcs-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bcs-logs" {
  bucket = aws_s3_bucket.uat-bcs-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bcw-documents" {
  bucket = aws_s3_bucket.uat-bcw-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "uat-bcw-response" {
  bucket = aws_s3_bucket.uat-bcw-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bcw-logs" {
  bucket = aws_s3_bucket.uat-bcw-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-cffg-documents" {
  bucket = aws_s3_bucket.uat-cffg-documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_public_access_block" "uat-cffg-response" {
  bucket = aws_s3_bucket.uat-cffg-response.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-cffg-logs" {
  bucket = aws_s3_bucket.uat-cffg-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bce-cloudfront-logs" {
  bucket = aws_s3_bucket.uat-bce-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bcs-cloudfront-logs" {
  bucket = aws_s3_bucket.uat-bcs-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-bcw-cloudfront-logs" {
  bucket = aws_s3_bucket.uat-bcw-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "uat-cffg-cloudfront-logs" {
  bucket = aws_s3_bucket.uat-cffg-cloudfront-logs.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Buckets for CloudFront

resource "aws_s3_bucket" "uat-bce-cloudfront-logs" {
  bucket = "uat-bce-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-bcs-cloudfront-logs" {
  bucket = "uat-bcs-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-bcw-cloudfront-logs" {
  bucket = "uat-bcw-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "uat-cffg-cloudfront-logs" {
  bucket = "uat-cffg-cloudfront-logs"
#  acl = "private"
logging {
  target_bucket = "uat-bcp-logs"
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
        kms_master_key_id = aws_kms_key.uat-kms.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# UAT maintenance bucket

resource "aws_s3_bucket" "uat-bcp-maintenance" {
  bucket = "uat-bcp-maintenance"
  acl = "public-read"
logging {
  target_bucket = "uat-bcp-logs"
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

server_side_encryption_configuration {
    rule {
        bucket_key_enabled = false
        apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_policy" "uat-public-read" {
  bucket = aws_s3_bucket.uat-bcp-maintenance.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.uat-bcp-maintenance.arn,
          "${aws_s3_bucket.uat-bcp-maintenance.arn}/*",
        ]
      },
    ]
  })
}


