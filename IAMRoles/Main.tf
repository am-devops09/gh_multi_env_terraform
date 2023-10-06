terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
		}
	}

	backend "remote" {
		hostname = "app.terraform.io"
		organization = "cicd-eks-gha"

		TF_WORKSPACE = var.workspace
		}
	}


provider "aws" {
	region = "us-east-1"
}