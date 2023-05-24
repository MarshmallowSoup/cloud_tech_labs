<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.60.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | cloudposse/label/null | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.dynamodb_crud_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.crud-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.iam_role_lambda_basic_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.serverless-api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_iam_policy_document.AWSLambdaTrustPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | Label module context | `any` | n/a | yes |
| <a name="input_env_var"></a> [env\_var](#input\_env\_var) | Map of environment variables that are accessible from the function code during execution. If provided at least one key must be present. | `map(string)` | `{}` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name of Lambda function | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | Function entrypoint in your code. | `string` | `""` | no |
| <a name="input_lambda_zip"></a> [lambda\_zip](#input\_lambda\_zip) | Path to the function's deployment package within the local filesystem | `any` | n/a | yes |
| <a name="input_policy_file"></a> [policy\_file](#input\_policy\_file) | n/a | `any` | n/a | yes |
| <a name="input_table_arn"></a> [table\_arn](#input\_table\_arn) | ARN of DynamoDB table | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_invocation_arn"></a> [invocation\_arn](#output\_invocation\_arn) | ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri. |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | Amazon Resource Name (ARN) identifying your Lambda Function. |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of Lambda Role |
<!-- END_TF_DOCS -->