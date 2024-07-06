variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "lambda_functions_arn" {
  description = "List of Lambda function ARNs"
  type        = list(string)
}

variable "lambda_functions_name" {
  description = "List of Lambda function names"
  type        = list(string)
}
