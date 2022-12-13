# Security Group resources: This will create 1 SG for the bastion service

resource "aws_security_group" "allow_ssh" {
  name = "DEV-PUBLIC-BASTION-SG"
  vpc_id = aws_vpc.dev-default.id
  description = "Security group for dev bastion server SSH access"
  ingress {
      description = "SSH access"
      cidr_blocks = ["92.54.181.130/32" ,"80.7.206.5/32" ,"5.148.17.54/32"]
      from_port = 22
      to_port = 22
      protocol = "tcp"
  }
  ingress {
      description = "HTTP access"
      cidr_blocks = ["92.54.181.130/32" ,"80.7.206.5/32" ,"5.148.17.54/32"]
      from_port = 80
      to_port = 80
      protocol = "tcp"
  }
  ingress {
      description = "HTTPS access"
      cidr_blocks = ["92.54.181.130/32" ,"5.148.17.54/32"]
      from_port = 443
      to_port = 443
      protocol = "tcp"
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "DEV Bastion security Group"
  }
}

# Security Group resources: This will create 4 SG's for the DEV External load balancers

resource "aws_security_group" "DEV-BCE-EXTALB-SG" {
  name = "DEV-BCE-EXTALB-SG"
  vpc_id = aws_vpc.dev-default.id
  description = "Security group for the dev BCE external application load balancer"
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["92.54.181.130/32", "5.148.17.54/32", var.dev_cidr_block]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "DEV BCE External ALB security Group"
  }
}

resource "aws_security_group" "DEV-BCS-EXTALB-SG" {
  name = "DEV-BCS-EXT-SG"
  vpc_id = aws_vpc.dev-default.id
  description = "Security group for the dev BCS external application load balancer"
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["92.54.181.130/32", "5.148.17.54/32", var.dev_cidr_block]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "DEV BCS External ALB security Group"
  }
}

resource "aws_security_group" "DEV-BCW-EXTALB-SG" {
  name = "DEV-BCW-EXTALB-SG"
  vpc_id = aws_vpc.dev-default.id
  description = "Security group for the dev BCW external application load balancer"
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["92.54.181.130/32", "5.148.17.54/32", var.dev_cidr_block]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "DEV BCW External ALB security Group"
  }
}

resource "aws_security_group" "DEV-CFFG-EXTALB-SG" {
  name = "DEV-CFFG-EXTALB-SG"
  vpc_id = aws_vpc.dev-default.id
  description = "Security group for the dev CFFG external application load balancer"
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["92.54.181.130/32", "5.148.17.54/32", var.dev_cidr_block]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "DEV CFFG External ALB security Group"
  }
}

# Security Group resources: This will create 1 SG for the application server(s)

resource "aws_security_group" "DEV-EC2-APP-SG" {
  name = "DEV-EC2-APP-SG"
  vpc_id = aws_vpc.dev-default.id
  description = "Security group for the dev BCE internal application load balancer"
  ingress {
      description = "HTTP Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-BCE-EXTALB-SG.id}" ,"${aws_security_group.DEV-BCS-EXTALB-SG.id}" ,"${aws_security_group.DEV-BCW-EXTALB-SG.id}" ,"${aws_security_group.DEV-CFFG-EXTALB-SG.id}"]
  }
  ingress {
      description = "SSH Access from bastion"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      security_groups = ["${aws_security_group.allow_ssh.id}"]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "DEV EC2 Application security Group"
  }
}

# Security Group resources: This will create 1 SG for the mapping ALB

#resource "aws_security_group" "DEV-INTALB-MAP-SG" {
#  name = "DEV-INTALB-MAP-SG"
#  vpc_id = aws_vpc.dev-default.id
#  description = "Security group for the dev internal ALB mapping load balancer"
#  ingress {
#      from_port = 8080
#      to_port = 8080
#      protocol = "tcp"
#      security_groups = ["${aws_security_group.DEV-EC2-APP-SG.id}"]
#  }
#  ingress {
#      description = "8080 Temp Access"
#      cidr_blocks = ["92.54.181.130/32" ,"80.7.206.5/32"]
#      from_port = 8080
#      to_port = 8080
#      protocol = "tcp"
#  }
#  egress {
#      from_port   = 0
#      to_port     = 0
#      protocol    = "-1"
#      cidr_blocks = ["0.0.0.0/0"]
#  }
#tags = {
#    Name = "DEV internal mapping server ALB security Group"
#  }
#}

# Security Group resources: This will create 1 SG for the mapping server(s)

resource "aws_security_group" "DEV-EC2-MAP-SG" {
  name = "DEV-EC2-MAP-SG"
  vpc_id = aws_vpc.dev-default.id
  description = "Security group for the dev mapping server"
#  ingress {
#      description = "8080 Access"
#      from_port = 8080
#      to_port = 8080
#      protocol = "tcp"
#      security_groups = ["${aws_security_group.DEV-INTALB-MAP-SG.id}"]
#  }  
 ingress {
      description = "80 Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-BCE-EXTALB-SG.id}"]
  }
 ingress {
      description = "80 Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-BCS-EXTALB-SG.id}"]
  }
 ingress {
      description = "80 Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-BCW-EXTALB-SG.id}"]
  }
 ingress {
      description = "80 Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-CFFG-EXTALB-SG.id}"]
  }
 ingress {
      description = "22 from bastion access"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      security_groups = ["${aws_security_group.allow_ssh.id}"]
  }
 ingress {
      description = "8080 Access"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-BCE-EXTALB-SG.id}"]
  }
 ingress {
      description = "8080 Access"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-BCS-EXTALB-SG.id}"]
  }
 ingress {
      description = "8080 Access"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-BCW-EXTALB-SG.id}"]
  }
 ingress {
      description = "8080 Access"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-CFFG-EXTALB-SG.id}"]
  }
 ingress {
      description = "22 from bastion access"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      security_groups = ["${aws_security_group.allow_ssh.id}"]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "DEV EC2 Mapping security Group"
  }
}

# Security Group resources: This will create 1 SG for the RDS instance

resource "aws_security_group" "DEV-RDS-SG" {
  name = "DEV-RDS-SG"
  vpc_id = aws_vpc.dev-default.id
  description = "Security group for the dev mapping server"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-EC2-MAP-SG.id}"]
  }
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = ["${aws_security_group.DEV-EC2-APP-SG.id}"]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "DEV RDS security Group"
  }
}
