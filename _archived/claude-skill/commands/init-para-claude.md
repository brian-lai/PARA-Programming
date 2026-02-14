# Initialize Project CLAUDE.md

Create a new `CLAUDE.md` file in the project root that references the global workflow guide at `~/.claude/CLAUDE.md`.

## Instructions

1. **First, gather project information by asking the user:**
   - Project name
   - Brief project description (what it does)
   - Tech stack (language, framework, database, key libraries)
   - Architecture type (monolith, microservices, serverless, etc.)

2. **Then create a new CLAUDE.md file** in the project root using the appropriate template:
   - Use the **full template** for complex projects with multiple components
   - Use the **minimal template** for simpler projects
   - If unsure, ask the user which template they prefer

3. **Ensure the file includes:**
   - Clear reference to the global workflow guide: `~/.claude/CLAUDE.md`
   - Project-specific context only (not workflow methodology)
   - Date-stamped if creating versioned documentation
   - Placeholders filled in with the information gathered from the user

## Full Template

Use this for comprehensive projects:

```markdown
# [Project Name] – Context Guide

> **CRITICAL: Workflow Methodology Reference**
>
> All workflow practices (Plan → Review → Execute → Summarize → Archive) are defined in the global guide at `~/.claude/CLAUDE.md`.
>
> **This document provides project-specific context ONLY.**
> Do not duplicate workflow instructions here.

---

## 📌 Quick Reference

| Property | Value |
|----------|-------|
| **Purpose** | [One-line project description] |
| **Tech Stack** | [e.g., Node.js, React, PostgreSQL, Redis] |
| **Primary Language** | [e.g., TypeScript] |
| **Architecture** | [e.g., Microservices, Monolith, Serverless] |
| **Repository** | [GitHub/GitLab URL if applicable] |

---

## 🎯 What This Project Does

[2-3 paragraphs explaining:
- The project's purpose and goals
- Key features and functionality
- Target users or use cases]

---

## 🏗 Architecture Overview

### System Design
[High-level description of how the system is structured]

### Key Components
- **Component A** (`path/to/component/`): [Purpose and responsibilities]
- **Component B** (`path/to/component/`): [Purpose and responsibilities]
- **Component C** (`path/to/component/`): [Purpose and responsibilities]

### Data Flow
[Describe how data moves through the system, key integration points]

---

## 🛠 Tech Stack Details

### Runtime & Frameworks
- **Runtime:** [e.g., Node.js 20.x, Python 3.11, Go 1.21]
- **Framework:** [e.g., Express.js, FastAPI, Next.js]
- **Language:** [e.g., TypeScript 5.x, Python, Go]

### Data Layer
- **Database:** [e.g., PostgreSQL 15, MongoDB 6.x, MySQL]
- **Cache:** [e.g., Redis 7.x, Memcached]
- **ORM/Query Builder:** [e.g., Prisma, Drizzle, SQLAlchemy, Mongoose]

### Infrastructure
- **Hosting:** [e.g., AWS, GCP, Azure, Vercel, Fly.io]
- **CI/CD:** [e.g., GitHub Actions, GitLab CI, Jenkins]
- **Monitoring:** [e.g., DataDog, Sentry, CloudWatch]

---

## 📂 Code Organization

```
src/
├── [directory]/     # [Purpose]
├── [directory]/     # [Purpose]
├── [directory]/     # [Purpose]
└── [directory]/     # [Purpose]
```

### Key Files & Directories

| Path | Purpose |
|------|---------|
| `[path/to/file]` | [What this file does] |
| `[path/to/file]` | [What this file does] |
| `[path/to/directory]/` | [What this directory contains] |

---

## 🎨 Conventions & Standards

### Code Style
- **Formatting:** [e.g., Prettier, Black, gofmt]
- **Linting:** [e.g., ESLint, pylint, golangci-lint]
- **Naming:** [e.g., camelCase for variables/functions, PascalCase for classes/types]

### Git Practices
- **Branch naming:** [e.g., `feature/description`, `fix/description`, `refactor/description`]
- **Commit style:** [e.g., Conventional Commits, custom format]
- **PR requirements:** [e.g., code review, tests passing, coverage threshold]

### Testing
- **Framework:** [e.g., Jest, Vitest, pytest, Go testing]
- **Coverage target:** [e.g., 80%+]
- **Test location:** [e.g., Co-located `*.test.ts`, `__tests__/` directory]

---

## 🔌 External Integrations

### APIs & Services
- **[Service Name]:** [Purpose, authentication method, documentation URL]
- **[Service Name]:** [Purpose, authentication method, documentation URL]

### Environment Variables
Key environment variables (see `.env.example` for full list):
- `[VAR_NAME]`: [Description]
- `[VAR_NAME]`: [Description]
- `[VAR_NAME]`: [Description]

---

## 🚀 Development Workflow

### Setup
```bash
# Install dependencies
[command]

# Setup environment
[command]

# Run migrations/setup
[command]

# Start dev server
[command]
```

### Common Commands
- `[command]` – [Description]
- `[command]` – [Description]
- `[command]` – [Description]
- `[command]` – [Description]

---

## 📚 Domain Knowledge

### Business Logic
[Explain key business rules, domain concepts, or complex logic that Claude should understand]

### Terminology
- **[Term]:** [Definition and usage in this project]
- **[Term]:** [Definition and usage in this project]

---

## 🔍 Troubleshooting Common Issues

### Issue: [Common problem description]
**Symptoms:** [What you see when this happens]
**Solution:** [How to fix it]

### Issue: [Another common problem]
**Symptoms:** [What you see when this happens]
**Solution:** [How to fix it]

---

## 📖 Additional Resources

- [Team Wiki/Confluence]
- [API Documentation]
- [Design System / Component Library]
- [Architecture Decision Records (ADRs)]

---

## 📝 Maintenance Notes

**Last Updated:** [YYYY-MM-DD]
**Maintained By:** [Team/Person]

Remember to update this file when:
- Architecture changes significantly
- New major dependencies are added
- Team conventions are established or changed
- New domain concepts are introduced
- Integration points change
```

## Minimal Template

Use this for simpler projects:

```markdown
# [Project Name]

> **CRITICAL: Workflow Methodology Reference**
>
> All workflow practices are defined in `~/.claude/CLAUDE.md`
> This document contains project-specific context only.

---

## About
[Brief description of what this project does and why it exists]

## Tech Stack
- **Language/Runtime:** [e.g., TypeScript/Node.js, Python, Go]
- **Framework:** [e.g., Express, FastAPI, Next.js]
- **Database:** [e.g., PostgreSQL, MongoDB, SQLite]
- **Key Libraries:** [List 3-5 most important dependencies]

## Code Structure
```
src/
├── [key directory]/    # [purpose]
├── [key directory]/    # [purpose]
└── [key directory]/    # [purpose]
```

## Key Files
- `[path]`: [purpose and importance]
- `[path]`: [purpose and importance]
- `[path]`: [purpose and importance]

## Conventions
- **Code Style:** [e.g., Prettier + ESLint]
- **Testing:** [e.g., Jest, 80% coverage target]
- **Git:** [e.g., Conventional Commits, feature branches]

## Getting Started
```bash
# Setup
[setup commands]

# Development
[dev commands]

# Testing
[test commands]
```

## Domain Notes
[Any important domain-specific concepts, terminology, or business logic]

---

**Last Updated:** [YYYY-MM-DD]
```

## After Creating the File

1. **Confirm** the file was created successfully at the project root
2. **Remind the user** that workflow methodology lives in `~/.claude/CLAUDE.md`
3. **Suggest** they review and customize the placeholders
4. **Note** that the CLAUDE.md should be committed to version control
