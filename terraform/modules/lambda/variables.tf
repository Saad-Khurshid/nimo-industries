variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "ses_email" {
  description = "SES verified email"
  type        = string
}

variable "email_crypto_price_lambda_role_arn" {
  description = "ARN of the IAM role for lambda execution"
  type        = string
}

variable "search_history_lambda_role_arn" {
  description = "ARN of the IAM role for lambda execution"
  type        = string
}
