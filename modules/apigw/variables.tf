variable "context" {
  description = "Label module context"
}

variable "name" {
  description = "Name of API Gateway"
  type        = string
}

variable "db_path_part" {
  description = "List of paths to different APIs"
  type        = list(string)
}

variable "lambdas_invocation_arn" {
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri."
  type        = list(string)
}