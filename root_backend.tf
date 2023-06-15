terraform {
  backend "s3" {
    key     = "aws-account.state"
    region  = "eu-west-2"
    encrypt = true
  }
}
