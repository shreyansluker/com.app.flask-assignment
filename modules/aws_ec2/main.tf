resource "aws_instance" "this" {
  ami                     = data.aws_ami.this.id
  subnet_id               = var.vpc_public_subnet_ids[0]
  vpc_security_group_ids  = [aws_security_group.this.id]
  instance_type           = var.instance_type
  iam_instance_profile    = module.server_instance_profile.instance_profile_name
  disable_api_termination = var.disable_api_termination
  associate_public_ip_address = var.enable_public_ip

  user_data_base64        = base64encode(data.cloudinit_config.user_data.rendered)

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.block_device_size_root
    volume_type           = var.volume_type
  }

  metadata_options {
    http_endpoint               = "enabled"
    instance_metadata_tags      = "enabled"
    http_put_response_hop_limit = var.http_put_response_hop_limit
    http_tokens                 = var.http_tokens
  }
}
