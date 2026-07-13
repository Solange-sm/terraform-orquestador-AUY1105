output "vpc_id_desplegada" {
  description = "ID de la VPC creada de forma remota"
  value       = module.redes.vpc_id
}

output "instancia_computo_id" {
  description = "ID de la instancia EC2 desplegada remotamente"
  value       = module.computo.instance_id
}

output "url_servidor_web" {
  description = "Dirección IP pública de la instancia EC2 para acceso al Web Server"
  value       = module.computo.instance_ip
}