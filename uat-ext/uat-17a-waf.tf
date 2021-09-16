##UAT BCE WAF config 

resource "aws_waf_ipset" "uat-bce-waf-ip-b" {
  name = "uat-bce-waf-ip-b"
  
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

resource "aws_waf_rule" "uat-bce-waf-rule-b" {
  depends_on  = [aws_waf_ipset.uat-bce-waf-ip-b]
  name        = "uat-bce-waf-rule-b"
  metric_name = "UatBceWafRuleB"

  predicates {
    data_id = aws_waf_ipset.uat-bce-waf-ip-b.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "uat-bce-waf-acl-b" {
  depends_on = [
    aws_waf_ipset.uat-bce-waf-ip-b,
    aws_waf_rule.uat-bce-waf-rule-b,
  ]
  name        = "uat-bce-waf-acl-b"
  metric_name = "UatBceWafAclB"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.uat-bce-waf-rule-b.id
    type     = "REGULAR"
  }
}

#UAT BCS WAF config

resource "aws_waf_ipset" "uat-bcs-waf-ip-b" {
  name = "uat-bcs-waf-ip-b"

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

resource "aws_waf_rule" "uat-bcs-waf-rule-b" {
  depends_on  = [aws_waf_ipset.uat-bcs-waf-ip-b]
  name        = "uat-bcs-waf-rule-b"
  metric_name = "UatBcsWafRuleB"

  predicates {
    data_id = aws_waf_ipset.uat-bcs-waf-ip-b.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "uat-bcs-waf-acl-b" {
  depends_on = [
    aws_waf_ipset.uat-bcs-waf-ip-b,
    aws_waf_rule.uat-bcs-waf-rule-b,
  ]
  name        = "uat-bcs-waf-acl-b"
  metric_name = "UatBcsWafAclB"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.uat-bcs-waf-rule-b.id
    type     = "REGULAR"
  }
}

#UAT BCW WAF config

resource "aws_waf_ipset" "uat-bcw-waf-ip-b" {
  name = "uat-bcw-waf-ip-b"

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

resource "aws_waf_rule" "uat-bcw-waf-rule-b" {
  depends_on  = [aws_waf_ipset.uat-bcw-waf-ip-b]
  name        = "uat-bcw-waf-rule-b"
  metric_name = "UatBcwWafRuleB"

  predicates {
    data_id = aws_waf_ipset.uat-bcw-waf-ip-b.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "uat-bcw-waf-acl-b" {
  depends_on = [
    aws_waf_ipset.uat-bcw-waf-ip-b,
    aws_waf_rule.uat-bcw-waf-rule-b,
  ]
  name        = "uat-bcw-waf-acl-b"
  metric_name = "UatBcwWafAclB"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.uat-bcw-waf-rule-b.id
    type     = "REGULAR"
  }
}

#UAT CFFG WAF config

resource "aws_waf_ipset" "uat-cffg-waf-ip-b" {
  name = "uat-cffg-waf-ip-b"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }
}

resource "aws_waf_rule" "uat-cffg-waf-rule-b" {
  depends_on  = [aws_waf_ipset.uat-cffg-waf-ip-b]
  name        = "uat-cffg-waf-rule-b"
  metric_name = "UatCffgWafRuleB"

  predicates {
    data_id = aws_waf_ipset.uat-cffg-waf-ip-b.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "uat-cffg-waf-acl-b" {
  depends_on = [
    aws_waf_ipset.uat-cffg-waf-ip-b,
    aws_waf_rule.uat-cffg-waf-rule-b,
  ]
  name        = "uat-cffg-waf-acl-b"
  metric_name = "UatCffgWafAclB"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.uat-cffg-waf-rule-b.id
    type     = "REGULAR"
  }
}

