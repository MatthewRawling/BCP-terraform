#PROD BCE WAF config 

resource "aws_waf_ipset" "prod-bce-waf-ip-b" {
  name = "prod-bce-waf-ip-b"
  
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

resource "aws_waf_rule" "prod-bce-waf-rule-b" {
  depends_on  = [aws_waf_ipset.prod-bce-waf-ip-b]
  name        = "prod-bce-waf-rule-b"
  metric_name = "ProdBceWafRuleB"

  predicates {
    data_id = aws_waf_ipset.prod-bce-waf-ip-b.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "prod-bce-waf-acl-b" {
  depends_on = [
    aws_waf_ipset.prod-bce-waf-ip-b,
    aws_waf_rule.prod-bce-waf-rule-b,
  ]
  name        = "prod-bce-waf-acl-b"
  metric_name = "ProdBceWafAclB"

  default_action {
    type = "ALLOW"
    #change type to "block" to restrict to IP list
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.prod-bce-waf-rule-b.id
    type     = "REGULAR"
  }
}

#PROD BCS WAF config

resource "aws_waf_ipset" "prod-bcs-waf-ip-b" {
  name = "prod-bcs-waf-ip-b"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }
}

resource "aws_waf_rule" "prod-bcs-waf-rule-b" {
  depends_on  = [aws_waf_ipset.prod-bcs-waf-ip-b]
  name        = "prod-bcs-waf-rule-b"
  metric_name = "ProdBcsWafRuleB"

  predicates {
    data_id = aws_waf_ipset.prod-bcs-waf-ip-b.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "prod-bcs-waf-acl-b" {
  depends_on = [
    aws_waf_ipset.prod-bcs-waf-ip-b,
    aws_waf_rule.prod-bcs-waf-rule-b,
  ]
  name        = "prod-bcs-waf-acl-b"
  metric_name = "ProdBcsWafAclB"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.prod-bcs-waf-rule-b.id
    type     = "REGULAR"
  }
}

#PROD BCW WAF config

resource "aws_waf_ipset" "prod-bcw-waf-ip-b" {
  name = "prod-bcw-waf-ip-b"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }
}

resource "aws_waf_rule" "prod-bcw-waf-rule-b" {
  depends_on  = [aws_waf_ipset.prod-bcw-waf-ip-b]
  name        = "prod-bcw-waf-rule-b"
  metric_name = "ProdBcwWafRuleB"

  predicates {
    data_id = aws_waf_ipset.prod-bcw-waf-ip-b.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "prod-bcw-waf-acl-b" {
  depends_on = [
    aws_waf_ipset.prod-bcw-waf-ip-b,
    aws_waf_rule.prod-bcw-waf-rule-b,
  ]
  name        = "prod-bcw-waf-acl-b"
  metric_name = "ProdBcwWafAclB"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.prod-bcw-waf-rule-b.id
    type     = "REGULAR"
  }
}

#PROD CFFG WAF config

resource "aws_waf_ipset" "prod-cffg-waf-ip-b" {
  name = "prod-cffg-waf-ip-b"

  ip_set_descriptors {
    type  = "IPV4"
    value = "92.54.181.130/32"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "213.160.107.50/32"
  }
}

resource "aws_waf_rule" "prod-cffg-waf-rule-b" {
  depends_on  = [aws_waf_ipset.prod-cffg-waf-ip-b]
  name        = "prod-cffg-waf-rule-b"
  metric_name = "ProdCffgWafRuleB"

  predicates {
    data_id = aws_waf_ipset.prod-cffg-waf-ip-b.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "prod-cffg-waf-acl-b" {
  depends_on = [
    aws_waf_ipset.prod-cffg-waf-ip-b,
    aws_waf_rule.prod-cffg-waf-rule-b,
  ]
  name        = "prod-cffg-waf-acl-b"
  metric_name = "ProdCffgWafAclB"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.prod-cffg-waf-rule-b.id
    type     = "REGULAR"
  }
}

