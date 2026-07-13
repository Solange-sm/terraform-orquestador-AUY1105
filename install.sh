#!/bin/bash
handle_error() {
  echo "Error: Falló la instalación en el paso $1."
  exit 1
}

echo "Iniciando instalación de herramientas de auditoría local..."
sudo yum install -y python3-pip || handle_error "1 (python3-pip)"
pip3 install checkov || handle_error "2 (checkov)"
sudo yum install -y yum-utils || handle_error "3.1 (yum-utils)"
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo || handle_error "3.2 (hashicorp repo)"
sudo yum -y install terraform || handle_error "4 (terraform)"
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash || handle_error "5 (tflint)"

# OPA
curl -L -o opa https://openpolicyagent.org/downloads/v0.61.0/opa_linux_amd64_static
chmod +x opa
sudo mv opa /usr/local/bin/

echo "Entorno local aprovisionado de forma exitosa."