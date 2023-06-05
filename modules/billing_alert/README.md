<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | cloudposse/label/null | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.account_billing_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.sns_alert_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS account id | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Label module context | `any` | n/a | yes |
| <a name="input_create_sns_topic"></a> [create\_sns\_topic](#input\_create\_sns\_topic) | Creates a SNS Topic if true. | `bool` | `true` | no |
| <a name="input_currency"></a> [currency](#input\_currency) | Currency which is used for checking billing | `string` | `"USD"` | no |
| <a name="input_monthly_billing_threshold"></a> [monthly\_billing\_threshold](#input\_monthly\_billing\_threshold) | The threshold for which estimated monthly charges will trigger the metric alarm. | `string` | n/a | yes |
| <a name="input_sns_list"></a> [sns\_list](#input\_sns\_list) | Additional SNS topics arn | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | n/a |
<!-- END_TF_DOCS -->