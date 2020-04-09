resource "aws_internet_gateway" "tf_cloud_demo_internet_gateway" {
  vpc_id = aws_vpc.tf_cloud_demo_vpc.id
  tags = {
    Name = "tf_cloud_demo_igw"
  }
}