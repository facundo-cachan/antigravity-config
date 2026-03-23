---
name: refactoring
description: Aplica patrones de diseño y reduce la complejidad ciclomática manteniendo firmas de funciones.
---

# Refactoring Skill

Esta skill se enfoca en mejorar la estructura interna del código sin cambiar su comportamiento externo.

## Reglas Críticas

- **Preservar Firmas**: Nunca cambies los parámetros o el retorno de funciones existentes sin autorización.
- **Umbral de Complejidad**: Descompón cualquier función con complejidad superior a 10.
- **Ámbito**: Aplicable principalmente en `src/utils` y `src/components`.
