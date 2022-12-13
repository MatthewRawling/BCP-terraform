data "aws_caller_identity" "current1" {}

resource "aws_cloudtrail" "dev-cloudtrail" {
  name                          = "dev-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.bcp-dev-cloudtrail.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = true
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  cloud_watch_logs_group_arn    = "arn:aws:logs:eu-west-2:975971611990:log-group:aws-cloudtrail-logs-975971611990-548aa58e:*"
  cloud_watch_logs_role_arn     = "arn:aws:iam::975971611990:role/service-role/dev-bcp-ct2cw" 
  kms_key_id                    = "arn:aws:kms:eu-west-2:975971611990:key/78dd90be-6721-400a-b96d-4c439c2126f0"
}


