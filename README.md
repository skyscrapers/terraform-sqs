# terraform-sqs

Terraform modules to set up SQS.

## sqs_with_iam

Adds a iam profile and sqs queue.

### Available variables:

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dead_letter_queue | The dead letter queue to use for undeliverable messages | string | `` | no |
| delay_seconds | Delay in displaying message | string | `0` | no |
| environment | How do you want to call your environment, this is helpful if you have more than 1 VPC | string | - | yes |
| fifo_queue | Configure the queue(s) to be FIFO queue(s). This will append the required extension `.fifo` to the queue name(s). | string | `false` | no |
| max_message_size | Max size of the message default to 256KB | string | `262144` | no |
| max_receive_count | Maximum receive count | string | `5` | no |
| message_retention_seconds | Seconds of retention of the message default to 4 days | string | `345600` | no |
| name | List of the SQS queue names. If you provide multiple names, each queue will be setup with the same configuration | list | - | yes |
| project | The project of this queue(s) | string | - | yes |
| receive_wait_time_seconds | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately. | string | `20` | no |
| visibility_timeout_seconds | The timeout in seconds of visibility of the message | string | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) specifying the role. |
| consumer_policy | A list of the arns of the IAM policies used by the queue pusher. |
| id | A list of URLs for the created Amazon SQS queues. |
| pusher_policy | A list of the arns of the IAM policies used by the queue consumer / worker. |
| queue_count | The number of queues to be created. To be used downstream |

### Examples

*Standard queue*

```hcl
module "sqs" {
  source      = "github.com/skyscrapers/terraform-sqs//sqs_with_iam"
  environment = "staging"
  project     = "example"
  name        = ["sqs_name"]
}

resource "aws_iam_role_policy_attachment" "sqs-attach" {
  count      = "${module.sqs.queue_count}"
  role       = "some_role_name"
  policy_arn = "${module.sqs.consumer_policy[count.index]}"
}
```

*FIFO queue*

```hcl
module "sqs" {
  source      = "github.com/skyscrapers/terraform-sqs//sqs_with_iam"
  environment = "staging"
  project     = "example"
  name        = ["sqs_name", "another_sqs_queue_name"]
  fifo_queue  = "true"
}

resource "aws_iam_role_policy_attachment" "sqs-attach" {
  count      = "${module.sqs.queue_count}"
  role       = "some_role_name"
  policy_arn = "${module.sqs.consumer_policy[count.index]}"
}
```
