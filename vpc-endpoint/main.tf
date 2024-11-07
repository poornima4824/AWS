data "aws_vpc" "selected_vpc" {
  id = var.vpc_id
}
resource "aws_vpc_endpoint" "vpc_endpoint_for_s3" {
  vpc_id       = data.aws_vpc.selected_vpc.id
  service_name = format("com.amazonaws.%s.s3", var.region)
  tags = var.tags
}