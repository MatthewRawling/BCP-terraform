# block redacted as an example of direct traffic to ALB (BCDR scenario)

#resource "aws_route53_record" "prod_bce" {
#  zone_id = var.bce_zone 
#  name    = "prod.bce2023.co.uk" 
#  type    = "CNAME"
#  ttl     = "60"
#  records = ["${aws_lb.prod-bce-app-alb.dns_name}"]
#}

resource "aws_route53_record" "prod_bce" {
  zone_id = var.bce_zone
  name    = "prod.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.prod-bce-cf.domain_name}"]
}

# block redacted as an example of direct traffic to ALB (BCDR scenario)

#resource "aws_route53_record" "www_prod_bce" {
#  zone_id = var.bce_zone
#  name    = "www.prod.bce2023.co.uk"
#  type    = "CNAME"
#  ttl     = "60"
#  records = ["${aws_lb.prod-bce-app-alb.dns_name}"]
#}

resource "aws_route53_record" "www_prod_bce" {
  zone_id = var.bce_zone
  name    = "www.prod.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.prod-bce-cf.domain_name}"]
}

resource "aws_route53_record" "prod_bcs" {
  zone_id = var.bcs_zone
  name    = "prod.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.prod-bcs-cf.domain_name}"]
}

resource "aws_route53_record" "www_prod_bcs" {
  zone_id = var.bcs_zone
  name    = "www.prod.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.prod-bcs-cf.domain_name}"]
}

resource "aws_route53_record" "prod_bcw" {
  zone_id = var.bcw_zone
  name    = "prod.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.prod-bcw-cf.domain_name}"]
}

resource "aws_route53_record" "www_prod_bcw" {
  zone_id = var.bcw_zone
  name    = "www.prod.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.prod-bcw-cf.domain_name}"]
}

resource "aws_route53_record" "prod_cffg" {
  zone_id = var.cffg_zone
  name    = "prod.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.prod-cffg-cf.domain_name}"]
}

resource "aws_route53_record" "www_prod_cffg" {
  zone_id = var.cffg_zone
  name    = "www.prod.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.prod-cffg-cf.domain_name}"]
}

# Provide static CNAME's for single RDS endpoint

resource "aws_route53_record" "bce_prod_db" {
  zone_id = var.bce_zone
  name    = "proddb.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.prod-bcp-db.address}"]
}

resource "aws_route53_record" "bcs_prod_db" {
  zone_id = var.bcs_zone
  name    = "proddb.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.prod-bcp-db.address}"]
}
resource "aws_route53_record" "bcw_prod_db" {
  zone_id = var.bcw_zone
  name    = "proddb.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.prod-bcp-db.address}"]
}
resource "aws_route53_record" "cffg_prod_db" {
  zone_id = var.cffg_zone
  name    = "proddb.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.prod-bcp-db.address}"]
}

# create zones for commissions

resource "aws_route53_zone" "prod-bce" {
  name = "bcereviews.org.uk"
  force_destroy = "true"
}

resource "aws_route53_zone" "prod-bcs" {
  name = "bcs2023review.com"
  force_destroy = "true"
}

resource "aws_route53_zone" "prod-bcw" {
  name = "bcw-reviews.org.uk"
  force_destroy = "true"
}

resource "aws_route53_zone" "prod-cffg" {
  name = "cffg-arolygon.org.uk"
  force_destroy = "true"
}

# Block redacted as traffic goes to clients CF - unredact for ours

#resource "aws_route53_record" "prod_ext_bce" {
#  zone_id = "${aws_route53_zone.prod-bce.id}"
#  name    = "bcereviews-prod.org.uk"
#  type    = "A"
#  alias {
#  name = "${aws_cloudfront_distribution.prod-bce-cf-ext.domain_name}"
#  zone_id = "${aws_cloudfront_distribution.prod-bce-cf-ext.hosted_zone_id}"
#  evalprode_target_health = false
#  }
#}

#resource "aws_route53_record" "www_prod_ext_bce" {
#  zone_id = "${aws_route53_zone.prod-bce.id}"
#  name    = "www.bcereviews-prod.org.uk"
#  type    = "CNAME"
#  ttl     = "60"
#  records = ["${aws_cloudfront_distribution.prod-bce-cf-ext.domain_name}"]
#}

# Client DB static endpoint

resource "aws_route53_record" "bce_prod_ext_db" {
  zone_id = "${aws_route53_zone.prod-bce.id}"
  name    = "proddb.bcereviews.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.prod-bcp-db.address}"]
}

resource "aws_route53_record" "bcs_prod_ext_db" {
  zone_id = "${aws_route53_zone.prod-bcs.id}"
  name    = "proddb.bcs2023review.com"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.prod-bcp-db.address}"]
}

resource "aws_route53_record" "bcw_prod_ext_db" {
  zone_id = "${aws_route53_zone.prod-bcw.id}"
  name    = "proddb.bcw-reviews.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.prod-bcp-db.address}"]
}

resource "aws_route53_record" "cffg_prod_ext_db" {
  zone_id = "${aws_route53_zone.prod-cffg.id}"
  name    = "proddb.cffg-arolygon.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.prod-bcp-db.address}"]
}

# Client CF details for apex record

resource "aws_route53_record" "prod_ext_bce" {
  zone_id = "${aws_route53_zone.prod-bce.id}"
  name    = "bcereviews.org.uk"
  type    = "A"
  alias {
  name = "d25sxuc2gisn3p.cloudfront.net"
  zone_id = "Z2FDTNDATAQYW2"
  evaluate_target_health = false
  }
}

resource "aws_route53_record" "prod_ext_bcs" {
  zone_id = "${aws_route53_zone.prod-bcs.id}"
  name    = "bcs2023review.com"
  type    = "A"
  alias {
  name = "d2ick9puu68nsc.cloudfront.net"
  zone_id = "Z2FDTNDATAQYW2"
   evaluate_target_health = false
  }
}

resource "aws_route53_record" "prod_ext_bcw" {
  zone_id = "${aws_route53_zone.prod-bcw.id}"
  name    = "bcw-reviews.org.uk"
  type    = "A"
  alias {
  name = "d3qmqqmwnu4ong.cloudfront.net"
  zone_id = "Z2FDTNDATAQYW2"
   evaluate_target_health = false
  }
}

resource "aws_route53_record" "prod_ext_cffg" {
  zone_id = "${aws_route53_zone.prod-cffg.id}"
  name    = "cffg-arolygon.org.uk"
  type    = "A"
  alias {
  name = "d17s7034xejv85.cloudfront.net"
  zone_id = "Z2FDTNDATAQYW2"
   evaluate_target_health = false
  }
}

# Client CF details for www record

resource "aws_route53_record" "www_prod_ext_bce" {
  zone_id = "${aws_route53_zone.prod-bce.id}"
  name    = "www.bcereviews.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["d22gwzqjsqx19y.cloudfront.net"]
}

resource "aws_route53_record" "www_prod_ext_bcs" {
  zone_id = "${aws_route53_zone.prod-bcs.id}"
  name    = "www.bcs2023review.com"
  type    = "CNAME"
  ttl     = "60"
  records = ["d338aziaac7f9b.cloudfront.net"]
}

resource "aws_route53_record" "www_prod_ext_bcw" {
  zone_id = "${aws_route53_zone.prod-bcw.id}"
  name    = "www.bcw-reviews.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["d3qmqqmwnu4ong.cloudfront.net"]
}

resource "aws_route53_record" "www_prod_ext_cffg" {
  zone_id = "${aws_route53_zone.prod-cffg.id}"
  name    = "www.cffg-arolygon.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["d17s7034xejv85.cloudfront.net"]
}

# Provide static CNAME's for alb's

resource "aws_route53_record" "bce_prod_alb" {
  zone_id = var.bce_zone
  name    = "prod-alb.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.prod-bce-app-alb.dns_name}"]
}

resource "aws_route53_record" "bcs_prod_alb" {
  zone_id = var.bcs_zone
  name    = "prod-alb.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.prod-bcs-app-alb.dns_name}"]
}

resource "aws_route53_record" "bcw_prod_alb" {
  zone_id = var.bcw_zone
  name    = "prod-alb.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.prod-bcw-app-alb.dns_name}"]
}

resource "aws_route53_record" "cffg_prod_alb" {
  zone_id = var.cffg_zone
  name    = "prod-alb.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.prod-cffg-app-alb.dns_name}"]
}

