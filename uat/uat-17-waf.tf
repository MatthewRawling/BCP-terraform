#UAT BCE WAF config 

resource "aws_waf_ipset" "uat-bce-waf-ip" {
  name = "uat-bce-waf-ip"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "51.149.9.112/29"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "51.149.9.240/29"
  }
}

resource "aws_waf_rule" "uat-bce-waf-rule" {
  depends_on  = [aws_waf_ipset.uat-bce-waf-ip]
  name        = "uat-bce-waf-rule"
  metric_name = "UatBceWafRule"

  predicates {
    data_id = aws_waf_ipset.uat-bce-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "uat-bce-waf-acl" {
  depends_on = [
    aws_waf_ipset.uat-bce-waf-ip,
    aws_waf_rule.uat-bce-waf-rule,
  ]
  name        = "uat-bce-waf-acl"
  metric_name = "UatBceWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.uat-bce-waf-rule.id
    type     = "REGULAR"
  }
}

#UAT BCS WAF config

resource "aws_waf_ipset" "uat-bcs-waf-ip" {
  name = "uat-bcs-waf-ip"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
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

resource "aws_waf_rule" "uat-bcs-waf-rule" {
  depends_on  = [aws_waf_ipset.uat-bcs-waf-ip]
  name        = "uat-bcs-waf-rule"
  metric_name = "UatBcsWafRule"

  predicates {
    data_id = aws_waf_ipset.uat-bcs-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "uat-bcs-waf-acl" {
  depends_on = [
    aws_waf_ipset.uat-bcs-waf-ip,
    aws_waf_rule.uat-bcs-waf-rule,
  ]
  name        = "uat-bcs-waf-acl"
  metric_name = "UatBcsWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.uat-bcs-waf-rule.id
    type     = "REGULAR"
  }
}

#UAT BCW WAF config

resource "aws_waf_ipset" "uat-bcw-waf-ip" {
  name = "uat-bcw-waf-ip"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
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

resource "aws_waf_rule" "uat-bcw-waf-rule" {
  depends_on  = [aws_waf_ipset.uat-bcw-waf-ip]
  name        = "uat-bcw-waf-rule"
  metric_name = "UatBcwWafRule"

  predicates {
    data_id = aws_waf_ipset.uat-bcw-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "uat-bcw-waf-acl" {
  depends_on = [
    aws_waf_ipset.uat-bcw-waf-ip,
    aws_waf_rule.uat-bcw-waf-rule,
  ]
  name        = "uat-bcw-waf-acl"
  metric_name = "UatBcwWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.uat-bcw-waf-rule.id
    type     = "REGULAR"
  }
}

#UAT CFFG WAF config

resource "aws_waf_ipset" "uat-cffg-waf-ip" {
  name = "uat-cffg-waf-ip"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }
}

resource "aws_waf_rule" "uat-cffg-waf-rule" {
  depends_on  = [aws_waf_ipset.uat-cffg-waf-ip]
  name        = "uat-cffg-waf-rule"
  metric_name = "UatCffgWafRule"

  predicates {
    data_id = aws_waf_ipset.uat-cffg-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "uat-cffg-waf-acl" {
  depends_on = [
    aws_waf_ipset.uat-cffg-waf-ip,
    aws_waf_rule.uat-cffg-waf-rule,
  ]
  name        = "uat-cffg-waf-acl"
  metric_name = "UatCffgWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.uat-cffg-waf-rule.id
    type     = "REGULAR"
  }
}

