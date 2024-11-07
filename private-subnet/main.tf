data "aws_vpc" "selected_vpc" {
  id = var.vpc_id
}

resource "aws_subnet" "private" {
  availability_zone       = var.availability_zone
  cidr_block              = var.private_subnet_cidr_block
  map_public_ip_on_launch = false
  vpc_id                  = data.aws_vpc.selected_vpc.id
  tags = var.tags
}