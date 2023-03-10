provider "aws" {
  version = "~> 2.0"
  region  = var.region
  access_key = var.myaccesskey
  secret_key = var.mysecretkey
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

module "eks" {
  source = "./modules/eks"
  sn_a_id = module.vpc.subnet_a_id
  sn_b_id = module.vpc.subnet_b_id
}