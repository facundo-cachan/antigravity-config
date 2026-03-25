---
name: recoil
description: >
  Recoil state management patterns (v0.7.7).
  Trigger: When implementing client-side state with Recoil (atoms, selectors, atom effects, useRecoilState).
license: MIT
metadata:
  author: Facundo Cachan
  version: "1.0"
  scope: [root, ui]
  auto_invoke: "Using Recoil atoms/selectors"
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, WebFetch, WebSearch, Task
---

# Setup

```typescript
// app/providers.tsx
"use client";

import { RecoilRoot } from "recoil";

export default function Providers({ children }: { children: React.ReactNode }) {
  return <RecoilRoot>{children}</RecoilRoot>;
}
```

## Atoms (Basic State)

Atoms are units of state. Updateable and subscribable.

```typescript
// stores/counter.ts
import { atom } from "recoil";

export const counterState = atom({
  key: "Counter", // Unique ID (with respect to other atoms/selectors)
  default: 0,     // Default value (aka initial value)
});

// Component Usage
import { useRecoilState } from "recoil";
import { counterState } from "./stores/counter";

function Counter() {
  const [count, setCount] = useRecoilState(counterState);

  return (
    <div>
      Count: {count}
      <button onClick={() => setCount(c => c + 1)}>Increment</button>
    </div>
  );
}
```

## Selectors (Derived State)

Pure functions that calculate state based on atoms or other selectors.

```typescript
// stores/charCount.ts
import { selector } from "recoil";
import { textState } from "./textAtom";

export const charCountState = selector({
  key: "CharCount",
  get: ({ get }) => {
    const text = get(textState);
    return text.length;
  },
});

// Component Usage
import { useRecoilValue } from "recoil";

function CharacterCount() {
  const count = useRecoilValue(charCountState); // Read-only
  return <>Character Count: {count}</>;
}
```

## Asynchronous Data Queries

Recoil handles async data naturally via selectors. Suspense is supported by default.

```typescript
// stores/user.ts
import { selector, atom } from "recoil";

const currentUserIdState = atom({
  key: "CurrentUserId",
  default: 1,
});

export const currentUserInfoQuery = selector({
  key: "CurrentUserInfo",
  get: async ({ get }) => {
    const userId = get(currentUserIdState);
    const response = await fetch(`/api/users/${userId}`);
    if (response.error) {
      throw response.error;
    }
    return response.json();
  },
});

// Component Usage
function UserInfo() {
  const userInfo = useRecoilValue(currentUserInfoQuery);
  return <div>{userInfo.name}</div>;
}

// Parent must wrap in Suspense
// <Suspense fallback={<div>Loading...</div>}>
//   <UserInfo />
// </Suspense>
```

## Atom Effects (Persistence & Logging)

Atom effects are used to manage side-effects (like syncing with localStorage).

```typescript
import { atom, AtomEffect } from "recoil";

const localStorageEffect = (key: string): AtomEffect<any> => ({ setSelf, onSet }) => {
  if (typeof window !== "undefined") {
    const savedValue = localStorage.getItem(key);
    if (savedValue != null) {
      setSelf(JSON.parse(savedValue));
    }

    onSet((newValue, _, isReset) => {
      isReset
        ? localStorage.removeItem(key)
        : localStorage.setItem(key, JSON.stringify(newValue));
    });
  }
};

export const themeState = atom({
  key: "Theme",
  default: "light",
  effects: [
    localStorageEffect("theme_storage"),
  ],
});
```

## Optimization & Best Practices

1. **useRecoilValue**: Use when you only need to read state. Component won't re-render if it doesn't need to write.
2. **useSetRecoilState**: Use when you only need to write state. Component won't re-render when value changes.
3. **atomFamily / selectorFamily**: Use for dynamic state (e.g., an atom per item ID).

```typescript
// Dynamic atom family
import { atomFamily } from "recoil";

export const itemState = atomFamily({
  key: "Item",
  default: id => ({ id, text: "", done: false }),
});

// Usage
const [item, setItem] = useRecoilState(itemState(uniqueId));
```
