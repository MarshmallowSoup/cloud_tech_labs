variable "context" {
  description = "Label module context"
}

variable "monthly_billing_threshold" {
  type        = string
  description = "	The threshold for which estimated monthly charges will trigger the metric alarm."
}

variable "create_sns_topic" {
  type        = bool
  default     = true
  description = "Creates a SNS Topic if true."
}

variable "aws_account_id" {
  type        = string
  description = "AWS account id"
}

variable "currency" {
  type        = string
  default     = "USD"
  description = "Currency which is used for checking billing"
}

variable "sns_list" {
  type        = list(string)
  default     = [""]
  description = "Additional SNS topics arn"
}