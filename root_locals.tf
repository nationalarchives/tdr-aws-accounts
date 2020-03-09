locals {
  environment = lower(terraform.workspace)
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
    "Terraform", true,
    "CostCentre", data.aws_ssm_parameter.cost_centre.value,
  )
  region = "eu-west-2"
  ip_set = data.aws_ssm_parameter.external_ips.value
}
