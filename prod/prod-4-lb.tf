# Create 4 Application ALB's

resource "aws_lb" "prod-bce-app-alb" {
  name               = "prod-bce-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.PROD-BCE-EXTALB-SG.id]
  subnets            = aws_subnet.prod-public.*.id

  enable_deletion_protection = false

access_logs {
  bucket  = aws_s3_bucket.prod-bce-logs.bucket
  prefix  = "prodbce"
  enabled = true
 }  
}

resource "aws_lb" "prod-bcs-app-alb" {
  name               = "prod-bcs-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.PROD-BCS-EXTALB-SG.id]
  subnets            = aws_subnet.prod-public.*.id

  enable_deletion_protection = false

 access_logs {
  bucket  = aws_s3_bucket.prod-bcs-logs.bucket
  prefix  = "prodbcs"
  enabled = true
}
}

resource "aws_lb" "prod-bcw-app-alb" {
  name               = "prod-bcw-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.PROD-BCW-EXTALB-SG.id]
  subnets            = aws_subnet.prod-public.*.id

  enable_deletion_protection = false

 access_logs {
  bucket  = aws_s3_bucket.prod-bcw-logs.bucket
  prefix  = "prodbcw"
  enabled = true
}
}

resource "aws_lb" "prod-cffg-app-alb" {
  name               = "prod-cffg-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.PROD-CFFG-EXTALB-SG.id]
  subnets            = aws_subnet.prod-public.*.id

  enable_deletion_protection = false

 access_logs {
  bucket  = aws_s3_bucket.prod-cffg-logs.bucket
  prefix  = "prodcffg"
  enabled = true
}
}

# Create 1 Mapping ALB - depricated

#resource "aws_lb" "prod-map-alb" {
#  name               = "prod-map-alb"
#  internal           = true
#  load_balancer_type = "application"
#  security_groups    = [aws_security_group.PROD-INTALB-MAP-SG.id]
#  subnets            = aws_subnet.prod-private.*.id
#
#  enable_deletion_protection = false

#  access_logs {
#    bucket  = aws_s3_bucket.lb_logs.bucket
#    prefix  = "test-lb"
#    enabled = true
#}
#}
