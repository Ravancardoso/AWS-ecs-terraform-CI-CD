# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

# Subnets públicas
output "public_subnet_ids" {
  description = "Public subnet IDs"
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

# Subnets privadas
output "private_subnet_ids" {
  description = "Private subnet IDs"
  value = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
}

# ALB
output "alb_dns_name" {
  description = "Application Load Balancer DNS"
  value       = aws_lb.ecs-aws.dns_name
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.ecs-aws.arn
}

# Target Group
output "alb_target_group_arn" {
  description = "ALB Target Group ARN"
  value       = aws_lb_target_group.lab_tg.arn
}

# Security Groups
output "ecs_tasks_security_group_id" {
  description = "ECS Tasks Security Group ID"
  value       = aws_security_group.ecs_tasks.id
}



