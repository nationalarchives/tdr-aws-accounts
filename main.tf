module "iam" {
  source = "./modules/iam"
}

module "guardduty-s3" {
  source      = "../tdr-terraform-modules/s3"
  project     = "tdr"
  function    = "guardduty"
  common_tags = local.common_tags
}

module "guardduty-s3-content" {
  source    = "./modules/guardduty-master-global"
  bucket_id = module.guardduty-s3.s3_bucket_id
  ip_set    = data.aws_ssm_parameter.external_ips.value
}

module "guardduty-master-eu-west-2" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
}

module "guardduty-master-ap-northeast-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.ap-northeast-1
  }
}

module "guardduty-master-ap-northeast-2" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.ap-northeast-2
  }
}

module "guardduty-master-ap-south-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.ap-south-1
  }
}

module "guardduty-master-ap-southeast-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.ap-southeast-1
  }
}

module "guardduty-master-ap-southeast-2" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.ap-southeast-2
  }
}

module "guardduty-master-ca-central-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.ca-central-1
  }
}

module "guardduty-master-eu-central-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.eu-central-1
  }
}

module "guardduty-master-eu-north-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.eu-north-1
  }
}

module "guardduty-master-eu-west-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.eu-west-1
  }
}

module "guardduty-master-eu-west-3" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.eu-west-3
  }
}

module "guardduty-master-sa-east-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.sa-east-1
  }
}

module "guardduty-master-us-east-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.us-east-1
  }
}

module "guardduty-master-us-east-2" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.us-east-2
  }
}

module "guardduty-master-us-west-1" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.us-west-1
  }
}

module "guardduty-master-us-west-2" {
  source              = "./modules/guardduty-master-regional"
  bucket_id           = module.guardduty-s3.s3_bucket_id
  ipset_s3_object_key = module.guardduty-s3-content.ipset_s3_object_key
  providers = {
    aws = aws.us-west-2
  }
}