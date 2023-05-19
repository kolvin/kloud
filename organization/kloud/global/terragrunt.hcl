include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git::https://github.com/kloud-cnf/terraform-aws-organization//?ref=v0.1.0"
}

inputs = {
  organization = {
    enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
    feature_set          = "ALL"
    service_access_principals = [
      "member.org.stacksets.cloudformation.amazonaws.com"
    ]
  }

  organization_units = [
    {
      path = "root/workloads"
      child_defaults = {
        iam_user_access_to_billing = "ALLOW"
      }
    },
    {
      path = "root/workloads/SDLC"
      child_defaults = {
        iam_user_access_to_billing = "ALLOW"
      }
    },
    {
      path                   = "root/labs"
      service_control_policy = "labs"
      child_defaults = {
        iam_user_access_to_billing = "DENY"
      }
    }
  ]

  accounts = [
    {
      account_name               = "dev"
      email                      = "aws-dev@kolv.in"
      iam_user_access_to_billing = "DENY"
      org_unit_path              = "root/workloads/SDLC"
    },
    {
      account_name               = "prod"
      email                      = "aws-prod@kolv.in"
      iam_user_access_to_billing = "DENY"
      org_unit_path              = "root/workloads"
    }
  ]

  lab_accounts = [
    {
      account_name               = "playground"
      email                      = "aws-playground@kolv.in"
      iam_user_access_to_billing = "DENY"
      org_unit_path              = "root/labs"
    }
  ]
}
