data "aws_vpc" "selected_vpc" {
  id = var.vpc_id
}

resource "aws_subnet" "public" {

  availability_zone       = var.availability_zone
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true
  vpc_id                  = data.aws_vpc.selected_vpc.id
  tags = var.tags
}