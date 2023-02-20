provider "aws" {
  version = "~> 2.0"
  region = var.region
}

module "vpc" {
  source = "./module"
  region = var.region
}
