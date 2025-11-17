# outputs.tf - Output values after deployment

output "pipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.app_pipeline.name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.app_pipeline.arn
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = aws_codebuild_project.app_build.name
}

output "s3_artifacts_bucket" {
  description = "S3 bucket for pipeline artifacts"
  value       = aws_s3_bucket.pipeline_artifacts.bucket
}

output "sns_topic_arn" {
  description = "SNS topic for pipeline notifications"
  value       = aws_sns_topic.pipeline_notifications.arn
}

output "pipeline_url" {
  description = "URL to view the pipeline in AWS Console"
  value       = "https://${var.aws_region}.console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.app_pipeline.name}/view"
}

output "next_steps" {
  description = "What to do next"
  value       = <<-EOT
    ✅ CI/CD Pipeline deployed successfully!
    
    Pipeline URL:
    https://${var.aws_region}.console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.app_pipeline.name}/view
    
    To trigger a deployment:
    1. Make a change to your GitHub repository
    2. Push to ${var.github_branch} branch
    3. Pipeline will automatically: Source → Build → Deploy
    
    View pipeline execution:
    aws codepipeline get-pipeline-state --name ${aws_codepipeline.app_pipeline.name} --region ${var.aws_region}
    
    View build logs:
    aws logs tail ${aws_cloudwatch_log_group.codebuild_logs.name} --follow --region ${var.aws_region}
    
    ⚠️ IMPORTANT: Check your email to confirm SNS subscription!
  EOT
}
