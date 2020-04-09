output "dmz_public_subnets" {
  value = aws_subnet.tf_cloud_demo_dmz_public_subnet.*.id
  description = "public DMZ subnet list"
}

output "dmz_public_ips" {
  value = aws_subnet.tf_cloud_demo_dmz_public_subnet.*.cidr_block
  description = "public DMZ subnet ips cidr list"  
}

output "app_private_subnets" {
  value = aws_subnet.tf_cloud_demo_app_private_subnet.*.id
  description = "private application subnet list"  
}

output "app_private_subnet_ips" {
  value = aws_subnet.tf_cloud_demo_app_private_subnet.*.cidr_block
  description = "private application subnet ips cidr list"
}

output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
  description = "bastion security group id"
}

output "webserver_sg" {
  value = aws_security_group.webserver_sg.id
  description = "webserver security group id"
}

output "target_group_arn" {
  value = aws_lb_target_group.tf_cloud_demo_target_group.arn
  description = "application loadbalancer target group arn"
}

output "alb_dns_name" {
  value = aws_alb.tf_cloud_demo.dns_name
  description = "application loadbalancer endpoint url"
}

