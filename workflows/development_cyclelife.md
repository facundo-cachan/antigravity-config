---
title: Ciclo Completo de Desarrollo Autónomo
description: Ejecuta el proceso desde el análisis de SRS hasta el reporte de cierre.
license: MIT
metadata:
  author: Facundo Cachan
  version: "1.0"
  scope: [root, ui]
  auto_invoke: "Auto Build"
allowed-tools: Read, Write, Modify
---

# 🏗️ Development Cycle

This workflow defines the exact steps for developing a task, ensuring quality and consistency with team standards.

## Environment Preparation

**Clone repository** (if one doesn't already exist).

**Update database**:

- `git checkout develop`

- `git pull origin develop`

**Install dependencies**:

- `pnpm install`

**Initial verification build**:

- `pnpm build`

- 🔴 **IF IT FAILS**: Stop. It's a "broken merge". Notify the team immediately. DO NOT continue.

## Task Development

**Create working branch**:

- `git checkout -b feature/descriptive-task-name develop`

**Develop the task**:

- Write clean and well-documented code.

- Refer to `MEMORY[GEMINI]` for styles and patterns.

## Quality Assurance (Local QA)

**Verification Build**:

- `pnpm build` (Must pass without errors)

**Linting and Formatting**:

- `pnpm lint`

- `pnpm format` (Prettier)

**Security and Quality Gates (MANDATORY)**:

- 🛡️ Run `snyk_code_scan` (SAST) to detect vulnerabilities in the generated code.

- 📊 Run SonarQube checks (via `quality-sonarqube` skill) to analyze code quality and technical debt.

- 🔴 **IF ANY FAIL**: Stop. Resolve all critical/high security vulnerabilities and code smells before considering the task "Ready" or proceeding to commit.

**Documentation**:

- Verify JSDoc in new functions/components.

- Comment complex logic.

**Unit Tests**:

- Run tests with Jest. (Note: Configure the `test` script if missing).

**Final Verification**:

- Run `pnpm build && pnpm test` to ensure nothing broke.

**Pre‑commit Validation (MANDATORY)**:

- Execute `snyk_code_scan` (SAST) and ensure it exits with status 0.
- Execute SonarQube quality gate (via `quality-sonarqube` skill or `sonar-scanner`) and ensure the gate passes.
- If any of the above fails, abort the commit, fix the issues, and re‑run the validation.

## Delivery

**Push to repository**:

- `git push origin feature/descriptive-task-name`

**Create Merge Request (MR)**:

- Clear description of changes.

- Link related tickets.

**Update status**:

- Move task in Jira/Trello.

**Review**:

- Request review from the team.

**Feedback**:

- Apply requested fixes to the same branch.
