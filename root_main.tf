module "iam" {
  source            = "./tdr-terraform-modules/iam"
  aws_account_level = true
}

# if the hosted zone has already been created manuallly, before applying terraform, import to state file using e.g.:
# terraform import module.route_53_zone.aws_route53_zone.hosted_zone Z4KAPRWWNC7JR
# terraform import module.route_53_zone.aws_route53_record.hosted_zone_ns Z4KAPRWWNC7JR_tdr-management.nationalarchives.gov.uk_NS_tdr-management

module "route_53_zone" {
  source                = "./tdr-terraform-modules/route53"
  project               = var.project
  environment_full_name = lookup(local.environment_full_name_map, local.environment)
  common_tags           = local.common_tags
}

# route53 hosted zone must already have been set up
module "ses-eu-west-1" {
  source                = "./tdr-terraform-modules/ses"
  project               = var.project
  environment_full_name = lookup(local.environment_full_name_map, local.environment)
  hosted_zone_id        = module.route_53_zone.hosted_zone_id
  providers = {
    aws = aws.eu-west-1
  }
}
