resource "aws_iam_policy" "consumer_policy" {
  count = "${length(var.name)}"
  name  = "sqs_${var.name[count.index]}_${var.project}_${var.environment}_consumer"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage*",
        "sqs:PurgeQueue",
        "sqs:ChangeMessageVisibility*"
      ],
      "Resource": [
        "${element(aws_sqs_queue.queue.*.arn, count.index)}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_policy" "pusher_policy" {
  count = "${length(var.name)}"
  name  = "sqs_${var.name[count.index]}_${var.project}_${var.environment}_pusher"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:SendMessage*"
      ],
      "Resource": [
        "${element(aws_sqs_queue.queue.*.arn, count.index)}"
      ]
    }
  ]
}
EOF
}
