resource "aws_api_gateway_rest_api" "crypto" {
  name        = "crypto_api"
  description = "Crypto API Gateway"
}

resource "aws_api_gateway_resource" "email_crypto_price_resource" {
  rest_api_id = aws_api_gateway_rest_api.crypto.id
  parent_id   = aws_api_gateway_rest_api.crypto.root_resource_id
  path_part   = "email-crypto-price"
}

resource "aws_api_gateway_method" "email_crypto_price_method" {
  rest_api_id   = aws_api_gateway_rest_api.crypto.id
  resource_id   = aws_api_gateway_resource.email_crypto_price_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_resource" "crypto_search_history_resource" {
  rest_api_id = aws_api_gateway_rest_api.crypto.id
  parent_id   = aws_api_gateway_rest_api.crypto.root_resource_id
  path_part   = "crypto-search-history"
}

resource "aws_api_gateway_method" "crypto_search_history_method" {
  rest_api_id   = aws_api_gateway_rest_api.crypto.id
  resource_id   = aws_api_gateway_resource.crypto_search_history_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "email_crypto_price_integration" {
  rest_api_id             = aws_api_gateway_rest_api.crypto.id
  resource_id             = aws_api_gateway_resource.email_crypto_price_resource.id
  http_method             = aws_api_gateway_method.email_crypto_price_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_functions_arn[0]}/invocations"
}

resource "aws_api_gateway_integration" "get_search_history_integration" {
  rest_api_id             = aws_api_gateway_rest_api.crypto.id
  resource_id             = aws_api_gateway_resource.crypto_search_history_resource.id
  http_method             = aws_api_gateway_method.crypto_search_history_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_functions_arn[1]}/invocations"
}

resource "aws_api_gateway_deployment" "crypto_deployment" {
  depends_on = [
    aws_api_gateway_integration.email_crypto_price_integration,
    aws_api_gateway_integration.get_search_history_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.crypto.id
  stage_name  = "dev" # Replace with your desired stage name
}

resource "aws_lambda_permission" "api_gateway_permission_email_crypto_price" {
  statement_id  = "AllowExecutionFromAPIGatewayEmailCryptoPrice"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions_name[0]
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.crypto.id}/*/*/*"
}

resource "aws_lambda_permission" "api_gateway_permission_get_search_history" {
  statement_id  = "AllowExecutionFromAPIGatewayGetSearchHistory"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions_name[1]
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.crypto.id}/*/*/*"
}



