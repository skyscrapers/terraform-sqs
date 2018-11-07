output "arn" {
  value       = ["${aws_sqs_queue.queue.*.arn}"]
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "id" {
  value       = ["${aws_sqs_queue.queue.*.id}"]
  description = "The URL for the created Amazon SQS queue."
}

output "pusher_policy" {
  value       = ["${aws_iam_policy.pusher_policy.*.arn}"]
  description = "A list of the arns of the IAM policies used by the queue consumer / worker."
}

output "consumer_policy" {
  value       = ["${aws_iam_policy.consumer_policy.*.arn}"]
  description = "A list of the arns of the IAM policies used by the queue pusher."
}

output "queue_count" {
  value       = "${length(var.name)}"
  description = "The number of queues to be created. To be used downstream"
}
