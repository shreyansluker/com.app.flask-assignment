resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr_block
  enable_dns_hostnames             = true
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name      = "${var.project_name}-${var.environment_name}"
    Env       = var.environment_name
    Terraform = "true"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name      = "${var.project_name}-${var.environment_name}-igw"
    Env       = var.environment_name
    Terraform = "true"
  }
}

resource "aws_vpc_dhcp_options" "default" {
  # XXX: Breaks newer Linux /etc/resolv.conf search option
  domain_name = var.dhcp_domain_name

  domain_name_servers = var.dhcp_domain_name_servers
  ntp_servers         = var.dhcp_ntp_servers

  tags = {
    Name      = "${var.project_name}-${var.environment_name}-dhcp"
    Env       = var.environment_name
    Terraform = "true"
  }
}

resource "aws_vpc_dhcp_options_association" "default" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.default.id
}
