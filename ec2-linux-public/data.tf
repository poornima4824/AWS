data "aws_vpc" "my_vpc" {
  id = var.vpc_id
}
data "aws_subnet" "selected" {
  id = var.public_subnet
}