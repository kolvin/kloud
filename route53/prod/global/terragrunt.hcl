include "common" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git::https://github.com/kolvin/terraform-aws-route53//?ref=v1.0.0"
}

inputs = {
  route53_zones = [
    {
      name          = "kolv.in"
      type          = "public"
      force_destroy = false
      vpc_id        = ""
      tags          = {}
      dns_records   = []
    }
  ]
}
