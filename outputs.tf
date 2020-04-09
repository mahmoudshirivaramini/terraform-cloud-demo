output "alb_dns_name" {
  value       = module.networking.alb_dns_name
  description = "application loadbalancer endpoint url"
}