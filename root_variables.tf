variable "project" {
  description = "abbreviation for the project, e.g. tdr, forms the first part of resource names"
}

variable "account_number" {
  description = "The AWS account number where the TDR environment is hosted"
  type        = string
}

variable "create_domain_email" {
  default = false
}

variable "create_hosted_zone" {
  default = false
}
