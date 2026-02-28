@echo off
setlocal

REM Ruta del ejecutable de Terraform (ajústala si cambias la ubicación)
set "TERRAFORM_EXE=C:\Users\francisco.becerra\Desktop\DESARROLLO\FORMACION\UNIR\Servers\terraform\terraform.exe"

REM Directorio de trabajo = carpeta actual desde donde ejecuto el bat
set "TERRAFORM_DIR=%CD%"

echo Ejecutando Terraform en: %TERRAFORM_DIR%
echo Comando: "%TERRAFORM_EXE%" -chdir="%TERRAFORM_DIR%" %*
"%TERRAFORM_EXE%" -chdir="%TERRAFORM_DIR%" %*

echo.
echo ---- Fin de la ejecución de Terraform ----
endlocal
