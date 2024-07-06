output "email_crypto_price_lambda_role_arn" {
  value = aws_iam_role.email_crypto_price_lambda_role.arn
}

output "search_history_lambda_role_arn" {
  value = aws_iam_role.search_history_lambda_role.arn
}
