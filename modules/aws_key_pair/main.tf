variable "project_name" {}
variable "environment" {}
variable "key_name" {}
variable "public_key" {}

resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = var.public_key
  
  tags = {
    Name      = "${var.project_name}-${var.environment}"
    Env       = var.environment
    Terraform = "true"
  }
}

output "key_name" {
  value = aws_key_pair.key.key_name
}
