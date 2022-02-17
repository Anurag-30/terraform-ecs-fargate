module "ecs-dev-cluster" {
  source = "../../../modules/ecs-cluster"
  name_prefix = var.name_prefix
}

output "iam-role" {
  value = module.ecs-dev-cluster.role-arn
}

output "cluster-name" {
  value = module.ecs-dev-cluster.ecs-cluster-name
}