resource "aws_lambda_function" "slack_notify" {
  filename      = var.lambda_zip
  function_name = module.labels.id 
  role          = aws_iam_role.lambda_role.arn
  handler       = var.handler
  runtime       = "python3.9"

  environment {
    variables = var.env_var
  }
}

module "labels" {
  source = "cloudposse/label/null"

  context = var.context
}