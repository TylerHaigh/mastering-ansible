# Provider to AWS

variable "aws_access_key" {
  description = "AWS CLI Access Key for programmatic access to AWS APIs"
}

variable "aws_secret_key" {
  description = "AWS CLI Access Key's Secret for programmatic access to AWS APIs"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "ap-southeast-2"
}
