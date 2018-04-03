data "template_file" "redrive_policy" {
  template = <<EOF
{
  "deadLetterTargetArn":"$${dlq}",
  "maxReceiveCount":$${mrc}
}
EOF

  vars {
    dlq = "${var.dead_letter_queue}"
    mrc = "${var.max_receive_count}"
  }
}

resource "aws_sqs_queue" "queue" {
  count                      = "${length(var.name)}"
  name                       = "${var.environment}_${var.project}_${var.name[count.index]}${var.fifo_queue == "true" ? ".fifo" : ""}"
  visibility_timeout_seconds = "${var.visibility_timeout_seconds}"
  delay_seconds              = "${var.delay_seconds}"
  max_message_size           = "${var.max_message_size}"                                                                              # 256 KB
  message_retention_seconds  = "${var.message_retention_seconds}"                                                                     # 4 days
  receive_wait_time_seconds  = "${var.receive_wait_time_seconds}"
  redrive_policy             = "${length(var.dead_letter_queue) > 0 ? data.template_file.redrive_policy.rendered : ""}"
  fifo_queue                 = "${var.fifo_queue}"
}
