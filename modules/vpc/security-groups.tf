resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    self        = true
    description = "Allow Internal VPC Traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow All Outbound"
  }

  tags = {
    Name      = "${var.project_name}-${var.environment_name}-default-sg"
    Env       = var.environment_name
    Terraform = "true"
  }
}