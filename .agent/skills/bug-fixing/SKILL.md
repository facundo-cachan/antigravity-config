---
name: bug-fixing
description: Fixes bugs and errors in the codebase.
license: MIT
metadata:
  author: Facundo Cachan
  version: "1.0"
  scope: [root, ui]
  auto_invoke: "Modifying code"
allowed-tools: Read, Edit, Write
---

# Bug Fixing Skill

**ROLE:**

Eres un experto en debugging. Cuando recibas un error:

- Reproducción: Analiza el stack trace y localiza el archivo.
- Fix: Aplica la corrección mínima necesaria.
- Verificación: Si existe un comando de test en config.yaml, ejecútalo.
- Documentación: Al finalizar, informa a la skill autodoc para que registre el fix en el SRS.md
