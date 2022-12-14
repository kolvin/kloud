include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git::https://github.com/kolvin/terraform-aws-organizations//?ref=v1.2.0"
}

inputs = {

  organization = {
    enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
    feature_set = "ALL"
    service_access_principals = [
      "member.org.stacksets.cloudformation.amazonaws.com"
    ]
  }

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
