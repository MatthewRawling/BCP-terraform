# block redacted as an example of direct traffic to ALB (BCDR scenario)

#resource "aws_route53_record" "dev_bce" {
#  zone_id = var.bce_zone 
#  name    = "dev.bce2023.co.uk" 
#  type    = "CNAME"
#  ttl     = "60"
#  records = ["${aws_lb.dev-bce-app-alb.dns_name}"]
#}

resource "aws_route53_record" "dev_bce" {
  zone_id = var.bce_zone
  name    = "dev.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.dev-bce-cf.domain_name}"]
}

# block redacted as an example of direct traffic to ALB (BCDR scenario)

#resource "aws_route53_record" "www_dev_bce" {
#  zone_id = var.bce_zone
#  name    = "www.dev.bce2023.co.uk"
#  type    = "CNAME"
#  ttl     = "60"
#  records = ["${aws_lb.dev-bce-app-alb.dns_name}"]
#}

resource "aws_route53_record" "www_dev_bce" {
  zone_id = var.bce_zone
  name    = "www.dev.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.dev-bce-cf.domain_name}"]
}

resource "aws_route53_record" "dev_bcs" {
  zone_id = var.bcs_zone
  name    = "dev.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.dev-bcs-cf.domain_name}"]
}

resource "aws_route53_record" "www_dev_bcs" {
  zone_id = var.bcs_zone
  name    = "www.dev.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.dev-bcs-cf.domain_name}"]
}

resource "aws_route53_record" "dev_bcw" {
  zone_id = var.bcw_zone
  name    = "dev.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.dev-bcw-cf.domain_name}"]
}

resource "aws_route53_record" "www_dev_bcw" {
  zone_id = var.bcw_zone
  name    = "www.dev.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.dev-bcw-cf.domain_name}"]
}

resource "aws_route53_record" "dev_cffg" {
  zone_id = var.cffg_zone
  name    = "dev.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.dev-cffg-cf.domain_name}"]
}

resource "aws_route53_record" "www_dev_cffg" {
  zone_id = var.cffg_zone
  name    = "www.dev.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.dev-cffg-cf.domain_name}"]
}

# Provide static CNAME's for single RDS endpoint

resource "aws_route53_record" "bce_dev_db" {
  zone_id = var.bce_zone
  name    = "devdb.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.dev-bcp-db.address}"]
}

resource "aws_route53_record" "bcs_dev_db" {
  zone_id = var.bcs_zone
  name    = "devdb.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.dev-bcp-db.address}"]
}
resource "aws_route53_record" "bcw_dev_db" {
  zone_id = var.bcw_zone
  name    = "devdb.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.dev-bcp-db.address}"]
}
resource "aws_route53_record" "cffg_dev_db" {
  zone_id = var.cffg_zone
  name    = "devdb.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.dev-bcp-db.address}"]
}

# Provide static CNAME's for alb's

resource "aws_route53_record" "bce_dev_alb" {
  zone_id = var.bce_zone
  name    = "dev-alb.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.dev-bce-app-alb.dns_name}"]
}

resource "aws_route53_record" "bcs_dev_alb" {
  zone_id = var.bcs_zone
  name    = "dev-alb.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.dev-bcs-app-alb.dns_name}"]
}

resource "aws_route53_record" "bcw_dev_alb" {
  zone_id = var.bcw_zone
  name    = "dev-alb.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.dev-bcw-app-alb.dns_name}"]
}

resource "aws_route53_record" "cffg_dev_alb" {
  zone_id = var.cffg_zone
  name    = "dev-alb.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.dev-cffg-app-alb.dns_name}"]
}

