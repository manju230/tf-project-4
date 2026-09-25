output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

# App subnets
output "app_subnets" {
  description = "App subnet IDs"
  value = [
    aws_subnet.app_a.id,
    aws_subnet.app_b.id,
    aws_subnet.app_c.id
  ]
}

# DB subnets
output "db_subnets" {
  description = "DB subnet IDs"
  value = [
    aws_subnet.db_a.id,
    aws_subnet.db_b.id,
    aws_subnet.db_c.id
  ]
}

# Web subnets
output "web_subnets" {
  description = "Web subnet IDs"
  value = [
    aws_subnet.web_a.id,
    aws_subnet.web_b.id,
    aws_subnet.web_c.id
  ]
}

# ECS subnets
output "ecs_subnets" {
  description = "ECS subnet IDs"
  value = [
    aws_subnet.ecs_a.id,
    aws_subnet.ecs_b.id,
    aws_subnet.ecs_c.id
  ]
}

# EKS subnets
output "eks_subnets" {
  description = "EKS subnet IDs"
  value = [
    aws_subnet.eks_a.id,
    aws_subnet.eks_b.id,
    aws_subnet.eks_c.id
  ]
}
