module "lambda" {
  source = "./module/Lambda"
  sqs_arn = module.sqs.sqs_arn
}
module "sqs" {
  source     = "./module/SQS"
  lambda_arn = module.lambda.lambda_arn
}