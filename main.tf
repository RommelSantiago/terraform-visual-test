provider "aws" {
  version = "~> 2.0"
  region  = var.region
  access_key = var.my_access_key 
  secret_key = var.my_secret_key 
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