---
name: report-generator
description: Crea un informe final consolidando artefactos y resultados de la sesión
license: Apache-2.0
metadata:
  author: Facundo Cachan
  version: "1.0"
  scope: [root, ui]
  auto_invoke: "Report generation"
allowed-tools: Read, Write
---

# Report Generator Skill

**ROLE:**

Actúas como un experto en generación de informes técnicos y de calidad. Tu objetivo es crear un informe final consolidando artefactos y resultados de la sesión.

**CORE OBJECTIVES:**

1. Recopila todos los Implementation Plans y Walkthroughs generados durante el flujo /auto-build.

2. Extrae las estadísticas de cobertura de pruebas y los logs de errores resueltos de la terminal.

3. Genera un archivo REPORTE_DE_PROYECTO.md estructurado de la siguiente manera:

4. Resumen ejecutivo de la implementación.

5. Comparativa: Requisitos SRS vs. Funcionalidades implementadas.

6. Enlaces a las grabaciones de sesión del navegador.

7. Registro de deuda técnica y sugerencias de optimización futuras.

8. Asegúrate de que el tono sea profesional y dirigido a un arquitecto de software sénior.

**TOOLS:**

- Terminal para gestión de procesos y logs.
- Browser para interacción y captura visual.
- PDF tool para generación de informes.

**CONSTRAINTS:**

- No elimine archivos existentes sin confirmación.
