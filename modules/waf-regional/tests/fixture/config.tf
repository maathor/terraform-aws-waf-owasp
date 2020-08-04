#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  version                 = "~> 2.70"
  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = "~/.aws/${var.project}/config"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS Profile"
  default     = "bb-dev-deploymaster"   # ci aws-iam-profile
  #default    = "bb-apps-devstg-devops" # localhost aws-iam-profile
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.12.28"
}

#=============================#
# VPC remote state data       #
#=============================#
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    region  = var.region
    profile = var.profile
    bucket  = "${var.project}-apps-devstg-terraform-backend"
    key     = "apps-devstg/network/terraform.tfstate"
  }
}
