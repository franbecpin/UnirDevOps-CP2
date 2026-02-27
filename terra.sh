#!/bin/bash

# -----------------------------------------------------------
# Script para ejecutar Terraform sin cambiar el directorio
# actual, usando -chdir=<ruta>.
# -----------------------------------------------------------

# Ruta del directorio donde tienes tu proyecto Terraform
TERRAFORM_DIR="/home/francisco.becerra/Servers/terraform"

# Ruta del ejecutable de Terraform
# Si Terraform está en el PATH, usa simplemente: TERRAFORM_EXE="terraform"
TERRAFORM_EXE="$TERRAFORM_DIR/terraform"

echo "Ejecutando Terraform en: $TERRAFORM_DIR"
echo "Comando: \"$TERRAFORM_EXE\" -chdir=\"$TERRAFORM_DIR\" $@"

"$TERRAFORM_EXE" -chdir="$TERRAFORM_DIR" "$@"

echo "---- Fin de la ejecución de Terraform ----"