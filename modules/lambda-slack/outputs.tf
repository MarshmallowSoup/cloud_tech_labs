output "role_arn" {
  description = "ARN of Lambda Role"
  value       = aws_iam_role.lambda_role.arn
}

output "lambda_arn" {
  description = "Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = aws_lambda_function.slack_notify.invoke_arn
}