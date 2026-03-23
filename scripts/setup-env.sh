#!/bin/bash
# .antigravity/scripts/setup-env.sh

echo "🏗️ Configurando entorno virtual de desarrollo..."

# 1. Instalar dependencias del proyecto
npm install

# 2. Instalar TruffleHog para escaneos locales
curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b /usr/local/bin

# 3. Instalar BiomeJS globalmente (para velocidad)
npm install -g @biomejs/biome

# 4. Instalar los Git Hooks de seguridad
bash .antigravity/scripts/install-hooks.sh

# 5. Copiar config
cp ~/.antigravity/ORCHESTRATOR.md ~/.gemini/extensions/base-orchestrator
cp -R ~/.antigravity/agents ~/.gemini/extensions

echo "✅ Entorno listo. Antigravity está operativo."
exit 0