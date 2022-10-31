include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git::https://github.com/kolvin/terraform-aws-organizations//?ref=v1.1.8"
}

inputs = {
  accounts = [
    {
      account_name               = "playground"
      email                      = "aws-playground@kolv.in"
      iam_user_access_to_billing = "DENY"
      org_unit                   = "Lab"
    },
    {
      account_name               = "dev"
      email                      = "aws-dev@kolv.in"
      iam_user_access_to_billing = "DENY"
      org_unit                   = "workloads"
    },
    {
      account_name               = "prod"
      email                      = "aws-prod@kolv.in"
      iam_user_access_to_billing = "DENY"
      org_unit                   = "workloads"
    }
  ]
}