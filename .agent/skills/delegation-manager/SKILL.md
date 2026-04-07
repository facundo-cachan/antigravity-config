---
description: Gestiona el ciclo de vida de sub-agents: consulta estado por nombre y cancela delegaciones en curso.
---

# Delegation Manager

## Overview

Skill para consultar el estado de sub-agents por nombre y cancelar delegaciones en curso.

**Limitación crítica**: OpenCode v1.3.15 **NO tiene** `delegation_cancel`, `delegation_kill` ni ninguna herramienta nativa de cancelación. El PR [#13924](https://github.com/anomalyco/opencode/pull/13924) que agrega cancelación individual está **abierto sin merge**.

## Sub-Agents Registrados (agent.yaml)

| Name | Role | Model | Tools |
| ------ | ------ | ------- | ------- |
| Designer | UI/UX y percepción visual | gemini-3-pro-high | browser |
| Coder | Full-Stack + Testing | gemini-3-flash | code_editor, terminal |
| Reporter | Documentación y Verificación | gemini-3-pro-low | code_editor, pdf |

## Consultar Estado por Nombre de Agent

### Algoritmo

```markdown
1. delegation_list() → obtener todas las delegaciones
2. Filtrar por agent name (case-insensitive partial match)
3. Para cada match, delegation_read(id) → obtener detalles
4. Devolver: status, prompt, agent, started_at
```

### Estados posibles de `delegation_list`

| Estado | Significado |
| -------- | ------------- |
| `running` | Delegación activa en ejecución |
| `completed` | Terminó exitosamente |
| `failed` | Terminó con error |

### Ejemplo de uso

Cuando el usuario pregunta "cómo va Designer?" o "estado del Coder":

1. Llamar `delegation_list()` para obtener todas las delegaciones
2. Buscar delegaciones donde el agent name contenga "Designer", "Coder", etc.
3. Para cada delegación matching, llamar `delegation_read(id)` para obtener el resultado
4. Si status es `running`, informar que aún está en ejecución con el prompt asignado
5. Si status es `completed`, devolver el resultado
6. Si status es `failed`, devolver el error

### Workaround: Archivo de estado compartido

Como `delegation_list` no expone el agent name directamente en todos los casos, usar un patrón de naming convention en los prompts:

```markdown
[AGENT:Designer] Tu tarea aquí...
[AGENT:Coder] Tu tarea aquí...
```

Esto permite filtrar delegaciones por agent name buscando el prefijo en el prompt.

## Cancelar Delegación (Workaround)

### Limitación

**NO existe cancelación nativa** en OpenCode v1.3.15. Las únicas formas de detener una delegación son:

1. **Cerrar la aplicación** (mata todas las delegaciones — NO recomendado)
2. **Esperar a que termine** (puede desperdiciar tokens y tiempo)

### Workaround: Archivo de señal (kill-flag)

Implementar un mecanismo de archivo de señal que el sub-agent verifica periódicamente:

```
1. Crear archivo: /tmp/opencode-kill-{delegation_id}
2. El sub-agent debe verificar la existencia del archivo antes de cada acción costosa
3. Si el archivo existe, el sub-agent termina limpiamente
4. El orquestador limpia el archivo después
```

#### Implementación del kill-flag

**Para el orquestador** (cuando quiere cancelar):

```bash
# Crear señal de cancelación
touch /tmp/opencode-kill-{delegation_id}
```

**Para el sub-agent** (verificar antes de cada acción costosa):

```bash
# Verificar si fue cancelado
if [ -f "/tmp/opencode-kill-{delegation_id}" ]; then
  echo "CANCELLED: Delegación cancelada por el orquestador"
  exit 0
fi
```

#### Prompt template para sub-agents con soporte de cancelación

Al lanzar una delegación, incluir estas instrucciones:

```markdown
IMPORTANTE: Antes de cada acción que tome más de 5 segundos, verificá si existe
el archivo /tmp/opencode-kill-{delegation_id}. Si existe, terminá inmediatamente
con el mensaje "CANCELLED: Delegación cancelada por el orquestador".
```

### Alternativa: Timeout en delegaciones

Para tareas que no requieren interacción, usar timeout en el prompt:

```markdown
Tenés 60 segundos para completar esta tarea. Si no podés terminarla en ese
tiempo, pará y devolvé lo que tengas hasta ahora.
```

## Flujo Completo

### Consultar estado

```markdown  
Usuario: "cómo va Designer?"
  → delegation_list()
  → Filtrar por [AGENT:Designer] en prompts
  → delegation_read(id) para cada match
  → Resumir estado al usuario
```

### Cancelar tarea

```markdown
Usuario: "cancelá al Coder"
  → delegation_list()
  → Identificar delegación running del Coder
  → touch /tmp/opencode-kill-{delegation_id}
  → Confirmar cancelación al usuario
  → (Opcional) delegation_read(id) para verificar que terminó
  → rm /tmp/opencode-kill-{delegation_id}
```

## Referencias

- Issue: [anomalyco/opencode#13916](https://github.com/anomalyco/opencode/issues/13916) — Feature request de cancelación
- PR: [anomalyco/opencode#13924](https://github.com/anomalyco/opencode/pull/13924) — Implementación pendiente de merge
- Issue: [anomalyco/opencode#5887](https://github.com/anomalyco/opencode/issues/5887) — True async delegation
