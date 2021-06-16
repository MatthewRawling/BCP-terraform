data "aws_caller_identity" "current1" {}

resource "aws_cloudtrail" "prod-cloudtrail" {
  name                          = "prod-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.bcp-prod-cloudtrail.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}

