output "ecs_endpoint" {
  value = "aws_ecs_cluster.my-cluster.arn"
}

output "ecr_endpoint" {
  value = "aws_ecr_repository.my-ecr-repository.repository_url"
}