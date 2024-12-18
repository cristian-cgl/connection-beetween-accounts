provider "aws" {
  region = "us-east-1"
}

# Tabla de Dynamo
resource "aws_dynamodb_table" "app_settings" {
  name         = "table-app-settings"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "my_item" {
  table_name = aws_dynamodb_table.app_settings.name
  hash_key   = "id"
  item = jsonencode({
    "id" : { "S" : "app-version" },
    "version" : { "S" : "20.12.24" }
  })
}

# Rol para poder tener vinculación
# 1. Creación de rol con politica de confianza
resource "aws_iam_role" "account_a_lambda_get_app_version" {
  name = "role-account-a-lambda-get-app-version"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${var.account_a_id}:role/role-lambda-get-app-version"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# # Políticas de permisos para el rol IAM
resource "aws_iam_role_policy" "account_a_lambda_get_app_version_policy" {
  name = "role-account-a-lambda-get-app-version-policy"
  role = aws_iam_role.account_a_lambda_get_app_version.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:dynamodb:us-east-1:${var.account_b_id}:table/table-app-settings"
      }
    ]
  })
}
