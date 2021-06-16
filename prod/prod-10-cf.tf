# Setup

#resource "aws_kms_key" "prod-kms-key" {
#  description             = "prod-kms-key"
#  deletion_window_in_days = 10
#}
#
#resource "aws_cloudfront_public_key" "prod-cf-key" {
#  comment     = "PROD CloudFront Key"
#  encoded_key = aws_kms_key.prod-kms-key.key_id
#  name        = "PROD_CloudFront_Key"
#}

# PROD CF for BCE

resource "aws_cloudfront_distribution" "prod-bce-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.prod.bce2023.co.uk", "prod.bce2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.prod-bce-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.prod-bce-app-alb.dns_name}"
    origin_id   = "${aws_lb.prod-bce-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.prod-bce-cloudfront-logs.bucket_domain_name
    prefix          = "prodbce"
  }
  origin {
    domain_name = "prod-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "PROD-Maintenance"
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
    target_origin_id = "${aws_lb.prod-bce-app-alb.name}"

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
#    target_origin_id = "${aws_lb.prod-bce-app-alb.name}"
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
#    target_origin_id = "${aws_lb.prod-bce-app-alb.name}"
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
    acm_certificate_arn = var.prod_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# PROD CF for BCS

resource "aws_cloudfront_distribution" "prod-bcs-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.prod.bcs2023.co.uk", "prod.bcs2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.prod-bcs-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.prod-bcs-app-alb.dns_name}"
    origin_id   = "${aws_lb.prod-bcs-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.prod-bcs-cloudfront-logs.bucket_domain_name
    prefix          = "prodbcs"
  }
  origin {
    domain_name = "prod-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "PROD-Maintenance"
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
    target_origin_id = "${aws_lb.prod-bcs-app-alb.name}"

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
#    target_origin_id = "${aws_lb.prod-bcs-app-alb.name}"
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
#    target_origin_id = "${aws_lb.prod-bcs-app-alb.name}"
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
    acm_certificate_arn = var.prod_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# PROD CF for BCW

resource "aws_cloudfront_distribution" "prod-bcw-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.prod.bcw2023.co.uk", "prod.bcw2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.prod-bcw-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.prod-bcw-app-alb.dns_name}"
    origin_id   = "${aws_lb.prod-bcw-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.prod-bcw-cloudfront-logs.bucket_domain_name
    prefix          = "prodbcw"
  }
  origin {
    domain_name = "prod-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "PROD-Maintenance"
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
    target_origin_id = "${aws_lb.prod-bcw-app-alb.name}"

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
#    target_origin_id = "${aws_lb.prod-bcw-app-alb.name}"
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
#    target_origin_id = "${aws_lb.prod-bcw-app-alb.name}"
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
    acm_certificate_arn = var.prod_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# PROD CF for CFFG

resource "aws_cloudfront_distribution" "prod-cffg-cf" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.prod.cffg2023.co.uk", "prod.cffg2023.co.uk"]
  web_acl_id       = "${aws_waf_web_acl.prod-cffg-waf-acl.id}"
  origin {
    domain_name = "${aws_lb.prod-cffg-app-alb.dns_name}"
    origin_id   = "${aws_lb.prod-cffg-app-alb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }    
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.prod-cffg-cloudfront-logs.bucket_domain_name
    prefix          = "prodcffg"
  }
  origin {
    domain_name = "prod-bcp-maintenance.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "PROD-Maintenance"
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
    target_origin_id = "${aws_lb.prod-cffg-app-alb.name}"

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
#    target_origin_id = "${aws_lb.prod-cffg-app-alb.name}"
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
#    target_origin_id = "${aws_lb.prod-cffg-app-alb.name}"
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
    acm_certificate_arn = var.prod_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}
