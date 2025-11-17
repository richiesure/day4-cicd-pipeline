# variables.tf - Input variables for CI/CD pipeline

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "github_repo" {
  description = "GitHub repository (format: username/repo)"
  type        = string
  default     = "richiesure/day3-docker-ecs-deployment"
}

variable "github_branch" {
  description = "GitHub branch to track"
  type        = string
  default     = "main"
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "devops-day3-app"
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "devops-day3-cluster"
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
  default     = "devops-day3-service"
}

variable "notification_email" {
  description = "Email for pipeline notifications"
  type        = string
  default     = "richieprograms@gmail.com.com"
}
