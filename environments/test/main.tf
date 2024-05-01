module "ec2_key_pair" {
  source = "../../modules/aws_key_pair"

  key_name   = "${var.project_name}-${var.environment}-linux"
  public_key = file("../../modules/aws_key_pair/keys/sunshineacadiana-prod-windows.pub")

  project_name = var.project_name
  environment  = var.environment
}

module "ec2_linux" {
  source                      = "../../modules/aws_ec2"
  vpc_id                      = module.vpc.vpc_id
  vpc_public_subnet_ids       = module.vpc.public_subnet_ids
  vpc_cidr_range              = var.vpc_cidr_block
  enable_public_ip            = true
  environment                 = "test"
  hostname                    = "flask-app"
  instance_type               = "t3.micro"
  http_tokens                 = "required"
  http_put_response_hop_limit = 3
}
