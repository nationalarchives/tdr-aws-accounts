module "global_parameters" {
  source = "./tdr-configurations/terraform"
}

module "iam" {
  source            = "./tdr-terraform-modules/iam"
  aws_account_level = true
}

# if the hosted zone has already been created manually, before applying terraform, import to state file using e.g.:
# terraform import module.route_53_zone.aws_route53_zone.hosted_zone Z4KAPRWWNC7JR
# terraform import module.route_53_zone.aws_route53_record.hosted_zone_ns Z4KAPRWWNC7JR_tdr-management.nationalarchives.gov.uk_NS_tdr-management

module "route_53_zone" {
  source                = "./tdr-terraform-modules/route53"
  project               = var.project
  environment_full_name = lookup(local.environment_full_name_map, local.environment)
  common_tags           = local.common_tags
  manual_creation       = local.environment == "mgmt" || local.environment == "intg" ? true : false
}

# route53 hosted zone must already have been set up
module "ses" {
  source                = "./tdr-terraform-modules/ses"
  project               = var.project
  environment_full_name = lookup(local.environment_full_name_map, local.environment)
  hosted_zone_id        = module.route_53_zone.hosted_zone_id
  #if building a new environment, uncomment the line below and replace xxxx with new workspace name
  #dns_delegated         = local.environment == "xxxx" ? false : true
}

module "security_hub" {
  source = "./tdr-terraform-modules/securityhub"
}

module "encryption_key" {
  source      = "./tdr-terraform-modules/kms"
  project     = var.project
  environment = local.environment
  common_tags = local.common_tags
  function    = "account"
  key_policy  = "cloudtrail"
}

module "log_data_sns" {
  source         = "./tdr-terraform-modules/sns"
  apply_resource = local.environment == "mgmt" || local.environment == "intg" || local.environment == "staging" || local.environment == "prod" ? true : false
  project        = var.project
  common_tags    = local.common_tags
  function       = "logs"
  sns_policy     = "log_data"
}

module "cloudtrail_s3" {
  source           = "./tdr-terraform-modules/s3"
  project          = var.project
  function         = "cloudtrail"
  common_tags      = local.common_tags
  bucket_policy    = "cloudtrail"
  access_logs      = false
  sns_topic_arn    = module.log_data_sns.sns_arn
  sns_notification = true
}

module "cloudtrail" {
  source              = "./tdr-terraform-modules/cloudtrail"
  project             = var.project
  common_tags         = local.common_tags
  s3_bucket_name      = module.cloudtrail_s3.s3_bucket_id
  kms_key_id          = module.encryption_key.kms_key_arn
  log_stream_wildcard = ":*"
}

module "lambda_s3_copy" {
  source             = "./tdr-terraform-modules/lambda"
  project            = var.project
  common_tags        = local.common_tags
  lambda_log_data    = true
  timeout_seconds    = 30
  log_data_sns_topic = module.log_data_sns.sns_arn
  target_s3_bucket   = "${var.project}-log-data-mgmt"
  kms_key_arn        = module.encryption_key.kms_key_arn
}

module "log_data_s3" {
  source         = "./tdr-terraform-modules/s3"
  apply_resource = local.environment == "mgmt" ? true : false
  project        = var.project
  common_tags    = local.common_tags
  function       = "log-data"
  bucket_policy  = "log-data"
  access_logs    = false
  force_destroy  = false
}

module "athena_s3" {
  source         = "./tdr-terraform-modules/s3"
  apply_resource = local.environment == "mgmt" ? true : false
  project        = var.project
  common_tags    = local.common_tags
  function       = "athena"
  access_logs    = false
}

module "athena" {
  source         = "./tdr-terraform-modules/athena"
  apply_resource = local.environment == "mgmt" ? true : false
  project        = var.project
  common_tags    = local.common_tags
  function       = "security_logs"
  bucket         = module.athena_s3.s3_bucket_id
  queries        = ["tdr_cloudtrail_logs_mgmt", "create_table_tdr_cloudtrail_logs_mgmt", "tdr_flowlogs_mgmt_jenkins", "create_table_tdr_flowlogs_mgmt_jenkins", "partition_tdr_flowlogs_mgmt_jenkins"]
}
