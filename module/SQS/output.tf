output "sqs_arn" {
  value = aws_sqs_queue.tf_queue.arn
}
output "sqs_url" {
  value = aws_sqs_queue.tf_queue.url
}