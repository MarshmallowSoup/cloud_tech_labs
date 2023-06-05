data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  version = "2012-10-17"

  statement {

    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

  }

}
