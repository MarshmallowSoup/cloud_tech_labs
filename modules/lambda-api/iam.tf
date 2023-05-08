resource "aws_iam_role" "lambda_role" {
  assume_role_policy = data.aws_iam_policy_document.AWSLambdaTrustPolicy.json
  name               = "${var.function_name}-iam-role-lambda"
}

resource "aws_iam_role_policy_attachment" "iam_role_lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "crud-policy-attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.dynamodb_crud_policy.arn
}

resource "aws_iam_policy" "dynamodb_crud_policy" {
  name        = "${var.function_name}-DynamoDBCrudPolicy"
  path        = "/"
  description = "DynamoDBCrudPolicy"

  policy = <<EOF
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
            "dynamodb:GetItem",
            "dynamodb:DeleteItem",
            "dynamodb:PutItem",
            "dynamodb:Scan",
            "dynamodb:Query",
            "dynamodb:UpdateItem",
            "dynamodb:BatchWriteItem",
            "dynamodb:BatchGetItem",
            "dynamodb:DescribeTable",
            "dynamodb:ConditionCheckItem"
            ],
            "Resource": [
            {
                "Fn::Sub": [
                "${var.table_arn}",
                {
                    "tableName": {
                    "Ref": "TableName"
                    }
                }
                ]
            },
            {
                "Fn::Sub": [
                "${var.table_arn}/index/*",
                {
                    "tableName": {
                    "Ref": "TableName"
                    }
                }
                ]
            }
            ]
        }
        ]
    EOF
}