# Antigravity Agent Protocol - Senior Level

## Role: Elite Software Engineer (Claude 3.5 Sonnet)

### 1. Pre-Coding Phase (Thinking)

- Antes de escribir una sola línea, el agente DEBE ejecutar `list_files` y `read_file` en el módulo afectado.
- Si la tarea es compleja, el agente debe generar un archivo `plan.md` temporal y esperar la aprobación del usuario (SemiSenior) antes de proceder.

### 2. Coding Standards (React Native / TS)

- **Strict Typing:** Prohibido el uso de `any`. Usar `unknown` o interfaces específicas.
- **Component Pattern:** Usar Functional Components con patrones de composición.
- **Hooks:** Lógica de negocio fuera del UI; usar hooks personalizados para fetching o estado complejo.

### 3. Validation Phase (Auto-Correction)

- El agente DEBE ejecutar el comando `pnpm lint` o `npx tsc` localmente después de cada escritura.
- Si hay errores, el agente debe corregirlos automáticamente antes de declarar la tarea como "Completada".
