resource "aws_iam_role" "lambda_role" {
  assume_role_policy = data.aws_iam_policy_document.AWSLambdaTrustPolicy.json
  name               = "${var.function_name}-iam-role-lambda"
}

resource "aws_iam_role_policy_attachment" "iam_role_lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "serverless-api" {
  filename      = var.lambda_zip
  function_name = var.function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = var.handler
  runtime       = "nodejs16.x"
}

module "labels" {
  source      = "cloudposse/label/null"

  context = var.context
}