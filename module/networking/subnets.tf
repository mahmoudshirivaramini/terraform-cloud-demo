resource "aws_subnet" "tf_cloud_demo_dmz_public_subnet" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.tf_cloud_demo_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index)
  tags = {
    Name = "tf_cloud_demo_dmz_public_${element(var.availability_zones, count.index)}"
  }
}

resource "aws_subnet" "tf_cloud_demo_app_private_subnet" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.tf_cloud_demo_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zones))
  map_public_ip_on_launch = false
  availability_zone       = element(var.availability_zones, count.index)
  tags = {
    Name = "tf_cloud_demo_app_private_${element(var.availability_zones, count.index)}"
  }
}