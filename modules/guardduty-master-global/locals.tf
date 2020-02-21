locals {
  ip_set = replace(var.ip_set, ",", "\n")
}