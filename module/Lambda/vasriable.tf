variable "filename" {
  type    = string
  default = "lambda.zip"
}
variable "function_name" {
  type    = string
  default = "Lambda_sqs"
}

variable "runtime" {
  type    = string
  default = "nodejs18.x"
}

variable "handler" {
  type    = string
  default = "index.handler"
}

variable "sqs_arn" {
  
}

