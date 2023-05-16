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

  request_templates = {
    "application/xml" = <<EOF
      {
        "body" : $input.json('$')
      }
      EOF
  }
  content_handling = "CONVERT_TO_TEXT"
}


resource "aws_api_gateway_method_response" "get_items_integration_response" {
  count = length(var.db_path_part)

  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.crud_paths[count.index].id
  http_method = aws_api_gateway_method.get_items[count.index].http_method
  status_code = "200"
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

resource "aws_api_gateway_method_response" "put_items_integration_response" {
  count = length(var.db_path_part)

  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.crud_paths[count.index].id
  http_method = aws_api_gateway_method.put_items[count.index].http_method
  status_code = "200"
}


resource "aws_api_gateway_resource" "by_id" {
  count = length(var.db_path_part)

  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  parent_id   = aws_api_gateway_resource.crud_paths[count.index].id
  path_part   = "{id}"

}

resource "aws_api_gateway_method" "get_item_by_id" {
  count = length(var.db_path_part)

  rest_api_id   = aws_api_gateway_rest_api.lambda_api.id
  resource_id   = aws_api_gateway_resource.by_id[count.index].id
  http_method   = "GET"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "get_item_by_id_integration" {
  count = length(var.db_path_part)

  rest_api_id             = aws_api_gateway_rest_api.lambda_api.id
  resource_id             = aws_api_gateway_resource.by_id[count.index].id
  http_method             = aws_api_gateway_method.get_items[count.index].http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = var.lambdas_invocation_arn[count.index]

  request_templates = {
    "application/xml" = <<EOF
      {
        "body" : $input.json('$')
      }
      EOF
  }
  content_handling = "CONVERT_TO_TEXT"
}


resource "aws_api_gateway_method_response" "get_item_by_id_integration_response" {
  count = length(var.db_path_part)

  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.by_id[count.index].id
  http_method = aws_api_gateway_method.get_item_by_id[count.index].http_method
  status_code = "200"
}

resource "aws_api_gateway_method" "delete_item" {
  count = length(var.db_path_part)

  rest_api_id   = aws_api_gateway_rest_api.lambda_api.id
  resource_id   = aws_api_gateway_resource.by_id[count.index].id
  http_method   = "DELETE"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "delete_item_integration" {
  count = length(var.db_path_part)

  rest_api_id             = aws_api_gateway_rest_api.lambda_api.id
  resource_id             = aws_api_gateway_resource.by_id[count.index].id
  http_method             = aws_api_gateway_method.delete_item[count.index].http_method
  integration_http_method = "DELETE"
  type                    = "AWS_PROXY"
  uri                     = var.lambdas_invocation_arn[count.index]

  request_templates = {
    "application/xml" = <<EOF
      {
        "body" : $input.json('$')
      }
      EOF
  }
  content_handling = "CONVERT_TO_TEXT"
}


resource "aws_api_gateway_method_response" "delete_item_integration_response" {
  count = length(var.db_path_part)

  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.by_id[count.index].id
  http_method = aws_api_gateway_method.delete_item[count.index].http_method
  status_code = "200"
}


resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
}

resource "aws_api_gateway_stage" "deployment_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.lambda_api.id
  stage_name    = "dev"
}