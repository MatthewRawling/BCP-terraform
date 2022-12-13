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

