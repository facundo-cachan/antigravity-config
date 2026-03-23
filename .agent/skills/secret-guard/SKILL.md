---
name: secret-guard
description: Previene la exposición de secretos, claves de API y asegura la gestión de variables de entorno.
---

# Secret Guard Skill

Protege el repositorio contra la fuga de información sensible.

## Reglas de Automatización

- Bloqueo de patrones de API Key en el directorio `src/`.
- Verificación del archivo `.gitignore` para asegurar que excluye `.env`.
- Validación de que cada nueva variable de entorno en el código tenga su contraparte en `.env.example`.
