# AMI Name
variable "ami_name" {
  type        = string
  description = "The ami name, e.g. amzn2-ami-hvm*"
  default     = "amzn2-ami-hvm*"
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
  default     = 30
}

# VPC ID
variable "vpc_id" {
  type        = string
  description = "ID of the VPC referenced by the instance"
}

variable "vpc_public_subnet_ids" {
  type        = list(string)
  description = "IDs of the subnet within the VPC"
}

# VPC CIDR range (aka prefix)
variable "vpc_cidr_range" {
  type        = string
  description = "CIDR range of hosts"
}

# Hostname
variable "hostname" {
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
  default = "test"
}

variable "disable_api_termination" {
  type = bool
  default = true
}

variable "enable_public_ip" {
  default = false
}