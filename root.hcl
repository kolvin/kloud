locals {
  # Read account configs
  account_config = read_terragrunt_config(find_in_parent_folders("account.terragrunt.hcl"))

  # Read project config file
  config = jsondecode(file("${get_parent_terragrunt_dir()}/config.json"))

  # Extract values from folder namespacing
  # <account_alias>/<component>/<region>
  path          = path_relative_to_include()
  path_split    = split("/", local.path)
  account_alias = local.path_split[0]
  component     = local.path_split[1]
  aws_region    = local.path_split[2]

  backend_filename = local.config.terragrunt.backend_filename

  tags = merge(
    local.account_config.locals.common_resource_tags,
    {
      Location = "${local.config.base.git_url}/${path_relative_to_include()}"
    }
  )
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
      user_data_dir         = "${get_parent_terragrunt_dir()}/user_data"
      template_dir          = "${get_parent_terragrunt_dir()}/templates"
      backend_filename      = "${local.backend_filename}"
      aws_account_id        = "${local.account_config.locals.aws_account_id}"
      aws_region            = "${local.aws_region}"
    }
  EOF
}

# Configure root level variables that all resources can inherit.
inputs = merge(
  {
    aws_region = local.aws_region == "global" ? "${local.config.aws.default_region}" : local.aws_region
  }
)

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "terragrunt-state-${local.account_config.locals.aws_account_id}"
    key            = "${join("/", compact([local.component, local.aws_region]))}/terraform.tfstate"
    region         = "eu-west-1" # one state bucket per account, multi region support in file path
    dynamodb_table = "terragrunt-locks-${local.account_config.locals.aws_account_id}"
  }

  generate = {
    path      = local.backend_filename
    if_exists = "overwrite_terragrunt"
  }
}