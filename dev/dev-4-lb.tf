# Create 4 Application ALB's

resource "aws_lb" "dev-bce-app-alb" {
  name               = "dev-bce-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.DEV-BCE-EXTALB-SG.id]
  subnets            = aws_subnet.dev-public.*.id

  enable_deletion_protection = false

access_logs {
  bucket  = aws_s3_bucket.dev-bce-logs.bucket
  prefix  = "devbce"
  enabled = true
 }  
}

resource "aws_lb" "dev-bcs-app-alb" {
  name               = "dev-bcs-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.DEV-BCS-EXTALB-SG.id]
  subnets            = aws_subnet.dev-public.*.id

  enable_deletion_protection = false

 access_logs {
  bucket  = aws_s3_bucket.dev-bcs-logs.bucket
  prefix  = "devbcs"
  enabled = true
}
}

resource "aws_lb" "dev-bcw-app-alb" {
  name               = "dev-bcw-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.DEV-BCW-EXTALB-SG.id]
  subnets            = aws_subnet.dev-public.*.id

  enable_deletion_protection = false

 access_logs {
  bucket  = aws_s3_bucket.dev-bcw-logs.bucket
  prefix  = "devbcw"
  enabled = true
}
}

resource "aws_lb" "dev-cffg-app-alb" {
  name               = "dev-cffg-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.DEV-CFFG-EXTALB-SG.id]
  subnets            = aws_subnet.dev-public.*.id

  enable_deletion_protection = false

 access_logs {
  bucket  = aws_s3_bucket.dev-cffg-logs.bucket
  prefix  = "devcffg"
  enabled = true
}
}

# Create 1 Mapping ALB - depricated

#resource "aws_lb" "dev-map-alb" {
#  name               = "dev-map-alb"
#  internal           = true
#  load_balancer_type = "application"
#  security_groups    = [aws_security_group.DEV-INTALB-MAP-SG.id]
#  subnets            = aws_subnet.dev-private.*.id
#
#  enable_deletion_protection = false

#  access_logs {
#    bucket  = aws_s3_bucket.lb_logs.bucket
#    prefix  = "test-lb"
#    enabled = true
#}
#}
