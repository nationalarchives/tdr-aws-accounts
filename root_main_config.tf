# this bucket and the config log bucket can be deleted, but will need to be emptied first
module "config_s3" {
  source      = "./da-terraform-modules/s3"
  bucket_name = local.config_bucket
  logging_bucket_policy = templatefile("./templates/s3/ssl-only.json.tpl", {
    bucket_name = "${local.config_bucket}-logs"
  })
  create_log_bucket = true
  common_tags       = local.common_tags
}
