<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.asg_cpu_high](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_dynamodb_table.tf_locks](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/dynamodb_table) | resource |
| [aws_eip.nat_a](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/eip) | resource |
| [aws_eip.nat_b](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/eip) | resource |
| [aws_iam_openid_connect_provider.gitlab](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.datadog_monitoring_role](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/iam_role) | resource |
| [aws_iam_role.gitlab_ci_role](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.gitlab_ci_policy](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.datadog_read_only](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_attach](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_s3_read](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/internet_gateway) | resource |
| [aws_lb.ecs-aws](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.lab_tg](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/lb_target_group) | resource |
| [aws_nat_gateway.nat_a](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.nat_b](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_a](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/route_table) | resource |
| [aws_route_table.private_b](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private_a](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_b](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_a](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_b](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/route_table_association) | resource |
| [aws_s3_account_public_access_block.block_account_public_access](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/s3_account_public_access_block) | resource |
| [aws_s3_bucket.state_terraform_infrastructure](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_versioning.state_terraform_infrastructure_versioning](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/security_group) | resource |
| [aws_security_group.ecs_tasks](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/security_group) | resource |
| [aws_sns_topic.alarm_topic](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/sns_topic) | resource |
| [aws_subnet.private_a](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/subnet) | resource |
| [aws_subnet.private_b](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/subnet) | resource |
| [aws_subnet.public_a](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/subnet) | resource |
| [aws_subnet.public_b](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region to deploy the resources | `string` | `"us-east-1"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket | `string` | n/a | yes |
| <a name="input_datadog_external_id"></a> [datadog\_external\_id](#input\_datadog\_external\_id) | External ID provided by Datadog for AWS Integration | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (e.g. dev, stag, prod) | `string` | `"dev"` | no |
| <a name="input_gitlab_project_path"></a> [gitlab\_project\_path](#input\_gitlab\_project\_path) | GitLab project path for OIDC Role (e.g. user/repo) | `string` | `"ravan/aws-ecs-terraform-CI-CD"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnet CIDRs | `list(string)` | <pre>[<br/>  "10.0.3.0/24",<br/>  "10.0.4.0/24"<br/>]</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name used for tagging and prefixing | `string` | `"ecs-aws"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of public subnet CIDRs | `list(string)` | <pre>[<br/>  "10.0.1.0/24",<br/>  "10.0.2.0/24"<br/>]</pre> | no |
| <a name="input_state_bucket_name"></a> [state\_bucket\_name](#input\_state\_bucket\_name) | The name of the S3 bucket for Terraform State | `string` | `"state-terraform-infrastructure-ecs-aws-ravan"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | Application Load Balancer ARN |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | Application Load Balancer DNS |
| <a name="output_alb_target_group_arn"></a> [alb\_target\_group\_arn](#output\_alb\_target\_group\_arn) | ALB Target Group ARN |
| <a name="output_ecs_tasks_security_group_id"></a> [ecs\_tasks\_security\_group\_id](#output\_ecs\_tasks\_security\_group\_id) | ECS Tasks Security Group ID |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | Private subnet IDs |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | Public subnet IDs |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
<!-- END_TF_DOCS -->