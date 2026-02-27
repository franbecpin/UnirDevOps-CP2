@echo off
setlocal

REM Ruta del ejecutable de Terraform
set "TERRAFORM_EXE=C:\Users\francisco.becerra\Desktop\DESARROLLO\FORMACION\UNIR\Servers\terraform\terraform.exe"

REM Ruta del proyecto Terraform
set "TERRAFORM_DIR=C:\Users\francisco.becerra\Desktop\DESARROLLO\FORMACION\UNIR\Servers\terraform"

echo Ejecutando Terraform en: %TERRAFORM_DIR%
echo Comando: "%TERRAFORM_EXE%" -chdir="%TERRAFORM_DIR%" %*

"%TERRAFORM_EXE%" -chdir="%TERRAFORM_DIR%" %*

echo.
echo ---- Fin de la ejecución de Terraform ----
endlocal
pause
