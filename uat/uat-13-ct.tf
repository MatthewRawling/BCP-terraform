data "aws_caller_identity" "current1" {}

resource "aws_cloudtrail" "uat-cloudtrail" {
  name                          = "uat-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.bcp-uat-cloudtrail.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = true
  enable_log_file_validation    = true
  is_multi_region_trail         = true
}

