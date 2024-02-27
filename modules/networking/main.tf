resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range
  enable_dns_hostnames = true
  
  tags = {
    Name = var.vpc_name
  }
}
