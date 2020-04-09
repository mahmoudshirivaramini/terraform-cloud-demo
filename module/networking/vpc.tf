resource "aws_vpc" "tf_cloud_demo_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  enable_classiclink   = "false"
  tags = {
    Name = "tf_cloud_demo_vpc"
  }
}