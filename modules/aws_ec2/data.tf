# Define the AMI to use
data "aws_ami" "this" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Define the instance profile
module "server_instance_profile" {
  source                           = "../instance_profile"
  instance_profile_name            = "${var.hostname}-instance-profile"
  role_name                        = "${var.hostname}-instance-profile"
  attach_ssm_policy                = true
  attach_policy_describe_instances = true
}

# Define cloudinit user_data necessary to run puppet initially
data "cloudinit_config" "user_data" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/scripts/deploy.tftpl", {})
  }
}
