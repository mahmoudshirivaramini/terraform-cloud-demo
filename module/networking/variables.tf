variable "cidr_block" { type = string }
variable "availability_zones" { type = list(string) }
variable "dmz_public_cidrs" { type = list(string) }
variable "app_private_cidrs" { type = list(string) }
variable "accessip" { type = string }
variable "log_bucket" { type = string }