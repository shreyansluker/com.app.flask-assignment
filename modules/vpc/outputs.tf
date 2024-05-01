output "default_sg_id" {
  value = aws_default_security_group.default.id
}

output "windows_sg_id" {
  value = aws_security_group.windows.id
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "ipv6_cidr_block" {
  value = aws_vpc.vpc.ipv6_cidr_block
}
