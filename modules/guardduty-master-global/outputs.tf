output "ipset_s3_object_key" {
  value = aws_s3_bucket_object.trusted_ip_list.key
}