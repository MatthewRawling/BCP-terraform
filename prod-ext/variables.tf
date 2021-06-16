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

variable "prod_cert2" {
  default     = "arn:aws:acm:us-east-1:416173853406:certificate/45ff3427-3cdf-4d3f-8ce7-21f64ceedcd3"
  type        = string
  description = "cert for PROD bce site (us)"
}

variable "prod_cert3" {
  default     = "arn:aws:acm:us-east-1:416173853406:certificate/f4e2b1db-1bed-4bd4-831c-945dd8b5dc06"
  type        = string
  description = "cert for PROD bcs site (us)"
}

variable "prod_cert4" {
  default     = "arn:aws:acm:us-east-1:416173853406:certificate/9f588067-4c16-4ce7-bed0-57fd314cc90f"
  type        = string
  description = "cert for PROD bcw site (us)"
}

variable "prod_cert5" {
  default     = "arn:aws:acm:us-east-1:416173853406:certificate/22ae4aa1-6a4b-4671-9390-82af9fd6b4e7"
  type        = string
  description = "cert for PROD cffg site (us)"
}

variable "prod_bce_alb_name" {
  default     = "prod-bce-app-alb-1142007458.eu-west-2.elb.amazonaws.com"
  type        = string
  description = "address of prod bce application load balancer"
}

variable "prod_bce_alb_origin" {
  default     = "prod-bce-app-alb"
  type        = string
  description = "name of prod bce application load balancer"
}

variable "prod_bcs_alb_name" {
  default     = "prod-bcs-app-alb-164974533.eu-west-2.elb.amazonaws.com"
  type        = string
  description = "address of prod bcs application load balancer"
}

variable "prod_bcs_alb_origin" {
  default     = "prod-bcs-app-alb"
  type        = string
  description = "name of prod bcs application load balancer"
}

variable "prod_bcw_alb_name" {
  default     = "prod-bcw-app-alb-1702065618.eu-west-2.elb.amazonaws.com"
  type        = string
  description = "address of prod bcw application load balancer"
}

variable "prod_bcw_alb_origin" {
  default     = "prod-bcw-app-alb"
  type        = string
  description = "name of prod bcw application load balancer"
}

variable "prod_cffg_alb_name" {
  default     = "prod-cffg-app-alb-498590345.eu-west-2.elb.amazonaws.com"
  type        = string
  description = "address of prod cffg application load balancer"
}

variable "prod_cffg_alb_origin" {
  default     = "prod-cffg-app-alb"
  type        = string
  description = "name of prod cffg application load balancer"
}
