include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git::https://github.com/kloud-cnf/terraform-aws-remote-backend//?ref=v0.1.0"
}

inputs = {
  state_config = {
    state_bucket_name_suffix = "terraform-state"
    lock_table_name_suffix   = "terraform-state-lock"
    state_bucket_allowed_roles = [
      "OrgAccessRole",
      "ci-role-provisioner",
      "github-ci-infrastructure-provisoner"
    ]
    state_bucket_allowed_users = [
      "root"
    ]
    enabled_org_units = [
      "root/workloads",
      "root/labs",
    ]
  }
}
