data "aws_vpc" "selected_vpc" {
  id = var.vpc_id
}

module "private_subnet" {
  source = "../private-subnet"
  vpc_id = data.aws_vpc.selected_vpc.id
  tags={
    "Name" = "private-subnet-infra-prov"
    "environment"   =   "dev"
    "SubnetType" = "private"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

module "internet_gateway_module" {
  source = "../internet-gateway"
  vpc_id = data.aws_vpc.selected_vpc.id
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = module.private_subnet.private_subnet_id
  tags = var.tags

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [module.internet_gateway_module]
}