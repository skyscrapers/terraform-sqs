data "aws_iam_policy_document" "consumer" {
  statement {
    effect    = "Allow"
    resources = [aws_sqs_queue.queue.arn]

    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage*",
      "sqs:PurgeQueue",
      "sqs:ChangeMessageVisibility*"
    ]
  }

  statement {
    effect    = "Allow"
    resources = [var.kms_master_key_id]

    actions = [
      "kms:Decrypt"
    ]
  }
}

data "aws_iam_policy_document" "pusher" {
  statement {
    effect    = "Allow"
    resources = [aws_sqs_queue.queue.arn]

    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:SendMessage*"
    ]
  }

  statement {
    effect    = "Allow"
    resources = [var.kms_master_key_id]

    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]
  }
}

resource "aws_iam_policy" "consumer" {
  name   = "sqs-${var.name}-consumer"
  policy = data.aws_iam_policy_document.consumer.json
}

resource "aws_iam_policy" "pusher" {
  name   = "sqs-${var.name}-pusher"
  policy = data.aws_iam_policy_document.pusher.json
}
