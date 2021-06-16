# Initial Setup

provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}

resource "aws_ebs_encryption_by_default" "prod-encryption" {
  enabled = true
}

#resource "aws_shield_protection" "prod-cf-shield" {
#  name         = "PROD BCE CloudFront Shield"
#  resource_arn = "${aws_cloudfront_distribution.prod-bce-cf-ext-b.arn}"
#
#  tags = {
#    Environment = "PROD"
#  }
#}

# PROD External CF for BCE

resource "aws_cloudfront_distribution" "prod-bce-cf-ext-b" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.bcereviews.org.uk", "bcereviews.org.uk"]
  web_acl_id       = "${aws_waf_web_acl.prod-bce-waf-acl-b.id}"
  origin {
    domain_name = var.prod_bce_alb_name
    origin_id   = var.prod_bce_alb_origin

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.prod-bce-cloudfront-logs-co.bucket_domain_name
    prefix          = "prodbceco"
  }
  origin {
    domain_name = "prod-bcp-maintenance-co.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "PROD-Maintenance-CO"
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
    target_origin_id = var.prod_bce_alb_origin

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
#    target_origin_id = var.prod_bce_alb_origin
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
#    target_origin_id = var.prod_bce_alb_origin
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
    acm_certificate_arn = var.prod_cert2
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# PROD External CF for BCS

resource "aws_cloudfront_distribution" "prod-bcs-cf-ext-b" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.bcs2023review.com", "bcs2023review.com"]
  web_acl_id       = "${aws_waf_web_acl.prod-bcs-waf-acl-b.id}"
  origin {
    domain_name = var.prod_bcs_alb_name
    origin_id   = var.prod_bcs_alb_origin

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.prod-bcs-cloudfront-logs-co.bucket_domain_name
    prefix          = "prodbcsco"
  }
  origin {
    domain_name = "prod-bcp-maintenance-co.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "PROD-Maintenance-CO"
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
    target_origin_id = var.prod_bcs_alb_origin

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
#    target_origin_id = var.prod_bcs_alb_origin
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
#    target_origin_id = var.prod_bcs_alb_origin
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
    acm_certificate_arn = var.prod_cert3
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# PROD External CF for BCW

resource "aws_cloudfront_distribution" "prod-bcw-cf-ext-b" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.bcw-reviews.org.uk", "bcw-reviews.org.uk"]
  web_acl_id       = "${aws_waf_web_acl.prod-bcw-waf-acl-b.id}"
  origin {
    domain_name = var.prod_bcw_alb_name
    origin_id   = var.prod_bcw_alb_origin

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.prod-bcw-cloudfront-logs-co.bucket_domain_name
    prefix          = "prodbcwco"
  }
  origin {
    domain_name = "prod-bcp-maintenance-co.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "PROD-Maintenance-CO"
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
    target_origin_id = var.prod_bcw_alb_origin

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
#    target_origin_id = var.prod_bcw_alb_origin
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
#    target_origin_id = var.prod_bcw_alb_origin
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
    acm_certificate_arn = var.prod_cert4
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

# PROD External CF for CFFG

resource "aws_cloudfront_distribution" "prod-cffg-cf-ext-b" {
  retain_on_delete = false
  enabled          = true
  aliases = ["www.cffg-arolygon.org.uk", "cffg-arolygon.org.uk"]
  web_acl_id       = "${aws_waf_web_acl.prod-cffg-waf-acl-b.id}"
  origin {
    domain_name = var.prod_cffg_alb_name
    origin_id   = var.prod_cffg_alb_origin

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
    logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.prod-cffg-cloudfront-logs-co.bucket_domain_name
    prefix          = "prodcffgco"
  }
  origin {
    domain_name = "prod-bcp-maintenance-co.s3-website.eu-west-2.amazonaws.com"
    origin_id   = "PROD-Maintenance-CO"
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
    target_origin_id = var.prod_cffg_alb_origin

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
#    target_origin_id = var.prod_cffg_alb_origin
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
#    target_origin_id = var.prod_cffg_alb_origin
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
    acm_certificate_arn = var.prod_cert5
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }

price_class = "PriceClass_All"

}

