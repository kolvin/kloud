include "common" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git::https://github.com/kloud-cnf/terraform-aws-ci-role-provisioner//?ref=v1.0.0"
}

inputs = {
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
