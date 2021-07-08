output "arn" {
  value       = aws_sqs_queue.queue.arn
  description = "The ARN for the created Amazon SQS queue"
}

output "id" {
  value       = aws_sqs_queue.queue.id
  description = "The URL for the created Amazon SQS queue"
}

output "pusher_policy_arn" {
  value       = aws_iam_policy.pusher.arn
  description = "The ARN of the IAM policy used by the queue consumer / worker"
}

output "consumer_policy_arn" {
  value       = aws_iam_policy.consumer.arn
  description = "The ARN of the IAM policy used by the queue pusher"
}
