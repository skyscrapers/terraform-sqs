output "arn" {
  value = "${aws_sqs_queue.queue.arn}"
}

output "pusher_policy" {
  value = "${aws_iam_policy.pusher_policy.arn}"
}

output "consumer_policy" {
  value = "${aws_iam_policy.consumer_policy.arn}"
}
