resource "aws_eip" "nat" {
  count = length(var.availability_zones)
  vpc   = true
  tags = {
    Name = "tf_cloud_demo_NatGatewayIP_${count.index + 1}"
  }
}

resource "aws_nat_gateway" "tf_cloud_demo_natgw" {
  count         = length(var.availability_zones)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.tf_cloud_demo_dmz_public_subnet.*.id, count.index)
  depends_on    = [aws_internet_gateway.tf_cloud_demo_internet_gateway]
  tags = {
    Name = "tf_cloud_demo_natgw_${element(var.availability_zones, count.index)}"
  }
}