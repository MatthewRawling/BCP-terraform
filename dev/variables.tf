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


variable "dev_cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "dev_public_subnet_cidr_blocks" {
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "dev_private_subnet_cidr_blocks" {
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
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

variable "bastion_ami_dev" {
  default     = "ami-0f78ae2fae25a1310"
  type        = string
  description = "AMI for bastion EC2 instance"
}

variable "application_ami_dev" {
  default     = "ami-0d91ff3c201b92f61"
  type        = string
  description = "AMI for DEV application EC2 instance"
}

variable "mapping_ami_dev" {
  default     = "ami-01a18357b8de4e513"
  type        = string
  description = "AMI for DEV mapping EC2 instance"
}

variable "application_ami_dev_temp" {
  default     = "ami-0a1a42725b932b8fe"
  type        = string
  description = "AMI for DEV application EC2 instance"
}

variable "mapping_ami_dev_temp" {
  default     = "ami-07fe9580227cdac4f"
  type        = string
  description = "AMI for DEV mapping EC2 instance"
}

variable "rds_instance_dev" {
  default     = "dev-bcp-db"
  type        = string
  description = "DEV RDS instance name"
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

variable "dev_cert" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/18aa0c00-55b3-4f07-81fe-19b7e15291e0"
  type        = string
  description = "cert for dev sites"
}

variable "dev_cert2" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/1efba1d8-8bb2-4763-a4aa-d22916c0f1fe"
  type        = string
  description = "cert for dev sites (us)"
}

variable "bcp-auth" {
  default     = "arn:aws:lambda:us-east-1:975971611990:function:bcp-auth2:3"
  type        = string
  description = "lambda reference"
}

#variables for target group HC
#running config

variable "dev-tg-unhealthy" {
  default     = "3"
  type        = string
  description = "Unhealthy threshold. The number of consecutive health check failures required before considering a target unhealthy."
}

variable "dev-tg-timeout" {
  default     = "5"
  type        = string
  description = "Timeout. The amount of time, in seconds, during which no response means a failed health check."
}

variable "dev-tg-interval" {
  default     = "30"
  type        = string
  description = "Interval. The approximate amount of time between health checks of an individual target"
}

variable "dev-cw-threshold" {
  default     = "75"
  type        = string
  description = "dev-cw-threshold"
}

variable "dev-cw-data" {
  default     = "1"
  type        = string
  description = "dev-cw-data"
}

variable "dev-cw-eval" {
  default     = "1"
  type        = string
  description = "dev-cw-eval"
}



#deployment config

#variable "dev-tg-unhealthy" {
#  default     = "10"
#  type        = string
#  description = "Unhealthy threshold. The number of consecutive health check failures required before considering a target unhealthy."
#}
#
#variable "dev-tg-timeout" {
#  default     = "120"
#  type        = string
#  description = "Timeout. The amount of time, in seconds, during which no response means a failed health check."
#}
#
#variable "dev-tg-interval" {
#  default     = "300"
#  type        = string
#  description = "Interval. The approximate amount of time between health checks of an individual target"
#}
#
#variable "dev-cw-threshold" {
#  default     = "99"
#  type        = string
#  description = "dev-cw-threshold"
#}
#
#variable "dev-cw-data" {
#  default     = "99"
#  type        = string
#  description = "dev-cw-data"
#}
#
#variable "dev-cw-eval" {
#  default     = "99"
#  type        = string
#  description = "dev-cw-eval"
#}

