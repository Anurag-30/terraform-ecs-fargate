provider "aws" {
  region = "us-east-1"
}

module "ecs-dev-cluster" {
  source = "../../../modules/ecs-cluster"
  name_prefix = var.name_prefix
  environment = var.environment
  vpc_id      = var.vpc_id
  public_subnets = var.public_subnets
  vpc_cidr       = var.vpc_cidr
}


output "iam-role" {
  value = module.ecs-dev-cluster.role-arn
}

output "cluster-name" {
  value = module.ecs-dev-cluster.ecs-cluster-name
}