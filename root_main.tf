module "global_parameters" {
  source = "./tdr-configurations/terraform"
}

module "terraform_config" {
  source  = "./da-terraform-configurations/"
  project = var.project
}

module "iam" {
  source            = "./iam_group"
  aws_account_level = true
  environment       = local.environment
}

# if the hosted zone has already been created manually, before applying terraform, import to state file using e.g.:
# terraform import module.route_53_zone.aws_route53_zone.hosted_zone Z4KAPRWWNC7JR
# terraform import module.route_53_zone.aws_route53_record.hosted_zone_ns Z4KAPRWWNC7JR_tdr-management.nationalarchives.gov.uk_NS_tdr-management

module "route_53_zone" {
  count                 = local.create_hosted_zone ? 1 : 0
  source                = "./tdr-terraform-modules/route53"
  project               = var.project
  environment_full_name = lookup(local.environment_full_name_map, local.environment)
  common_tags           = local.common_tags
  manual_creation       = local.environment == "mgmt" || local.environment == "intg" ? true : false
  create_hosted_zone    = true
}

# route53 hosted zone must already have been set up
module "ses" {
  count                 = local.create_domain_email ? 1 : 0
  source                = "./tdr-terraform-modules/ses"
  project               = var.project
  environment_full_name = lookup(local.environment_full_name_map, local.environment)
  hosted_zone_id        = module.route_53_zone[count.index].hosted_zone_id
  email_address         = split("@", module.terraform_config.terraform_config["notification_email"])[0]
  #if building a new environment, uncomment the line below and replace xxxx with new workspace name
  #dns_delegated         = local.environment == "xxxx" ? false : true
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
  source = "./da-terraform-modules/sns"
  lambda_subscriptions = {
    s3_copy = module.lambda_s3_copy.lambda_arn
  }
  sns_policy = templatefile("./templates/sns/log-data.json.tpl", {
    sns_topic_name = "${var.project}-logs-${local.environment}",
    account_id     = data.aws_caller_identity.current.account_id
  })
  tags       = local.common_tags
  topic_name = "${var.project}-logs-${local.environment}"
}

module "cloudtrail_s3" {
  source      = "./da-terraform-modules/s3"
  bucket_name = local.cloudtrail_bucket
  bucket_policy = templatefile("./templates/s3/cloudtrail.json.tpl", {
    bucket_name   = local.cloudtrail_bucket
    aws_partition = data.aws_partition.current.id
    aws_region    = data.aws_region.current.name
    account_id    = data.aws_caller_identity.current.id
  })
  create_log_bucket = false
  common_tags       = local.common_tags
  sns_topic_config = {
    "s3:ObjectCreated:*" = module.log_data_sns.sns_arn
  }
}

module "cloudtrail" {
  source              = "./tdr-terraform-modules/cloudtrail"
  project             = var.project
  common_tags         = local.common_tags
  s3_bucket_name      = local.cloudtrail_bucket
  kms_key_id          = module.encryption_key.kms_key_arn
  log_stream_wildcard = ":*"
}

module "lambda_s3_copy" {
  source = "./da-terraform-modules/lambda"
  plaintext_env_vars = {
    TARGET_S3_BUCKET = "${var.project}-log-data-mgmt"
  }
  function_name = "${var.project}-log-data-${local.environment}"
  handler       = "lambda_function.lambda_handler"
  policies = {
    log_data = templatefile("./templates/lambda/log-data.json.tpl", {
      bucket_name = "${var.project}-log-data-${local.environment}"
    })
  }
  runtime = "python3.10"
  tags    = local.common_tags
  lambda_invoke_permissions = {
    "sns.amazonaws.com" = module.log_data_sns.sns_arn
  }
  filename        = data.archive_file.log_data_lambda.output_path
  timeout_seconds = 30
}

module "log_data_s3" {
  count       = local.environment == "mgmt" ? 1 : 0
  source      = "./da-terraform-modules/s3"
  bucket_name = "${var.project}-log-data-${local.environment}"
  bucket_policy = templatefile("./templates/s3/log-data-policy.json.tpl", {
    bucket_name        = "${var.project}-log-data-${local.environment}"
    external_account_1 = module.terraform_config.account_numbers["intg"],
    external_account_2 = module.terraform_config.account_numbers["staging"],
    external_account_3 = module.terraform_config.account_numbers["prod"]
    role_name_intg     = "${var.project}-log-data-intg-role"
    role_name_staging  = "${var.project}-log-data-staging-role"
    role_name_prod     = "${var.project}-log-data-prod-role"
  })
  create_log_bucket = false
  common_tags       = local.common_tags
}

module "athena_s3" {
  source = "./da-terraform-modules/s3"
  count  = local.environment == "mgmt" || var.project == "dr2" ? 1 : 0

  bucket_name       = local.athena_bucket
  create_log_bucket = false
  common_tags       = local.common_tags
}

module "athena" {
  source         = "./tdr-terraform-modules/athena"
  apply_resource = local.environment == "mgmt" ? true : false
  project        = var.project
  common_tags    = local.common_tags
  function       = "security_logs"
  bucket         = local.athena_bucket
  queries = [
    "tdr_cloudtrail_logs_mgmt", "create_table_tdr_cloudtrail_logs_mgmt", "tdr_flowlogs_mgmt_jenkins",
    "create_table_tdr_flowlogs_mgmt_jenkins", "partition_tdr_flowlogs_mgmt_jenkins"
  ]
  environment = local.environment
}
