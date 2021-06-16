# Setup

#resource "aws_kms_key" "dev-kms-key" {
#  description             = "dev-kms-key"
#  deletion_window_in_days = 10
#}
#
#resource "aws_cloudfront_public_key" "dev-cf-key" {
#  comment     = "DEV CloudFront Key"
#  encoded_key = aws_kms_key.dev-kms-key.key_id
#  name        = "DEV_CloudFront_Key"
#}

# DEV CF for BCE

resource "aws_cloudfront_distribution" "dev-bce-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.dev.bce2023.co.uk", "dev.bce2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.dev-bce-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.dev-bce-app-alb.dns_name}"
    origin_id   = "${aws_lb.dev-bce-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.dev-bce-cloudfront-logs.bucket_domain_name
    prefix          = "devbce"
  }
  origin {
    domain_name = "dev-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "DEV-Maintenance"
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
    target_origin_id = "${aws_lb.dev-bce-app-alb.name}"

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
#    target_origin_id = "${aws_lb.dev-bce-app-alb.name}"
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
#    target_origin_id = "${aws_lb.dev-bce-app-alb.name}"
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
    acm_certificate_arn = var.dev_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# DEV CF for BCS

resource "aws_cloudfront_distribution" "dev-bcs-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.dev.bcs2023.co.uk", "dev.bcs2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.dev-bcs-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.dev-bcs-app-alb.dns_name}"
    origin_id   = "${aws_lb.dev-bcs-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.dev-bcs-cloudfront-logs.bucket_domain_name
    prefix          = "devbcs"
  }
  origin {
    domain_name = "dev-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "DEV-Maintenance"
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
    target_origin_id = "${aws_lb.dev-bcs-app-alb.name}"

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
#    target_origin_id = "${aws_lb.dev-bcs-app-alb.name}"
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
#    target_origin_id = "${aws_lb.dev-bcs-app-alb.name}"
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
    acm_certificate_arn = var.dev_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# DEV CF for BCW

resource "aws_cloudfront_distribution" "dev-bcw-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.dev.bcw2023.co.uk", "dev.bcw2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.dev-bcw-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.dev-bcw-app-alb.dns_name}"
    origin_id   = "${aws_lb.dev-bcw-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.dev-bcw-cloudfront-logs.bucket_domain_name
    prefix          = "devbcw"
  }
  origin {
    domain_name = "dev-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "DEV-Maintenance"
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
    target_origin_id = "${aws_lb.dev-bcw-app-alb.name}"

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
#    target_origin_id = "${aws_lb.dev-bcw-app-alb.name}"
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
#    target_origin_id = "${aws_lb.dev-bcw-app-alb.name}"
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
    acm_certificate_arn = var.dev_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# DEV CF for CFFG

resource "aws_cloudfront_distribution" "dev-cffg-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.dev.cffg2023.co.uk", "dev.cffg2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.dev-cffg-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.dev-cffg-app-alb.dns_name}"
    origin_id   = "${aws_lb.dev-cffg-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.dev-cffg-cloudfront-logs.bucket_domain_name
    prefix          = "devcffg"
  }
  origin {
    domain_name = "dev-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "DEV-Maintenance"
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
    target_origin_id = "${aws_lb.dev-cffg-app-alb.name}"

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
#    target_origin_id = "${aws_lb.dev-cffg-app-alb.name}"
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
#    target_origin_id = "${aws_lb.dev-cffg-app-alb.name}"
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
    acm_certificate_arn = var.dev_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}
