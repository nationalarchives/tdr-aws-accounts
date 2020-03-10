module "iam" {
  source            = "./tdr-terraform-modules/iam"
  aws_account_level = true
}

# route53 hosted zone must already have been set up
module "ses-eu-west-1" {
  source                        = "./tdr-terraform-modules/ses"
  project                       = var.project
  environment_full_name         = lookup(local.environment_full_name_map, local.environment)
  providers = {
    aws = aws.eu-west-1
  }
}
