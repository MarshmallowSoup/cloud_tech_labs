output "role_arn" {
  description = "ARN of Lambda Role"
  value       = aws_iam_role.lambda_role.arn
}

output "invocation_arn" {
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri."
  value       = aws_lambda_function.serverless-api.invoke_arn
}

output "lambda_arn" {
  description = "Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = aws_lambda_function.serverless-api.invoke_arn
}