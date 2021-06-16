# block redacted as an example of direct traffic to ALB (BCDR scenario)

#resource "aws_route53_record" "uat_bce" {
#  zone_id = var.bce_zone 
#  name    = "uat.bce2023.co.uk" 
#  type    = "CNAME"
#  ttl     = "60"
#  records = ["${aws_lb.uat-bce-app-alb.dns_name}"]
#}

resource "aws_route53_record" "uat_bce" {
  zone_id = var.bce_zone
  name    = "uat.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.uat-bce-cf.domain_name}"]
}

# block redacted as an example of direct traffic to ALB (BCDR scenario)

#resource "aws_route53_record" "www_uat_bce" {
#  zone_id = var.bce_zone
#  name    = "www.uat.bce2023.co.uk"
#  type    = "CNAME"
#  ttl     = "60"
#  records = ["${aws_lb.uat-bce-app-alb.dns_name}"]
#}

resource "aws_route53_record" "www_uat_bce" {
  zone_id = var.bce_zone
  name    = "www.uat.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.uat-bce-cf.domain_name}"]
}

resource "aws_route53_record" "uat_bcs" {
  zone_id = var.bcs_zone
  name    = "uat.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.uat-bcs-cf.domain_name}"]
}

resource "aws_route53_record" "www_uat_bcs" {
  zone_id = var.bcs_zone
  name    = "www.uat.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.uat-bcs-cf.domain_name}"]
}

resource "aws_route53_record" "uat_bcw" {
  zone_id = var.bcw_zone
  name    = "uat.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"  
  records = ["${aws_cloudfront_distribution.uat-bcw-cf.domain_name}"]
}

resource "aws_route53_record" "www_uat_bcw" {
  zone_id = var.bcw_zone
  name    = "www.uat.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.uat-bcw-cf.domain_name}"]
}

resource "aws_route53_record" "uat_cffg" {
  zone_id = var.cffg_zone
  name    = "uat.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.uat-cffg-cf.domain_name}"]
}

resource "aws_route53_record" "www_uat_cffg" {
  zone_id = var.cffg_zone
  name    = "www.uat.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_cloudfront_distribution.uat-cffg-cf.domain_name}"]
}

# Provide static CNAME's for single RDS endpoint

resource "aws_route53_record" "bce_uat_db" {
  zone_id = var.bce_zone
  name    = "uatdb.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.uat-bcp-db.address}"]
}

resource "aws_route53_record" "bcs_uat_db" {
  zone_id = var.bcs_zone
  name    = "uatdb.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.uat-bcp-db.address}"]
}
resource "aws_route53_record" "bcw_uat_db" {
  zone_id = var.bcw_zone
  name    = "uatdb.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.uat-bcp-db.address}"]
}
resource "aws_route53_record" "cffg_uat_db" {
  zone_id = var.cffg_zone
  name    = "uatdb.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.uat-bcp-db.address}"]
}

# create zones for commissions

resource "aws_route53_zone" "uat-bce" {
  name = "bcereviews-uat.org.uk"
  force_destroy = "true"
}

resource "aws_route53_zone" "uat-bcs" {
  name = "bcs2023demo.com"
  force_destroy = "true"
}

resource "aws_route53_zone" "uat-bcw" {
  name = "bcw-2023.org.uk"
  force_destroy = "true"
}

resource "aws_route53_zone" "uat-cffg" {
  name = "cffg-2023.org.uk"
  force_destroy = "true"
}

# Block redacted as traffic goes to clients CF - unredact for ours

#resource "aws_route53_record" "uat_ext_bce" {
#  zone_id = "${aws_route53_zone.uat-bce.id}"
#  name    = "bcereviews-uat.org.uk"
#  type    = "A"
#  alias {
#  name = "${aws_cloudfront_distribution.uat-bce-cf-ext.domain_name}"
#  zone_id = "${aws_cloudfront_distribution.uat-bce-cf-ext.hosted_zone_id}"
#  evaluate_target_health = false
#  }
#}

#resource "aws_route53_record" "www_uat_ext_bce" {
#  zone_id = "${aws_route53_zone.uat-bce.id}"
#  name    = "www.bcereviews-uat.org.uk"
#  type    = "CNAME"
#  ttl     = "60"
#  records = ["${aws_cloudfront_distribution.uat-bce-cf-ext.domain_name}"]
#}

# Client DB static endpoint

resource "aws_route53_record" "bce_uat_ext_db" {
  zone_id = "${aws_route53_zone.uat-bce.id}"
  name    = "uatdb.bcereviews-uat.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.uat-bcp-db.address}"]
}

resource "aws_route53_record" "bcs_uat_ext_db" {
  zone_id = "${aws_route53_zone.uat-bcs.id}"
  name    = "uatdb.bcs2023demo.com"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.uat-bcp-db.address}"]
}

resource "aws_route53_record" "bcw_uat_ext_db" {
  zone_id = "${aws_route53_zone.uat-bcw.id}"
  name    = "uatdb.bcw-2023.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.uat-bcp-db.address}"]
}

resource "aws_route53_record" "cffg_uat_ext_db" {
  zone_id = "${aws_route53_zone.uat-cffg.id}"
  name    = "uatdb.cffg-2023.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.uat-bcp-db.address}"]
}

# Client CF details for apex record

resource "aws_route53_record" "uat_ext_bce" {
  zone_id = "${aws_route53_zone.uat-bce.id}"
  name    = "bcereviews-uat.org.uk"
  type    = "A"
  alias {
  name = "d22gwzqjsqx19y.cloudfront.net"
  zone_id = "Z2FDTNDATAQYW2"
  evaluate_target_health = false
  }
}

resource "aws_route53_record" "uat_ext_bcs" {
  zone_id = "${aws_route53_zone.uat-bcs.id}"
  name    = "bcs2023demo.com"
  type    = "A"
  alias {
  name = "d338aziaac7f9b.cloudfront.net"
  zone_id = "Z2FDTNDATAQYW2"
  evaluate_target_health = false
  }
}

resource "aws_route53_record" "uat_ext_bcw" {
  zone_id = "${aws_route53_zone.uat-bcw.id}"
  name    = "bcw-2023.org.uk"
  type    = "A"
  alias {
  name = "d3bp7iq9j9cg1b.cloudfront.net"
  zone_id = "Z2FDTNDATAQYW2"
  evaluate_target_health = false
  }
}

resource "aws_route53_record" "uat_ext_cffg" {
  zone_id = "${aws_route53_zone.uat-cffg.id}"
  name    = "cffg-2023.org.uk"
  type    = "A"
  alias {
  name = "d3gevfdpkh2g7v.cloudfront.net"
  zone_id = "Z2FDTNDATAQYW2"
  evaluate_target_health = false
  }
}

# Client CF details for www record

resource "aws_route53_record" "www_uat_ext_bce" {
  zone_id = "${aws_route53_zone.uat-bce.id}"
  name    = "www.bcereviews-uat.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["d22gwzqjsqx19y.cloudfront.net"]
}

resource "aws_route53_record" "www_uat_ext_bcs" {
  zone_id = "${aws_route53_zone.uat-bcs.id}"
  name    = "www.bcs2023demo.com"
  type    = "CNAME"
  ttl     = "60"
  records = ["d338aziaac7f9b.cloudfront.net"]
}

resource "aws_route53_record" "www_uat_ext_bcw" {
  zone_id = "${aws_route53_zone.uat-bcw.id}"
  name    = "www.bcw-2023.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["d3bp7iq9j9cg1b.cloudfront.net"]
}

resource "aws_route53_record" "www_uat_ext_cffg" {
  zone_id = "${aws_route53_zone.uat-cffg.id}"
  name    = "www.cffg-2023.org.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["d3gevfdpkh2g7v.cloudfront.net"]
}

# Provide static CNAME's for alb's

resource "aws_route53_record" "bce_uat_alb" {
  zone_id = var.bce_zone
  name    = "uat-alb.bce2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.uat-bce-app-alb.dns_name}"]
}

resource "aws_route53_record" "bcs_uat_alb" {
  zone_id = var.bcs_zone
  name    = "uat-alb.bcs2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.uat-bcs-app-alb.dns_name}"]
}

resource "aws_route53_record" "bcw_uat_alb" {
  zone_id = var.bcw_zone
  name    = "uat-alb.bcw2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.uat-bcw-app-alb.dns_name}"]
}

resource "aws_route53_record" "cffg_uat_alb" {
  zone_id = var.cffg_zone
  name    = "uat-alb.cffg2023.co.uk"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.uat-cffg-app-alb.dns_name}"]
}

