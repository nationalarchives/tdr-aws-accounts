removed {
  from = module.security_hub.aws_securityhub_account.security_hub

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.security_hub.ws_securityhub_standards_subscription.security_ruleset

  lifecycle {
    destroy = true
  }
}
