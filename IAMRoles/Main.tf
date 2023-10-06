# terraform {
#   required_version = ">= 1.1.0"

#   cloud {
#    organization = "my-org"
#     workspaces {
#      tags = ["app:mine"]
#     }
#   }
# }

# provider "aws" {
# 	region = "us-east-1"
# }
terraform {
  backend "s3" {
    bucket = "terraform-workspaces-mvone"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}