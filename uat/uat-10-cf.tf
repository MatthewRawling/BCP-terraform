# Setup

#resource "aws_kms_key" "uat-kms-key" {
#  description             = "uat-kms-key"
#  deletion_window_in_days = 10
#}
#
#resource "aws_cloudfront_public_key" "uat-cf-key" {
#  comment     = "UAT CloudFront Key"
#  encoded_key = aws_kms_key.uat-kms-key.key_id
#  name        = "UAT_CloudFront_Key"
#}

# UAT CF for BCE

resource "aws_cloudfront_distribution" "uat-bce-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.uat.bce2023.co.uk", "uat.bce2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.uat-bce-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.uat-bce-app-alb.dns_name}"
    origin_id   = "${aws_lb.uat-bce-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.uat-bce-cloudfront-logs.bucket_domain_name
    prefix          = "uatbce"
  }
  origin {
    domain_name = "uat-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "UAT-Maintenance"
#    origin_path = "/index.html"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_lb.uat-bce-app-alb.name}"

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }
#    lambda_function_association {
#              event_type   = "viewer-request"
#              include_body = false
#              lambda_arn   = "arn:aws:lambda:us-east-1:975971611990:function:bcp-auth2:3"
#    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

#  ordered_cache_behavior {
#    path_pattern     = "*.css"
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "${aws_lb.uat-bce-app-alb.name}"
#
#    forwarded_values {
#      query_string = false
#      headers      = [
#                   "Accept",
#                   "Accept-Charset",
#                   "Accept-Datetime",
#                   "Accept-Encoding",
#                   "Accept-Language",
#                   "Authorization",
#                   "CloudFront-Forwarded-Proto",
#                   "Host",
#                   "Origin",
#                   "Referer",
#                ]
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    min_ttl                = 0
#    default_ttl            = 86400
#    max_ttl                = 31536000
#    compress               = true
#    viewer_protocol_policy = "allow-all"
#  }
#
#  ordered_cache_behavior {
#    path_pattern     = "*.js"
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "${aws_lb.uat-bce-app-alb.name}"
#
#    forwarded_values {
#      query_string = false
#      headers      = [
#                   "Accept",
#                   "Accept-Charset",
#                   "Accept-Datetime",
#                   "Accept-Encoding",
#                   "Accept-Language",
#                   "Authorization",
#                   "CloudFront-Forwarded-Proto",
#                   "Host",
#                   "Origin",
#                   "Referer",
#                ]
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    min_ttl                = 0
#    default_ttl            = 86400
#    max_ttl                = 31536000
#    compress               = true
#    viewer_protocol_policy = "allow-all"
#  }

viewer_certificate {
    acm_certificate_arn = var.uat_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# UAT CF for BCS

resource "aws_cloudfront_distribution" "uat-bcs-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.uat.bcs2023.co.uk", "uat.bcs2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.uat-bcs-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.uat-bcs-app-alb.dns_name}"
    origin_id   = "${aws_lb.uat-bcs-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.uat-bcs-cloudfront-logs.bucket_domain_name
    prefix          = "uatbcs"
  }
  origin {
    domain_name = "uat-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "UAT-Maintenance"
#    origin_path = "/index.html"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_lb.uat-bcs-app-alb.name}"

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }
#    lambda_function_association {
#              event_type   = "viewer-request"
#              include_body = false
#              lambda_arn   = "arn:aws:lambda:us-east-1:975971611990:function:bcp-auth2:3"
#    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

#  ordered_cache_behavior {
#    path_pattern     = "*.css"
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "${aws_lb.uat-bcs-app-alb.name}"
#
#    forwarded_values {
#      query_string = false
#      headers      = [
#                   "Accept",
#                   "Accept-Charset",
#                   "Accept-Datetime",
#                   "Accept-Encoding",
#                   "Accept-Language",
#                   "Authorization",
#                   "CloudFront-Forwarded-Proto",
#                   "Host",
#                   "Origin",
#                   "Referer",
#                ]
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    min_ttl                = 0
#    default_ttl            = 86400
#    max_ttl                = 31536000
#    compress               = true
#    viewer_protocol_policy = "allow-all"
#  }
#
#  ordered_cache_behavior {
#    path_pattern     = "*.js"
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "${aws_lb.uat-bcs-app-alb.name}"
#
#    forwarded_values {
#      query_string = false
#      headers      = [
#                   "Accept",
#                   "Accept-Charset",
#                   "Accept-Datetime",
#                   "Accept-Encoding",
#                   "Accept-Language",
#                   "Authorization",
#                   "CloudFront-Forwarded-Proto",
#                   "Host",
#                   "Origin",
#                   "Referer",
#                ]
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    min_ttl                = 0
#    default_ttl            = 86400
#    max_ttl                = 31536000
#    compress               = true
#    viewer_protocol_policy = "allow-all"
#  }

viewer_certificate {
    acm_certificate_arn = var.uat_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# UAT CF for BCW

resource "aws_cloudfront_distribution" "uat-bcw-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.uat.bcw2023.co.uk", "uat.bcw2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.uat-bcw-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.uat-bcw-app-alb.dns_name}"
    origin_id   = "${aws_lb.uat-bcw-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.uat-bcw-cloudfront-logs.bucket_domain_name
    prefix          = "uatbcw"
  }
  origin {
    domain_name = "uat-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "UAT-Maintenance"
#    origin_path = "/index.html"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_lb.uat-bcw-app-alb.name}"

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }
#    lambda_function_association {
#              event_type   = "viewer-request"
#              include_body = false
#              lambda_arn   = "arn:aws:lambda:us-east-1:975971611990:function:bcp-auth2:3"
#    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

#  ordered_cache_behavior {
#    path_pattern     = "*.css"
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "${aws_lb.uat-bcw-app-alb.name}"
#
#    forwarded_values {
#      query_string = false
#      headers      = [
#                   "Accept",
#                   "Accept-Charset",
#                   "Accept-Datetime",
#                   "Accept-Encoding",
#                   "Accept-Language",
#                   "Authorization",
#                   "CloudFront-Forwarded-Proto",
#                   "Host",
#                   "Origin",
#                   "Referer",
#                ]
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    min_ttl                = 0
#    default_ttl            = 86400
#    max_ttl                = 31536000
#    compress               = true
#    viewer_protocol_policy = "allow-all"
#  }
#
#  ordered_cache_behavior {
#    path_pattern     = "*.js"
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "${aws_lb.uat-bcw-app-alb.name}"
#
#    forwarded_values {
#      query_string = false
#      headers      = [
#                   "Accept",
#                   "Accept-Charset",
#                   "Accept-Datetime",
#                   "Accept-Encoding",
#                   "Accept-Language",
#                   "Authorization",
#                   "CloudFront-Forwarded-Proto",
#                   "Host",
#                   "Origin",
#                   "Referer",
#                ]
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    min_ttl                = 0
#    default_ttl            = 86400
#    max_ttl                = 31536000
#    compress               = true
#    viewer_protocol_policy = "allow-all"
#  }

viewer_certificate {
    acm_certificate_arn = var.uat_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# UAT CF for CFFG

resource "aws_cloudfront_distribution" "uat-cffg-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.uat.cffg2023.co.uk", "uat.cffg2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.uat-cffg-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.uat-cffg-app-alb.dns_name}"
    origin_id   = "${aws_lb.uat-cffg-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.uat-cffg-cloudfront-logs.bucket_domain_name
    prefix          = "uatcffg"
  }
  origin {
    domain_name = "uat-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "UAT-Maintenance"
#    origin_path = "/index.html"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_lb.uat-cffg-app-alb.name}"

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }
#    lambda_function_association {
#              event_type   = "viewer-request"
#              include_body = false
#              lambda_arn   = "arn:aws:lambda:us-east-1:975971611990:function:bcp-auth2:3"
#    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

#  ordered_cache_behavior {
#    path_pattern     = "*.css"
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "${aws_lb.uat-cffg-app-alb.name}"
#
#    forwarded_values {
#      query_string = false
#      headers      = [
#                   "Accept",
#                   "Accept-Charset",
#                   "Accept-Datetime",
#                   "Accept-Encoding",
#                   "Accept-Language",
#                   "Authorization",
#                   "CloudFront-Forwarded-Proto",
#                   "Host",
#                   "Origin",
#                   "Referer",
#               ]
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    min_ttl                = 0
#    default_ttl            = 86400
#    max_ttl                = 31536000
#    compress               = true
#    viewer_protocol_policy = "allow-all"
# }
#
#  ordered_cache_behavior {
#    path_pattern     = "*.js"
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "${aws_lb.uat-cffg-app-alb.name}"
#
#    forwarded_values {
#      query_string = false
#      headers      = [
#                   "Accept",
#                   "Accept-Charset",
#                   "Accept-Datetime",
#                   "Accept-Encoding",
#                   "Accept-Language",
#                   "Authorization",
#                   "CloudFront-Forwarded-Proto",
#                   "Host",
#                   "Origin",
#                   "Referer",
#                ]
#
#      cookies {
#        forward = "none"
#     }
#    }
#
#    min_ttl                = 0
#    default_ttl            = 86400
#    max_ttl                = 31536000
#    compress               = true
#    viewer_protocol_policy = "allow-all"
#  }

viewer_certificate {
    acm_certificate_arn = var.uat_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}
