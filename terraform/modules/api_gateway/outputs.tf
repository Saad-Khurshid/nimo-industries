output "email_price_api_endpoint" {
  value = "${aws_api_gateway_rest_api.crypto.id}.execute-api.${var.aws_region}.amazonaws.com/dev/email-crypto-price?coin=bitcoin&toEmail=saadkhurshid@rocketmail.com"
}

output "search_history_api_endpoint" {
  value = "${aws_api_gateway_rest_api.crypto.id}.execute-api.${var.aws_region}.amazonaws.com/dev/crypto-search-history?email=saadkhurshid@rocketmail.com"
}
