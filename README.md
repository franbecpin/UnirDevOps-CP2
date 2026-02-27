# UnirDevOps-CP2
Repositorio para la práctica 2 de UnirDevops

---
Ejemplo proyecto Terraform:

mi-proyecto-terraform/
├── main.tf          # Recursos principales y llamadas a módulos
├── variables.tf     # Definición de variables de entrada
├── outputs.tf       # Salidas (IDs, IPs, etc.)
├── providers.tf     # Configuración del proveedor (AWS, Azure, GCP)
├── locals.tf        # Variables locales (opcional, para lógica compleja)
├── terraform.tfvars # Valores reales de las variables
├── backend.tf       # Configuración del backend (donde se guarda el estado)
├── README.md        # Documentación
├── modules/         # Módulos reutilizables propios
│   └── mi-modulo/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/    # Configuración por entorno (opcional, para gran escala)
    ├── dev/
    └── prod/

