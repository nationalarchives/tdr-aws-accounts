data "aws_ssm_parameter" "cost_centre" {
  name = "/mgmt/cost_centre"
}

data "aws_ssm_parameter" "external_ips" {
  name = "/${local.environment}/external_ips"
}