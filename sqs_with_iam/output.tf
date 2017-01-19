output "arn" {
  value = "${aws_sqs_queue.queue.arn}"
}
output "policy" {
  value = "${aws_iam_policy.policy.arn}"
}
