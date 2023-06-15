data "archive_file" "log_data_lambda" {
  type        = "zip"
  source_file = "./tdr-terraform-modules/lambda/functions/log-data/lambda_function.py"
  output_path = "/tmp/log-data-lambda.zip"
}

data "aws_caller_identity" "current" {}
