terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
		}
	}

	backend "remote" {
		hostname = "app.terraform.io"
		organization = "cicd-eks-gha"

		# workspaces {
		# 	# name = "multi_env_ghactions" ## i have to mad it tfvars which depends in git branch or env 
		# 	name = var.workspace
		# }
	}
}

provider "aws" {
	region = "us-east-1"
}