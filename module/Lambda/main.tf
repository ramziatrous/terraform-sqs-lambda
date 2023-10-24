locals {
  account_number = (Account Number)
  }
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role1"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Effect : "Allow",
        Principal : {
          Service : "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "sqs_policy" {
  name = "sqs_policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sqs:ListQueues",
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "sqs:*",
            "Resource": var.sqs_arn
        }
    ]
})
}

resource "aws_iam_policy" "cloudwatch_policy" {
  name = "cloudwatch_policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:eu-central-1:${local.account_number}:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:eu-central-1:${local.account_number}:log-group:/aws/lambda/Lambda_sqs:*"
            ]
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.sqs_policy.arn
  role       = aws_iam_role.lambda_role.name
}
resource "aws_iam_role_policy_attachment" "lambda_cw_attachment" {
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_function" "lambda" {
  filename      = var.filename
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = aws_iam_role.lambda_role.arn

}


resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn  = var.sqs_arn
  function_name     = aws_lambda_function.lambda.arn
}

