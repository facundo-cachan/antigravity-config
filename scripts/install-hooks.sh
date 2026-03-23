#!/bin/bash
# .antigravity/scripts/install-hooks.sh

echo "🛠 Instalando Hooks de Seguridad..."

# Verificar si TruffleHog está instalado
if ! command -v trufflehog &> /dev/null
then
    echo "⚠️ TruffleHog no encontrado. Instalando vía Brew..."
    brew install trufflehog
fi

# Crear el archivo pre-commit
cat <<EOF > .git/hooks/pre-commit
#!/bin/bash
echo "🔍 Escaneando secretos con TruffleHog..."
trufflehog git file://. --since-commit HEAD --fail
if [ \$? -ne 0 ]; then
    echo "❌ ERROR: Se detectaron secretos. El commit ha sido bloqueado."
    exit 1
fi
echo "✅ Seguridad validada."
EOF

chmod +x .git/hooks/pre-commit
echo "🚀 Pre-commit hook instalado con éxito."