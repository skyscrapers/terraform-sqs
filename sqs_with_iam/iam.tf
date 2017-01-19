
resource "aws_iam_policy" "policy" {
    name = "sqs_${var.name}_${var.project}_${var.environment}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "sqs:GetQueueAttributes",
              "sqs:ListQueues",
              "sqs:ReceiveMessage",
              "sqs:SendMessage",
              "sqs:SendMessageBatch"
            ],
            "Resource": [
                "${aws_sqs_queue.queue.arn}"
            ]
        }
    ]
}
EOF
}
