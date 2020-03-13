data "aws_ssm_parameter" "cost_centre" {
  name = "/mgmt/cost_centre"
}

data "aws_ssm_parameter" "trusted_ips" {
  name = "/mgmt/trusted_ips"
}