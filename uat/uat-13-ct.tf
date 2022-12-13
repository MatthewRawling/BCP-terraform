data "aws_caller_identity" "current1" {}

resource "aws_cloudtrail" "uat-cloudtrail" {
  name                          = "uat-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.bcp-uat-cloudtrail.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = true
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  cloud_watch_logs_group_arn    = "arn:aws:logs:eu-west-2:975971611990:log-group:aws-cloudtrail-logs-975971611990-ad1574f8:*"
  cloud_watch_logs_role_arn     = "arn:aws:iam::975971611990:role/service-role/uat-bcp-ct2cw"
  kms_key_id                    = "arn:aws:kms:eu-west-2:975971611990:key/8aef1df2-783e-40e3-a4cf-36b9197ec98a"
}

