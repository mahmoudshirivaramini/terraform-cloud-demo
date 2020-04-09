variable "public_key" { type = string }
variable "bastion_sg" { type = string }
variable "webserver_sg" { type = string }
variable "dmz_public_subnets" { type = list(string) }
variable "app_private_subnets" { type = list(string) }
variable "availability_zones" { type = list(string) }
variable "alb_dns_name" { type = string }
variable "target_group_arn" { type = string }