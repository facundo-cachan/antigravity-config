---
name: ui-components
description: >
  UI components patterns and best practices.
  Trigger: When creating or modifying UI components, pages, or layouts.
license: MIT
metadata:
  author: Facundo Cachan
  version: "2.0"
  scope: [root, ui]
  auto_invoke: "Creating or modifying UI components"
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, WebFetch, WebSearch, Task
---

# Purpose

This project follows a strict **Atomic Design** system. All UI elements must use the components provided in `@/components` instead of raw HTML elements when possible.

## Directory Structure

```markdown
components/
├── atoms/          # Basic building blocks (Button, Input, Text, View)
├── molecules/      # Combinations of atoms (Cards, Banners, Headers)
├── organisms/      # Complex sections (Navbar, Forms, Sidebar)
├── templates/      # Page layouts (DashboardLayout, AuthLayout)
└── types.ts        # Shared type definitions
```

## Core Principles

1. **Composition over Inheritance**: Build complex UIs by composing smaller components.
2. **Semantic HTML**: The `View` and `Text` atoms are polymorphic and must be used to generate semantic tags (`section`, `article`, `h1`, `label`).
3. **Compound Components**: For complex structures (like Tables or Modals), use the Compound Component pattern (`Table.Row`, `Table.Cell`) to allow flexibility.
4. **Strict Typing**: All props must be typed. Export types from `components/types.ts`.

## Critical Styling Rules (via Tailwind 4)

1. **No Hardcoded Hex**: Use semantic colors (`bg-primary`, `text-n600`) from the theme.
2. **No `var()` in className**: Tailwind utilities must be static. Dynamic variables go in `style`.
3. **Responsive First**: Use mobile-first prefixes (`md:`, `lg:`) for responsive designs.
4. **Dark Mode**: Use `dark:` prefix for dark mode variants.
5. **Class Merging**: Always use `cn()` (or `styleText`/`className` props in atoms) to merge classes cleanly.

## Component Usage Guide

### Basics (Atoms)

#### View (Layout)

The universal container. Replaces `div`, `section`, `main`, etc.

```tsx
<View type="section" className="flex flex-col gap-4 p-4">
  <View type="article" className="rounded-lg shadow">
    {/* content */}
  </View>
</View>
```

### Text (Typography)

The universal text renderer. Replaces `h1`-`h6`, `p`, `span`, `label`.

```tsx
<Text type="h1" className="text-2xl font-bold">
  Page Title
</Text>
<Text type="p" className="text-sm">
  Description text...
</Text>
```

### Button & ButtonIcon

Use `ButtonIcon` for most interactive elements.

```tsx
<ButtonIcon
  action={() => save()}
  left="save:fa:solid" // Icon format: name:source:style
  className="bg-primary text-white"
>
  Save Changes
</ButtonIcon>
```

## Structural (Molecules & Organisms)

### Cards

for listing items or summaries.

```tsx
<Card
  title="Product Name"
  subtitle="In Stock"
  image="/img/product.jpg"
  footer="$29.99"
/>
```

### Tables (Compound Pattern)

Use for data grids.

```tsx
<Table id="users-grid">
  <Table.Header>
    <Table.Row>
      <Table.Cell type="th">Name</Table.Cell>
      <Table.Cell type="th">Role</Table.Cell>
    </Table.Row>
  </Table.Header>
  <Table.Body>
    <Table.Row>
      <Table.Cell>John Doe</Table.Cell>
      <Table.Cell>Admin</Table.Cell>
    </Table.Row>
  </Table.Body>
</Table>
```

### Forms (Configuration Driven)

For data entry. Prefer config-based rendering over manual input layout.

```tsx
<Forms
  id="login-form"
  title="Login"
  action={handleLogin}
  inputs={{
    data: [
      { name: "email", type: "email", label: "Email" },
      { name: "password", type: "password", label: "Password" }
    ]
  }}
  submit={{ children: "Sign In" }}
/>
```

### Modals

Use the simplified Modal molecule.

```tsx
<Modal
  isOpen={isOpen}
  title="Confirm Action"
  description="Are you sure?"
  onClose={() => setIsOpen(false)}
>
  <View className="flex justify-end gap-2">
    <Button action={cancel}>Cancel</Button>
    <Button action={confirm} className="bg-red-500 text-white">Delete</Button>
  </View>
</Modal>
```

## Icon System

Icons strings follow the format: `name:source:style:size` or `name`.

- **Sources**: `fa` (FontAwesome), `bx` (Boxicons).
- **Styles**: `solid`, `regular`, `brands`.
- **Sizes**: `1x`, `2x`, `3x` to `10x` (biggest).

Example: `"user:fa:solid:lg"` or `"home:bx"`.

## Best Practices Checklist

- [ ] Am I using `View` and `Text` instead of `div`/`span`?
- [ ] Are colors using the semantic theme (`primary`, `black`, `-`n900`)?
- [ ] Is `darkMode` supported via `dark:` classes?
- [ ] Are lists rendered using `map` with unique `key`s?
- [ ] Are complex states managed outside the visual layer (e.g. in Hooks)?

## Good Practices & Considerations

### Component Syntax

If the component is of type:

```tsx
const ComponentName = () => {
  return (<ComponentType />)
};
```

It must be:

```tsx
const ComponentName = (): JSX.Element => (<ComponentType />);
```

### Component Props

The text must always be wrapped by the `<Text />` component, never if it is.

### Effects

For web apps, use `./gsap/SKILL`
For mobile apps, use [Reanimated](https://docs.swmansion.com/react-native-reanimated/)
