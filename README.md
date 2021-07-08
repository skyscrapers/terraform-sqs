# terraform-sqs

Terraform modules to set up SQS.

## sqs_with_iam

Adds a iam profile and sqs queue.

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | >= 3.48 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 3.48 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_iam_policy.consumer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.pusher](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_sqs_queue.queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_iam_policy_document.consumer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pusher](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input_name) | The SQS queue name | `string` | n/a | yes |
| <a name="input_content_based_deduplication"></a> [content_based_deduplication](#input_content_based_deduplication) | Enables content-based deduplication for FIFO queues | `bool` | `false` | no |
| <a name="input_dead_letter_queue"></a> [dead_letter_queue](#input_dead_letter_queue) | The dead letter queue to use for undeliverable messages | `string` | `null` | no |
| <a name="input_deduplication_scope"></a> [deduplication_scope](#input_deduplication_scope) | Specifies whether message deduplication occurs at the message group or queue level. Valid values are `messageGroup` and `queue` (default) | `string` | `null` | no |
| <a name="input_delay_seconds"></a> [delay_seconds](#input_delay_seconds) | The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds | `number` | `0` | no |
| <a name="input_fifo_queue"></a> [fifo_queue](#input_fifo_queue) | Boolean designating a FIFO queue. If not set, it defaults to false making it standard. This will append the required extension `.fifo` to the queue name | `bool` | `false` | no |
| <a name="input_fifo_throughput_limit"></a> [fifo_throughput_limit](#input_fifo_throughput_limit) | Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are `perQueue` (default) and `perMessageGroupId` | `string` | `null` | no |
| <a name="input_kms_data_key_reuse_period_seconds"></a> [kms_data_key_reuse_period_seconds](#input_kms_data_key_reuse_period_seconds) | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes) | `number` | `null` | no |
| <a name="input_kms_master_key_id"></a> [kms_master_key_id](#input_kms_master_key_id) | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK | `string` | `null` | no |
| <a name="input_max_message_size"></a> [max_message_size](#input_max_message_size) | The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB) | `number` | `262144` | no |
| <a name="input_max_receive_count"></a> [max_receive_count](#input_max_receive_count) | maxReceiveCount for the Dead Letter Queue redrive policy | `number` | `5` | no |
| <a name="input_message_retention_seconds"></a> [message_retention_seconds](#input_message_retention_seconds) | The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days) | `number` | `345600` | no |
| <a name="input_receive_wait_time_seconds"></a> [receive_wait_time_seconds](#input_receive_wait_time_seconds) | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input_tags) | A map of tags to assign to the queue | `map(string)` | `null` | no |
| <a name="input_visibility_timeout_seconds"></a> [visibility_timeout_seconds](#input_visibility_timeout_seconds) | The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. | `number` | `30` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output_arn) | The ARN for the created Amazon SQS queue |
| <a name="output_consumer_policy_arn"></a> [consumer_policy_arn](#output_consumer_policy_arn) | The ARN of the IAM policy used by the queue pusher |
| <a name="output_id"></a> [id](#output_id) | The URL for the created Amazon SQS queue |
| <a name="output_pusher_policy_arn"></a> [pusher_policy_arn](#output_pusher_policy_arn) | The ARN of the IAM policy used by the queue consumer / worker |

### Examples

```terraform
module "sqs" {
  source = "github.com/skyscrapers/terraform-sqs//sqs_with_iam?ref=4.0.0"

  for_each = toset(["myqueue"])

  name       = "${each.key}-${terraform.workspace}"
  fifo_queue = true
}

resource "aws_iam_role_policy_attachment" "sqs_consumer_attach" {
  role       = "some_role_name"
  policy_arn = module.sqs["myqueue"].consumer_policy_arn
}
```

### Migrating from 3.0.0 to 4.0.0

This module has been completely rewritten between v3 and v4. Most important changes:

- Removed the `count` on the resources. Instead you can use `for_each` on the module

  You could migrate existing state, for example:

  ```terraform
  module "sqs" {
    source   = "github.com/skyscrapers/terraform-sqs//sqs_with_iam?ref=4.0.0"

    for_each = toset(["queue1", "queue2"])
    name     = "${terraform.workspace}_myproject_${each.key}"
  }
  ```

  ```shell
  terraform state mv module.sqs.aws_sqs_queue.queue[0] module.sqs["queue1"].aws_sqs_queue.queue
  terraform state mv module.sqs.aws_sqs_queue.queue[1] module.sqs["queue2"].aws_sqs_queue.queue
  ```

- Removed the `environment` and `project` variables. Instead provide a `name` variable of choice. To keep the previous queue name, you can set `name = "<environment>_<project>_<oldname>"`
- Renamed the AWS IAM Policies created by the module. This is breaking without a migration path: policies will be destroyed and recreated. You can remove the old policies from the Terraform state (and cleanup manually afterwards) via:

  ```shell
  terraform state rm aws_iam_policy.consumer_policy
  terraform state rm aws_iam_policy.pusher_policy
  ```

- Renamed outputs: `pusher_policy` becomes `pusher_policy_arn` and `consumer_policy` becomes `consumer_policy_arn`
