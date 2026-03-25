---
name: testing
description: Testing strategies and patterns for Unit (Jest) and E2E (Maestro) tests.
license: MIT
metadata:
  author: Facundo Cachan
  version: "1.0"
  scope: [root, ui, logic]
  auto_invoke: "Writing or running tests"
allowed-tools: Read, Edit, Write, Bash, Task
---

# Purpose

---
Testing Skill

**ROLE:**

Eres un QA Automation Engineer experto. Tu objetivo es asegurar la calidad del código mediante una estrategia de testing robusta que combina pruebas unitarias rápidas y pruebas E2E fiables.

**CORE STRATEGY:**

1. **Unit Testing (Jest)**:
    - **Scope**: Funciones puras, utilidades, hooks personalizados y componentes aislados (atoms/molecules).
    - **Objetivo**: Verificar la lógica de negocio y casos borde.
    - **Coverage**: Apunta a >80% en `utils/` y `hooks/`.

2. **E2E Testing (Maestro)**:
    - **Scope**: Flujos de usuario completos (Login, Navegación, Formularios complejos).
    - **Objetivo**: Verificar que la aplicación funciona integrada como lo haría un usuario real.
    - **Simplicidad**: Maestro usa sintaxis YAML simple. Mantén los tests legibles.

---

## Unit Testing with Jest

### Configuration

Asegúrate de que `jest.config.js` esté configurado correctamente para soportar TypeScript y transformaciones de Next.js/React Native si corresponde.

### Writing Unit Tests

**Pattern (AAA - Arrange, Act, Assert):**

```typescript
// utils/sum.test.ts
import { sum } from './sum';

describe('sum utility', () => {
  it('should return correct sum of positive numbers', () => {
    // Arrange
    const a = 5;
    const b = 10;

    // Act
    const result = sum(a, b);

    // Assert
    expect(result).toBe(15);
  });
});
```

**Testing React Components (with React Testing Library):**

```tsx
// components/atoms/Button/Button.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import Button from './index';

describe('Button Component', () => {
  it('renders correctly', () => {
    render(<Button action={() => {}}>Click Me</Button>);
    expect(screen.getByText('Click Me')).toBeInTheDocument();
  });

  it('calls action prop when clicked', () => {
    const handleClick = jest.fn();
    render(<Button action={handleClick}>Click Me</Button>);
    fireEvent.click(screen.getByText('Click Me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });
});
```

---

## E2E Testing with Maestro

Maestro se utiliza para probar flujos móviles o flujos web simulados de manera declarativa. Los tests se definen en archivos `.yaml`.

### Directory Structure

Guarda los flujos de maestro en `.maestro/`.

```markdown
.maestro/
├── login-flow.yaml
├── profile-flow.yaml
└── sanity-check.yaml
```

### Writing Maestro Flows

**Sintaxis Clave:**

- `appId`: ID del paquete de la app.
- `launchApp`: Inicia la aplicación.
- `tapOn`: Simula un toque (por texto o ID).
- `assertVisible`: Verifica que un elemento esté en pantalla.
- `inputText`: Escribe en un campo de texto.

#### Example: Login Flow

```yaml
# .maestro/login-flow.yaml
appId: com.example.app
---
- launchApp

# Verify we are on login screen
- assertVisible: "Login"

# Input credentials
- tapOn: "Email Input"
- inputText: "user@example.com"
- tapOn: "Password Input"
- inputText: "password123"

# Submit
- tapOn: "Sign In"

# Verify successful navigation
- assertVisible: "Dashboard"
- assertVisible: "Welcome, User"
```

### Best Practices for Maestro

1. **Test IDs**: Usa `testID` (React Native) o `data-testid` (Web) para selectores robustos, en lugar de depender solo del texto visible.
2. **Flow Isolation**: Cada archivo YAML debe probar un flujo específico.
3. **Clean State**: Asume que cada test corre en un estado limpio o manéjalo explícitamente (ej: logout al final del test).

---

## Workflow Integration

Cuando se te pida "testear" una funcionalidad:

1. **Analiza la naturaleza del cambio**:
    - ¿Es lógica pura? -> Crea un test de **Jest**.
    - ¿Es un flujo visual o de integración? -> Crea/Actualiza un flujo de **Maestro**.
2. **Ejecuta los tests**:
    - Unitarios: `npm run test` (o `jest`).
    - E2E: `maestro test .maestro/flow_name.yaml`.
