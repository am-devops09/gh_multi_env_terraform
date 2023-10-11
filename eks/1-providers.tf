provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }
  backend "s3" {
    bucket = "terraform-workspaces-backup"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

  required_version = "~> 1.0"
}
