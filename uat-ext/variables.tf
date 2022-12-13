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

variable "availability_zones" {
  default     = ["eu-west-2a", "eu-west-2b"]
  type        = list
  description = "List of availability zones"
}

variable "uat_cert2" {
  default     = "arn:aws:acm:us-east-1:181623394163:certificate/0413b71c-6833-46c0-bd8a-5e5f8e42c36c"
  type        = string
  description = "cert for UAT bce site (us)"
}

variable "uat_cert3" {
  default     = "arn:aws:acm:us-east-1:181623394163:certificate/53b29a4c-dec5-4cd1-9598-f6489177c5bd"
  type        = string
  description = "cert for UAT bcs site (us)"
}

variable "uat_cert4" {
  default     = "arn:aws:acm:us-east-1:181623394163:certificate/6cc45c66-e40b-473b-a4b9-e23ca3d7fa12"
  type        = string
  description = "cert for UAT bcw site (us)"
}

variable "uat_cert5" {
  default     = "arn:aws:acm:us-east-1:181623394163:certificate/a328f494-b5b4-466b-af06-c7ca970ba935"
  type        = string
  description = "cert for UAT cffg site (us)"
}

variable "uat_bce_alb_name" {
  default     = "uat-bce-app-alb-546190699.eu-west-2.elb.amazonaws.com"
  type        = string
  description = "address of uat bce application load balancer"
}

variable "uat_bce_alb_origin" {
  default     = "uat-bce-app-alb"
  type        = string
  description = "name of uat bce application load balancer"
}

variable "uat_bcs_alb_name" {
  default     = "uat-bcs-app-alb-1768519539.eu-west-2.elb.amazonaws.com"
  type        = string
  description = "address of uat bcs application load balancer"
}

variable "uat_bcs_alb_origin" {
  default     = "uat-bcs-app-alb"
  type        = string
  description = "name of uat bcs application load balancer"
}

variable "uat_bcw_alb_name" {
  default     = "uat-bcw-app-alb-815203766.eu-west-2.elb.amazonaws.com"
  type        = string
  description = "address of uat bcw application load balancer"
}

variable "uat_bcw_alb_origin" {
  default     = "uat-bcw-app-alb"
  type        = string
  description = "name of uat bcw application load balancer"
}

variable "uat_cffg_alb_name" {
  default     = "uat-cffg-app-alb-60691542.eu-west-2.elb.amazonaws.com"
  type        = string
  description = "address of uat cffg application load balancer"
}

variable "uat_cffg_alb_origin" {
  default     = "uat-cffg-app-alb"
  type        = string
  description = "name of uat cffg application load balancer"
}
