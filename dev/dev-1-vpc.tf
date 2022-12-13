# Setup block

provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}

resource "aws_ebs_encryption_by_default" "dev-encryption" {
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

# BCP-DEV VPC resources: This will create 1 VPC with 4 Subnets, 1 Internet Gateway, 4 Route Tables. 

resource "aws_vpc" "dev-default" {
  cidr_block           = var.dev_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
tags = {
    Name = "DEV-VPC"
  }
}

resource "aws_internet_gateway" "dev-default" {
  vpc_id = aws_vpc.dev-default.id
tags = {
    Name = "DEV-IGW"
  }
}

# DEV Private Subnets

resource "aws_route_table" "dev-private" {
  count = length(var.dev_private_subnet_cidr_blocks)

  vpc_id = aws_vpc.dev-default.id
tags = {
    Name = "DEV-PRIVATE-RT"
  }
}

resource "aws_route" "dev-private" {
  count = length(var.dev_private_subnet_cidr_blocks)

  route_table_id         = aws_route_table.dev-private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.dev-default[count.index].id
}

resource "aws_subnet" "dev-private" {
  count = length(var.dev_private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.dev-default.id
  cidr_block        = var.dev_private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = false
tags = {
    Name = "DEV-PRIVATE-SUB${count.index + 1}"
  }
}

resource "aws_route_table_association" "dev-private" {
  count = length(var.dev_private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.dev-private[count.index].id
  route_table_id = aws_route_table.dev-private[count.index].id
}

#DEV Public Subnets

resource "aws_route_table" "dev-public" {
  vpc_id = aws_vpc.dev-default.id
tags = {
    Name = "DEV-PUBLIC_RT"
  }
}

resource "aws_route" "dev-public" {
  route_table_id         = aws_route_table.dev-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev-default.id
}

resource "aws_subnet" "dev-public" {
  count = length(var.dev_public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.dev-default.id
  cidr_block              = var.dev_public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
tags = {
    Name = "DEV-PUBLIC-SUB${count.index + 1}"
  }
}

resource "aws_route_table_association" "dev-public" {
  count = length(var.dev_public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.dev-public[count.index].id
  route_table_id = aws_route_table.dev-public.id
}

# Create DEV DB Subnet Group

resource "aws_db_subnet_group" "dev-rds-sub" {
  name       = "main"
  subnet_ids = aws_subnet.dev-private.*.id

  tags = {
    Name = "DEV RDS Subnet Group"
  }
}

# NAT resources: This will create 2 NAT gateways in 2 Public Subnets for 2 different Private Subnets.

resource "aws_eip" "dev-eip" {
  count = length(var.dev_public_subnet_cidr_blocks)

  vpc = true
tags = {
    Name = "DEV-EIP${count.index + 1}"
  }
}

resource "aws_nat_gateway" "dev-default" {
  depends_on = ["aws_internet_gateway.dev-default"]

  count = length(var.dev_public_subnet_cidr_blocks)

  allocation_id = aws_eip.dev-eip[count.index].id
  subnet_id     = aws_subnet.dev-public[count.index].id
tags = {
    Name = "DEV-NAT${count.index + 1}"
  }
}

# DEV Cognito

resource "aws_cognito_user_pool" "dev-userpool" {
  name = "DEV Cognito User Pool"
}

resource "aws_cognito_user_group" "dev-drupal" {
  name         = "dev-drupal"
  user_pool_id = aws_cognito_user_pool.dev-userpool.id
  description  = "Group for web auth"
  precedence   = 42
  # role_arn     = aws_iam_role.group_role.arn
}

# DEV VPC Flow Logging

resource "aws_flow_log" "dev-vpc-flowlog" {
  iam_role_arn    = aws_iam_role.dev-ec2-cloudwatch.arn
  log_destination = aws_cloudwatch_log_group.dev-vpclogs.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.dev-default.id
  tags = {
	Name            = "DEV VPC Flow Log"
	}
}

