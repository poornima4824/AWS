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

module "rt" {
  source = "../route-table"
  vpc_id = data.aws_vpc.selected_vpc.id
  tags={
    "Name" = "rt-infra-prov"
    "environment"   =   "dev"
}
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = module.private_subnet.private_subnet_id
  route_table_id = module.rt.route_table_id
}