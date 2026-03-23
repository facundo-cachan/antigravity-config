---
name: best-practices
description: Reviews code changes for bugs, style issues, and best practices. Use when reviewing PRs or checking code quality.
license: Apache-2.0
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

## How to provide feedback

- Be specific about what needs to change
- Explain why, not just what
- Suggest alternatives when possible
