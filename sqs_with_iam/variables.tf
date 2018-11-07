variable "environment" {
  description = "How do you want to call your environment, this is helpful if you have more than 1 VPC"
}

variable "project" {
  description = "The project of this queue(s)"
}

variable "name" {
  description = "List of the SQS queue names. If you provide multiple names, each queue will be setup with the same configuration"
  type        = "list"
}

variable "visibility_timeout_seconds" {
  description = "The timeout in seconds of visibility of the message"
  default     = 30
}

variable "delay_seconds" {
  description = "Delay in displaying message"
  default     = "0"
}

variable "max_message_size" {
  description = "Max size of the message default to 256KB"
  default     = "262144"
}

variable "message_retention_seconds" {
  description = "Seconds of retention of the message default to 4 days"
  default     = "345600"
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately."
  default     = "20"
}

variable "dead_letter_queue" {
  description = "The dead letter queue to use for undeliverable messages"
  default     = ""
}

variable "max_receive_count" {
  description = "Maximum receive count"
  default     = "5"
}

variable "fifo_queue" {
  description = "Configure the queue(s) to be FIFO queue(s). This will append the required extension `.fifo` to the queue name(s)."
  default     = "false"
}
