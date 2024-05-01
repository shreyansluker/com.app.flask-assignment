# Define the security group for the instances itself
resource "aws_security_group" "this" {
  name        = "${var.hostname}-sg"
  description = "${var.hostname}-sg"
  vpc_id      = var.vpc_id
}

# Allow all egress traffic from the instance itself
resource "aws_security_group_rule" "egress-all" {
  description       = "Allow all egress"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.this.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow ingress from vpc on port 8080
resource "aws_security_group_rule" "ingress-vpc" {
  description       = "Allow ingress to port 8080"
  from_port         = 5000
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = 5000
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}