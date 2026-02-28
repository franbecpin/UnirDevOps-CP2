# UnirDevOps-CP2
## Repositorio para la práctica 2 de UnirDevops

---
## Estructura solicitada de Repositorio
```
ansible/
  deploy.sh
  hosts
  playbook.yml
terraform/
  vars.tf
  main.tf
  recursos.tf
```
## Pasos para resolver la práctica
FASE 0 — Preparar entorno y repo    
FASE 1 — Login Azure  
FASE 2 — Terraform:
    - ACR
    - VM Linux
    - AKS
FASE 3 — Construir y subir imágenes a ACR
FASE 4 — Ansible:
    - Configurar VM + Podman
    - Configurar AKS + app con PVC
FASE 5 — Validar accesos
FASE 6 — Crear informe PDF

```
GEMINI
Fase 1: Preparación del Entorno

Configurar la cuenta de Azure: Activar la suscripción de estudiante (crédito de $100) utilizando el correo institucional y el CIF de UNIR.


Preparar el Nodo de Control: Configurar una máquina (Linux/Mac preferiblemente) con Python 3, Ansible (v2.12+), Terraform y Azure CLI.
+1


Generar Claves SSH: Crear un par de claves en el nodo de control para permitir la conexión de Ansible con la futura máquina virtual.


Inicializar el Repositorio Git: Crear un repo público con la estructura obligatoria: carpetas /terraform (con main.tf, vars.tf, recursos.tf) y /ansible (con hosts, playbook.yml, deploy.sh).
+1

Fase 2: Infraestructura con Terraform

Definir el Azure Container Registry (ACR): Crear el registro con acceso desde Internet y autenticación habilitada.
+1


Crear la Máquina Virtual (VM): Desplegar una VM Linux (distribución libre) que servirá para ejecutar Podman.
+1


Desplegar el Cluster AKS: Configurar un cluster gestionado con un único worker.
+1


Vincular ACR y AKS: Configurar los permisos o credenciales para que el cluster de Kubernetes pueda descargar imágenes del registro privado.

Fase 3: Gestión de Imágenes y Contenedores

Preparar Aplicaciones: Crear dos aplicaciones distintas (ej. Nginx para VM y Apache para AKS).
+1


Subir Imágenes al ACR: * La imagen para la VM debe incluir: contenido web, certificado x.509 autofirmado y credenciales htpasswd.
+2

Etiquetar ambas imágenes con la versión obligatoria: casopractico2.

Fase 4: Configuración con Ansible
Configurar la Aplicación en la VM:

Instalar Podman y desplegar la aplicación como un contenedor.
+1

Asegurar que la aplicación se gestione como un servicio del sistema persistente a reinicios.

Configurar el acceso externo a través de HTTPS con autenticación básica.
+1

Desplegar en Kubernetes (AKS):

Automatizar el despliegue de la aplicación con almacenamiento persistente (Storage Classes de AKS).
+1

Asegurar que la aplicación sea accesible desde Internet.


Nota: Evitar módulos command, shell o script en los playbooks siempre que sea posible.

Fase 5: Documentación y Entrega

Redactar el Informe PDF: Debe incluir la URL del repo, diagramas propios de la arquitectura, descripción del proceso de despliegue, detalles de las aplicaciones, resolución de problemas (formato APA) y la licencia de código utilizada.
+2


Verificación Final: Confirmar que no hay pasos manuales en el proceso y que el repositorio es público.
+2
```

### FASE 0 — Preparar entorno y repo
```
- Actualizar paquete del sistema
sudo apt update && sudo apt upgrade -y

- Instalar Python 3
sudo apt install -y python3 python3-pip

- Instalar Ansible
sudo apt install -y ansible
ansible --version

- Genera para de claves SSH
ssh-keygen -t ed25519 -C "unir-cp2"

- Genera
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub

- Instalar Terraform
wget https://releases.hashicorp.com/terraform/<VERSION>/terraform_<VERSION>_linux_amd64.zip
unzip terraform_*.zip
sudo mv terraform /usr/local/bin/
terraform -version

- Instalar Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az version

- Verificar acceso a suscripción Azure
az login
[IMAGEN DE EVIDENCIA DE LOGIN]
- Verificar el tenant y la suscripción
az account show
```


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
	

- Formatear automaticamente los ficheros: ```terraform fmt```
- Crear la infraestructura definida en terraform.tf: ```terraform init```
```
Ver archivos creados por terraform init
---------------------------------------
tree /F
```

- Validar el código: ```terraform validate```
- Autentificación para AWS: ```aws configure list```

> Asignar la credenciales AWS a Terraform
> 1. Abrir AWS Console y acceder al servicio IAM.
> 2. Ir a "Usuarios" y pulsar "Crear usuario".
> 3. Escribir el nombre del usuario: `terraform-user`.
> 4. NO marcar "Proporcionar acceso de usuario a la consola de administración de AWS".
> 5. Pulsar "Siguiente".
> 6. En "Permisos", seleccionar "Agregar usuario a un grupo".
> 7. Crear un nuevo grupo llamado `terraform-admins`.
> 8. Dentro del grupo, marcar la política `AdministratorAccess`.
> 9. Crear el grupo y seleccionarlo.
> 10. Pulsar "Siguiente".
> 11. Saltar las etiquetas (opcional) y pulsar "Siguiente".
> 12. Pulsar "Crear usuario".
> 13. Abrir el usuario recién creado (`terraform-user`) en la lista de usuarios.
> 14. Ir a la sección "Credenciales de seguridad".
> 15. Ir al apartado "Claves de acceso".
> 16. Pulsar "Crear clave de acceso".
> 17. Seleccionar "CLI de AWS, SDK y otras herramientas de desarrollo".
> 18. Pulsar "Siguiente".
> 19. (Opcional) Añadir una descripción para la clave.
> 20. Pulsar "Crear clave de acceso".
> 21. Descargar el archivo `.csv` que contiene `Access Key ID` y `Secret Access Key`.
> 22. Guardar las claves en un lugar seguro (no se volverán a mostrar).
> 23. En tu equipo local, configurar las credenciales con AWS CLI ejecutando `aws configure`.
> 24. Introducir `AWS Access Key ID`, `AWS Secret Access Key`, región `us-west-2` y formato `json`.
> 25. Verificar que las credenciales funcionan ejecutando `aws sts get-caller-identity`.
> 26. Asegurarse de que el `provider` de Terraform solo contenga la región:
> ```
>    hcl
>    provider "aws" {
>      region = "us-west-2"
>    }
> ```    
> 27. Ejecutar en tu equipo local:
> ```
>    terraform init
>    terraform plan
>    # Volcar el plan en un fichero
>    terraform plan -out mifichero.json 
>    terraform apply 
>   # Se puede aplicar un plan desde un archivo
>    terraform apply mifichero.json
>    ```
> 28. Con esto, Terraform podrá autenticarse y crear una VM (EC2) en tu laboratorio AWS.

- Aplicar la configuración para crear el EC2 en AWS: ```terraform apply```
- Lista de estados de los recursos: ```terraform state list```
- Ver el estado. Muestra la información sobre los recursos en formato JSON: ```terraform show```


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

### Ejemplo de uso outputs.tf
```
# Obtener la IP pública de una instancia EC2 creada
output "instance_public_ip" {
  description = "Dirección IP pública de la instancia web"
  value       = aws_instance.web.public_ip
}

# Obtener el ID de la instancia
output "instance_id" {
  value = aws_instance.web.id
}

```
- Salida por consola
```
terraform output
instance_id = "i-0abcd1234efgh5678"
instance_public_ip = "54.123.45.67"

terraform output instance_id
instance_id = "i-0abcd1234efgh5678"
```
