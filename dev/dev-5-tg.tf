# Target Group resources: This will create 4 TG's for the application EC2 instance(s)

resource "aws_lb_target_group" "DEV-BCE-APP-TG" {
  name     = "DEV-BCE-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.dev-tg-unhealthy
    interval = var.dev-tg-interval
    timeout = var.dev-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.dev-default.id
}

resource "aws_lb_target_group" "DEV-BCS-APP-TG" {
  name     = "DEV-BCS-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.dev-tg-unhealthy
    interval = var.dev-tg-interval
    timeout = var.dev-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true  
}
vpc_id   = aws_vpc.dev-default.id
}

resource "aws_lb_target_group" "DEV-BCW-APP-TG" {
  name     = "DEV-BCW-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.dev-tg-unhealthy
    interval = var.dev-tg-interval
    timeout = var.dev-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.dev-default.id
}

resource "aws_lb_target_group" "DEV-CFFG-APP-TG" {
  name     = "DEV-CFFG-Applicaton-TG"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/health.txt"
    healthy_threshold = 3
    unhealthy_threshold = var.dev-tg-unhealthy
    interval = var.dev-tg-interval
    timeout = var.dev-tg-timeout
    matcher = "200"
  }
stickiness {
   type = "lb_cookie"
   enabled = true
}
  vpc_id   = aws_vpc.dev-default.id
}

# Target Group resources: This will create 4 TG's for the mapping EC2 instance(s)

resource "aws_lb_target_group" "DEV-BCE-MAP-TG" {
  name     = "DEV-BCE-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.dev-tg-unhealthy
    interval = var.dev-tg-interval
    timeout = var.dev-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.dev-default.id
}

resource "aws_lb_target_group" "DEV-BCS-MAP-TG" {
  name     = "DEV-BCS-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.dev-tg-unhealthy
    interval = var.dev-tg-interval
    timeout = var.dev-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.dev-default.id
}

resource "aws_lb_target_group" "DEV-BCW-MAP-TG" {
  name     = "DEV-BCW-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.dev-tg-unhealthy
    interval = var.dev-tg-interval
    timeout = var.dev-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.dev-default.id
}

resource "aws_lb_target_group" "DEV-CFFG-MAP-TG" {
  name     = "DEV-CFFG-Mapping-TG"
  port     = 8080
  protocol = "HTTP"
  health_check {
    path = "/geoserver/web/"
    healthy_threshold = 3
    unhealthy_threshold = var.dev-tg-unhealthy
    interval = var.dev-tg-interval
    timeout = var.dev-tg-timeout
    matcher = "200"
  }
  vpc_id   = aws_vpc.dev-default.id
}

# Create 1 DEV Mapping Target Group Listener - depricated

#resource "aws_alb_listener" "dev-map-alb-listener" {  
#  load_balancer_arn = "${aws_lb.dev-map-alb.arn}"  
#  port              = 8080  
#  protocol          = "HTTP"
  
#  default_action {    
#    target_group_arn = "${aws_lb_target_group.DEV-MAP-TG.arn}"
#    type             = "forward"  
#  }
#}

# Create 4 DEV Mapping Target Group Listeners

resource "aws_alb_listener" "dev-bce-map-alb-listener" {
  load_balancer_arn = "${aws_lb.dev-bce-app-alb.arn}"
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-BCE-MAP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-bcs-map-alb-listener" {
  load_balancer_arn = "${aws_lb.dev-bcs-app-alb.arn}"
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-BCS-MAP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-bcw-map-alb-listener" {
  load_balancer_arn = "${aws_lb.dev-bcw-app-alb.arn}"
  port              = 8080  
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-BCW-MAP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-cffg-map-alb-listener" {
  load_balancer_arn = "${aws_lb.dev-cffg-app-alb.arn}"
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-CFFG-MAP-TG.arn}"
    type             = "forward"
  }
}

# Create 4 DEV Application Target Group Listeners

resource "aws_alb_listener" "dev-bce-app-alb-listener" {
  load_balancer_arn = "${aws_lb.dev-bce-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.dev_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-BCE-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-bce-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.dev-bce-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-BCE-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-bcs-app-alb-listener" {
  load_balancer_arn = "${aws_lb.dev-bcs-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.dev_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-BCS-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-bcs-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.dev-bcs-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-BCS-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-bcw-app-alb-listener" {
  load_balancer_arn = "${aws_lb.dev-bcw-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.dev_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-BCW-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-bcw-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.dev-bcw-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-BCW-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-cffg-app-alb-listener" {
  load_balancer_arn = "${aws_lb.dev-cffg-app-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.dev_cert

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-CFFG-APP-TG.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "dev-cffg-app-alb-listener80" {
  load_balancer_arn = "${aws_lb.dev-cffg-app-alb.arn}"
  port              = 80
  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = "arn:aws:acm:eu-west-2:975971611990:certificate/1d59350b-1878-4cca-a03b-5f68c52f8c18"

  default_action {
    target_group_arn = "${aws_lb_target_group.DEV-CFFG-APP-TG.arn}"
    type             = "forward"
  }
}

# Add EC2 instances to application TG's - depricated by ASG's

#resource "aws_lb_target_group_attachment" "dev-bce-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.DEV-BCE-APP-TG.arn
#  target_id        = aws_instance.DEV-EC2-APP[count.index].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "dev-bcs-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.DEV-BCS-APP-TG.arn
#  target_id        = aws_instance.DEV-EC2-APP[count.index].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "dev-bcw-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.DEV-BCW-APP-TG.arn
#  target_id        = aws_instance.DEV-EC2-APP[count.index].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "dev-cffg-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.DEV-CFFG-APP-TG.arn
#  target_id        = aws_instance.DEV-EC2-APP[count.index].id
#  port             = 80
#}

# Add EC2 instances to mapping TG's - depricated by ASG's

#resource "aws_lb_target_group_attachment" "dev-bce-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.DEV-BCE-MAP-TG.arn
#  target_id        = aws_instance.DEV-EC2-MAP[count.index].id
#  port             = 8080
#}
#
#resource "aws_lb_target_group_attachment" "dev-bcs-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.DEV-BCS-MAP-TG.arn
#  target_id        = aws_instance.DEV-EC2-MAP[count.index].id
#  port             = 8080
#}
#
#resource "aws_lb_target_group_attachment" "dev-bcw-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.DEV-BCW-MAP-TG.arn
#  target_id        = aws_instance.DEV-EC2-MAP[count.index].id
#  port             = 8080
#}
#
#resource "aws_lb_target_group_attachment" "dev-cffg-map-attach" {
#  count = 1
#  target_group_arn = aws_lb_target_group.DEV-CFFG-MAP-TG.arn
#  target_id        = aws_instance.DEV-EC2-MAP[count.index].id
#  port             = 8080
#}

# Add geoserver rule to 443 listeners

resource "aws_alb_listener_rule" "dev-map-bce-rule" {
  listener_arn = aws_alb_listener.dev-bce-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.DEV-BCE-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCE/*"]
  }
}
}

resource "aws_alb_listener_rule" "dev-map-bcs-rule" {
  listener_arn = aws_alb_listener.dev-bcs-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.DEV-BCS-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCS/*"]
  }
}
}

resource "aws_alb_listener_rule" "dev-map-bcw-rule" {
  listener_arn = aws_alb_listener.dev-bcw-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.DEV-BCW-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCW/*"]
  }
}
}

resource "aws_alb_listener_rule" "dev-map-cffg-rule" {
  listener_arn = aws_alb_listener.dev-cffg-app-alb-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.DEV-CFFG-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/CFFG/*"]
  }
}
}

# Add geoserver rule to 80 listeners

resource "aws_alb_listener_rule" "dev-map-bce-rule80" {
  listener_arn = aws_alb_listener.dev-bce-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.DEV-BCE-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCE/*"]
  }
}
}

resource "aws_alb_listener_rule" "dev-map-bcs-rule80" {
  listener_arn = aws_alb_listener.dev-bcs-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.DEV-BCS-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCS/*"]
  }
}
}

resource "aws_alb_listener_rule" "dev-map-bcw-rule80" {
  listener_arn = aws_alb_listener.dev-bcw-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.DEV-BCW-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/BCW/*"]
  }
}
}

resource "aws_alb_listener_rule" "dev-map-cffg-rule80" {
  listener_arn = aws_alb_listener.dev-cffg-app-alb-listener80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.DEV-CFFG-MAP-TG.arn
  }

  condition {
    path_pattern {
      values = ["/geoserver/CFFG/*"]
  }
}
}

