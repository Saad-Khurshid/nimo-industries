output "lambda_functions_name" {
  value = [
    aws_lambda_function.email_crypto_price.function_name,
    aws_lambda_function.get_search_history.function_name
  ]
}

output "lambda_functions_arn" {
  value = [
    aws_lambda_function.email_crypto_price.arn,
    aws_lambda_function.get_search_history.arn
  ]
}