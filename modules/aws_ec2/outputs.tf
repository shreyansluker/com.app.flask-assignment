output "userdata" {
  value = data.cloudinit_config.user_data.rendered
}

output "aws_security_group" {
  value = aws_security_group.this.id
}