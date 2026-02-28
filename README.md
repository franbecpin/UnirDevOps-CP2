# UnirDevOps-CP2
## Repositorio para la práctica 2 de UnirDevops

**Tutoriales**
Tutoriales de Hashicorp.
Contiene ejemplos y una consola para hacer pruebas:  
https://developer.hashicorp.com/terraform/tutorials

Documentación de Terraform:  
https://developer.hashicorp.com/terraform/docs

Información proveedores, módulos, etc (con código básico de ejemplo)  
https://registry.terraform.io/

### main.tf
- Crea la VM en AWS
- Crea la VM en Azure

### providers.tf
- Definición del Proveedor AWS (No requiere cambios posteriores)
- Definición del Proveedor Azure. (No requiere cambios posteriores)

### outputs.tf
- Recoge los valores para la salida por pantalla.


---
## Ejecución Terraform
- Crear los ficheros:
	- terraform.tf
	- main.tf
	

- Formatear automaticamente los ficheros
'''terraform fmt'''

- Crear la infraestructura definida en terraform.tf
'''terraform init'''

- Validar el código.
'''terraform validate'''

- Autentificación para AWS
'''aws configure list'''

- Aplicar la configuración para crear el EC2 en AWS.
'''terraform apply'''

- Lista de estados de los recursos.
'''terraform state list'''

- Ver el estado. Muestra la información sobre los recursos en formato JSON.
'''terraform show'''


---
Ejemplo proyecto Terraform:
```
mi-proyecto-terraform/  
├── main.tf          # Recursos principales y llamadas a módulos  
├── providers.tf     # Configuración del proveedor (AWS, Azure, GCP)  
├── versions.tf      # Configuración de las versiones del proveedor (Opcional para separarlos de provider)   
│                    # (AWS, Azure, GCP)  
├── variables.tf     # Definición de variables de entrada  
├── outputs.tf       # Salidas (IDs, IPs, etc.) Se ejecuta al final del proceso de despliegue 
├── locals.tf        # Variables locales (opcional, para lógica compleja)  
├── terraform.tfvars # Valores reales de las variables  
├── backend.tf       # Configuración del backend (donde se guarda el estado)  
├── README.md        # Documentación  
├── modules/         # Módulos reutilizables propios  
│   └── mi-modulo/  
│       ├── main.tf  # Contendrá el código asociado al módulo
│       ├── variables.tf  
│       └── outputs.tf  
└── environments/    # Configuración por entorno (opcional, para gran escala)  
    ├── dev/  
    └── prod/  
```
---
## Asignar la credenciales AWS a Terraform
1. Abrir AWS Console y acceder al servicio IAM.
2. Ir a "Usuarios" y pulsar "Crear usuario".
3. Escribir el nombre del usuario: `terraform-user`.
4. NO marcar "Proporcionar acceso de usuario a la consola de administración de AWS".
5. Pulsar "Siguiente".
6. En "Permisos", seleccionar "Agregar usuario a un grupo".
7. Crear un nuevo grupo llamado `terraform-admins`.
8. Dentro del grupo, marcar la política `AdministratorAccess`.
9. Crear el grupo y seleccionarlo.
10. Pulsar "Siguiente".
11. Saltar las etiquetas (opcional) y pulsar "Siguiente".
12. Pulsar "Crear usuario".
13. Abrir el usuario recién creado (`terraform-user`) en la lista de usuarios.
14. Ir a la sección "Credenciales de seguridad".
15. Ir al apartado "Claves de acceso".
16. Pulsar "Crear clave de acceso".
17. Seleccionar "CLI de AWS, SDK y otras herramientas de desarrollo".
18. Pulsar "Siguiente".
19. (Opcional) Añadir una descripción para la clave.
20. Pulsar "Crear clave de acceso".
21. Descargar el archivo `.csv` que contiene `Access Key ID` y `Secret Access Key`.
22. Guardar las claves en un lugar seguro (no se volverán a mostrar).
23. En tu equipo local, configurar las credenciales con AWS CLI ejecutando `aws configure`.
24. Introducir `AWS Access Key ID`, `AWS Secret Access Key`, región `us-west-2` y formato `json`.
25. Verificar que las credenciales funcionan ejecutando `aws sts get-caller-identity`.
26. Asegurarse de que el `provider` de Terraform solo contenga la región:
    ```hcl
    provider "aws" {
      region = "us-west-2"
    }
    ```
27. Ejecutar en tu equipo local:
    - `terraform init`
    - `terraform plan`
    - `terraform apply`
28. Con esto, Terraform podrá autenticarse y crear una VM (EC2) en tu laboratorio AWS.