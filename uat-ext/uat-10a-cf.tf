# Initial Setup

provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}

resource "aws_ebs_encryption_by_default" "uat-encryption" {
  enabled = true
}

#resource "aws_shield_protection" "uat-cf-shield" {
#  name         = "UAT BCE CloudFront Shield"
#  resource_arn = "${aws_cloudfront_distribution.uat-bce-cf-ext-b.arn}"
#
#  tags = {
#    Environment = "UAT"
#  }
#}

# UAT External CF for BCE

resource "aws_cloudfront_distribution" "uat-bce-cf-ext-b" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.bcereviews-uat.org.uk", "bcereviews-uat.org.uk"]
  web_acl_id       = "${aws_waf_web_acl.uat-bce-waf-acl-b.id}"
  origin {
    domain_name = var.uat_bce_alb_name
    origin_id   = var.uat_bce_alb_origin

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.uat-bce-cloudfront-logs-co.bucket_domain_name
    prefix          = "uatbceco"
  }
  origin {
    domain_name = "uat-bcp-maintenance-co.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "UAT-Maintenance-CO"
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
    target_origin_id = var.uat_bce_alb_origin

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }

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
#    target_origin_id = var.uat_bce_alb_origin
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
#    target_origin_id = var.uat_bce_alb_origin
#
#    forwarded_values {
#      query_string = false
#      headers      = [
#                   "Accept",
#                   "Accept-Charset",
#                  "Accept-Datetime",
#                  "Accept-Encoding",
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

# UAT External CF for BCS

resource "aws_cloudfront_distribution" "uat-bcs-cf-ext-b" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.bcs2023demo.com", "bcs2023demo.com"]
  web_acl_id       = "${aws_waf_web_acl.uat-bcs-waf-acl-b.id}"
  origin {
    domain_name = var.uat_bcs_alb_name
    origin_id   = var.uat_bcs_alb_origin

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.uat-bcs-cloudfront-logs-co.bucket_domain_name
    prefix          = "uatbcsco"
  }
  origin {
    domain_name = "uat-bcp-maintenance-co.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "UAT-Maintenance-CO"
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
    target_origin_id = var.uat_bcs_alb_origin

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }

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
#    target_origin_id = var.uat_bcs_alb_origin
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
#    target_origin_id = var.uat_bcs_alb_origin
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
    acm_certificate_arn = var.uat_cert3
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# UAT External CF for BCW

resource "aws_cloudfront_distribution" "uat-bcw-cf-ext-b" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.bcw-2023.org.uk", "bcw-2023.org.uk"]
  web_acl_id       = "${aws_waf_web_acl.uat-bcw-waf-acl-b.id}"
  origin {
    domain_name = var.uat_bcw_alb_name
    origin_id   = var.uat_bcw_alb_origin

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.uat-bcw-cloudfront-logs-co.bucket_domain_name
    prefix          = "uatbcwco"
  }
  origin {
    domain_name = "uat-bcp-maintenance-co.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "UAT-Maintenance-CO"
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
    target_origin_id = var.uat_bcw_alb_origin

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }

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
#    target_origin_id = var.uat_bcw_alb_origin
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
#    target_origin_id = var.uat_bcw_alb_origin
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
    acm_certificate_arn = var.uat_cert4
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# UAT External CF for CFFG

resource "aws_cloudfront_distribution" "uat-cffg-cf-ext-b" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.cffg-2023.org.uk", "cffg-2023.org.uk"]
  web_acl_id       = "${aws_waf_web_acl.uat-cffg-waf-acl-b.id}"
  origin {
    domain_name = var.uat_cffg_alb_name
    origin_id   = var.uat_cffg_alb_origin

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.uat-cffg-cloudfront-logs-co.bucket_domain_name
    prefix          = "uatcffgco"
  }
  origin {
    domain_name = "uat-bcp-maintenance-co.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "UAT-Maintenance-CO"
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
    target_origin_id = var.uat_cffg_alb_origin

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }

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
#    target_origin_id = var.uat_cffg_alb_origin
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
#    target_origin_id = var.uat_cffg_alb_origin
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
    acm_certificate_arn = var.uat_cert5
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

