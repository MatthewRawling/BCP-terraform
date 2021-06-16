# Target Group resources: This will create 4 TG's for the application EC2 instance(s)

resource "aws_lb_target_group" "UAT-BCE-APP-TG" {
  name     = "UAT-BCE-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.uat-tg-unhealthy
    interval = var.uat-tg-interval
    timeout = var.uat-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.uat-default.id
}

resource "aws_lb_target_group" "UAT-BCS-APP-TG" {
  name     = "UAT-BCS-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.uat-tg-unhealthy
    interval = var.uat-tg-interval
    timeout = var.uat-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.uat-default.id
}

resource "aws_lb_target_group" "UAT-BCW-APP-TG" {
  name     = "UAT-BCW-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.uat-tg-unhealthy
    interval = var.uat-tg-interval
    timeout = var.uat-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.uat-default.id
}

resource "aws_lb_target_group" "UAT-CFFG-APP-TG" {
  name     = "UAT-CFFG-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.uat-tg-unhealthy
    interval = var.uat-tg-interval
    timeout = var.uat-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.uat-default.id
}

# Target Group resources: This will create 4 TG's for the mapping EC2 instance(s)

resource "aws_lb_target_group" "UAT-BCE-MAP-TG" {
  name     = "UAT-BCE-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.uat-tg-unhealthy
    interval = var.uat-tg-interval
    timeout = var.uat-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.uat-default.id
}

resource "aws_lb_target_group" "UAT-BCS-MAP-TG" {
  name     = "UAT-BCS-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.uat-tg-unhealthy
    interval = var.uat-tg-interval
    timeout = var.uat-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.uat-default.id
}

resource "aws_lb_target_group" "UAT-BCW-MAP-TG" {
  name     = "UAT-BCW-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.uat-tg-unhealthy
    interval = var.uat-tg-interval
    timeout = var.uat-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.uat-default.id
}

resource "aws_lb_target_group" "UAT-CFFG-MAP-TG" {
  name     = "UAT-CFFG-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.uat-tg-unhealthy
    interval = var.uat-tg-interval
    timeout = var.uat-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.uat-default.id
}

# Create 1 UAT Mapping Target Group Listener - depricated

#resource "aws_alb_listener" "uat-map-alb-listener" {  
#  load_balancer_arn = "${aws_lb.uat-map-alb.arn}"  
#  port              = 8080  
#  protocol          = "HTTP"
  
#  default_action {    
#    target_group_arn = "${aws_lb_target_group.UAT-MAP-TG.arn}"
#    type             = "forward"  
#  }
#}

# Create 4 UAT Mapping Target Group Listeners

resource "aws_alb_listener" "uat-bce-map-alb-listener" {
  load_balancer_arn = "${aws_lb.uat-bce-app-alb.arn}"
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-BCE-MAP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-bcs-map-alb-listener" {
  load_balancer_arn = "${aws_lb.uat-bcs-app-alb.arn}"
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-BCS-MAP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-bcw-map-alb-listener" {
  load_balancer_arn = "${aws_lb.uat-bcw-app-alb.arn}"
  port              = 8080  
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-BCW-MAP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-cffg-map-alb-listener" {
  load_balancer_arn = "${aws_lb.uat-cffg-app-alb.arn}"
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-CFFG-MAP-TG.arn}"
    type             = "forward"
  }
}

# Create 4 UAT Application Target Group Listeners

resource "aws_alb_listener" "uat-bce-app-alb-listener" {
  load_balancer_arn = "${aws_lb.uat-bce-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.uat_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-BCE-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-bce-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.uat-bce-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-BCE-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-bcs-app-alb-listener" {
  load_balancer_arn = "${aws_lb.uat-bcs-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.uat_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-BCS-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-bcs-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.uat-bcs-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-BCS-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-bcw-app-alb-listener" {
  load_balancer_arn = "${aws_lb.uat-bcw-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.uat_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-BCW-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-bcw-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.uat-bcw-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-BCW-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-cffg-app-alb-listener" {
  load_balancer_arn = "${aws_lb.uat-cffg-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.uat_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-CFFG-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "uat-cffg-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.uat-cffg-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.UAT-CFFG-APP-TG.arn}"
    type             = "forward"
  }
}

# Add EC2 instances to application TG's - depricated by ASG's

#resource "aws_lb_target_group_attachment" "uat-bce-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.UAT-BCE-APP-TG.arn
#  target_id        = aws_instance.UAT-EC2-APP[count.index].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "uat-bcs-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.UAT-BCS-APP-TG.arn
#  target_id        = aws_instance.UAT-EC2-APP[count.index].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "uat-bcw-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.UAT-BCW-APP-TG.arn
#  target_id        = aws_instance.UAT-EC2-APP[count.index].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "uat-cffg-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.UAT-CFFG-APP-TG.arn
#  target_id        = aws_instance.UAT-EC2-APP[count.index].id
#  port             = 80
#}

# Add EC2 instances to mapping TG's - depricated by ASG's

#resource "aws_lb_target_group_attachment" "uat-bce-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.UAT-BCE-MAP-TG.arn
#  target_id        = aws_instance.UAT-EC2-MAP[count.index].id
#  port             = 8080
#}
#
#resource "aws_lb_target_group_attachment" "uat-bcs-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.UAT-BCS-MAP-TG.arn
#  target_id        = aws_instance.UAT-EC2-MAP[count.index].id
#  port             = 8080
#}
#
#resource "aws_lb_target_group_attachment" "uat-bcw-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.UAT-BCW-MAP-TG.arn
#  target_id        = aws_instance.UAT-EC2-MAP[count.index].id
#  port             = 8080
#}
#
#resource "aws_lb_target_group_attachment" "uat-cffg-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.UAT-CFFG-MAP-TG.arn
#  target_id        = aws_instance.UAT-EC2-MAP[count.index].id
#  port             = 8080
#}

# Add geoserver rule to 443 listeners

resource "aws_alb_listener_rule" "uat-map-bce-rule" {
  listener_arn = aws_alb_listener.uat-bce-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.UAT-BCE-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCE/*"]
  }
}
}

resource "aws_alb_listener_rule" "uat-map-bcs-rule" {
  listener_arn = aws_alb_listener.uat-bcs-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.UAT-BCS-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCS/*"]
  }
}
}

resource "aws_alb_listener_rule" "uat-map-bcw-rule" {
  listener_arn = aws_alb_listener.uat-bcw-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.UAT-BCW-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCW/*"]
  }
}
}

resource "aws_alb_listener_rule" "uat-map-cffg-rule" {
  listener_arn = aws_alb_listener.uat-cffg-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.UAT-CFFG-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/CFFG/*"]
  }
}
}

# Add geoserver rule to 80 listeners

resource "aws_alb_listener_rule" "uat-map-bce-rule80" {
  listener_arn = aws_alb_listener.uat-bce-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.UAT-BCE-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCE/*"]
  }
}
}

resource "aws_alb_listener_rule" "uat-map-bcs-rule80" {
  listener_arn = aws_alb_listener.uat-bcs-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.UAT-BCS-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCS/*"]
  }
}
}

resource "aws_alb_listener_rule" "uat-map-bcw-rule80" {
  listener_arn = aws_alb_listener.uat-bcw-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.UAT-BCW-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCW/*"]
  }
}
}

resource "aws_alb_listener_rule" "uat-map-cffg-rule80" {
  listener_arn = aws_alb_listener.uat-cffg-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.UAT-CFFG-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/CFFG/*"]
  }
}
}

# add external cert to bce app listener

resource "aws_lb_listener_certificate" "uat-app-bce-cert" {
  listener_arn    = "${aws_alb_listener.uat-bce-app-alb-listener.arn}"
  certificate_arn = var.uat_cert3
}

# add external cert to bcs app listener

resource "aws_lb_listener_certificate" "uat-app-bcs-cert" {
  listener_arn    = "${aws_alb_listener.uat-bcs-app-alb-listener.arn}"
  certificate_arn = var.uat_cert5
}

# add external cert to bcw app listener

resource "aws_lb_listener_certificate" "uat-app-bcw-cert" {
  listener_arn    = "${aws_alb_listener.uat-bcw-app-alb-listener.arn}"
  certificate_arn = var.uat_cert7
}

# add external cert to cffg app listener

resource "aws_lb_listener_certificate" "uat-app-cffg-cert" {
  listener_arn    = "${aws_alb_listener.uat-cffg-app-alb-listener.arn}"
  certificate_arn = var.uat_cert9
}

