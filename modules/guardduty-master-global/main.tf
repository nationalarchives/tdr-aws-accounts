# Create IP Set for GuardDuty in S3 bucket
resource "aws_s3_bucket_object" "trusted_ip_list" {
  acl     = "private"
  content = local.ip_set
  bucket  = var.bucket_id
  key     = "trusted-ip-list"
}
