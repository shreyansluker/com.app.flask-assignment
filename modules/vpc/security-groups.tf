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

resource "aws_security_group" "windows" {
  name        = "${var.project_name}-${var.environment_name}-windows-sg"
  description = "${var.project_name}-${var.environment_name}-windows-sg"

  vpc_id = aws_vpc.vpc.id

  # Only over VPN
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow RDP Traffic From Internet"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    description = "Allow HTTP Web Traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow All Outbound"
  }

  tags = {
    Name      = "${var.project_name}-${var.environment_name}-windows-sg"
    Env       = var.environment_name
    Terraform = "true"
  }
}