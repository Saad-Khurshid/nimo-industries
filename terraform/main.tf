data "aws_caller_identity" "current" {}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "iam_role" {
  source                              = "./modules/iam_role"
  email_crypto_price_lambda_role_name = "price_lambda_execution_role"
  search_history_lambda_role_name     = "search_lambda_execution_role"
}

module "ses_email_identity" {
  source    = "./modules/ses"
  ses_email = var.ses_email
}

module "lambda" {
  source                             = "./modules/lambda"
  dynamodb_table_name                = module.dynamodb.table_name
  ses_email                          = var.ses_email
  email_crypto_price_lambda_role_arn = module.iam_role.email_crypto_price_lambda_role_arn
  search_history_lambda_role_arn     = module.iam_role.search_history_lambda_role_arn
}

module "api_gateway" {
  source                = "./modules/api_gateway"
  aws_account_id        = data.aws_caller_identity.current.account_id
  aws_region            = var.aws_region
  lambda_functions_arn  = module.lambda.lambda_functions_arn
  lambda_functions_name = module.lambda.lambda_functions_name
}
