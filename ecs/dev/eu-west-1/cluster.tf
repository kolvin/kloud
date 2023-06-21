resource "aws_iam_service_linked_role" "ecs" {
  aws_service_name = "ecs.amazonaws.com"
}

module "ecs" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecs//?ref=v5.2.0"
  
  cluster_name = "${local.aws_region}-${local.environment}"

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

  depends_on = [
    aws_iam_service_linked_role.ecs
  ]
}
