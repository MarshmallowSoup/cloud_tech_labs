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
  table_arn     = module.authors_table.table_arn

  env_var = {
    TABLE_NAME = module.authors_table.table_name
  }

  policy_file = data.template_file.crud_policy_authors.rendered

  depends_on = [null_resource.create_lambda]
}

module "courses_lambda" {
  source = "../modules/lambda-api"

  function_name = format("courses-%v", module.naming.id)
  handler       = "index.handler"
  lambda_zip    = "${path.module}/code.zip"
  context       = module.naming.context
  table_arn     = module.courses_table.table_arn

  env_var = {
    TABLE_NAME = module.courses_table.table_name
  }

  policy_file = data.template_file.crud_policy_courses.rendered

  depends_on = [null_resource.create_lambda]
}

resource "null_resource" "create_lambda" {
  provisioner "local-exec" {
    command = "cd lambda_code && npm i && zip -r ../code.zip ."
  }
}

module "api_gw" {
  source = "../modules/apigw"

  context                = module.naming.context
  db_path_part           = [lower(module.courses_table.table_name), lower(module.authors_table.table_name)]
  lambdas_invocation_arn = [module.courses_lambda.invocation_arn, module.authors_lambda.invocation_arn]

  depends_on = [ module.authors_lambda, module.courses_lambda ]
}