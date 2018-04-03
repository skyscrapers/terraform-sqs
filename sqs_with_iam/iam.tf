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
        "${aws_sqs_queue.queue.arn}"
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
        "${aws_sqs_queue.queue.arn}"
      ]
    }
  ]
}
EOF
}
