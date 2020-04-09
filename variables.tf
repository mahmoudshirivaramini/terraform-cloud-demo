# networking module
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "dmz_public_cidrs" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

}

variable "app_private_cidrs" {
  type = list(string)
  default = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]

}
variable "accessip" {
  type    = string
  default = "0.0.0.0/0"
}

# compute module
variable "public_key" {
  type    = string
  default = "tf_cloud_demo.pub"
}

# aws_logs module
variable "s3_bucket_name" {
  type    = string
  default = "tfclouddemo"
}
