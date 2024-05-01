resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.aws_region_name}.s3"
  route_table_ids = [
    aws_route_table.public.id,
    aws_route_table.private.id
  ]
  tags = {
    Name      = "${var.project_name}-${var.environment_name}-s3-endpoint"
    Env       = var.environment_name
    Terraform = "true"
  }
}