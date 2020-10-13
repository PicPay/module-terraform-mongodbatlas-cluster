provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  profile = "picpay-lab"
}

terraform {
  backend "s3" {
    bucket = "081471437700-terraform-state"
    key =  "module-mongodb-cluster/terraform.tfstate"
    profile = "picpay-lab"
    region = "us-east-1"
  }
}