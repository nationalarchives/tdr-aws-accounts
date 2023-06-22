locals {
  environment = lower(terraform.workspace)
  assume_role = module.terraform_config.terraform_config[local.environment]["terraform_account_role"]
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
