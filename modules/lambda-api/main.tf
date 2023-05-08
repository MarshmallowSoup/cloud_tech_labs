resource "aws_lambda_function" "serverless-api" {
  filename      = var.lambda_zip
  function_name = var.function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = var.handler
  runtime       = "nodejs16.x"

  environment {
    variables = var.env_var
  }
}

module "labels" {
  source = "cloudposse/label/null"

  context = var.context
}