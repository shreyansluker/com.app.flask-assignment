output "instance_profile_name" {
  value       = aws_iam_instance_profile.instance-profile.name
  description = "instance profile name"
}

output "role_name" {
  value       = aws_iam_role.role.name
  description = "Role name"
}
