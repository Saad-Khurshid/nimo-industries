resource "aws_lambda_function" "email_crypto_price" {
  function_name    = "email_crypto_price_function"
  role             = var.email_crypto_price_lambda_role_arn
  handler          = "index.handler"
  runtime          = "nodejs16.x"
  filename         = "${path.module}/../../../lambda/email_crypto_price/uploadFunction.zip"
  source_code_hash = filebase64sha256("${path.module}/../../../lambda/email_crypto_price/uploadFunction.zip")
  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
      SES_EMAIL  = var.ses_email
    }
  }
}

resource "aws_lambda_function" "get_search_history" {
  function_name    = "get_search_history_function"
  role             = var.search_history_lambda_role_arn
  handler          = "index.handler"
  runtime          = "nodejs16.x"
  filename         = "${path.module}/../../../lambda/get_search_history/uploadFunction.zip"
  source_code_hash = filebase64sha256("${path.module}/../../../lambda/get_search_history/uploadFunction.zip")
  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}
