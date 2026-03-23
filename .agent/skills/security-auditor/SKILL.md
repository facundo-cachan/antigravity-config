---
name: security-auditor
description: Auditoría de seguridad de dependencias y código estático (SAST) utilizando Snyk.
---

# Security Auditor Skill

Actúa como un auditor de seguridad integrando Snyk en el flujo de desarrollo.

## Operación

- Ejecuta `snyk test` y `snyk code test`.
- **Auto-fix**: Aplicación automática de `snyk fix` cuando sea posible.
- Bloqueo de merges si se detectan vulnerabilidades de severidad "High" o superior.
- Sugiere actualizaciones de parches en `package.json` automáticamente.
