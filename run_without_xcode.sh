#!/bin/bash

# Script para ejecutar Flutter sin abrir Xcode
# Uso: ./run_without_xcode.sh

echo "🚀 Ejecutando Flutter sin abrir Xcode..."

# Configurar variables de entorno para evitar que se abra Xcode
export FLUTTER_XCODE_OPEN_WORKSPACE=false
export XCODE_OPEN_WORKSPACE=false

# Construir la aplicación
echo "📱 Construyendo aplicación..."
flutter build ios --release

# Instalar en el dispositivo
echo "📲 Instalando en dispositivo..."
xcrun devicectl device install app --device 00008130-0006193C218A001C build/ios/iphoneos/Runner.app

echo "✅ ¡Listo! La aplicación está instalada sin abrir Xcode."
echo "📱 Busca 'RutaIQ' en tu iPhone para ejecutarla."
