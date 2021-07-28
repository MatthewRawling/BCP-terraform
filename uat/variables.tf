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


variable "uat_cidr_block" {
  default     = "10.1.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "uat_public_subnet_cidr_blocks" {
  default     = ["10.1.0.0/24", "10.1.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "uat_private_subnet_cidr_blocks" {
  default     = ["10.1.1.0/24", "10.1.3.0/24"]
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

variable "bastion_ami_uat" {
  default     = "ami-0a1a17886f455a17d"
  type        = string
  description = "AMI for bastion EC2 instance"
}

variable "application_ami_uat" {
  default     = "ami-0dd8608397c059e79"
  type        = string
  description = "AMI for UAT application EC2 instance"
}

variable "mapping_ami_uat" {
  default     = "ami-059f3c759c483100c"
  type        = string
  description = "AMI for UAT mapping EC2 instance"
}

variable "application_ami_uat_temp" {
  default     = "ami-0426a02594e0cdb2f"
  type        = string
  description = "AMI for UAT application EC2 instance"
}

variable "mapping_ami_uat_temp" {
  default     = "ami-059f3c759c483100c"
  type        = string
  description = "AMI for UAT mapping EC2 instance"
}

variable "rds_instance_uat" {
  default     = "uat-bcp-db"
  type        = string
  description = "UAT RDS instance name"
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

variable "uat_cert" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/c751b490-39bb-402e-9363-e5e842edc319"
  type        = string
  description = "cert for uat 2023 sites"
}

variable "uat_cert2" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/0df0c2f6-399c-4724-9ff5-9e84e2be40b1"
  type        = string
  description = "cert for uat 2023 sites (us)"
}

variable "uat_cert3" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/66c239f3-b46a-4a06-bffb-5308ddb616be"
  type        = string
  description = "ext cert for uat bce site (eu)"
}

variable "uat_cert4" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/b3250efb-671f-4b91-b314-5df36eda43b6"
  type        = string
  description = "ext cert for uat bce (us)"
}

variable "uat_cert5" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/cc49daab-ce64-4dea-bfce-1d893756bd5c"
  type        = string
  description = "ext cert for uat bcs (eu)"
}

variable "uat_cert6" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/9f922f26-4797-48f8-9501-f65f3e9fbe92"
  type        = string
  description = "ext cert for uat bcs (us)"
}

variable "uat_cert7" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/93d87aa1-d3f7-483c-a01c-9de4977d2065"
  type        = string
  description = "ext cert for uat bcw (eu)"
}

variable "uat_cert8" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/04f89af5-ff3c-4dbd-a343-200bbc5c28c0"
  type        = string
  description = "ext cert for uat bcw (us)"
}

variable "uat_cert9" {
  default     = "arn:aws:acm:eu-west-2:975971611990:certificate/a863204a-b8a9-4afb-ac77-8bdbead60237"
  type        = string
  description = "ext cert for uat cffg (eu)"
}

variable "uat_cert10" {
  default     = "arn:aws:acm:us-east-1:975971611990:certificate/cbdba63e-e4be-4608-9252-1870633a1bd2"
  type        = string
  description = "ext cert for uat cffg (us)"
}

variable "bcp-auth" {
  default     = "arn:aws:lambda:us-east-1:975971611990:function:bcp-auth2:3"
  type        = string
  description = "lambda reference"
}

#variables for target group HC
#running config

variable "uat-tg-unhealthy" {
  default     = "3"
  type        = string
  description = "Unhealthy threshold. The number of consecutive health check failures required before considering a target unhealthy."
}

variable "uat-tg-timeout" {
  default     = "5"
  type        = string
  description = "Timeout. The amount of time, in seconds, during which no response means a failed health check."
}

variable "uat-tg-interval" {
  default     = "30"
  type        = string
  description = "Interval. The approximate amount of time between health checks of an individual target"
}

variable "uat-cw-threshold" {
  default     = "75"
  type        = string
  description = "uat-cw-threshold"
}

variable "uat-cw-data" {
  default     = "1"
  type        = string
  description = "uat-cw-data"
}

variable "uat-cw-eval" {
  default     = "1"
  type        = string
  description = "uat-cw-eval"
}



#deployment config

#variable "uat-tg-unhealthy" {
#  default     = "10"
#  type        = string
#  description = "Unhealthy threshold. The number of consecutive health check failures required before considering a target unhealthy."
#}
#variable "uat-tg-timeout" {
#  default     = "120"
#  type        = string
#  description = "Timeout. The amount of time, in seconds, during which no response means a failed health check."
#}
#
#variable "uat-tg-interval" {
#  default     = "300"
#  type        = string
#  description = "Interval. The approximate amount of time between health checks of an individual target"
#}
#
#variable "uat-cw-threshold" {
#  default     = "99"
#  type        = string
#  description = "uat-cw-threshold"
#}
#
#variable "uat-cw-data" {
#  default     = "99"
#  type        = string
#  description = "uat-cw-data"
#}
#
#variable "uat-cw-eval" {
#  default     = "99"
#  type        = string
#  description = "uat-cw-eval"
#}

