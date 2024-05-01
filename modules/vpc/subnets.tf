resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 7, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  lifecycle {
    ignore_changes = [tags]
  }

  tags = {
    Name                     = "${var.project_name}-${var.environment_name}-public-${count.index}"
    Env                      = var.environment_name
    "kubernetes.io/role/elb" = 1
    Terraform                = "true"
  }
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 7, count.index + 8)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  lifecycle {
    ignore_changes = [tags]
  }

  tags = {
    Name                              = "${var.project_name}-${var.environment_name}-private-${count.index}"
    Env                               = var.environment_name
    Terraform                         = "true"
  }
}