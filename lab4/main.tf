module "slack_lambda" {
  source = "../modules/lambda-slack"

  handler       = "index.handler"
  lambda_zip    = "${path.module}/code.zip"
  context       = module.naming.context
  table_arn     = module.courses_table.table_arn

  env_var = {
    SLACK_URL = module.courses_table.table_name
  }

  policy_file = data.template_file.crud_policy_courses.rendered

  depends_on = [null_resource.create_lambda]

}

module "billng_alert" {
  source = "../modules/billing_alert"
}

resource "null_resource" "create_lambda" {
    provisioner "local-exec" {
        command = "cd lambda_code && zip -r ../code.zip ."
    }  
}

resource "aws_sns_topic_subscription" "user_updates_lampda_target" {
  topic_arn = module.billng_alert.sns_topic_arn
  protocol  = "lambda"
  endpoint  = module.slack_lambda.lambda_arn
}