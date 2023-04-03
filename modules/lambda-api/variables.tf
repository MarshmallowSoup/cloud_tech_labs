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