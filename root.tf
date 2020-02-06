locals {
  environment = terraform.workspace
  assume_role = local.environment == "mgmt" || local.environment == "sbox" || local.environment == "ddri" ? "arn:aws:iam::${var.tdr_account_number}:role/IAM_Admin_Role" : "arn:aws:iam::${var.tdr_account_number}:role/TDRTerraformRole${title(local.environment)}"
  environment_full_name_map = {
    "mgmt"    = "management",
    "intg"    = "integration",
    "staging" = "staging",
    "prod"    = "production",
    "sbox"    = "sandbox",
    "prot"    = "prototype"
  }
  common_tags = map(
    "Environment", local.environment,
    "Owner", "TDR",
    "Terraform", true
  )
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket         = "tdr-terraform-state"
    key            = "aws-account.state"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "tdr-terraform-state-lock"
  }
}

provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

module "iam" {
  source = "./modules/iam"
}