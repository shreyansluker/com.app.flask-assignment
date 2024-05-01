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
  from_port         = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = 8080
  type              = "ingress"
  cidr_blocks       = [var.vpc_cidr_range]
}

# Allow SSH from Jenkins on port 22
resource "aws_security_group_rule" "ingress-jenkins" {
  description              = "Allow SSH ingress traffic from the Jenkins instances"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = var.jenkins_sg_id
  to_port                  = 22
  type                     = "ingress"
}

# Prometheus Scrape SG rules
resource "aws_security_group_rule" "phpapp-ingress-prometheus" {
  description              = "Allow prometheus to scrape exports in their dedicated port-range"
  from_port                = 9100
  to_port                  = 9120
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = var.prometheus-sg-id
  type                     = "ingress"
}