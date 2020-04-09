resource "aws_key_pair" "tf_cloud_demo" {
  key_name   = "tf_cloud_demo"
  public_key = file(var.public_key)
}