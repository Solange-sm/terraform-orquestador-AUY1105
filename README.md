# terraform-orquestador-AUY1105
EFT

## Orquestador central de infraestructura modularizada

**Alumna:** Solange Milla  
**Asignatura:** Infraestructura como Código II (AUY1105)  
**Institución:** Duoc UC  
**Nomenclatura corporativa estandarizada:** `AUY1105-etsmc`

---

## Descripción del proyecto

Este repositorio actúa como el orquestador principal de la solución de infraestructura definida para la Evaluación Final Transversal (EFT). Su función es integrar y coordinar los módulos de Terraform desarrollados por separado para la capa de redes y la capa de cómputo, manteniendo un diseño modular, desacoplado y reutilizable.

La solución reemplaza una arquitectura monolítica por un enfoque distribuido, donde cada módulo se publica y consume de forma independiente mediante referencias remotas desde GitHub y versionado semántico. Esto permite mejorar la mantenibilidad, la trazabilidad de cambios y la evolución controlada de la infraestructura.

---

## Objetivo del repositorio

El objetivo de este repositorio es centralizar la orquestación de los módulos de infraestructura, inyectando las dependencias necesarias entre ellos y consolidando la configuración final de la solución.

En particular, este repositorio:

- Consume el módulo de redes (VPC) como base de conectividad.
- Consume el módulo de cómputo (EC2) como instancia principal de aplicación.
- Gestiona variables, outputs y dependencias entre módulos.
- Integra validaciones de seguridad, documentación y automatización CI/CD.
- Mantiene trazabilidad mediante changelog y versionado semántico.

---

## Módulos utilizados

Este repositorio consume los siguientes módulos externos:

- **Módulo de Redes (VPC)**  
  Versión: `v1.0.1`  
  Repositorio: `git::https://github.com/Solange-sm/terraform-aws-vpc-AUY1105.git?ref=v1.0.1`

- **Módulo de Cómputo (EC2)**  
  Versión: `v1.0.1`  
  Repositorio: `git::https://github.com/Solange-sm/terraform-aws-ec2-AUY1105.git?ref=v1.0.1`

---

## Componentes desplegados

La infraestructura orquestada aprovisiona de forma automatizada los siguientes elementos:

### Capa de redes
- VPC principal con CIDR `10.1.0.0/16`.
- Subredes públicas en dos zonas de disponibilidad.
- Subredes privadas en dos zonas de disponibilidad.
- Internet Gateway para conectividad pública.
- NAT Gateway respaldado por Elastic IP para salida a internet desde subredes privadas.
- Tablas de ruteo públicas y privadas con sus respectivas asociaciones.
- VPC Flow Logs integrados con CloudWatch para auditoría de tráfico.
- Security Group para cómputo con acceso SSH restringido y tráfico HTTP permitido.

### Capa de cómputo
- Instancia EC2 Linux desplegada con `LabInstanceProfile`.
- Volumen raíz cifrado.
- IMDSv2 obligatorio.
- Monitoreo detallado habilitado.
- Reglas de red asociadas mediante el módulo VPC.

---

## Validaciones y seguridad

La solución incorpora mecanismos de validación y endurecimiento para fortalecer la infraestructura:

- **Checkov** para análisis estático de seguridad.
- **TFLint** para revisión de calidad y consistencia del código.
- **OPA (Open Policy Agent)** para validación de políticas de seguridad.
- **.gitignore** para excluir archivos temporales, estado local y artefactos de Terraform.
- **CHANGELOG.md** para registrar cambios relevantes por versión.
- **SemVer** para mantener control de versiones sobre los módulos publicados.

---

## Estructura del proyecto

```text
.
├── main.tf               # Invocación remota de los módulos e interconexión de dependencias.
├── variables.tf          # Definición de parámetros inyectados dinámicamente.
├── outputs.tf            # Consolidación de outputs de la solución.
├── versions.tf           # Restricción de versiones de Terraform y del proveedor AWS.
├── .gitignore            # Exclusión de archivos de estado local y credenciales.
├── README.md             # Documentación principal del proyecto.
├── CHANGELOG.md          # Registro histórico y trazabilidad semántica de cambios.
├── install.sh            # Script opcional para aprovisionamiento local de herramientas.
├── policies/             # Políticas restrictivas escritas en Rego evaluadas por OPA.
│   ├── region_check.rego # Validación de región permitida y bloqueo de SSH público.
│   └── name_check.rego   # Validación de nomenclatura y tipo de instancia.
└── .github/
    └── workflows/
        └── cicd.yml      # Pipeline CI/CD en GitHub Actions.
```

---

## Arquitectura general

La solución se compone de tres piezas independientes que se integran mediante referencias remotas desde GitHub:

```text
┌────────────────────────────────────────────────────────┐
│   terraform-orquestador-AUY1105 (Este repositorio)    │
└───────────────────────────┬────────────────────────────┘
                            │
            ┌───────────────┴───────────────┐
            ▼                               ▼
┌──────────────────────────────┐   ┌──────────────────────────────┐
│ terraform-aws-vpc-AUY1105    │   │ terraform-aws-ec2-AUY1105    │
│ Red, subredes, rutas, logs   │   │ Instancia EC2 y hardening    │
└──────────────────────────────┘   └──────────────────────────────┘
```

El orquestador central obtiene los outputs del módulo VPC y los utiliza para alimentar el módulo EC2, logrando una solución modular, reutilizable y coherente.

---

## Versionado y trazabilidad

La solución utiliza versionado semántico para mantener control sobre la evolución de cada módulo. Esto permite identificar con claridad cuándo una versión introduce mejoras, correcciones o cambios incompatibles.

Además, el repositorio mantiene un `CHANGELOG.md` con el historial de cambios relevantes, siguiendo el estándar *Keep a Changelog* para facilitar la revisión y la auditoría del proyecto.

---

## Consideraciones finales

Este repositorio fue diseñado para evidenciar los indicadores de modularidad, documentación, validación estática, políticas de seguridad, automatización CI/CD y versionado semántico requeridos por la evaluación.

La estructura separada por módulos permite una implementación más mantenible, trazable y fácil de explicar durante la presentación final.