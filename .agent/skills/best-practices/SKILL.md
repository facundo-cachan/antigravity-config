---
name: best-practices
description: Reviews code changes for bugs, style issues, and best practices. Use when reviewing PRs or checking code quality.
license: MIT
metadata:
  author: Facundo Cachan
  version: "1.0"
  scope: [root, ui]
  auto_invoke: "Modifying code"
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, WebFetch, WebSearch, Task
---

# Best Practices Skill

When reviewing code, follow these steps:

## Review checklist

1. **Correctness**: Does the code do what it's supposed to?
2. **Edge cases**: Are error conditions handled?
3. **Style**: Does it follow project conventions?
4. **Performance**: Are there obvious inefficiencies?
5. **no-use-effect**: The only place useEffect may appear directly is inside reusable custom hooks (like useMountEffect itself, or a useData hook when no fetching library is available). Components must never import or call useEffect.
6. **Security**: Are there obvious security vulnerabilities?

## How to provide feedback

- Be specific about what needs to change
- Explain why, not just what
- Suggest alternatives when possible
