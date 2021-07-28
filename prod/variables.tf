variable "access_key" {
     description = "Access key to AWS console"
     
}
variable "secret_key" {
     description = "Secret key to AWS console"
     
}

variable "region" {
  default     = "eu-west-2"
  type        = string
  description = "Region of the VPC"
}


variable "prod_cidr_block" {
  default     = "10.2.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "prod_public_subnet_cidr_blocks" {
  default     = ["10.2.0.0/24", "10.2.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "prod_private_subnet_cidr_blocks" {
  default     = ["10.2.1.0/24", "10.2.3.0/24"]
  type        = list
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  default     = ["eu-west-2a", "eu-west-2b"]
  type        = list
  description = "List of availability zones"
}

variable "key_pair" {
  default     = "CO-BCP"
  type        = string
  description = "EC2 Key Pair"
}

variable "bastion_ami_prod" {
  default     = "ami-0a1a17886f455a17d"
  type        = string
  description = "AMI for bastion EC2 instance"
}

variable "application_ami_prod" {
  default     = "ami-0c62e4caa3bf6f4e1"
  type        = string
  description = "AMI for PROD application EC2 instance"
}

variable "mapping_ami_prod" {
  default     = "ami-0c011e62109f4bc49"
  type        = string
  description = "AMI for PROD mapping EC2 instance"
}

variable "application_ami_prod_temp" {
  default     = "ami-0c62e4caa3bf6f4e1"
  type        = string
  description = "AMI for PROD application EC2 instance"
}

variable "mapping_ami_prod_temp" {
  default     = "ami-0c011e62109f4bc49"
  type        = string
  description = "AMI for PROD mapping EC2 instance"
}

variable "rds_instance_prod" {
  default     = "prod-bcp-db"
  type        = string
  description = "PROD RDS instance name"
}

variable "bce_zone" {
  default     = "Z04517471XDEFZB5FO5DB"
  type        = string
  description = "bce2023.co.uk zone"
}

variable "bcs_zone" {
  default     = "Z00762241G67N0D1GZ0KC"
  type        = string
  description = "bcs2023.co.uk zone"
}

variable "bcw_zone" {
  default     = "Z031797914Y0JGYK1EOWO"
  type        = string
  description = "bcw2023.co.uk zone"
}

variable "cffg_zone" {
  default     = "Z03174633CRGT06QCWDSS"
  type        = string
  description = "cffg2023.co.uk zone"
}

variable "prod_cert" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/ff9e8e41-7993-4d98-bd6f-de71b4702cf2"
  type        = string
  description = "cert for prod 2023 sites (eu)"
}

variable "prod_cert2" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/7dc39ace-9113-4077-b1ad-ed015b3a2133"
  type        = string
  description = "cert for prod 2023 sites (us)"
}

variable "prod_cert3" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/f9defe89-d151-43f4-974a-d5f7eaae30cc"
  type        = string
  description = "ext cert for prod bce site (eu)"
}

variable "prod_cert4" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/2ef70a6b-f63c-4f31-a6d6-772779d08df0"
  type        = string
  description = "ext cert for prod bce (us)"
}

variable "prod_cert5" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/b2c57bd4-5dcb-4258-bd1d-8150dfdb1bea"
  type        = string
  description = "ext cert for prod bcs (eu)"
}

variable "prod_cert6" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/fe99ef45-bd4d-40e2-9081-41492fb82c7f"
  type        = string
  description = "ext cert for prod bcs (us)"
}

variable "prod_cert7" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/cc40c391-6b4e-451f-92ca-106032188192"
  type        = string
  description = "ext cert for prod bcw (eu)"
}

variable "prod_cert8" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/99fe24fa-e979-45b8-91af-3ac9a6701ec0"
  type        = string
  description = "ext cert for prod bcw (us)"
}

variable "prod_cert9" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/93f9aeb1-fade-4dc9-bfcf-cd5ce1e10d6d"
  type        = string
  description = "ext cert for prod cffg (eu)"
}

variable "prod_cert10" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/7dfcee7c-1fff-4bd4-aa88-651d85437edb"
  type        = string
  description = "ext cert for prod cffg (us)"
}

variable "bcp-auth" {
  default     = "arn:aws:lambda:us-east-1:975971611990:function:bcp-auth2:3"
  type        = string
  description = "lambda reference"
}

#variables for target group HC
#running config

variable "prod-tg-unhealthy" {
  default     = "3"
  type        = string
  description = "Unhealthy threshold. The number of consecutive health check failures required before considering a target unhealthy."
}

variable "prod-tg-timeout" {
  default     = "5"
  type        = string
  description = "Timeout. The amount of time, in seconds, during which no response means a failed health check."
}

variable "prod-tg-interval" {
  default     = "30"
  type        = string
  description = "Interval. The approximate amount of time between health checks of an individual target"
}

variable "prod-cw-threshold" {
  default     = "75"
  type        = string
  description = "prod-cw-threshold"
}

variable "prod-cw-data" {
  default     = "1"
  type        = string
  description = "prod-cw-data"
}

variable "prod-cw-eval" {
  default     = "1"
  type        = string
  description = "prod-cw-eval"
}



#deployment config

#variable "prod-tg-unhealthy" {
#  default     = "10"
#  type        = string
#  description = "Unhealthy threshold. The number of consecutive health check failures required before considering a target unhealthy."
#}
#
#variable "prod-tg-timeout" {
#  default     = "120"
#  type        = string
#  description = "Timeout. The amount of time, in seconds, during which no response means a failed health check."
#}
#
#variable "prod-tg-interval" {
#  default     = "300"
#  type        = string
#  description = "Interval. The approximate amount of time between health checks of an individual target"
#}
#
#variable "prod-cw-threshold" {
#  default     = "99"
#  type        = string
#  description = "prod-cw-threshold"
#}
#
#variable "prod-cw-data" {
#  default     = "99"
#  type        = string
#  description = "prod-cw-data"
#}
#
#variable "prod-cw-eval" {
#  default     = "99"
#  type        = string
#  description = "prod-cw-eval"
#}

