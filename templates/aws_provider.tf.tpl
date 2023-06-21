variable "aws_account_id" {
  type        = string
  description = "Wit account we oan"
}

variable "aws_region" {
  type        = string
  description = "Wit region we oan"
}

variable "environment" {
  type        = string
  description = "Freindly name for target account"
}

variable "default_tags" {
  type        = map(any)
  description = "wit region we oan"
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = ["${var.aws_account_id}"]

  default_tags {
    tags = var.default_tags
  }
}
