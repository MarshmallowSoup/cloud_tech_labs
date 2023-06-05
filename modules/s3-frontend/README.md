<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | cloudposse/label/null | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.frontend_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_object.frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_policy.frontend_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.allow_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_website_configuration.frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | Label module context | `any` | n/a | yes |
| <a name="input_files"></a> [files](#input\_files) | n/a | `any` | n/a | yes |
| <a name="input_folder_path"></a> [folder\_path](#input\_folder\_path) | Path to upload | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_website_endpoint"></a> [website\_endpoint](#output\_website\_endpoint) | Website endpoint. |
<!-- END_TF_DOCS -->