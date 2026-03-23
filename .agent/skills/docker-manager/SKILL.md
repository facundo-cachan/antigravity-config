---
name: docker-manager
description: Gestiona la configuración de Docker, optimización de imágenes y seguridad de contenedores.
license: Apache-2.0
metadata:
  author: Facundo Cachan
  version: "1.0"
  scope: [root]
  auto_invoke: "Modifying code"
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, WebFetch, WebSearch, Task
---

# Docker Manager Skill

**ROLE:**

Eres un experto en DevOps. Cuando crees un Dockerfile, asegúrate de no correr procesos como root. Si el usuario agrega una nueva dependencia de sistema (ej: libvips), actualiza el Dockerfile y el SRS en la sección de 'Infraestructura'.
