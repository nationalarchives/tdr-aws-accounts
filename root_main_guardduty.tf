module "guardduty_s3" {
  source      = "git::https://github.com/nationalarchives/da-terraform-modules//s3"
  bucket_name = local.guard_duty_bucket
  bucket_policy = templatefile("./templates/s3/ssl-only.json.tpl", {
    bucket_name = local.guard_duty_bucket
  })
  create_log_bucket = false
  common_tags       = local.common_tags
  sns_topic_config = {
    "s3:ObjectCreated:*" = module.log_data_sns.sns_arn
  }
}

module "guardduty-master-eu-west-2" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
}

module "guardduty-master-ap-northeast-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.ap-northeast-1
  }
}

module "guardduty-master-ap-northeast-2" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.ap-northeast-2
  }
}

module "guardduty-master-ap-northeast-3" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.ap-northeast-3
  }
}

module "guardduty-master-ap-south-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.ap-south-1
  }
}

module "guardduty-master-ap-southeast-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.ap-southeast-1
  }
}

module "guardduty-master-ap-southeast-2" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.ap-southeast-2
  }
}

module "guardduty-master-ca-central-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.ca-central-1
  }
}

module "guardduty-master-eu-central-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.eu-central-1
  }
}

module "guardduty-master-eu-north-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.eu-north-1
  }
}

module "guardduty-master-eu-west-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.eu-west-1
  }
}

module "guardduty-master-eu-west-3" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.eu-west-3
  }
}

module "guardduty-master-sa-east-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.sa-east-1
  }
}

module "guardduty-master-us-east-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.us-east-1
  }
}

module "guardduty-master-us-east-2" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.us-east-2
  }
}

module "guardduty-master-us-west-1" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.us-west-1
  }
}

module "guardduty-master-us-west-2" {
  source    = "./tdr-terraform-modules/guardduty"
  bucket_id = local.guard_duty_bucket
  ip_set    = local.ip_set
  providers = {
    aws = aws.us-west-2
  }
}
