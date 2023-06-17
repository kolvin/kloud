include "root" {
  path = find_in_parent_folders("common.hcl")
}

include "component" {
  path = find_in_parent_folders("component.hcl")
}

inputs = {
  create_vpc                       = false
  manage_default_vpc               = true
  default_vpc_name                 = "default"
  default_vpc_enable_dns_hostnames = true
}
