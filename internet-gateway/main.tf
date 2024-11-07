data "aws_vpc" "selected_vpc" {
  id = var.vpc_id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.selected_vpc.id
  tags = var.tags
}