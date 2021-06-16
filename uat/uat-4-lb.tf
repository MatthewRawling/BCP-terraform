# Create 4 Application ALB's

resource "aws_lb" "uat-bce-app-alb" {
  name               = "uat-bce-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.UAT-BCE-EXTALB-SG.id]
  subnets            = aws_subnet.uat-public.*.id

  enable_deletion_protection = false

access_logs {
  bucket  = aws_s3_bucket.uat-bce-logs.bucket
  prefix  = "uatbce"
  enabled = true
 }  
}

resource "aws_lb" "uat-bcs-app-alb" {
  name               = "uat-bcs-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.UAT-BCS-EXTALB-SG.id]
  subnets            = aws_subnet.uat-public.*.id

  enable_deletion_protection = false

 access_logs {
  bucket  = aws_s3_bucket.uat-bcs-logs.bucket
  prefix  = "uatbcs"
  enabled = true
}
}

resource "aws_lb" "uat-bcw-app-alb" {
  name               = "uat-bcw-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.UAT-BCW-EXTALB-SG.id]
  subnets            = aws_subnet.uat-public.*.id

  enable_deletion_protection = false

 access_logs {
  bucket  = aws_s3_bucket.uat-bcw-logs.bucket
  prefix  = "uatbcw"
  enabled = true
}
}

resource "aws_lb" "uat-cffg-app-alb" {
  name               = "uat-cffg-app-alb"
  internal           = false
  drop_invalid_header_fields = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.UAT-CFFG-EXTALB-SG.id]
  subnets            = aws_subnet.uat-public.*.id

  enable_deletion_protection = false

 access_logs {
  bucket  = aws_s3_bucket.uat-cffg-logs.bucket
  prefix  = "uatcffg"
  enabled = true
}
}

# Create 1 Mapping ALB - depricated

#resource "aws_lb" "uat-map-alb" {
#  name               = "uat-map-alb"
#  internal           = true
#  load_balancer_type = "application"
#  security_groups    = [aws_security_group.UAT-INTALB-MAP-SG.id]
#  subnets            = aws_subnet.uat-private.*.id
#
#  enable_deletion_protection = false

#  access_logs {
#    bucket  = aws_s3_bucket.lb_logs.bucket
#    prefix  = "test-lb"
#    enabled = true
#}
#}
