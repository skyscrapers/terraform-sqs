resource "aws_sqs_queue" "queue" {
  name                       = "${var.environment}_${var.project}_${var.name}"
  visibility_timeout_seconds = "${var.visibility_timeout_seconds}"
  delay_seconds              = "${var.delay_seconds}"
  max_message_size           = "${var.max_message_size}"                                                        # 256 KB
  message_retention_seconds  = "${var.message_retention_seconds}"                                                        # 4 days
  receive_wait_time_seconds  = "${var.receive_wait_time_seconds}"
}
