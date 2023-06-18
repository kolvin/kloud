include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecs//?ref=v5.2.0"
}

inputs = {
  cluster_name = "dev"

  # Capacity provider
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
        base   = 20
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  tags = {}
}
