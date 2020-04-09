module "networking" {
  source             = "./module/networking"
  cidr_block         = var.cidr_block
  availability_zones = var.availability_zones
  dmz_public_cidrs   = var.dmz_public_cidrs
  app_private_cidrs  = var.app_private_cidrs
  accessip           = var.accessip
  log_bucket         = module.aws_logs.aws_logs_bucket
}

module "compute" {
  source              = "./module/compute"
  availability_zones  = var.availability_zones
  public_key          = var.public_key
  bastion_sg          = module.networking.bastion_sg
  webserver_sg        = module.networking.webserver_sg
  dmz_public_subnets  = module.networking.dmz_public_subnets
  app_private_subnets = module.networking.app_private_subnets
  target_group_arn    = module.networking.target_group_arn
  alb_dns_name        = module.networking.alb_dns_name
}

module "aws_logs" {
  source         = "trussworks/logs/aws"
  s3_bucket_name = var.s3_bucket_name
  region         = var.aws_region
  default_allow  = false
  allow_alb      = true
  force_destroy  = true
}