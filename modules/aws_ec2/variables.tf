# AMI Name
variable "ami_name" {
  type        = string
  description = "The ami name, e.g. Sixt CentOS 7"
  default     = "Sixt-CentOS-7.9*"
}

# AMI Owner
variable "ami_owner" {
  type        = string
  description = "The ami name, e.g. self or some id"
  default     = "078177869999"
}

# Instance type
variable "instance_type" {
  type        = string
  description = "Instance type to use within the autoscaling group"
  default     = "t3.medium"
}

# Instance root block device size
variable "block_device_size_root" {
  type        = number
  description = "Size of the root block device"
  default     = 60
}

# Instance user block device size
variable "block_device_size_user" {
  type        = number
  description = "Size of the user block device"
  default     = 100
}

# VPC ID
variable "vpc_id" {
  type        = string
  description = "ID of the VPC referenced by the instance"
}

# VPC Subnet IDs
variable "vpc_private_subnet_ids" {
  type        = list(string)
  description = "IDs of the subnet within the VPC"
}

variable "vpc_public_subnet_ids" {
  type        = list(string)
  description = "IDs of the subnet within the VPC"
}

# VPC CIDR range (aka prefix)
variable "vpc_cidr_range" {
  type        = string
  description = "CIDR range of hosts that should be able to reach Puppet"
}

# Route 53 Zone ID
variable "route53_zone_id" {
  type        = string
  description = "ID of the route53 zone in which the 'jenkins' record will be created"
}

# Puppetserver hostname
variable "puppet_server" {
  type        = string
  description = "Hostname of the puppetserver for the initial run"
}

# Puppetserver environment
variable "puppet_environment" {
  type        = string
  description = "Environment the initial puppet run should utilize"
}

# Puppetserver role
variable "puppet_role" {
  type        = string
  description = "Role of the puppetserver for the initial run"
}

# Puppetserver cluster
variable "puppet_cluster" {
  type        = string
  description = "Cluster of the puppetserver for the initial run"
}

# Hostname
variable "hostname" {
  default = ""
}

# KMS Key 
variable "kms_key_arn" {
  default = ""
}

# AWS Backup
variable "backup" {
  default = false
  type    = bool
}

# CATO range
variable "cato_cidr" {
  default = ""
}

# EBS Volume Type
variable "volume_type" {
  default = "gp3"
}

# IMDS V2 hop limit
variable "http_put_response_hop_limit" {
  type    = number
  default = 1
}

# HTTP Tokens
variable "http_tokens" {
  type    = string
  default = "required"
}

# Environment
variable "environment" {
  default = "dev"
}

# Jenkins Security Group 
variable "jenkins_sg_id" {
}


variable "prometheus-sg-id" {
  type        = string
  description = "Prometheus SG to scrape exports running on "
}

variable "disable_api_termination" {
  type = bool
  default = true
}