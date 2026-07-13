# Changelog - Orquestador Central de Infraestructura (Grupo 4)

Todos los cambios notables en este proyecto serán documentados en este archivo. El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/) y este proyecto se adhiere a las buenas prácticas de versionado bajo el estándar de [Versionado Semántico](https://semver.org/lang/es/) (SemVer).

## [1.0.0] - 2026-07-13
### Added
- **Orquestación Multi-Repositorio:** Inicialización del proyecto orquestador raíz encargado de centralizar, coordinar e interconectar la infraestructura distribuida para el Examen Transversal (EFT).
- **Consumo de Módulos Remotos:** Integración en `main.tf` de las llamadas remotas vía HTTPS a los repositorios independientes de Redes (`terraform-aws-vpc-AUY1105`) y Cómputo (`terraform-aws-ec2-AUY1105`) apuntando firmemente a la versión estable `v1.0.1`.
- **Automatización CI/CD (GitHub Actions):** Creación del workflow `.github/workflows/cicd.yml` enfocado en la validación continua de calidad y seguridad ante eventos en la rama `dev` y Pull Requests a `main`.
- **Gobernanza Corporativa y Políticas (OPA):** Incorporación de la carpeta `policies/` con reglas en lenguaje Rego para validar de forma automatizada la región obligatoria (`us-east-1`), el tipo de instancia (`t2.micro`), la nomenclatura institucional (`AUY1105_etsmc`) y el bloqueo absoluto de accesos SSH masivos (`0.0.0.0/0`).
- **Documentación Maestra:** Creación de un `README.md` robusto con matrices de secretos, instrucciones de despliegue local, diagramas de flujo y justificaciones técnicas de cumplimiento de la rúbrica.

### Changed
- **Estandarización de Nomenclatura:** Configuración global de variables para usar el prefijo corporativo mandatorio `AUY1105-etsmc`.

### Fixed
- **Ajuste de Control Semántico (Checkov):** Inyección de la excepción técnica `CKV_TF_1` en el pipeline de Checkov. Esto permite omitir la exigencia estricta de usar hashes SHA de Git, habilitando la evaluación y uso de Git Tags.