# Setup block

provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}

resource "aws_ebs_encryption_by_default" "uat-encryption" {
  enabled = true
}

terraform {
   required_providers {    
    aws = {
         source = "hashicorp/aws"
         version =  "~> 3.74.2"
    }
    consul = {
      source = "hashicorp/consul"
    }
  }
  required_version = ">= 0.13"
}

# BCP-UAT VPC resources: This will create 1 VPC with 4 Subnets, 1 Internet Gateway, 4 Route Tables. 

resource "aws_vpc" "uat-default" {
  cidr_block           = var.uat_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
tags = {
    Name = "UAT-VPC"
  }
}

resource "aws_internet_gateway" "uat-default" {
  vpc_id = aws_vpc.uat-default.id
tags = {
    Name = "UAT-IGW"
  }
}

# UAT Private Subnets

resource "aws_route_table" "uat-private" {
  count = length(var.uat_private_subnet_cidr_blocks)

  vpc_id = aws_vpc.uat-default.id
tags = {
    Name = "UAT-PRIVATE-RT"
  }
}

resource "aws_route" "uat-private" {
  count = length(var.uat_private_subnet_cidr_blocks)

  route_table_id         = aws_route_table.uat-private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.uat-default[count.index].id
}

resource "aws_subnet" "uat-private" {
  count = length(var.uat_private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.uat-default.id
  cidr_block        = var.uat_private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = false
tags = {
    Name = "UAT-PRIVATE-SUB${count.index + 1}"
  }
}

resource "aws_route_table_association" "uat-private" {
  count = length(var.uat_private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.uat-private[count.index].id
  route_table_id = aws_route_table.uat-private[count.index].id
}

# UAT Public Subnets

resource "aws_route_table" "uat-public" {
  vpc_id = aws_vpc.uat-default.id
tags = {
    Name = "UAT-PUBLIC_RT"
  }
}

resource "aws_route" "uat-public" {
  route_table_id         = aws_route_table.uat-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.uat-default.id
}

resource "aws_subnet" "uat-public" {
  count = length(var.uat_public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.uat-default.id
  cidr_block              = var.uat_public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
tags = {
    Name = "UAT-PUBLIC-SUB${count.index + 1}"
  }
}

resource "aws_route_table_association" "uat-public" {
  count = length(var.uat_public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.uat-public[count.index].id
  route_table_id = aws_route_table.uat-public.id
}

# Create UAT DB Subnet Group

resource "aws_db_subnet_group" "uat-rds-sub" {
  name       = "dev-main"
  subnet_ids = aws_subnet.uat-private.*.id

  tags = {
    Name = "UAT RDS Subnet Group"
  }
}

# NAT resources: This will create 2 NAT gateways in 2 Public Subnets for 2 different Private Subnets.

resource "aws_eip" "uat-eip" {
  count = length(var.uat_public_subnet_cidr_blocks)

  vpc = true
tags = {
    Name = "UAT-EIP${count.index + 1}"
  }
}

resource "aws_nat_gateway" "uat-default" {
  depends_on = ["aws_internet_gateway.uat-default"]

  count = length(var.uat_public_subnet_cidr_blocks)

  allocation_id = aws_eip.uat-eip[count.index].id
  subnet_id     = aws_subnet.uat-public[count.index].id
tags = {
    Name = "UAT-NAT${count.index + 1}"
  }
}

# UAT VPC Flow Logging

resource "aws_flow_log" "uat-vpc-flowlog" {
  iam_role_arn    = aws_iam_role.uat-ec2-cloudwatch.arn
  log_destination = aws_cloudwatch_log_group.uat-vpclogs.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.uat-default.id
  tags = {
        Name            = "UAT VPC Flow Log"
        }
}

