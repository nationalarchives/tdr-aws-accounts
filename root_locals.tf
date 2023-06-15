locals {
  environment = lower(terraform.workspace)
  assume_role = var.project == "dr2" ? "arn:aws:iam::${var.account_number}:role/${title(local.environment)}TerraformRole" : local.environment == "mgmt" || local.environment == "sbox" || local.environment == "ddri" ? "arn:aws:iam::${var.account_number}:role/IAM_Admin_Role" : "arn:aws:iam::${var.account_number}:role/TDRTerraformRole${title(local.environment)}"
  environment_full_name_map = {
    "mgmt"    = "management",
    "intg"    = "integration",
    "staging" = "staging",
    "prod"    = "production",
    "sbox"    = "sandbox",
    "prot"    = "prototype"
  }
  common_tags = tomap(
    {
      "Environment"     = local.environment,
      "Owner"           = "TDR",
      "Terraform"       = true,
      "CostCentre"      = module.global_parameters.cost_centre,
      "TerraformSource" = "https://github.com/nationalarchives/tdr-aws-accounts.git"
    }
  )
  region            = "eu-west-2"
  ip_set            = module.global_parameters.trusted_ips
  cloudtrail_bucket = "${var.project}-cloudtrail-${local.environment}"
  athena_bucket     = "${var.project}-athena-${local.environment}"
  config_bucket     = "${var.project}-config-${local.environment}"
  guard_duty_bucket = "${var.project}-guardduty-${local.environment}"
}
