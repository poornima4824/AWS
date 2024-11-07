data "aws_vpc" "selected_vpc" {
  id = var.vpc_id
}

module "internet_gateway_module" {
  source = "../internet-gateway"
  vpc_id = data.aws_vpc.selected_vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = data.aws_vpc.selected_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway_module.internet_gateway_id
  }
  tags = var.tags
}