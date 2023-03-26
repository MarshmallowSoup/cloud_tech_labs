module "authors_table" {
  source = "../modules/dynamodb"

  table_name = "Authors"
}

module "courses_table" {
  source = "../modules/dynamodb"

  table_name = "Courses"
}

module "lambda_api" {
  source = "../modules/lambda-api"

  function_name = module.naming.id
  handler       = "index.handler"
  lambda_zip    = "${path.module}../lambda-api.zip"
}

