#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------
# terra.sh — wrapper sencillo para Terraform
# Usa SIEMPRE el directorio actual (%CD% en Windows, $PWD en Linux)
# Ejemplo de uso (desde AWS_CLI):
#   ../terra.sh init
#   ../terra.sh plan
#   ../terra.sh apply -auto-approve
# -----------------------------------------

# Si terraform está en el PATH, esto bastará:
TERRAFORM_EXE="${TERRAFORM_EXE:-terraform}"

# Directorio de trabajo = carpeta actual desde donde invocas el script
TERRAFORM_DIR="${PWD}"

# Comprobaciones básicas
if ! command -v "$TERRAFORM_EXE" >/dev/null 2>&1; then
  echo "[ERROR] No se encontró 'terraform' en el PATH ni en \$TERRAFORM_EXE" >&2
  exit 127
fi

if [ ! -d "$TERRAFORM_DIR" ]; then
  echo "[ERROR] Directorio inválido: $TERRAFORM_DIR" >&2
  exit 1
fi

echo "Ejecutando Terraform en: $TERRAFORM_DIR"
echo "Comando: \"$TERRAFORM_EXE\" -chdir=\"$TERRAFORM_DIR\" $*"
"$TERRAFORM_EXE" -chdir="$TERRAFORM_DIR" "$@"

echo
echo "---- Fin de la ejecución de Terraform ----"