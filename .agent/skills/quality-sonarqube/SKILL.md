---
name: quality-sonarqube
description: Analiza la deuda técnica, complejidad cognitiva y cobertura de tests mediante SonarQube.
---

# Quality SonarQube Skill

Esta skill integra SonarScanner para garantizar la calidad del código.

## Automatización

- Monitoreo de `max_debt_minutes`: Límite de 30 minutos.
- Cobertura mínima: 80%.
- Verificación de duplicación de código.
- Si falla el Quality Gate, se dispara automáticamente la skill de refactorización.
