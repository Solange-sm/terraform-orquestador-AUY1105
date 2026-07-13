# Orquestador Raíz de Infraestructura Modularizada Examen Transversal
# ==============================================================================

provider "aws" {
  region = "us-east-1"
}

module "redes" {
  # Consumo del modulo publicado en la Fase 1 bajo la etiqueta v1.0.0
  source       = "git::https://github.com/Solange-sm/terraform-aws-vpc-AUY1105.git?ref=v1.0.1"
  mi_ip_acceso = var.mi_ip_acceso
  environment  = var.environment
}

module "computo" {
  # Consumo del modulo publicado en la Fase 2 bajo la etiqueta v1.0.0
  source            = "git::https://github.com/Solange-sm/terraform-aws-ec2-AUY1105.git?ref=v1.0.1"
  subnet_id         = module.redes.public_subnet_ids[0]
  security_group_id = module.redes.security_group_id
  environment       = var.environment
}