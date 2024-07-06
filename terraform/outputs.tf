output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "email_price_api_endpoint" {
  value = module.api_gateway.email_price_api_endpoint
}

output "search_history_api_endpoint" {
  value = module.api_gateway.search_history_api_endpoint
}
