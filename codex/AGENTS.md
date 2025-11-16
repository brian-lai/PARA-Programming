# Global AGENTS.md – Workflow & Methodology Guide

> **Location:** `~/.codex/AGENTS.md` (or `~/.config/codex/AGENTS.md` depending on your setup)
> **Purpose:** Defines **HOW** to do work with Codex CLI across all projects
> **Scope:** Global instructions for workflow, methodology, and tool integration

---

## 📋 Document Hierarchy

This is your **global workflow guide**. It defines the methodology for how Codex should work with you across all projects.

### Global vs. Local AGENTS.md Files

| File Type | Location | Purpose | Contents |
|-----------|----------|---------|----------|
| **Global** (this file) | `~/.codex/AGENTS.md` | Workflow methodology & best practices | How to plan, execute, summarize, archive; preprocessing patterns; token efficiency strategies |
| **Local** (project-specific) | `<project-root>/AGENTS.md` | Project-specific context | Architecture, tech stack, conventions, domain knowledge, team practices |

### How Local Files Should Reference This Document

Every project-level `AGENTS.md` should include a reference to this global guide:

```markdown
# Project AGENTS.md

This document contains project-specific context only.

# CRITICAL (MUST FOLLOW RULES)
**Workflow Methodology:** Follow the global workflow guide at `~/.codex/AGENTS.md`

## About This Project
[Your project description here...]

## Architecture
[Your architecture details here...]

## Conventions
[Your project conventions here...]
```

---

## 🎯 Goals of This Global Guide

This guide explains how to use **Codex CLI** efficiently with structured context and persistent memory. It focuses on:

1. **Accuracy** – consistent, context-aware outputs across sessions.
2. **Token Efficiency** – minimal active context through persistent storage and preprocessing.
3. **Auditability** – every action and decision is captured in structured files.
4. **Scalability** – treating Codex and the engineer as a unified, extensible Second Brain.

---

## 🧠 Core Concepts

### The Second Brain System

Our collaboration with Codex is structured like a *shared cognitive system*:

* **Codex = Active Reasoning**
* **Human = Intent & Judgment**
* **Context Directory = Memory Layer**
* **Preprocessing Tools = Execution Layer**

This design ensures reasoning persists over time and token use remains low.

### How Preprocessing Improves Efficiency

* **Persistent Execution Layer:** Tasks are executed by preprocessing tools that live in `context/servers/`.
* **Data Filtering:** Large data is filtered or summarized *before* inclusion in prompts.
* **Selective Context Loading:** Only relevant files or tool outputs are sent to Codex at runtime.
* **Separation of Code and Context:** Tool logic is distinct from session reasoning.

---

## 🗂 Directory Structure

Each project includes a structured `context/` directory that Codex uses for persistence.

```
project-root/
├── context/
│   ├── context.md              # Active session context
│   ├── data/                   # Input/output files, payloads, datasets
│   ├── plans/                  # Pre-work plans, mini tech specs
│   ├── summaries/              # Post-work summaries and reports
│   ├── archives/               # Archived session states
│   └── servers/                # Preprocessing tool wrappers and execution code
└── AGENTS.md                    # Local project context (references global guide)
```

---

## 📅 File Naming Convention

**All context files must use date prefixes for chronological ordering:**

- **Format:** `YYYY-MM-DD-descriptive-name.extension`
- **Examples:**
  - Plans: `2025-11-15-auth-refactor.md`
  - Data: `2025-11-15-api-payload.json`
  - Summaries: `2025-11-15-auth-refactor-summary.md`
  - Archives: `2025-11-15-context.md`

**Why date prefixes?**
- Files naturally sort chronologically in directories
- Easy to find recent work
- Clear audit trail of when work was performed
- No need to check file metadata for timestamps

**Exception:** Files in `context/servers/` do NOT require date prefixes, as they are persistent tool implementations, not session-specific artifacts.

---

## 🧭 Context Directory Details

| Directory            | Description                                                                                                                   |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `context/data/`      | Input files, API payloads, datasets (used by Codex or preprocessing tools). Files prefixed with `YYYY-MM-DD-` for chronological ordering. |
| `context/plans/`     | Planning artifacts written before code changes; defines scope and intent. Files prefixed with `YYYY-MM-DD-` for chronological ordering.   |
| `context/summaries/` | Summaries after execution, capturing results and rationale. Files prefixed with `YYYY-MM-DD-` for chronological ordering.                 |
| `context/archives/`  | Archived `context/context.md` files for traceability. Files prefixed with `YYYY-MM-DD-` for chronological ordering.                       |
| `context/servers/`   | Preprocessing tool wrappers (e.g., for repos, APIs, file ops). Enables execution without bloating model context.                          |

---

## 📘 The Master File – `context/context.md`

This file tracks active work. It contains:

1. **Human-readable summary** of current focus.
2. **JSON block** tracking active plans, data files, and tool wrappers.

Example:

````markdown
# Current Work Summary
Enhancing payroll API with token-efficient preprocessing integration.

---
```json
{
  "active_context": [
    "context/plans/2025-11-15-payroll-api-enhancement.md",
    "context/data/2025-11-15-payload-example.json",
    "context/servers/github/fetchRepo.ts"
  ],
  "completed_summaries": [
    "context/summaries/2025-11-15-payroll-enhancement-summary.md"
  ],
  "last_updated": "2025-11-15T15:20:00Z"
}
```
````

After completion:
```bash
mv context/context.md context/archives/$(date +%F)-context.md
```

---

## 🔁 Workflow Loop

```
(Plan) → (Review) → (Execute) → (Summarize) → (Archive)
              ↑                           ↓
        Human Review                 Context Refresh
```

### Step Breakdown

#### 1. Plan

* Codex drafts a plan in `context/plans/` with filename format: `YYYY-MM-DD-task-name.md`
* Include objective, scope, risks, data sources, and preprocessing tool usage.

#### 2. Review

Codex pauses and requests human validation:

> "Please review `context/plans/YYYY-MM-DD-task-name.md`. Does it align with your intent?"

#### 3. Execute

* Codex uses preprocessing tools in `context/servers/` to run operations and filter data.
* Only relevant results are passed into model context.
* Example: Filtering a CSV or summarizing an API payload *before* sending it to Codex.

#### 4. Summarize

* Codex writes a report to `context/summaries/` with filename format: `YYYY-MM-DD-task-name-summary.md`
* The summary should describe:
    * What changed
    * Why
    * Which preprocessing tools or data sources were used
    * Key learnings

#### 5. Archive

* Move `context/context.md` → `context/archives/YYYY-MM-DD-context.md`
* Start a new `context/context.md` seeded with ongoing data if needed.
* Use the current date in YYYY-MM-DD format for the archived filename.

---

## ⚙️ Preprocessing & Token Efficiency

| Principle                  | Implementation                                                             |
| -------------------------- | -------------------------------------------------------------------------- |
| **Persistent Execution**   | Use code in `context/servers/` to handle large operations offline.         |
| **Selective Context**      | Only load necessary outputs into model memory.                             |
| **Preprocessing**          | Transform or summarize large data before feeding it to Codex.              |
| **Lazy Loading**           | Codex dynamically loads only relevant tools at runtime.                    |
| **State Awareness**        | Preprocessing tools maintain execution state, so Codex stays efficient.    |
| **Reduced Token Overhead** | Preprocessing offloads heavy data processing from LLM context.             |

---

## 🧩 Example Preprocessing Workflow

1. **Preprocessing (Code Layer)**
    * Tool: `context/servers/github/fetchRepo.ts`
    * Function: Pull and summarize repo structure, returning 2–3 key files.

2. **Reasoning (Codex Layer)**
    * Input: Short summary (1–2k tokens max) of relevant code sections.
    * Output: Plan or patch proposal.

3. **Postprocessing (Code Layer)**
    * Tool applies changes or updates repositories directly.

This hybrid setup makes Codex act as an *executive layer* on top of efficient, persistent preprocessing tools.

---

## 🧹 Session Hygiene

1. Archive old contexts regularly.
2. Keep `context/servers/` modular and documented.
3. Record provenance in every summary (tools used, files touched, timestamps).
4. Use small, composable preprocessing tools instead of monolithic ones.

---

## ✅ Summary Checklist

* [ ] Preprocessing tool wrappers stored in `context/servers/`
* [ ] Plans include preprocessing tool references
* [ ] Data preprocessed before prompting
* [ ] Token usage monitored
* [ ] Context archived per task

---

## 🧭 Closing Thought

> *"Codex should think with the smallest possible context, not the largest."*
> By pairing structured context (memory) with preprocessing execution (action), we create an intelligent, persistent, and efficient Second Brain where humans and Codex collaborate seamlessly.

---

## 🚀 Quickstart: Preprocessing‑Aware Project Setup

### 1) Scaffold the context + servers directories

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
: > context/context.md
```

### 2) Seed `context/context.md`

````markdown
# Current Work Summary
Bootstrapping preprocessing-aware project.

---
```json
{
  "active_context": [
    "context/plans/2025-11-15-hello-preprocessing.md"
  ],
  "completed_summaries": [],
  "last_updated": "YYYY-MM-DDTHH:MM:SSZ"
}
```
````

### 3) Create your first plan (referencing preprocessing)

`context/plans/2025-11-15-hello-preprocessing.md`
```markdown
# Plan: Hello Preprocessing Tooling

## Objective
Test a preprocessing wrapper that lists repo files and returns a short summary.

## Approach
1. Implement a small preprocessing wrapper in `context/servers/`
2. Call it to list files, then summarize the top 3 relevant paths
3. Feed only the summary back to Codex

## Data Sources (Proposed)
- Preprocessing tool: context/servers/repo/listFiles.ts

## Review Checklist
- [ ] Wrapper created
- [ ] Output <= 1–2k tokens
- [ ] Summary captured in `context/summaries/2025-11-15-hello-preprocessing-summary.md`
```

### 4) Add a minimal preprocessing wrapper

`context/servers/repo/listFiles.ts`

```ts
// Example preprocessing wrapper for file listing
import { glob } from 'glob';

export async function listFiles(prefix: string) {
  const files = await glob(`${prefix}/**/*`);

  // Preprocess: filter & compress
  const shortlist = files
    .filter(p => !p.includes("node_modules") && !p.startsWith("."))
    .slice(0, 200);

  return {
    count: shortlist.length,
    preview: shortlist.slice(0, 20),
  };
}
```

> **Why code here?** This keeps heavy work **outside** the LLM and returns a compact result for Codex.

### 5) Run the workflow

1. **Plan**: Open `2025-11-15-hello-preprocessing.md`, approve steps.
2. **Execute**: Call `listFiles()` from your preprocessing runtime.
3. **Summarize**: Save a short write‑up → `context/summaries/2025-11-15-hello-preprocessing-summary.md`.
4. **Archive**: Move `context/context.md` to `context/archives/2025-11-15-context.md` when done.

### 6) Keep it lean

* Aim for ≤ 1–2k tokens of **active** context per step.
* Preprocess/aggregate in `context/servers/` first.
* Store larger artifacts in `context/data/` and pass only excerpts/summaries to Codex.

> Next: replicate this pattern for additional tools (APIs, search, analysis), always returning **the smallest useful slice** of data back to Codex.

---

## 📝 Creating Local Project AGENTS.md Files

### What Belongs in a Local AGENTS.md

Local `AGENTS.md` files should contain **project-specific context**, not workflow methodology. Focus on:

#### ✅ Include in Local Files
- **Project purpose & domain knowledge**
- **Architecture overview** (high-level system design)
- **Tech stack & dependencies**
- **Code organization & conventions**
- **Team practices & style guides**
- **Domain-specific terminology**
- **Key files & their purposes**
- **Integration points & external services**
- **Testing strategies**
- **Deployment processes**

#### ❌ Do NOT Duplicate in Local Files
- Workflow methodology (that's in this global guide)
- Preprocessing integration patterns (covered here)
- Plan/Execute/Summarize/Archive loop (covered here)
- Token efficiency strategies (covered here)
- Context directory structure (covered here)

### Template for Local AGENTS.md

Here's a template for initializing a new project's `AGENTS.md`:

````markdown
# [Project Name] – Context Guide

> **Workflow Methodology:** All workflow practices follow `~/.codex/AGENTS.md`
> This document provides project-specific context only.

---

## 📌 Quick Reference

| Property | Value |
|----------|-------|
| **Purpose** | [One-line project description] |
| **Tech Stack** | [e.g., Node.js, React, PostgreSQL, Redis] |
| **Primary Language** | [e.g., TypeScript] |
| **Architecture** | [e.g., Microservices, Monolith, Serverless] |
| **Repository** | [GitHub/GitLab URL] |

---

## 🎯 What This Project Does

[2-3 paragraphs explaining the project's purpose, key features, and user base]

---

## 🏗 Architecture Overview

### System Design
[High-level architecture diagram description or key components]

### Key Components
- **Component A** (`src/services/a/`): [Purpose]
- **Component B** (`src/services/b/`): [Purpose]
- **Component C** (`src/lib/c/`): [Purpose]

### Data Flow
[How data moves through the system]

---

## 🛠 Tech Stack Details

### Runtime & Frameworks
- **Runtime:** Node.js 20.x
- **Framework:** Express.js 4.x / Next.js 14.x
- **Language:** TypeScript 5.x

### Data Layer
- **Database:** PostgreSQL 15 / MongoDB 6.x
- **Cache:** Redis 7.x
- **ORM/Query Builder:** Prisma / Drizzle / Mongoose

---

## 📂 Code Organization

```
src/
├── api/          # HTTP endpoints and route handlers
├── services/     # Business logic layer
├── models/       # Data models and schemas
├── lib/          # Shared utilities and helpers
├── config/       # Configuration files
└── tests/        # Test suites
```

### Key Files & Directories

| Path | Purpose |
|------|---------|
| `src/api/routes.ts` | Main API route definitions |
| `src/services/auth/` | Authentication & authorization |
| `src/lib/db.ts` | Database connection setup |
| `src/config/env.ts` | Environment configuration |

---

## 🎨 Conventions & Standards

### Code Style
- **Formatting:** Prettier (see `.prettierrc`)
- **Linting:** ESLint (see `.eslintrc`)
- **Naming:** camelCase for variables/functions, PascalCase for classes/types

### Git Practices
- **Branch naming:** `feature/description`, `fix/description`, `refactor/description`
- **Commit style:** [Conventional Commits](https://www.conventionalcommits.org/)
- **PR requirements:** [List requirements]

### Testing
- **Framework:** Jest / Vitest / Mocha
- **Coverage target:** 80%+
- **Test location:** Co-located with source (`*.test.ts` or `__tests__/`)

---

## 🚀 Development Workflow

### Setup
```bash
# Install dependencies
npm install

# Setup environment
cp .env.example .env

# Run migrations
npm run migrate

# Start dev server
npm run dev
```

### Common Commands
- `npm run dev` – Start development server
- `npm run build` – Build for production
- `npm test` – Run test suite
- `npm run lint` – Lint code

---

## 📚 Domain Knowledge

### Business Logic
[Explain key business rules, domain concepts, or complex logic]

### Terminology
- **Term A:** Definition and usage
- **Term B:** Definition and usage
````

### Minimal Template (For Smaller Projects)

For simpler projects, use this condensed version:

````markdown
# [Project Name]

> **Workflow Methodology:** Follow `~/.codex/AGENTS.md`

## About
[Brief description of what this project does]

## Tech Stack
- [Language/Framework]
- [Database]
- [Key libraries]

## Structure
```
src/
├── [key directory]: [purpose]
├── [key directory]: [purpose]
```

## Key Files
- `[path]`: [purpose]
- `[path]`: [purpose]

## Conventions
- [Key convention 1]
- [Key convention 2]

## Getting Started
```bash
[setup commands]
```
````

### When to Update Local AGENTS.md

Update your project's `AGENTS.md` when:
- Architecture changes significantly
- New major dependencies are added
- Team conventions are established or changed
- New domain concepts are introduced
- Integration points change

### Keep It Lean

Remember: Codex reads this on **every** session. Keep local AGENTS.md files:
- **Concise** (aim for 500-1500 lines max)
- **Structured** (use headers and tables)
- **Current** (update when the project evolves)
- **Focused** (project context only, not workflow)

By separating workflow methodology (global) from project context (local), we achieve:
- **Consistency** across all projects
- **Efficiency** (no duplicated workflow instructions)
- **Maintainability** (update workflow once, applies everywhere)
- **Clarity** (clear separation of concerns)
