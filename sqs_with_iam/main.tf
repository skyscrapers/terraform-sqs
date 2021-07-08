locals {
  redrive_policy = jsonencode({
    deadLetterTargetArn = var.dead_letter_queue
    maxReceiveCount     = var.max_receive_count
  })
}

resource "aws_sqs_queue" "queue" {
  name = "${var.name}${var.fifo_queue ? ".fifo" : ""}"
  tags = var.tags

  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds

  redrive_policy = var.dead_letter_queue != null ? local.redrive_policy : null

  fifo_queue                  = var.fifo_queue
  fifo_throughput_limit       = var.fifo_throughput_limit
  content_based_deduplication = var.content_based_deduplication
  deduplication_scope         = var.deduplication_scope

  kms_master_key_id                 = var.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
}
