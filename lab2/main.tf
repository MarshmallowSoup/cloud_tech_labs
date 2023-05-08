module "authors_table" {
  source = "../modules/dynamodb"

  table_name = "Authors"
  context    = module.naming.context
}

module "courses_table" {
  source = "../modules/dynamodb"

  table_name = "Courses"
  context    = module.naming.context
}

module "authors_lambda" {
  source = "../modules/lambda-api"

  function_name = format("authors-%v", module.naming.id)
  handler       = "index.handler"
  lambda_zip    = "${path.module}/code.zip"
  context       = module.naming.context

  env_var = {
    TABLE_NAME = module.authors_table.table_name
  }
  
  depends_on = [ null_resource.create_lambda ]
}

module "courses_lambda" {
  source = "../modules/lambda-api"

  function_name = format("courses-%v", module.naming.id)
  handler       = "index.handler"
  lambda_zip    = "${path.module}/code.zip"
  context       = module.naming.context

  env_var = {
    TABLE_NAME = module.courses_table.table_name
  }

  depends_on = [ null_resource.create_lambda ]
}

resource "null_resource" "create_lambda" {
  provisioner "local-exec" {
    command = "cd lambda_code && npm i && zip -r ../code.zip ."
  }
}

module "api_gw" {
  source = "../modules/apigw"

  
}