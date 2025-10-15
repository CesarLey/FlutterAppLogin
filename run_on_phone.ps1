Param(
    [string]$DeviceId = "6TNZYXFI6LV4LBT8"
)

# Script para preparar y ejecutar la app en un dispositivo Android
# Ubica el script en la raíz del proyecto (login_app) y ejecútalo desde PowerShell.

Write-Host "Usando device id: $DeviceId"

# Asegura que el script se ejecute desde la carpeta donde está ubicado
if ($PSScriptRoot) {
    Set-Location -Path $PSScriptRoot
} else {
    Write-Host "No se pudo determinar la ruta del script; asegúrate de ejecutar desde la carpeta del script."; exit 1
}

Write-Host "Directorio actual: $(Get-Location)"

# Comprobar existencia de AndroidManifest
if (-Not (Test-Path -Path '.\android\AndroidManifest.xml')) {
    Write-Host "android/AndroidManifest.xml no encontrado. Necesario generar soporte de plataforma Android."
    $answer = Read-Host "Ejecutar 'flutter create . --platforms=android'? Esto puede crear archivos de plataforma. Continuar? (y/n)"
    if ($answer -ne 'y') {
        Write-Host "Operación cancelada por el usuario."; exit 1
    }

    Write-Host "Ejecutando: flutter create . --platforms=android"
    flutter create . --platforms=android
    if ($LASTEXITCODE -ne 0) {
        Write-Host "flutter create falló (exit code $LASTEXITCODE). Revisa la salida anterior."; exit $LASTEXITCODE
    }
}

# Instalar dependencias
Write-Host "Ejecutando: flutter pub get"
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "flutter pub get falló (exit code $LASTEXITCODE). Revisa pubspec.yaml y la salida."; exit $LASTEXITCODE
}

# Mostrar dispositivos
Write-Host "Dispositivos disponibles:"
flutter devices

# Ejecutar en el dispositivo seleccionado
Write-Host "Ejecutando la app en el dispositivo $DeviceId"
flutter run -d $DeviceId

exit $LASTEXITCODE
