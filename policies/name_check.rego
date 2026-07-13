package terraform.authz

import future.keywords.if

default allow = {
    "status": false,
    "reason": "La instancia no cumple con la nomenclatura obligatoria AUY1105-etsmc-ec2 o no es tipo t2.micro."
}

allow = result if {
    some i
    resource := input.resource_changes[i]
    resource.type == "aws_instance"
    
    # Validacion 1: Nombre exacto de nomenclatura
    resource.change.after.tags.Name == "AUY1105-etsmc-ec2"
    
    # Validacion 2: Restriccion estricta de costos y tamaño
    resource.change.after.instance_type == "t2.micro"

    result := {
        "status": true,
        "reason": "Nomenclatura institucional y Tipo de instancia (t2.micro) aprobados con éxito."
    }
}