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

resource "aws_instance" "UAT-EC2-BAST" {
  count = "1"
  ami           = var.bastion_ami_uat
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.uat-ec2-cloudwatch.name}"
   root_block_device {
        volume_type           = "gp2"
        volume_size           = "8"
        delete_on_termination = "true"
      }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id = aws_subnet.uat-public[count.index].id
  key_name = var.key_pair
  associate_public_ip_address = true
  monitoring = "true"
tags = {
    Name = "UAT-EC2-BASTION${count.index + 1}"
  }
}

# Blocks depricated - instances now defined in Launch Configs

# EC2 Group resources: This will create 1 EC2 instance in a public subnet for the application server

#resource "aws_instance" "UAT-EC2-APP" {
#  count = "1"
#  ami           = var.application_ami_uat
#  instance_type = "t2.small"
##    root_block_uatice {
##        volume_type           = "gp2"
##        volume_size           = "20"
##        delete_on_termination = "true"
##      }
#  vpc_security_group_ids = ["${aws_security_group.UAT-EC2-APP-SG.id}"]
#  subnet_id = aws_subnet.uat-public[count.index].id
#  key_name = var.key_pair
#  associate_public_ip_address = true
#  monitoring = "true"
#tags = {
#    Name = "UAT-EC2-APPLICATION${count.index + 1}"
#  }
#}

# EC2 Group resources: This will create 1 EC2 instance in a private subnet for the mapping server

#resource "aws_instance" "UAT-EC2-MAP" {
#  count = "1"
#  ami           = var.mapping_ami_uat
#  instance_type = "t2.small"
#   root_block_uatice {
#        volume_type           = "gp2"
#        volume_size           = "100"
#        delete_on_termination = "true"
#      }
#  vpc_security_group_ids = ["${aws_security_group.UAT-EC2-MAP-SG.id}"]
#  subnet_id = aws_subnet.uat-public[count.index].id
#  key_name = var.key_pair
#  associate_public_ip_address = true
#  monitoring = "true"
#tags = {
#    Name = "UAT-EC2-MAPPING${count.index + 1}"
#  }
#}

# Define cloudwatch role for EC2 instances

resource "aws_iam_role" "uat-ec2-cloudwatch" {
  name = "uat-ec2-cloudwatch"
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
    tag-key = "uat-ec2-cloudwatch"
  }
}
resource "aws_iam_role_policy_attachment" "uat-ec2-cloudwatch" {
  role       = "${aws_iam_role.uat-ec2-cloudwatch.name}"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
resource "aws_iam_instance_profile" "uat-ec2-cloudwatch" {
  name  = "uat-ec2-cloudwatch"
  role = "${aws_iam_role.uat-ec2-cloudwatch.name}"
}

