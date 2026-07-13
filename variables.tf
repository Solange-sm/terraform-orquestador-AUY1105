variable "mi_ip_acceso" {
  description = "Dirección IP pública para el acceso SSH seguro restringido"
  type        = string
}

variable "environment" {
  description = "Prefijo para nomenclatura corporativa estandarizada"
  type        = string
  default     = "AUY1105_etsmc"
}