locals {
  # Read project config file
  config = jsondecode(file("${get_parent_terragrunt_dir()}/config.json"))

  # Extract values from folder namespacing
  # <component>/<account>/<region>
  path           = path_relative_to_include()
  path_split     = split("/", local.path)
  component      = local.path_split[0]
  account        = local.path_split[1]
  aws_region     = local.path_split[2]
  aws_account_id = local.config.aws.accounts[local.account]

  backend_filename = local.config.terragrunt.backend_filename

  default_tags = {
    environment = local.account
    Location    = "${local.config.base.git_url}/${path_relative_to_include()}"
  }
}

# DRY terragrunt actions
# https://terragrunt.gruntwork.io/docs/features/keep-your-cli-flags-dry/
terraform {
  extra_arguments "plan" {
    commands  = ["plan"]
    arguments = ["-out=${get_terragrunt_dir()}/tgplan.out"]
  }

  extra_arguments "apply" {
    commands  = ["apply"]
    arguments = ["${get_terragrunt_dir()}/tgplan.out"]
  }
}

# Generate an AWS provider block
# https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#example
generate "aws_provider" {
  path      = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("${get_parent_terragrunt_dir()}/templates/aws_provider.tf.tpl")
}

generate "terragrunt_local_vars" {
  path      = "_locals.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    locals {
      terragrunt_dir        = "${get_terragrunt_dir()}"
      parent_terragrunt_dir = "${get_parent_terragrunt_dir()}"
      template_dir          = "${get_parent_terragrunt_dir()}/templates"
      backend_filename      = "${local.backend_filename}"
      aws_region            = "${local.aws_region}"
      environment           = "${local.account}"
    }
  EOF
}

# Configure root level variables that all resources can inherit.
inputs = merge(
  {
    aws_region     = local.aws_region == "global" ? "${local.config.aws.home_region}" : local.aws_region
    aws_account_id = local.aws_account_id
    environment    = local.account
    default_tags   = local.default_tags
  }
)

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"

  config = {
    encrypt               = true
    bucket                = "terraform-state-${local.aws_account_id}"
    key                   = "${join("/", compact([local.component, local.aws_region]))}/terraform.tfstate"
    region                = "eu-west-1" # one state bucket per account, multi region support via file path
    dynamodb_table        = "terraform-locks-${local.aws_account_id}"
    disable_bucket_update = true
  }

  generate = {
    path      = local.backend_filename
    if_exists = "overwrite_terragrunt"
  }
}
