resource "aws_api_gateway_rest_api" "lambda_api" {
  name = "${var.name}-api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "db_paths" {
  count = length(var.db_path_part)

  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  parent_id   = aws_api_gateway_rest_api.lambda_api.root_resource_id
  path_part   = var.db_path_part[count.index]

}

resource "aws_api_gateway_resource" "crud_paths" {
  count = length(var.db_path_part)

  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  parent_id   = aws_api_gateway_resource.db_paths[count.index].id
  path_part   = "items"

}


resource "aws_api_gateway_method" "get_items" {
  count = length(var.db_path_part)

  rest_api_id   = aws_api_gateway_rest_api.lambda_api.id
  resource_id   = aws_api_gateway_resource.crud_paths[count.index].id
  http_method   = "GET"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "get_items_integration" {
  count = length(var.db_path_part)

  rest_api_id             = aws_api_gateway_rest_api.lambda_api.id
  resource_id             = aws_api_gateway_resource.crud_paths[count.index].id
  http_method             = aws_api_gateway_method.get_items[count.index].http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = var.lambdas_invocation_arn[count.index]
}

resource "aws_api_gateway_method" "put_items" {
  count = length(var.db_path_part)

  rest_api_id   = aws_api_gateway_rest_api.lambda_api.id
  resource_id   = aws_api_gateway_resource.crud_paths[count.index].id
  http_method   = "PUT"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "put_items_integration" {
  count = length(var.db_path_part)

  rest_api_id             = aws_api_gateway_rest_api.lambda_api.id
  resource_id             = aws_api_gateway_resource.crud_paths[count.index].id
  http_method             = aws_api_gateway_method.put_items[count.index].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambdas_invocation_arn[count.index]
}