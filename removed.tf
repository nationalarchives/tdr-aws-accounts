removed {
  from = module.athena_s3.aws_s3_bucket.bucket

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.athena_s3.aws_s3_bucket_policy.bucket_policy

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.athena_s3.aws_s3_bucket_public_access_block.bucket_public_access

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.athena_s3.aws_s3_bucket_server_side_encryption_configuration.encryption_configuration

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.athena_s3.aws_s3_bucket_versioning.versioning

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-ap-northeast-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-ap-northeast-2.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-ap-northeast-3.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-ap-northeast-3.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-ap-south-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-ap-southeast-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-ap-southeast-2.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-ca-central-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-eu-central-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-eu-north-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-eu-west-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-eu-west-2.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-eu-west-3.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-us-west-2.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-us-west-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-us-east-2.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-us-east-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.guardduty-master-sa-east-1.aws_guardduty_detector.master

  lifecycle {
    destroy = false
  }
}