
## i will need s3 to have multiple backends, but first i will try another way with terraform cloud

# terraform {
#   backend "s3" {
#     bucket = "terraform-workspaces-mvone"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#   }
# }