# Enable GuardDuty
resource "aws_guardduty_detector" "master" {
  enable = true
}

resource "aws_guardduty_ipset" "trusted_ip_list" {
  activate    = true
  detector_id = aws_guardduty_detector.master.id
  format      = "TXT"
  location    = "https://s3.amazonaws.com/${var.bucket_id}/${var.ipset_s3_object_key}"
  name        = "trusted-ip-list-${data.aws_region.current.name}"
}