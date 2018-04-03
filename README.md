# terraform-sqs

Terraform modules to set up SQS.

## sqs_with_iam

Adds a iam profile and sqs queue.

### Available variables:

* [`project`]: String(required): The project of this queue
* [`environment`]: String(required): How do you want to call your environment, this is helpful if you have more than 1 VPC.
* [`name`]: List(required): A list of the sqs queues
* [`fifo_queue`]: Boolean(optional, defaults to `false`): Create a FIFO queue.
  This will append the required extension `.fifo` to the queue name.
* all other variables and description can be found in the variables.tf section

### Output

* [`arn`]: String: The Amazon Resource Name (ARN) specifying the role.
* [`id`]: String: The URL for the created Amazon SQS queue.
* [`consumer_policy`]: List: A list of the arns of the IAM policies used by the queue consumer / worker.
* [`pusher_policy`]: List: A list of the arns of the IAM policies used by the queue pusher.

### Examples

*Standard queue*

```hcl
  module "sqs" {
    source      = "github.com/skyscrapers/terraform-sqs//sqs_with_iam"
    environment = "${var.environment}"
    project     = "${var.project}"
    name        = ["sqs_name"]
  }
  resource "aws_iam_role_policy_attachment" "sqs-attach" {
      role       = "${module.instance.role}"
      policy_arn = "${module.sqs_api.consumer_policy}"
  }
```

*FIFO queue*

```hcl
  module "sqs" {
    source      = "github.com/skyscrapers/terraform-sqs//sqs_with_iam"
    environment = "${var.environment}"
    project     = "${var.project}"
    name        = ["sqs_name"]
    fifo_queue  = "true"
  }
  resource "aws_iam_role_policy_attachment" "sqs-attach" {
      role       = "${module.instance.role}"
      policy_arn = "${module.sqs_api.consumer_policy}"
  }
```
