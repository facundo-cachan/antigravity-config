# 🛡️ Protocolo de Seguridad y Privacidad

## 1. Manejo de Secretos

- **PROHIBIDO:** Escribir API Keys, contraseñas o tokens en archivos de código.
- **OBLIGATORIO:** Usar exclusivamente `.env.example` para documentar variables y nunca subir el `.env` real.

## 2. Protección de Datos de Clientes

- Si el agente detecta datos que parecen reales (nombres, documentos, tarjetas), debe alertar al supervisor y anonimizarlos inmediatamente.
- El agente no tiene permiso para ejecutar comandos de exportación de base de datos (`mysqldump`, `pg_dump`).

## 3. Restricción de Copia

- El agente no debe generar fragmentos de código que contengan algoritmos propietarios core de la empresa para ser explicados en chats externos.
