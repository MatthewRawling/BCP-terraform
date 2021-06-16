# Security Group resources: This will create 1 SG for the bastion service

resource "aws_security_group" "allow_ssh" {
  name = "UAT-PUBLIC-BASTION-SG"
  vpc_id = aws_vpc.uat-default.id
  description = "Security group for uat bastion server SSH access"
  ingress {
      description = "SSH access"
      cidr_blocks = ["92.54.181.130/32"]
      from_port = 22
      to_port = 22
      protocol = "tcp"
  }
  ingress {
      description = "HTTP access"
      cidr_blocks = ["92.54.181.130/32"]
      from_port = 80
      to_port = 80
      protocol = "tcp"
  }
  ingress {
      description = "HTTPS access"
      cidr_blocks = ["92.54.181.130/32"]
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
  ingress {
      description = "NCC Temp SSH access"
      cidr_blocks = ["5.148.32.192/26", "5.148.69.16/28", "31.221.110.80/29", "154.51.64.64/27", "154.51.128.224/27", "167.98.1.160/28", "167.98.25.176/28", "167.98.200.192/27", "195.95.131.0/24"]
      from_port = 22
      to_port = 22
      protocol = "tcp"
  }
tags = {
    Name = "UAT Bastion security Group"
  }
}

# Security Group resources: This will create 4 SG's for the UAT External load balancers

resource "aws_security_group" "UAT-BCE-EXTALB-SG" {
  name = "UAT-BCE-EXTALB-SG"
  vpc_id = aws_vpc.uat-default.id
  description = "Security group for the uat BCE external application load balancer"
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
      cidr_blocks = ["92.54.181.130/32", var.uat_cidr_block]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "UAT BCE External ALB security Group"
  }
}

resource "aws_security_group" "UAT-BCS-EXTALB-SG" {
  name = "UAT-BCS-EXT-SG"
  vpc_id = aws_vpc.uat-default.id
  description = "Security group for the uat BCS external application load balancer"
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
      cidr_blocks = ["92.54.181.130/32", var.uat_cidr_block]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "UAT BCS External ALB security Group"
  }
}

resource "aws_security_group" "UAT-BCW-EXTALB-SG" {
  name = "UAT-BCW-EXTALB-SG"
  vpc_id = aws_vpc.uat-default.id
  description = "Security group for the uat BCW external application load balancer"
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
      cidr_blocks = ["92.54.181.130/32", var.uat_cidr_block]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "UAT BCW External ALB security Group"
  }
}

resource "aws_security_group" "UAT-CFFG-EXTALB-SG" {
  name = "UAT-CFFG-EXTALB-SG"
  vpc_id = aws_vpc.uat-default.id
  description = "Security group for the uat CFFG external application load balancer"
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
      cidr_blocks = ["92.54.181.130/32", var.uat_cidr_block]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "UAT CFFG External ALB security Group"
  }
}

# Security Group resources: This will create 1 SG for the application server(s)

resource "aws_security_group" "UAT-EC2-APP-SG" {
  name = "UAT-EC2-APP-SG"
  vpc_id = aws_vpc.uat-default.id
  description = "Security group for the uat BCE internal application load balancer"
  ingress {
      description = "HTTP Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-BCE-EXTALB-SG.id}" ,"${aws_security_group.UAT-BCS-EXTALB-SG.id}" ,"${aws_security_group.UAT-BCW-EXTALB-SG.id}" ,"${aws_security_group.UAT-CFFG-EXTALB-SG.id}"]
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
    Name = "UAT EC2 Application security Group"
  }
}

# Security Group resources: This will create 1 SG for the mapping ALB

#resource "aws_security_group" "UAT-INTALB-MAP-SG" {
#  name = "UAT-INTALB-MAP-SG"
#  vpc_id = aws_vpc.uat-default.id
#  description = "Security group for the uat internal ALB mapping load balancer"
#  ingress {
#      from_port = 8080
#      to_port = 8080
#      protocol = "tcp"
#      security_groups = ["${aws_security_group.UAT-EC2-APP-SG.id}"]
#  }
#  ingress {
#      description = "8080 Temp Access"
#      cidr_blocks = ["92.54.181.130/32"]
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
#    Name = "UAT internal mapping server ALB security Group"
#  }
#}

# Security Group resources: This will create 1 SG for the mapping server(s)

resource "aws_security_group" "UAT-EC2-MAP-SG" {
  name = "UAT-EC2-MAP-SG"
  vpc_id = aws_vpc.uat-default.id
  description = "Security group for the uat mapping server"
#  ingress {
#      description = "8080 Access"
#      from_port = 8080
#      to_port = 8080
#      protocol = "tcp"
#      security_groups = ["${aws_security_group.UAT-INTALB-MAP-SG.id}"]
#  }  
 ingress {
      description = "80 Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-BCE-EXTALB-SG.id}"]
  }
 ingress {
      description = "80 Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-BCS-EXTALB-SG.id}"]
  }
 ingress {
      description = "80 Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-BCW-EXTALB-SG.id}"]
  }
 ingress {
      description = "80 Access"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-CFFG-EXTALB-SG.id}"]
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
      security_groups = ["${aws_security_group.UAT-BCE-EXTALB-SG.id}"]
  }
 ingress {
      description = "8080 Access"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-BCS-EXTALB-SG.id}"]
  }
 ingress {
      description = "8080 Access"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-BCW-EXTALB-SG.id}"]
  }
 ingress {
      description = "8080 Access"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-CFFG-EXTALB-SG.id}"]
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
    Name = "UAT EC2 Mapping security Group"
  }
}

# Security Group resources: This will create 1 SG for the RDS instance

resource "aws_security_group" "UAT-RDS-SG" {
  name = "UAT-RDS-SG"
  vpc_id = aws_vpc.uat-default.id
  description = "Security group for the uat mapping server"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-EC2-MAP-SG.id}"]
  }
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = ["${aws_security_group.UAT-EC2-APP-SG.id}"]
  }
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "UAT RDS security Group"
  }
}
