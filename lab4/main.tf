module "slack_lambda" {
  source = "../modules/lambda-slack"

  handler       = "index.handler"
  lambda_zip    = "${path.module}/code.zip"
  context       = module.naming.context

  env_var = {
    SLACK_URL = "<slack url>"
  }
  

  depends_on = [null_resource.create_lambda]

}

module "billng_alert" {
  source = "../modules/billing_alert"

  context = module.naming.context
  monthly_billing_threshold = "200"
  currency = "USD"
  aws_account_id = "073240252659"
}

resource "null_resource" "create_lambda" {
    provisioner "local-exec" {
        command = "cd lambda_code && zip -r ../code.zip ."
    }  
}

resource "aws_sns_topic_subscription" "sns_to_slack" {
  topic_arn = module.billng_alert.sns_topic_arn[0]
  protocol  = "lambda"
  endpoint  = module.slack_lambda.lambda_arn

  depends_on = [ module.billng_alert,  module.slack_lambda]
}