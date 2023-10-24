variable "lambda_arn" {


}
variable "sqs_name" {
  default = "tf_queue"
}
variable "delay_seconds" {
  default = "0"
}

variable "max_message_size" {
  default = "1024"
}

variable "message_retention_seconds" {
  default = "86400"
}

variable "receive_wait_time_seconds" {
  default = "0"
}

variable "Environment" {
  default = "production"
}