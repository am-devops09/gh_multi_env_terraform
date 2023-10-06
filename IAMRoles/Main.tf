terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
		}
	}

	backend "remote" {
		hostname = "app.terraform.io"
		organization = "cicd-eks-gha"

		workspaces {
			name = "multi_env_ghactions"
		}
	}
}

provider "aws" {
	region = "us-east-1"
}