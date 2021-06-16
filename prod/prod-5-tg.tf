# Target Group resources: This will create 4 TG's for the application EC2 instance(s)

resource "aws_lb_target_group" "PROD-BCE-APP-TG" {
  name     = "PROD-BCE-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.prod-tg-unhealthy
    interval = var.prod-tg-interval
    timeout = var.prod-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.prod-default.id
}

resource "aws_lb_target_group" "PROD-BCS-APP-TG" {
  name     = "PROD-BCS-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.prod-tg-unhealthy
    interval = var.prod-tg-interval
    timeout = var.prod-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.prod-default.id
}

resource "aws_lb_target_group" "PROD-BCW-APP-TG" {
  name     = "PROD-BCW-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.prod-tg-unhealthy
    interval = var.prod-tg-interval
    timeout = var.prod-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.prod-default.id
}

resource "aws_lb_target_group" "PROD-CFFG-APP-TG" {
  name     = "PROD-CFFG-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.prod-tg-unhealthy
    interval = var.prod-tg-interval
    timeout = var.prod-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.prod-default.id
}

# Target Group resources: This will create 4 TG's for the mapping EC2 instance(s)

resource "aws_lb_target_group" "PROD-BCE-MAP-TG" {
  name     = "PROD-BCE-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.prod-tg-unhealthy
    interval = var.prod-tg-interval
    timeout = var.prod-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.prod-default.id
}

resource "aws_lb_target_group" "PROD-BCS-MAP-TG" {
  name     = "PROD-BCS-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.prod-tg-unhealthy
    interval = var.prod-tg-interval
    timeout = var.prod-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.prod-default.id
}

resource "aws_lb_target_group" "PROD-BCW-MAP-TG" {
  name     = "PROD-BCW-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.prod-tg-unhealthy
    interval = var.prod-tg-interval
    timeout = var.prod-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.prod-default.id
}

resource "aws_lb_target_group" "PROD-CFFG-MAP-TG" {
  name     = "PROD-CFFG-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.prod-tg-unhealthy
    interval = var.prod-tg-interval
    timeout = var.prod-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.prod-default.id
}

# Create 1 PROD Mapping Target Group Listener - depricated

#resource "aws_alb_listener" "prod-map-alb-listener" {  
#  load_balancer_arn = "${aws_lb.prod-map-alb.arn}"  
#  port              = 8080  
#  protocol          = "HTTP"
  
#  default_action {    
#    target_group_arn = "${aws_lb_target_group.PROD-MAP-TG.arn}"
#    type             = "forward"  
#  }
#}

# Create 4 PROD Mapping Target Group Listeners

resource "aws_alb_listener" "prod-bce-map-alb-listener" {
  load_balancer_arn = "${aws_lb.prod-bce-app-alb.arn}"
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-BCE-MAP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-bcs-map-alb-listener" {
  load_balancer_arn = "${aws_lb.prod-bcs-app-alb.arn}"
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-BCS-MAP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-bcw-map-alb-listener" {
  load_balancer_arn = "${aws_lb.prod-bcw-app-alb.arn}"
  port              = 8080  
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-BCW-MAP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-cffg-map-alb-listener" {
  load_balancer_arn = "${aws_lb.prod-cffg-app-alb.arn}"
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-CFFG-MAP-TG.arn}"
    type             = "forward"
  }
}

# Create 4 PROD Application Target Group Listeners

resource "aws_alb_listener" "prod-bce-app-alb-listener" {
  load_balancer_arn = "${aws_lb.prod-bce-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.prod_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-BCE-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-bce-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.prod-bce-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-BCE-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-bcs-app-alb-listener" {
  load_balancer_arn = "${aws_lb.prod-bcs-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.prod_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-BCS-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-bcs-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.prod-bcs-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-BCS-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-bcw-app-alb-listener" {
  load_balancer_arn = "${aws_lb.prod-bcw-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.prod_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-BCW-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-bcw-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.prod-bcw-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-BCW-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-cffg-app-alb-listener" {
  load_balancer_arn = "${aws_lb.prod-cffg-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.prod_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-CFFG-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "prod-cffg-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.prod-cffg-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.PROD-CFFG-APP-TG.arn}"
    type             = "forward"
  }
}

# Add EC2 instances to application TG's - depricated by ASG's

#resource "aws_lb_target_group_attachment" "prod-bce-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.PROD-BCE-APP-TG.arn
#  target_id        = aws_instance.PROD-EC2-APP[count.index].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "prod-bcs-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.PROD-BCS-APP-TG.arn
#  target_id        = aws_instance.PROD-EC2-APP[count.index].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "prod-bcw-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.PROD-BCW-APP-TG.arn
#  target_id        = aws_instance.PROD-EC2-APP[count.index].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "prod-cffg-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.PROD-CFFG-APP-TG.arn
#  target_id        = aws_instance.PROD-EC2-APP[count.index].id
#  port             = 80
#}

# Add EC2 instances to mapping TG's - depricated by ASG's

#resource "aws_lb_target_group_attachment" "prod-bce-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.PROD-BCE-MAP-TG.arn
#  target_id        = aws_instance.PROD-EC2-MAP[count.index].id
#  port             = 8080
#}
#
#resource "aws_lb_target_group_attachment" "prod-bcs-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.PROD-BCS-MAP-TG.arn
#  target_id        = aws_instance.PROD-EC2-MAP[count.index].id
#  port             = 8080
#}
#
#resource "aws_lb_target_group_attachment" "prod-bcw-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.PROD-BCW-MAP-TG.arn
#  target_id        = aws_instance.PROD-EC2-MAP[count.index].id
#  port             = 8080
#}
#
#resource "aws_lb_target_group_attachment" "prod-cffg-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.PROD-CFFG-MAP-TG.arn
#  target_id        = aws_instance.PROD-EC2-MAP[count.index].id
#  port             = 8080
#}

# Add geoserver rule to 443 listeners

resource "aws_alb_listener_rule" "prod-map-bce-rule" {
  listener_arn = aws_alb_listener.prod-bce-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PROD-BCE-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCE/*"]
  }
}
}

resource "aws_alb_listener_rule" "prod-map-bcs-rule" {
  listener_arn = aws_alb_listener.prod-bcs-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PROD-BCS-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCS/*"]
  }
}
}

resource "aws_alb_listener_rule" "prod-map-bcw-rule" {
  listener_arn = aws_alb_listener.prod-bcw-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PROD-BCW-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCW/*"]
  }
}
}

resource "aws_alb_listener_rule" "prod-map-cffg-rule" {
  listener_arn = aws_alb_listener.prod-cffg-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PROD-CFFG-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/CFFG/*"]
  }
}
}

# Add geoserver rule to 80 listeners

resource "aws_alb_listener_rule" "prod-map-bce-rule80" {
  listener_arn = aws_alb_listener.prod-bce-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PROD-BCE-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCE/*"]
  }
}
}

resource "aws_alb_listener_rule" "prod-map-bcs-rule80" {
  listener_arn = aws_alb_listener.prod-bcs-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PROD-BCS-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCS/*"]
  }
}
}

resource "aws_alb_listener_rule" "prod-map-bcw-rule80" {
  listener_arn = aws_alb_listener.prod-bcw-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PROD-BCW-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCW/*"]
  }
}
}

resource "aws_alb_listener_rule" "prod-map-cffg-rule80" {
  listener_arn = aws_alb_listener.prod-cffg-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PROD-CFFG-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/CFFG/*"]
  }
}
}

# add external cert to bce app listener

resource "aws_lb_listener_certificate" "prod-app-bce-cert" {
  listener_arn    = "${aws_alb_listener.prod-bce-app-alb-listener.arn}"
  certificate_arn = var.prod_cert3
}

# add external cert to bcs app listener

resource "aws_lb_listener_certificate" "prod-app-bcs-cert" {
  listener_arn    = "${aws_alb_listener.prod-bcs-app-alb-listener.arn}"
  certificate_arn = var.prod_cert5
}

# add external cert to bcw app listener

resource "aws_lb_listener_certificate" "prod-app-bcw-cert" {
  listener_arn    = "${aws_alb_listener.prod-bcw-app-alb-listener.arn}"
  certificate_arn = var.prod_cert7
}

# add external cert to cffg app listener

resource "aws_lb_listener_certificate" "prod-app-cffg-cert" {
  listener_arn    = "${aws_alb_listener.prod-cffg-app-alb-listener.arn}"
  certificate_arn = var.prod_cert9
}

