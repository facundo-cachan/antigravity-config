# .antigravity/scripts/update-others.sh

# Función para sincronizar directorios (Skills)
sync_skills() {
  local target_dir=$1
  echo "📂 Sincronizando Skills en $target_dir..."
  mkdir -p "$target_dir"
  cp -R ~/.antigravity/.agent/skills/* "$target_dir/" 2>/dev/null || echo "⚠️ No se encontraron skills para copiar."
}

# Función para sincronizar el Orquestador (Agents)
sync_agents() {
  local target_file=$1
  echo "🤖 Sincronizando Orquestador en $target_file..."
  mkdir -p "$(dirname "$target_file")"
  cp ~/.antigravity/ORCHESTATOR.md "$target_file" 2>/dev/null || echo "⚠️ No se encontró ORCHESTATOR.md."
}

# Función para actualizar mcpServers en Gemini settings.json
update_gemini_mcp() {
  local settings_file="$HOME/.gemini/settings.json"
  local mcp_config="$HOME/.antigravity/mcp_config.json"
  
  if [ ! -f "$mcp_config" ]; then
    echo "❌ No se encontró mcp_config.json"
    return 1
  fi

  echo "⚙️ Actualizando MCP Servers en Gemini..."
  
  # Usamos jq para extraer mcpServers de antigravity e insertarlos/reemplazarlos en gemini settings
  # Mantiene el resto de la configuración intacta.
  if [ -f "$settings_file" ]; then
    local tmp_file=$(mktemp)
    jq --slurpfile config "$mcp_config" '.mcpServers = $config[0].mcpServers' "$settings_file" > "$tmp_file" && mv "$tmp_file" "$settings_file"
  else
    echo "⚠️ No se encontró settings.json, creando uno nuevo..."
    mkdir -p "$(dirname "$settings_file")"
    jq '{mcpServers: .mcpServers}' "$mcp_config" > "$settings_file"
  fi
}

echo "🏗️ Sincronizando SKILLs..."
sync_skills "$HOME/.codex/skills"
sync_skills "$HOME/.gemini/skills"
sync_skills "$HOME/.claude/skills"

echo "🏗️ Sincronizando Agents..."
sync_agents "$HOME/.codex/agents.md"
sync_agents "$HOME/.gemini/GEMINI.md"
sync_agents "$HOME/.claude/CLAUDE.md"

echo "🏗️ Sincronizando MCP Servers..."
update_gemini_mcp

# TODO Dividir los `mcpServers` en ~/.antigravity/mcp_config.json segun cada CLI
# Para claude, dividir los `mcpServers` en ~/.antigravity/mcp_config.json y crear un file, con el nomnbre del id, en ~/.claude/mcp

echo "✅ Entorno listo y operativo."
exit 0