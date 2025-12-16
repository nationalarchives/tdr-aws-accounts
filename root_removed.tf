removed {
  from = module.encryption_key
  lifecycle {
    destroy = false
  }
}


removed {
  from = module.iam_group
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.config_s3.aws_s3_bucket_lifecycle_configuration.delete_incomplete_multipart_uploads
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.ses
  lifecycle {
    destroy = true
  }
}


removed {
  from = module.route_53_zone
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.iam
  lifecycle {
    destroy = false
  }
}


