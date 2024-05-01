module "ec2_key_pair" {
  source = "../../modules/aws_key_pair"

  key_name   = "${var.project_name}-${var.environment}-linux"
  public_key = file("../../modules/aws_key_pair/keys/sunshineacadiana-prod-windows.pub")

  project_name = var.project_name
  environment  = var.environment
}