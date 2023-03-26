output "api_id" {
  value = aws_api_gateway_rest_api.lambda_api.id
}

output "api_resource_id" {
  value = aws_api_gateway_resource.example.id
}