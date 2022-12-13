#PROD BCE WAF config 

resource "aws_waf_ipset" "prod-bce-waf-ip" {
  name = "prod-bce-waf-ip"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "5.148.17.54/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }
}

resource "aws_waf_rule" "prod-bce-waf-rule" {
  depends_on  = [aws_waf_ipset.prod-bce-waf-ip]
  name        = "prod-bce-waf-rule"
  metric_name = "ProdBceWafRule"

  predicates {
    data_id = aws_waf_ipset.prod-bce-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "prod-bce-waf-acl" {
  depends_on = [
    aws_waf_ipset.prod-bce-waf-ip,
    aws_waf_rule.prod-bce-waf-rule,
  ]
  name        = "prod-bce-waf-acl"
  metric_name = "ProdBceWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.prod-bce-waf-rule.id
    type     = "REGULAR"
  }
}

#PROD BCS WAF config

resource "aws_waf_ipset" "prod-bcs-waf-ip" {
  name = "prod-bcs-waf-ip"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "5.148.17.54/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "164.134.2.0/24"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "164.134.2.0/24"
  }
  ip_set_descriptors {
    type  = "IPV4"
    value = "164.134.3.132/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "164.134.6.220/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "164.134.1.133/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "164.134.6.244/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "164.134.2.3/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "164.134.2.12/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "164.134.2.67/32"
  }
}

resource "aws_waf_rule" "prod-bcs-waf-rule" {
  depends_on  = [aws_waf_ipset.prod-bcs-waf-ip]
  name        = "prod-bcs-waf-rule"
  metric_name = "ProdBcsWafRule"

  predicates {
    data_id = aws_waf_ipset.prod-bcs-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "prod-bcs-waf-acl" {
  depends_on = [
    aws_waf_ipset.prod-bcs-waf-ip,
    aws_waf_rule.prod-bcs-waf-rule,
  ]
  name        = "prod-bcs-waf-acl"
  metric_name = "ProdBcsWafAcl"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.prod-bcs-waf-rule.id
    type     = "REGULAR"
  }
}

#PROD BCW WAF config

resource "aws_waf_ipset" "prod-bcw-waf-ip" {
  name = "prod-bcw-waf-ip"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "5.148.17.54/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "165.225.80.0/24"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "147.161.166.0/24"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "165.225.196.0/24"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "165.225.197.0/24"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "165.225.198.0/24"
  }
}

resource "aws_waf_rule" "prod-bcw-waf-rule" {
  depends_on  = [aws_waf_ipset.prod-bcw-waf-ip]
  name        = "prod-bcw-waf-rule"
  metric_name = "ProdBcwWafRule"

  predicates {
    data_id = aws_waf_ipset.prod-bcw-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "prod-bcw-waf-acl" {
  depends_on = [
    aws_waf_ipset.prod-bcw-waf-ip,
    aws_waf_rule.prod-bcw-waf-rule,
  ]
  name        = "prod-bcw-waf-acl"
  metric_name = "ProdBcwWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.prod-bcw-waf-rule.id
    type     = "REGULAR"
  }
}

#PROD CFFG WAF config

resource "aws_waf_ipset" "prod-cffg-waf-ip" {
  name = "prod-cffg-waf-ip"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "5.148.17.54/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "165.225.80.0/24"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "147.161.166.0/24"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "165.225.196.0/24"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "165.225.197.0/24"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "165.225.198.0/24"
  }
}

resource "aws_waf_rule" "prod-cffg-waf-rule" {
  depends_on  = [aws_waf_ipset.prod-cffg-waf-ip]
  name        = "prod-cffg-waf-rule"
  metric_name = "ProdCffgWafRule"

  predicates {
    data_id = aws_waf_ipset.prod-cffg-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "prod-cffg-waf-acl" {
  depends_on = [
    aws_waf_ipset.prod-cffg-waf-ip,
    aws_waf_rule.prod-cffg-waf-rule,
  ]
  name        = "prod-cffg-waf-acl"
  metric_name = "ProdCffgWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.prod-cffg-waf-rule.id
    type     = "REGULAR"
  }
}

