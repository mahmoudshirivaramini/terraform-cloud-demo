resource "aws_route_table" "tf_cloud_demo_dmz_public_rt" {
  vpc_id = aws_vpc.tf_cloud_demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_cloud_demo_internet_gateway.id
  }
  tags = {
    Name = "tf_cloud_demo_dmz_public"
  }
}

resource "aws_route_table_association" "tf_cloud_demo_dmz_public_assoc" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.tf_cloud_demo_dmz_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.tf_cloud_demo_dmz_public_rt.id
}

resource "aws_route_table" "tf_cloud_demo_app_private_rt" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.tf_cloud_demo_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.tf_cloud_demo_natgw.*.id, count.index)
  }
  tags = {
    Name = "tf_cloud_demo_app_private"
  }
}

resource "aws_route_table_association" "tf_cloud_demo_app_private_assoc" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.tf_cloud_demo_app_private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.tf_cloud_demo_app_private_rt.*.id, count.index)
  depends_on     = [aws_nat_gateway.tf_cloud_demo_natgw]
}