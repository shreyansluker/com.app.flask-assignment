variable "availability_zones" {
  type = list(any)
}

variable "aws_account_id" {}

variable "aws_region_name" {}

variable "cidr_block" {}

variable "dhcp_domain_name" {}

variable "dhcp_domain_name_servers" {
  default = ["AmazonProvidedDNS"]
}

variable "dhcp_ntp_servers" {
  default = ["169.254.169.123"]
}

variable "environment_name" {}

variable "project_name" {}