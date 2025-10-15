Param(
    [string]$SourcePath
)

# Script para copiar una imagen al directorio assets/images del proyecto
# Uso:
# 1) Ejecutar desde la carpeta del proyecto: Set-Location -Path '...\login_app'
# 2) Ejecutar el script pasando la ruta de la imagen:
#    .\copy_logo_to_assets.ps1 -SourcePath 'C:\Users\cesar\Downloads\miLogo.png'
#  O sin parámetro para que te pida la ruta:
#    .\copy_logo_to_assets.ps1

if ($PSScriptRoot) {
    Set-Location -Path $PSScriptRoot
}

$assetsDir = Join-Path $PSScriptRoot 'assets\images'
if (-Not (Test-Path -Path $assetsDir)) {
    New-Item -ItemType Directory -Path $assetsDir -Force | Out-Null
}

if (-Not $SourcePath) {
    Write-Host "Introduce la ruta completa al archivo de imagen (ej: C:\Users\cesar\Downloads\logo.png) o arrastra el archivo aquí y presiona Enter:" -ForegroundColor Yellow
    $SourcePath = Read-Host "Ruta de origen"
}

if (-Not (Test-Path -Path $SourcePath)) {
    Write-Error "Archivo no encontrado: $SourcePath"
    exit 1
}

$dest = Join-Path $assetsDir 'logo_app.png'

try {
    Copy-Item -Path $SourcePath -Destination $dest -Force
    Write-Host "Imagen copiada a: $dest" -ForegroundColor Green
    # Abrir la carpeta en el Explorador de Windows
    Start-Process explorer.exe -ArgumentList "$assetsDir"
} catch {
    Write-Error "Error al copiar la imagen: $_"
    exit 1
}

exit 0
