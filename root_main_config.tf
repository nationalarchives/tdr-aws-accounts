module "config-s3" {
  source        = "./tdr-terraform-modules/s3"
  project       = var.project
  function      = "config"
  common_tags   = local.common_tags
  sns_topic_arn = module.log_data_sns.sns_arn
}

module "config-eu-west-2" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = true
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  common_tags                   = local.common_tags
}

module "config-ap-northeast-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.ap-northeast-1
  }
}

module "config-ap-northeast-2" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.ap-northeast-2
  }
}

module "config-ap-northeast-3" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.ap-northeast-3
  }
}

module "config-ap-south-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.ap-south-1
  }
}

module "config-ap-southeast-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.ap-southeast-1
  }
}

module "config-ap-southeast-2" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.ap-southeast-2
  }
}

module "config-ca-central-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.ca-central-1
  }
}

module "config-eu-central-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.eu-central-1
  }
}

module "config-eu-north-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.eu-north-1
  }
}

module "config-eu-west-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.eu-west-1
  }
}

module "config-eu-west-3" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.eu-west-3
  }
}

module "config-sa-east-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.sa-east-1
  }
}

module "config-us-east-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.us-east-1
  }
}

module "config-us-east-2" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.us-east-2
  }
}

module "config-us-west-1" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.us-west-1
  }
}

module "config-us-west-2" {
  source                        = "./tdr-terraform-modules/config"
  include_global_resource_types = false
  bucket_id                     = module.config-s3.s3_bucket_id
  project                       = var.project
  primary_config_recorder_id    = module.config-eu-west-2.config_recorder_id #used to ensure dependency
  common_tags                   = local.common_tags
  providers = {
    aws = aws.us-west-2
  }
}
