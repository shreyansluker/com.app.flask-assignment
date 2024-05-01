resource "aws_instance" "this" {
  ami                     = data.aws_ami.this.id
  subnet_id               = var.vpc_private_subnet_ids[0]
  vpc_security_group_ids  = [aws_security_group.this.id]
  instance_type           = var.instance_type
  iam_instance_profile    = module.server_instance_profile.instance_profile_name
  disable_api_termination = var.disable_api_termination

  user_data_base64            = base64encode(data.cloudinit_config.user_data.rendered)

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = var.block_device_size_root
    volume_type           = var.volume_type
    kms_key_id            = var.kms_key_arn
  }

  metadata_options {
    http_endpoint               = "enabled"
    instance_metadata_tags      = "enabled"
    http_put_response_hop_limit = var.http_put_response_hop_limit
    http_tokens                 = var.http_tokens
  }

  tags = {
    Puppet-Environment = var.puppet_environment
    Puppet-Role        = var.puppet_role
    Puppet-Cluster     = var.puppet_cluster
    Name               = var.hostname
    AWSBackup          = var.backup == true ? "include" : "exclude"
  }

  lifecycle {
    ignore_changes = [
      root_block_device, user_data, launch_template, user_data_base64, ami
    ]
  }
  depends_on = [
    aws_ebs_volume.user,
  ]
}

data "aws_subnet" "this" {
  id = var.vpc_private_subnet_ids[0]
}

resource "aws_volume_attachment" "user" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.user.id
  instance_id = aws_instance.this.id
}

resource "aws_ebs_volume" "user" {
  availability_zone    = data.aws_subnet.this.availability_zone
  encrypted            = true
  kms_key_id           = var.kms_key_arn
  multi_attach_enabled = "false"
  size                 = var.block_device_size_user
  type                 = var.volume_type
}

# resource "aws_cloudwatch_metric_alarm" "recover" {
#   alarm_name          = format("%s-%s-%s-ec2-autorecover", var.alert_prefix, aws_instance.this.id)
#   namespace           = "AWS/EC2"
#   evaluation_periods  = "2"
#   period              = "60"
#   alarm_description   = format("Status Checked failed on %s (%s) - Auto Recovery is triggered", aws_instance.this.id)
#   alarm_actions       = ["arn:aws:automate:${var.region}:ec2:recover", var.arn_sns_topic]
#   ok_actions          = [var.arn_sns_topic]
#   statistic           = "Minimum"
#   comparison_operator = "GreaterThanThreshold"
#   threshold           = "0"
#   metric_name         = "StatusCheckFailed_System"
#   dimensions = {
#     InstanceId = aws_instance.this.id
#   }
# }

resource "aws_route53_record" "this" {
  name    = "${var.hostname}.${var.environment}.classic.sixt.cloud"
  type    = "A"
  zone_id = var.route53_zone_id
  records = [aws_instance.this.private_ip]
  ttl     = 300
}