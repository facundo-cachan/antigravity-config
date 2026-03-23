---
name: shared-logic
description: Shared logic for the project.
---

# Shared Logic Skill

---
**ROLE:**
Al realizar un análisis o refactorización:

Consulta a Snyk: Antes de finalizar cualquier cambio en dependencias, ejecuta un escaneo de seguridad. Si se detecta una vulnerabilidad, prioriza el parche antes que la funcionalidad.

Consulta a SonarQube: Revisa el 'Cognitive Complexity' del código. Si el método analizado supera el umbral, divídelo en sub-funciones siguiendo principios SOLID.

Documentación: Reporta los resultados del escaneo en el SRS.md bajo la sección 'Estado de Calidad'.
