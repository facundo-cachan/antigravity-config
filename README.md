# 🚀 Agentic Stack: Guía de Operaciones (Universal Architecture)

Este repositorio utiliza un flujo de trabajo **AI-First** optimizado para **Antigravity + Claude 3.5 Sonnet**. El objetivo es que la IA actúe como un **Senior Principal Engineer**, permitiendo que el desarrollador humano se enfoque en la validación arquitectónica y lógica de negocio.

## 🛠 El Stack Tecnológico

* **Orquestador:** Antigravity IDE (Engine: Claude 3.5 Sonnet).
* **Validación:** [BiomeJS](https://biomejs.dev/) (Lint/Format en Rust) + TypeScript Strict.
* **Diseño:** [Pencil.dev](https://www.pencil.dev/) (Design-to-Code Context).
* **Arquitectura:** React Native Universal (Compartido Web/Mobile).

---

## 🤖 Cómo trabajar con los Agentes

Para obtener resultados de nivel Senior, no des instrucciones ambiguas. Sigue este protocolo:

### 1. El Flujo de Trabajo (Workflow)

1. **Misión:** Proporcionas la tarea y el contexto de Pencil (JSON/Link).
2. **Planificación:** El agente genera un plan técnico. **Revísalo antes de que escriba código.**
3. **Ejecución:** El agente desarrolla en la librería compartida (`packages/ui-core`).
4. **Auto-Corrección:** El agente ejecuta `quality_check` (Biome + TS). Si falla, se corrige solo.
5. **Validación Humana:** El desarrollador SemiSenior aprueba el Pull Request final.

### 2. Estrategias de Código Compartido (Divergencia)

Priorizamos la reutilización total. Si un componente o lógica debe variar entre Web y Mobile, usamos la **Estrategia de Extensiones**:

* `Logic.ts` / `Component.tsx` -> **Código 100% Compartido.**
* `Logic.web.ts` / `Component.web.tsx` -> **Implementación específica para Browser.**
* `Logic.native.ts` / `Component.native.tsx` -> **Implementación específica para iOS/Android.**

---

## 📐 Reglas de Oro para el Agente (Style Guide)

El agente tiene instrucciones estrictas en `.antigravity/style-guide.md`:

* **Prohibido el uso de `any`.**
* **Uso obligatorio de Componentes Core:** No usar `View` o `div` nativos si existe un componente en `@tu-empresa/ui-core`.
* **Inmutabilidad:** Siempre usar patrones funcionales y hooks.

---

## 🆘 Troubleshooting: Manejo de Bucles y Errores

Si el agente entra en un bucle de error, el desarrollador humano debe intervenir como **Pilot**:

| Problema | Causa Probable | Acción Correctiva |
| --- | --- | --- |
| **Linting Loop** | Conflicto de Biome. | *"Ignora la regla con `// biome-ignore` y justifica."* |
| **Fuga de Contexto** | API Web en Native. | *"Mueve la lógica de `window` a un archivo `.web.ts`."* |
| **Alucinación** | Index desactualizado. | *"Ejecuta `check_shared_library` para refrescar contexto."* |
| **Desvío de Diseño** | Mala lectura de Pencil. | *"Ajusta los tokens de color según la `style-guide.md`."* |

---

## 🚦 Comandos del Entorno

* **Validar Calidad:** `bash .antigravity/scripts/quality-check.sh [archivo]`
* **Chequeo Biome:** `npx @biomejs/biome check --apply [archivo]`
* **Limpiar Caché:** `npx tsc --build --clean`

---

## 💡 Nota para el Desarrollador (The Pilot)

Tu rol ha evolucionado. Ya no eres un "picacodigo", eres un **revisor de calidad y arquitecto**. Si el agente comete un error repetitivo, no lo arregles a mano en el código: **arregla el System Prompt o la Style Guide.** Así, el error no volverá a ocurrir nunca más.

---

### ¿Qué sigue?

Luego de clonar el repo, ejecuta:

```bash
bash .antigravity/scripts/install-hooks.sh
```
