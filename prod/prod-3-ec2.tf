# Block depricated - using original BCP key

# Key Pair resource: This will create 1 keypair
#
#resource "tls_private_key" "BCP2023-KEY" {
#  algorithm = "RSA"
#}
#
#module "key_pair" {
#  source = "terraform-aws-modules/key-pair/aws"
#
#  key_name   = "BCP2023-KEY"
#  public_key = tls_private_key.BCP2023-KEY.public_key_openssh
#}

# EC2 Group resources: This will create 1 EC2 instance in a public subnet to be used as a bastion server

resource "aws_instance" "PROD-EC2-BAST" {
  count = "1"
  ami           = var.bastion_ami_prod
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.prod-ec2-cloudwatch.name}"
   root_block_device {
        volume_type           = "gp2"
        volume_size           = "8"
        delete_on_termination = "true"
      }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id = aws_subnet.prod-public[count.index].id
  key_name = var.key_pair
  associate_public_ip_address = true
  monitoring = "true"
  metadata_options {
  http_endpoint = "enabled"
  http_tokens = "required"
  }
  lifecycle {
    create_before_destroy = false
  }
tags = {
    Name = "PROD-EC2-BASTION${count.index + 1}"
  }
}

# Blocks depricated - instances now defined in Launch Configs

# EC2 Group resources: This will create 1 EC2 instance in a public subnet for the application server

#resource "aws_instance" "PROD-EC2-APP" {
#  count = "1"
#  ami           = var.application_ami_prod
#  instance_type = "t2.small"
##    root_block_prodice {
##        volume_type           = "gp2"
##        volume_size           = "20"
##        delete_on_termination = "true"
##      }
#  vpc_security_group_ids = ["${aws_security_group.PROD-EC2-APP-SG.id}"]
#  subnet_id = aws_subnet.prod-public[count.index].id
#  key_name = var.key_pair
#  associate_public_ip_address = true
#  monitoring = "true"
#tags = {
#    Name = "PROD-EC2-APPLICATION${count.index + 1}"
#  }
#}

# EC2 Group resources: This will create 1 EC2 instance in a private subnet for the mapping server

#resource "aws_instance" "PROD-EC2-MAP" {
#  count = "1"
#  ami           = var.mapping_ami_prod
#  instance_type = "t2.small"
#   root_block_prodice {
#        volume_type           = "gp2"
#        volume_size           = "100"
#        delete_on_termination = "true"
#      }
#  vpc_security_group_ids = ["${aws_security_group.PROD-EC2-MAP-SG.id}"]
#  subnet_id = aws_subnet.prod-public[count.index].id
#  key_name = var.key_pair
#  associate_public_ip_address = true
#  monitoring = "true"
#tags = {
#    Name = "PROD-EC2-MAPPING${count.index + 1}"
#  }
#}

# Define cloudwatch role for EC2 instances

resource "aws_iam_role" "prod-ec2-cloudwatch" {
  name = "prod-ec2-cloudwatch"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "prod-ec2-cloudwatch"
  }
}
resource "aws_iam_role_policy_attachment" "prod-ec2-cloudwatch" {
  role       = "${aws_iam_role.prod-ec2-cloudwatch.name}"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
resource "aws_iam_instance_profile" "prod-ec2-cloudwatch" {
  name  = "prod-ec2-cloudwatch"
  role = "${aws_iam_role.prod-ec2-cloudwatch.name}"
}

