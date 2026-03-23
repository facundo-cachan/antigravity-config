# 🏛 Guía de Estilo y Estándares Senior - [Tu Empresa]

Este documento es la referencia obligatoria para el Agente (Claude 3.5 Sonnet). Todo código generado que no cumpla con estos puntos será considerado "fallido" en la etapa de validación.

---

## 1. Arquitectura y Estructura

- **Clean Architecture:** Separar claramente la lógica de negocio (Hooks/Services) de la UI (Components).
- **Componentes:** Un archivo por componente. Los estilos (StyleSheet) deben vivir al final del mismo archivo o en un `.styles.ts` adyacente si superan las 50 líneas.
- **Naming:** - Componentes y Interfaces: `PascalCase`.
  - Funciones y Variables: `camelCase`.
  - Archivos de componentes: `ComponentName.tsx`.

## 2. TypeScript (Strict Mode)

- **Cero 'any':** El uso de `any` está estrictamente prohibido. Si el tipo es desconocido, usar `unknown` y estrechar el tipo (type narrowing).
- **Interfaces vs Types:** Usar `interface` para definiciones de objetos públicos y `type` para uniones o transformaciones complejas.
- **Prop-types:** Definir siempre la interfaz `Props` para cada componente.

## 3. React Native & Performance

- **Hooks:** Utilizar `useCallback` en todas las funciones que se pasen como props a componentes hijos para evitar re-renders.
- **Memoización:** Usar `React.memo` en componentes de listas o componentes pesados solo después de identificar un cuello de botella.
- **Imágenes:** Siempre incluir `accessibilityLabel` y usar `resizeMode="cover"` por defecto.
- **Safe Area:** Todo layout principal debe respetar el `SafeAreaView` o usar el hook de `react-native-safe-area-context`.

## 4. Gestión de Estado y Datos

- **Context API:** Usar para estado global simple (Temas, Auth).
- **Hooks Personalizados:** Toda lógica de fetching (usando TanStack Query o similar) debe estar encapsulada en un hook `useSomething.ts`.
- **Inmutabilidad:** Prohibido mutar estados directamente; usar siempre el set del useState o reducers.

## 5. Manejo de Errores y Logs

- **Estrategia:** Implementar `try/catch` en todas las operaciones asíncronas.
- **Feedback:** El usuario siempre debe recibir una respuesta visual ante un error (no solo un `console.log`).

---

## 6. Checklist de Validación para el Agente

Antes de reportar una tarea como completada, el agente debe verificar:

1. [ ] ¿El código pasa el `quality-check.sh`?
2. [ ] ¿Se han eliminado los `console.log` de debug?
3. [ ] ¿Se han definido correctamente los tipos de TS?
4. [ ] ¿El código sigue la estructura de carpetas existente?

## 7. Librería de Componentes y Código Compartido (Universal)

- **Componentes Core:** Se prohíbe el uso de primitivas nativas (`<View>`, `<Text>`, `<div>`) directamente si existe un equivalente en nuestra librería personalizada `@tu-empresa/ui-core`.
- **Shared Logic:** La lógica de negocio (validaciones, estados, hooks) debe residir en la carpeta `/packages/shared` o `/shared-logic` para garantizar paridad entre Web y Mobile.
- **Plataformas:** Si un componente requiere comportamiento específico por plataforma, usar la extensión `.native.tsx` o `.web.tsx`, o bien el condicional `Platform.OS`.
- **Documentación:** El agente debe consultar el archivo `COMPONENT_DOCS.md` (o Storybook) antes de implementar un componente para usar las `props` correctas.

## 8. Diseño con Pencil.dev

- Cuando se reciba un link o referencia de Pencil, el agente debe priorizar la jerarquía de componentes visuales definida en el diseño.
- Si Pencil propone un componente que no existe en nuestra librería compartida, el agente tiene permiso para crear el componente en /packages/ui-core, documentarlo mínimamente y luego usarlo.
- Se debe mantener la paridad de tokens de diseño (colores, espaciados) entre Pencil y nuestro tema de la librería.

## 9. Reglas de Divergencia (Web vs Mobile)

- **Prohibido:** Usar `Platform.OS === 'web'` dentro del render principal si el componente se vuelve difícil de leer.
- **Preferencia:** Inyectar la diferencia vía Props desde el componente padre o usar el patrón de "Adapter".
- **Interacciones:** - Mobile: Usar gestos, feedback háptico y navegación por stack.
  - Web: Usar estados de `hover`, punteros de mouse y navegación por URL (Search Params).
- **Librerías:** Si una librería no es compatible con ambas, el agente debe crear un "Stub" o "Mock" para la plataforma no soportada para evitar errores de compilación.

## 10. Protocolo de Secretos

> "Antes de pushear, es recomendable correr TruffleHog localmente. Si el pipeline falla por un 'Secret Detected', no intentes borrarlo con un nuevo commit; debes hacer un git rebase para eliminar el secreto del historial del commit afectado."

## 11. Protocolo de Seguridad

> "El desarrollo deberá realizarse exclusivamente en el entorno virtual (VDI/Codespaces) proporcionado por la Empresa. La extracción de código mediante copiado manual, capturas de pantalla o exportación de archivos sin autorización previa será considerada una falta grave y causal de rescisión inmediata del contrato."

---
