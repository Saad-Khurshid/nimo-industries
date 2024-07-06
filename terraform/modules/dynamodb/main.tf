resource "aws_dynamodb_table" "search_history" {
  name         = "search_history"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "email"
  range_key    = "timestamp"

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }
}
