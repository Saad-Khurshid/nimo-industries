terraform {
  backend "s3" {
    region         = "us-east-2"
    bucket         = "nimo-terraform-state-bucket"
    key            = "lock/terraform.tfstate"
    dynamodb_table = "nimo-terraform-lock-table"
  }
}
