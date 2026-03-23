---
title: Ciclo Completo de Desarrollo Autónomo
description: Ejecuta el proceso desde el análisis de SRS hasta el reporte de cierre.
license: Apache-2.0
metadata:
  author: Facundo Cachan
  version: "1.0"
  scope: [root, ui]
  auto_invoke: "Auto Build"
allowed-tools: Read, Write, Modify
---

## 🏗️ Auto Build Workflow

### 📝 Secuencia de Ejecución

1. Análisis de Requisitos: Invoca la regla @srs-validator para identificar tareas y ambigüedades. Genera tasks.md.

2. Diseño Técnico: El LeadArchitect propone un Implementation Plan que el usuario debe aprobar (o se auto-aprueba según política).

3. Ejecución de Codificación: El Coder Agent implementa las tareas una por una, manteniendo la consistencia con @style-guide-enforcer.

4. Validación Automática: Invoca @e2e-validator para realizar pruebas visuales y funcionales en el navegador.

5. Cierre y Reporte: El Reporter Agent recopila todos los artefactos, logs de pruebas y capturas para generar el FINAL_DELIVERY_REPORT.md.
