moved {
  from = module.athena_s3.aws_s3_bucket.bucket
  to   = module.athena_s3[0].aws_s3_bucket.bucket
}

moved {
  from = module.athena_s3.aws_s3_bucket_policy.bucket_policy
  to   = module.athena_s3[0].aws_s3_bucket_policy.bucket_policy
}

moved {
  from = module.athena_s3.aws_s3_bucket_public_access_block.bucket_public_access
  to   = module.athena_s3[0].aws_s3_bucket_public_access_block.bucket_public_access
}

moved {
  from = module.athena_s3.aws_s3_bucket_server_side_encryption_configuration.encryption_configuration
  to   = module.athena_s3[0].aws_s3_bucket_server_side_encryption_configuration.encryption_configuration
}

moved {
  from = module.athena_s3.aws_s3_bucket_versioning.versioning
  to   = module.athena_s3[0].aws_s3_bucket_versioning.versioning
}
