module "organization" {
  source = "git::https://github.com/kloud-cnf/terraform-aws-organization//?ref=v0.1.0"
  
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
      org_unit_path              = "root/workloads"
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

module "remote-backend" {
  source = "git::https://github.com/kloud-cnf/terraform-aws-remote-backend//?ref=v0.1.1"

  state_config = {
    state_bucket_name_suffix = "terraform-state"
    lock_table_name_suffix   = "terraform-state-lock"
    state_bucket_allowed_roles = [
      "OrgAccessRole",
      "github-ci-role-provisioner",
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

module "ci-role-provisioner" {
  source = "git::https://github.com/kloud-cnf/terraform-aws-ci-role-provisioner//?ref=v1.0.5"

  oidc_providers = {
    github = { # https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services#adding-the-identity-provider-to-aws
      enabled         = true
      provider_domain = "token.actions.githubusercontent.com"
      audience        = "sts.amazonaws.com"
      thumbprints     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
      enabled_org_units = [
        "root/workloads",
        "root/labs",
      ]
      trusted_projects_refs = [
        {
          paths    = ["kolvin/github-aws-ci-roles"] # Centralised repo on github to manage AWS CI roles
          branches = ["*"]
          tags     = ["*"]
        }
      ]
    },
    gitlab = { # https://docs.gitlab.com/ee/ci/cloud_services/aws/#add-the-identity-provider
      enabled         = true
      thumbprints     = ["b3dd7606d2b5a8b4a13771dbecc9ee1cecafa38a"]
      provider_domain = "gitlab.com"
      audience        = "https://gitlab.com"
      enabled_org_units = [
        "root/workloads",
        "root/labs",
      ]
      trusted_projects_refs = [
        {
          paths    = ["kolvin/gitlab-aws-ci-roles"] # Centralised repo on gitlab to manage AWS CI roles
          branches = ["*"]
          tags     = ["*"]
        }
      ]
    }
  }
}
