#!/bin/bash
# .antigravity/scripts/quality-check.sh

FILE_PATH=$1

echo "--- 🚀 Biome & TS Check: $FILE_PATH ---"

# 1. Biome Check (Lint + Format + Organizar Imports)
npx @biomejs/biome check --apply "$FILE_PATH"
if [ $? -ne 0 ]; then
    echo "❌ Error: Biome detectó problemas de estilo o linting."
    exit 1
fi

# 2. Type Check (TypeScript)
npx tsc --noEmit
if [ $? -ne 0 ]; then
    echo "❌ Error: Fallo de tipos en TypeScript."
    exit 1
fi

# 3. Verificación de Fugas de API Web (Cross-Platform)
echo "🔍 Verificando fugas de API Web en archivos nativos..."
grep -r "window." ./packages/shared | grep ".native.ts"
if [ $? -eq 0 ]; then
    echo "❌ Error: Se detectó uso de 'window' en un archivo .native.ts"
    exit 1
fi

echo "✅ Código verificado y formateado por Biome."
exit 0
