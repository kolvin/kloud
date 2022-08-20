include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/kolvin/terraform-aws-organizations//?ref=v1.1.3"
}

inputs = {
  accounts = [
    {
      account_name               = "playground"
      email                      = "aws-playground@kolv.in"
      iam_user_access_to_billing = "DENY"
      org_unit                   = ""
    }
  ]
}