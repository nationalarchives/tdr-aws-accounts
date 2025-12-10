removed {
  from = module.encryption_key
  lifecycle {
    destroy = false
  }
}
