module "vpc" {
  source = "../../modules/vpc"

  cidr_block = var.vpc_cidr_block

  availability_zones = [
    "${local.aws_region_name}a",
    "${local.aws_region_name}b",
    "${local.aws_region_name}c"
  ]
  dhcp_domain_name = local.vpc_domain_name

  aws_region_name = local.aws_region_name
  aws_account_id  = local.aws_account_id

  project_name     = var.project_name
  environment_name = var.environment
}