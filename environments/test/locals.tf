data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  aws_region_name = data.aws_region.current.name
  aws_account_id  = data.aws_caller_identity.current.account_id
  vpc_domain_name   = "default"
}