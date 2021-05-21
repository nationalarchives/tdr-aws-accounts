locals {
  environment = lower(terraform.workspace)
  assume_role = local.environment == "mgmt" || local.environment == "sbox" ? "arn:aws:iam::${var.tdr_account_number}:role/IAM_Admin_Role" : "arn:aws:iam::${var.tdr_account_number}:role/TDRTerraformRole${title(local.environment)}"
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
    "CostCentre", module.global_parameters.cost_centre,
  )
  region = "eu-west-2"
  ip_set = module.global_parameters.trusted_ips
}
