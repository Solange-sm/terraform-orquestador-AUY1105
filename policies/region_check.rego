package terraform.authz

import future.keywords.if

default allow = {
    "status": false,
    "reason": "Error: La región configurada no es us-east-1 o se detectó apertura SSH masiva (0.0.0.0/0)."
}

allow = result if {
    # Validacion 1: Restriccion geografica del proveedor
    provider := input.configuration.provider_config[_]
    provider.name == "aws"
    provider.expressions.region.constant_value == "us-east-1"

    # Validacion 2: Asegurar que el trafico SSH no este abierto al mundo
    not any_public_ssh

    result := {
        "status": true,
        "reason": "Validación regional us-east-1 y control estricto de SSH aprobados."
    }
}

any_public_ssh if {
    resource := input.resource_changes[_]
    resource.type == "aws_security_group"
    ingress := resource.change.after.ingress[_]
    ingress.from_port == 22
    ingress.cidr_blocks[_] == "0.0.0.0/0"
}