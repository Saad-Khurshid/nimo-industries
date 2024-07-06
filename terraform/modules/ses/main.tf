resource "aws_ses_email_identity" "email_identity" {
  email = var.ses_email
}