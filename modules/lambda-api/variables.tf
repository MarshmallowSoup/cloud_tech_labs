variable "function_name" {
  type        = string
  description = "Name of Lambda function"
}

variable "lambda_zip" {
  description = "Path to the function's deployment package within the local filesystem"
}

variable "handler" {
  default     = ""
  description = "Function entrypoint in your code."
}

variable "context" {
  description = "Label module context"
}

variable "env_var" {
  default     = {}
  description = "Map of environment variables that are accessible from the function code during execution. If provided at least one key must be present."
  type        = map(string)
}

variable "table_arn" {
  type        = string
  description = "ARN of DynamoDB table"
}

variable "policy_file" {

}