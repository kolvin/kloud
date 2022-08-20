variable "aws_region" {
  type        = string
  description = "wit region we talking too"
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = ["${local.aws_account_id}"]
  default_tags {
    tags = {
      Greeting = "Why hello there"
    }
  }
}
