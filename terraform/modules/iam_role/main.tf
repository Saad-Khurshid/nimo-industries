resource "aws_iam_role" "email_crypto_price_lambda_role" {
  name = var.email_crypto_price_lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "ses_send_email_policy" {
  name = "ses_send_email_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ses:SendEmail"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "email_crypto_price_lambda_ses_send_email" {
  role       = aws_iam_role.email_crypto_price_lambda_role.name
  policy_arn = aws_iam_policy.ses_send_email_policy.arn
}

data "aws_iam_policy_document" "email_crypto_price_dynamodb_policy_doc" {
  statement {
    actions = [
      "dynamodb:PutItem",
    ]
    resources = [
      "arn:aws:dynamodb:*:*:table/search_history",
    ]
  }
}

resource "aws_iam_policy" "email_crypto_price_dynamodb_policy" {
  name   = "email_crypto_price_dynamodb_policy"
  policy = data.aws_iam_policy_document.email_crypto_price_dynamodb_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "email_crypto_price_dynamodb_policy_attachment" {
  role       = aws_iam_role.email_crypto_price_lambda_role.name
  policy_arn = aws_iam_policy.email_crypto_price_dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "email_crypto_price_lambda_basic_execution" {
  role       = aws_iam_role.email_crypto_price_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "email_crypto_price_lambda_dynamodb_policy" {
  role       = aws_iam_role.email_crypto_price_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole"
}

resource "aws_iam_role" "search_history_lambda_role" {
  name = var.search_history_lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy_document" "search_history_dynamodb_policy_doc" {
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]
    resources = [
      "arn:aws:dynamodb:*:*:table/search_history",
    ]
  }
}

resource "aws_iam_policy" "search_history_dynamodb_policy" {
  name   = "search_history_dynamodb_policy"
  policy = data.aws_iam_policy_document.search_history_dynamodb_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "search_history_dynamodb_policy_attachment" {
  role       = aws_iam_role.search_history_lambda_role.name
  policy_arn = aws_iam_policy.search_history_dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "search_history_lambda_basic_execution" {
  role       = aws_iam_role.search_history_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
