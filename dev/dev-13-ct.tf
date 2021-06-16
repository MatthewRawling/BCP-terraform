data "aws_caller_identity" "current1" {}

resource "aws_cloudtrail" "dev-cloudtrail" {
  name                          = "dev-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.bcp-dev-cloudtrail.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}

