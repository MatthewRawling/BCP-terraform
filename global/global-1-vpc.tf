# Setup block

provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
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
