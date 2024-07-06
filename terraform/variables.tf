variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "ses_email" {
  description = "SES verified email"
  type        = string
  default     = "saadkhurshid06@gmail.com"
}
