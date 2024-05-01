variable "instance_profile_name" {
  type = string
}

variable "role_name" {
  type = string
}

variable "attach_ssm_policy" {
  type = bool
}

variable "extra_policy_documents" {
  type    = map(string)
  default = {}
}

variable "attach_policy_describe_instances" {
  type    = bool
  default = false
}
