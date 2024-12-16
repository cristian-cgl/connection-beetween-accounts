provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "role_lambda_get_app_version" {
  name = "role-lambda-get-app-version"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "role_lambda_get_app_version_policy" {
  name = "role-lambda-get-app-version-policy"
  role = aws_iam_role.role_lambda_get_app_version.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "logs:*"
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
      # {
      #   Effect : "Allow",
      #   Action : [
      #     "sts:AssumeRole"
      #   ],
      #   Resource : "arn:aws:iam::${var.account_b_id}:role/role-account-a-lambda-get-app-version"
      # }
    ]
  })
}

# Crear la función Lambda
resource "aws_lambda_function" "example_lambda" {
  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("./lambda.zip")
  function_name    = "get-app-version"
  role             = aws_iam_role.role_lambda_get_app_version.arn
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  environment {}
}