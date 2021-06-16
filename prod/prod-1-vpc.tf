# Setup block

provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}

resource "aws_ebs_encryption_by_default" "prod-encryption" {
  enabled = true
}

# BCP-PROD VPC resources: This will create 1 VPC with 4 Subnets, 1 Internet Gateway, 4 Route Tables. 

resource "aws_vpc" "prod-default" {
  cidr_block           = var.prod_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
tags = {
    Name = "PROD-VPC"
  }
}

resource "aws_internet_gateway" "prod-default" {
  vpc_id = aws_vpc.prod-default.id
tags = {
    Name = "PROD-IGW"
  }
}

# PROD Private Subnets

resource "aws_route_table" "prod-private" {
  count = length(var.prod_private_subnet_cidr_blocks)

  vpc_id = aws_vpc.prod-default.id
tags = {
    Name = "PROD-PRIVATE-RT"
  }
}

resource "aws_route" "prod-private" {
  count = length(var.prod_private_subnet_cidr_blocks)

  route_table_id         = aws_route_table.prod-private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.prod-default[count.index].id
}

resource "aws_subnet" "prod-private" {
  count = length(var.prod_private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.prod-default.id
  cidr_block        = var.prod_private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = false
tags = {
    Name = "PROD-PRIVATE-SUB${count.index + 1}"
  }
}

resource "aws_route_table_association" "prod-private" {
  count = length(var.prod_private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.prod-private[count.index].id
  route_table_id = aws_route_table.prod-private[count.index].id
}

# PROD Public Subnets

resource "aws_route_table" "prod-public" {
  vpc_id = aws_vpc.prod-default.id
tags = {
    Name = "PROD-PUBLIC_RT"
  }
}

resource "aws_route" "prod-public" {
  route_table_id         = aws_route_table.prod-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.prod-default.id
}

resource "aws_subnet" "prod-public" {
  count = length(var.prod_public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.prod-default.id
  cidr_block              = var.prod_public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
tags = {
    Name = "PROD-PUBLIC-SUB${count.index + 1}"
  }
}

resource "aws_route_table_association" "prod-public" {
  count = length(var.prod_public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.prod-public[count.index].id
  route_table_id = aws_route_table.prod-public.id
}

# Create PROD DB Subnet Group

resource "aws_db_subnet_group" "prod-rds-sub" {
  name       = "prod-main"
  subnet_ids = aws_subnet.prod-private.*.id

  tags = {
    Name = "PROD RDS Subnet Group"
  }
}

# NAT resources: This will create 2 NAT gateways in 2 Public Subnets for 2 different Private Subnets.

resource "aws_eip" "prod-eip" {
  count = length(var.prod_public_subnet_cidr_blocks)

  vpc = true
tags = {
    Name = "PROD-EIP${count.index + 1}"
  }
}

resource "aws_nat_gateway" "prod-default" {
  depends_on = ["aws_internet_gateway.prod-default"]

  count = length(var.prod_public_subnet_cidr_blocks)

  allocation_id = aws_eip.prod-eip[count.index].id
  subnet_id     = aws_subnet.prod-public[count.index].id
tags = {
    Name = "PROD-NAT${count.index + 1}"
  }
}
