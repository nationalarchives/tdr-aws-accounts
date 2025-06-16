data "archive_file" "log_data_lambda" {
  type        = "zip"
  source_file = "./templates/lambda/functions/log_data_lambda_function.py"
  output_path = "/tmp/log-data-lambda.zip"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}
