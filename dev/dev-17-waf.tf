#DEV BCE WAF config 

resource "aws_waf_ipset" "dev-bce-waf-ip" {
  name = "dev-bce-waf-ip"

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
    value = "51.149.9.112/29"
  }

#  ip_set_descriptors {
#    type  = "IPV4"
#    value = "51.149.9.240/29"
#  }
  ip_set_descriptors {
    type  = "IPV4"
    value = "51.149.8.0/25"
  }
}

resource "aws_waf_rule" "dev-bce-waf-rule" {
  depends_on  = [aws_waf_ipset.dev-bce-waf-ip]
  name        = "dev-bce-waf-rule"
  metric_name = "DevBceWafRule"

  predicates {
    data_id = aws_waf_ipset.dev-bce-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "dev-bce-waf-acl" {
  depends_on = [
    aws_waf_ipset.dev-bce-waf-ip,
    aws_waf_rule.dev-bce-waf-rule,
  ]
  name        = "dev-bce-waf-acl"
  metric_name = "DevBceWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.dev-bce-waf-rule.id
    type     = "REGULAR"
  }
}

#DEV BCS WAF config

resource "aws_waf_ipset" "dev-bcs-waf-ip" {
  name = "dev-bcs-waf-ip"

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

resource "aws_waf_rule" "dev-bcs-waf-rule" {
  depends_on  = [aws_waf_ipset.dev-bcs-waf-ip]
  name        = "dev-bcs-waf-rule"
  metric_name = "DevBcsWafRule"

  predicates {
    data_id = aws_waf_ipset.dev-bcs-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "dev-bcs-waf-acl" {
  depends_on = [
    aws_waf_ipset.dev-bcs-waf-ip,
    aws_waf_rule.dev-bcs-waf-rule,
  ]
  name        = "dev-bcs-waf-acl"
  metric_name = "DevBcsWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.dev-bcs-waf-rule.id
    type     = "REGULAR"
  }
}

#DEV BCW WAF config

resource "aws_waf_ipset" "dev-bcw-waf-ip" {
  name = "dev-bcw-waf-ip"

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

resource "aws_waf_rule" "dev-bcw-waf-rule" {
  depends_on  = [aws_waf_ipset.dev-bcw-waf-ip]
  name        = "dev-bcw-waf-rule"
  metric_name = "DevBcwWafRule"

  predicates {
    data_id = aws_waf_ipset.dev-bcw-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "dev-bcw-waf-acl" {
  depends_on = [
    aws_waf_ipset.dev-bcw-waf-ip,
    aws_waf_rule.dev-bcw-waf-rule,
  ]
  name        = "dev-bcw-waf-acl"
  metric_name = "DevBcwWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.dev-bcw-waf-rule.id
    type     = "REGULAR"
  }
}

#DEV CFFG WAF config

resource "aws_waf_ipset" "dev-cffg-waf-ip" {
  name = "dev-cffg-waf-ip"

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

resource "aws_waf_rule" "dev-cffg-waf-rule" {
  depends_on  = [aws_waf_ipset.dev-cffg-waf-ip]
  name        = "dev-cffg-waf-rule"
  metric_name = "DevCffgWafRule"

  predicates {
    data_id = aws_waf_ipset.dev-cffg-waf-ip.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "dev-cffg-waf-acl" {
  depends_on = [
    aws_waf_ipset.dev-cffg-waf-ip,
    aws_waf_rule.dev-cffg-waf-rule,
  ]
  name        = "dev-cffg-waf-acl"
  metric_name = "DevCffgWafAcl"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.dev-cffg-waf-rule.id
    type     = "REGULAR"
  }
}

