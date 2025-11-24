# Global CLAUDE.md – Workflow & Methodology Guide

> **Location:** `~/.claude/CLAUDE.md`
> **Purpose:** Defines **HOW** to do work with Claude Code across all projects
> **Scope:** Global instructions for workflow, methodology, and MCP integration

---

## 📋 Document Hierarchy

This is your **global workflow guide**. It defines the methodology for how Claude should work with you across all projects.

### Global vs. Local CLAUDE.md Files

| File Type | Location | Purpose | Contents |
|-----------|----------|---------|----------|
| **Global** (this file) | `~/.claude/CLAUDE.md` | Workflow methodology & best practices | How to plan, execute, summarize, archive; MCP patterns; token efficiency strategies |
| **Local** (project-specific) | `<project-root>/CLAUDE.md` | Project-specific context | Architecture, tech stack, conventions, domain knowledge, team practices |

### How Local Files Should Reference This Document

Every project-level `CLAUDE.md` should include a reference to this global guide:

```markdown
# Project CLAUDE.md

This document contains project-specific context only.

# CRITICAL (MUST FOLLOW RULES)
**Workflow Methodology:** Follow the global workflow guide at `~/.claude/CLAUDE.md`

## About This Project
[Your project description here...]

## Architecture
[Your architecture details here...]

## Conventions
[Your project conventions here...]
```

---

## 🎯 Goals of This Global Guide

This guide explains how to use **Claude Code** efficiently with the **Model Context Protocol (MCP)** and persistent context strategy. It focuses on:

1. **Accuracy** – consistent, context-aware outputs across sessions.
2. **Token Efficiency** – minimal active context through persistent storage and MCP wrappers.
3. **Auditability** – every action and decision is captured in structured files.
4. **Scalability** – treating Claude and the engineer as a unified, extensible Second Brain.

---

## 🧠 Core Concepts

### The Second Brain System

Our collaboration with Claude is structured like a *shared cognitive system*:

* **Claude = Active Reasoning**
* **Human = Intent & Judgment**
* **Context Directory = Memory Layer**
* **MCP Servers = Tool/Execution Layer**

This design ensures reasoning persists over time and token use remains low.

### How MCP Improves Efficiency

* **Persistent Execution Layer:** Tasks are executed by MCP tools (code, APIs) that live in `context/servers/`.
* **Preprocessing:** Large data is filtered or summarized *outside* Claude before inclusion in prompts.
* **Selective Context Loading:** Only relevant files or tool outputs are sent to Claude at runtime.
* **Separation of Code and Context:** Tool logic (MCP) is distinct from session reasoning (Claude).

---

## 🗂 Directory Structure

Each project includes a structured `context/` directory that Claude and MCP use for persistence.

```
project-root/
├── context/
│   ├── context.md              # Active session context
│   ├── data/                   # Input/output files, payloads, datasets
│   ├── plans/                  # Pre-work plans, mini tech specs
│   ├── summaries/              # Post-work summaries and reports
│   ├── archives/               # Archived session states
│   └── servers/                # MCP tool wrappers and execution code
└── CLAUDE.md                   # Local project context (references global guide)
```

---

## 📅 File Naming Convention

**All context files must use date prefixes for chronological ordering:**

- **Format:** `YYYY-MM-DD-descriptive-name.extension`
- **Examples:**
  - Plans: `2025-11-11-auth-refactor.md`
  - Data: `2025-11-11-api-payload.json`
  - Summaries: `2025-11-11-auth-refactor-summary.md`
  - Archives: `2025-11-11-context.md`

**Why date prefixes?**
- Files naturally sort chronologically in directories
- Easy to find recent work
- Clear audit trail of when work was performed
- No need to check file metadata for timestamps

**Exception:** Files in `context/servers/` do NOT require date prefixes, as they are persistent MCP tool implementations, not session-specific artifacts.

---

## 🧭 Context Directory Details

| Directory            | Description                                                                                                                   |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `context/data/`      | Input files, API payloads, datasets (used by Claude or MCP). Files prefixed with `YYYY-MM-DD-` for chronological ordering.                                                                  |
| `context/plans/`     | Planning artifacts written before code changes; defines scope and intent. Files prefixed with `YYYY-MM-DD-` for chronological ordering.                                                     |
| `context/summaries/` | Summaries after execution, capturing results and rationale. Files prefixed with `YYYY-MM-DD-` for chronological ordering.                                                                   |
| `context/archives/`  | Archived `context/context.md` files for traceability. Files prefixed with `YYYY-MM-DD-` for chronological ordering.                                                                         |
| `context/servers/`   | MCP tool wrappers (e.g., for repos, APIs, file ops). Enables code execution and preprocessing without bloating model context. |

---

## 📘 The Master File – `context/context.md`

This file tracks active work. It contains:

1. **Human-readable summary** of current focus.
2. **JSON block** tracking active plans, data files, and tool wrappers.

Example:

````markdown
# Current Work Summary
Enhancing payroll API with token-efficient MCP integration.

---
```json
{
  "active_context": [
    "context/plans/2025-11-08-payroll-api-mcp.md",
    "context/data/2025-11-08-payload-example.json",
    "context/servers/github/fetchRepo.ts"
  ],
  "completed_summaries": [
    "context/summaries/2025-11-08-payroll-mcp-summary.md"
  ],
  "last_updated": "2025-11-08T15:20:00Z"
}
````

````

After completion:
```bash
mv context/context.md context/archives/$(date +%F)-context.md
````

---

## 🔁 Workflow Loop

```
(Plan) → (Review) → (Execute) → (Summarize) → (Archive)
              ↑                           ↓
        Human Review                 Context Refresh
```

---

## ⚠️ CRITICAL: When to Apply PARA Workflow

**The PARA workflow MUST be strictly followed for all project work. Do NOT skip or shortcut this process for complex projects.**

### ✅ ALWAYS Use PARA Workflow For:

- **All code changes** - Features, bug fixes, refactoring, optimizations
- **Architecture decisions** - Adding libraries, changing patterns, major refactors
- **File modifications** - Creating, editing, or deleting project files
- **Configuration changes** - Build configs, dependencies, environment setup
- **Database changes** - Migrations, schema updates, data transformations
- **Testing implementation** - Writing or modifying tests
- **Documentation that affects code** - API docs, technical specs
- **Debugging complex issues** - Requiring code investigation and fixes
- **Performance optimizations** - Requiring measurement and code changes
- **Security implementations** - Authentication, authorization, encryption

**Rule of thumb:** If it results in git changes to project files, use PARA workflow.

### ❌ Do NOT Use PARA Workflow For:

- **Simple informational queries** - "What does this function do?" "Where is X defined?"
- **Codebase navigation** - "Show me the authentication logic" "List all API routes"
- **Explanation requests** - "Explain how this works" "What's the difference between X and Y?"
- **General questions** - Questions unrelated to the current project
- **Quick lookups** - "What's the current version?" "What dependencies do we have?"
- **Summary documentation** - Generating docs that describe existing code without changes

**Rule of thumb:** If it's read-only or informational, skip PARA workflow and answer directly.

### 🤔 Decision Tree

```
Is this request asking for code/file changes?
├─ YES → Use PARA Workflow (Plan → Review → Execute → Summarize → Archive)
└─ NO → Is it asking about this project's code?
    ├─ YES → Provide direct answer with file references
    └─ NO → Provide standard Claude response
```

### Examples

**✅ Use PARA Workflow:**
```
User: "Add user authentication to the API"
Claude: I'll create a plan for implementing authentication...
[Creates context/plans/2025-11-24-user-auth.md]
```

**✅ Use PARA Workflow:**
```
User: "Fix the memory leak in the WebSocket handler"
Claude: I'll create a plan to debug and fix this issue...
[Creates context/plans/2025-11-24-fix-memory-leak.md]
```

**❌ Skip PARA Workflow:**
```
User: "Where is the authentication middleware defined?"
Claude: The authentication middleware is in src/middleware/auth.ts:45-89
```

**❌ Skip PARA Workflow:**
```
User: "Explain how the caching system works"
Claude: The caching system uses Redis for storing frequently accessed data...
```

**❌ Skip PARA Workflow:**
```
User: "What's the difference between OAuth and JWT?"
Claude: OAuth is an authorization framework while JWT is a token format...
```

---

### Step Breakdown

#### 1. Plan

* **First, ensure context directory exists:** If `context/` and its subdirectories don't exist, create them automatically:
  ```bash
  mkdir -p context/{data,plans,summaries,archives,servers}
  ```
* Claude drafts a plan in `context/plans/` with filename format: `YYYY-MM-DD-task-name.md`
* Include objective, scope, risks, data sources, and MCP tool usage.
* Reference the **Plan Authoring Guide (Confluence)** for templates.

#### 2. Review

Claude pauses and requests human validation:

> "Please review `context/plans/YYYY-MM-DD-task-name.md`. Does it align with your intent and the MCP tools specified?"

#### 3. Execute

* Claude uses MCP wrappers in `context/servers/` to run tools and preprocess data.
* Only relevant results are passed into model context.
* Example: Filtering a CSV or summarizing an API payload *before* sending it to Claude.

#### 4. Summarize

* Claude writes a report to `context/summaries/` with filename format: `YYYY-MM-DD-task-name-summary.md`
* The summary should describe:

    * What changed
    * Why
    * Which MCP wrappers or data sources were used
    * Key learnings

#### 5. Archive

* Move `context/context.md` → `context/archives/YYYY-MM-DD-context.md`
* Start a new `context/context.md` seeded with ongoing data if needed.
* Use the current date in YYYY-MM-DD format for the archived filename.

---

## ⚙️ MCP & Token Efficiency

| Principle                  | Implementation                                                             |
| -------------------------- | -------------------------------------------------------------------------- |
| **Persistent Execution**   | Use code in `context/servers/` to handle large operations offline.         |
| **Selective Context**      | Only load necessary outputs into model memory.                             |
| **Preprocessing**          | Transform or summarize large data before feeding it to Claude.             |
| **Lazy Loading**           | Claude dynamically loads only relevant MCP tools at runtime.               |
| **State Awareness**        | MCP maintains execution state, so Claude can stay stateless and efficient. |
| **Reduced Token Overhead** | MCP offloads heavy data processing from LLM context.                       |

---

## 🧩 Example MCP Workflow

1. **Preprocessing (Code Layer)**

    * Tool: `context/servers/github/fetchRepo.ts`
    * Function: Pull and summarize repo structure, returning 2–3 key files.

2. **Reasoning (Claude Layer)**

    * Input: Short summary (1–2k tokens max) of relevant code sections.
    * Output: Plan or patch proposal.

3. **Postprocessing (Code Layer)**

    * Tool applies changes or updates repositories directly.

This hybrid setup makes Claude act as an *executive layer* on top of efficient, persistent MCP tools.

---

## 🧹 Session Hygiene

1. Archive old contexts regularly.
2. Keep `context/servers/` modular and documented.
3. Record provenance in every summary (tools used, files touched, timestamps).
4. Use small, composable MCP tools instead of monolithic ones.

---

## ✅ Summary Checklist

* [ ] MCP tool wrappers stored in `context/servers/`
* [ ] Plans include MCP tool references
* [ ] Data preprocessed before prompting
* [ ] Token usage monitored
* [ ] Context archived per task

---

## 🧭 Closing Thought

> *“Claude should think with the smallest possible context, not the largest.”*
> By pairing structured context (memory) with MCP execution (action), we create an intelligent, persistent, and efficient Second Brain where humans and Claude collaborate seamlessly.

---

## 🚀 Quickstart: MCP‑Aware Project Setup

### 1) Scaffold the context + servers directories

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
: > context/context.md
```

### 2) Seed `context/context.md`

````markdown
# Current Work Summary
Bootstrapping MCP-aware project.

---
```json
{
  "active_context": [
    "context/plans/2025-11-11-hello-mcp.md"
  ],
  "completed_summaries": [],
  "last_updated": "YYYY-MM-DDTHH:MM:SSZ"
}
````

````

### 3) Create your first plan (referencing MCP)
`context/plans/2025-11-11-hello-mcp.md`
```markdown
# Plan: Hello MCP Tooling

## Objective
Test an MCP wrapper that lists repo files and returns a short summary.

## Approach
1. Implement a small MCP wrapper in `context/servers/`
2. Call it to list files, then summarize the top 3 relevant paths
3. Feed only the summary back to Claude

## Data Sources (Proposed)
- MCP: repo-indexer (list-files)
- Wrapper: context/servers/repo/listFiles.ts

## Review Checklist
- [ ] Wrapper created
- [ ] Output <= 1–2k tokens
- [ ] Summary captured in `context/summaries/2025-11-11-hello-mcp-summary.md`
````

### 4) Add a minimal MCP wrapper

`context/servers/repo/listFiles.ts`

```ts
// Example pseudo-wrapper for MCP list-files
import { mcpClient } from "./sdk";

export async function listFiles(prefix: string) {
  const files = await mcpClient.listFiles({ prefix });
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

> **Why code here?** This keeps heavy work **outside** the LLM and returns a compact result for Claude.

### 5) Run the workflow

1. **Plan**: Open `2025-11-11-hello-mcp.md`, approve steps.
2. **Execute**: Call `listFiles()` from your MCP client / agent runtime.
3. **Summarize**: Save a short write‑up → `context/summaries/2025-11-11-hello-mcp-summary.md`.
4. **Archive**: Move `context/context.md` to `context/archives/2025-11-11-context.md` when done.

### 6) Keep it lean

* Aim for ≤ 1–2k tokens of **active** context per step.
* Preprocess/aggregate in `context/servers/` first.
* Store larger artifacts in `context/data/` and pass only excerpts/summaries to Claude.

> Next: replicate this pattern for additional tools (APIs, search, vector lookups), always returning **the smallest useful slice** of data back to Claude.

---

## 📝 Creating Local Project CLAUDE.md Files

### What Belongs in a Local CLAUDE.md

Local `CLAUDE.md` files should contain **project-specific context**, not workflow methodology. Focus on:

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
- MCP integration patterns (covered here)
- Plan/Execute/Summarize/Archive loop (covered here)
- Token efficiency strategies (covered here)
- Context directory structure (covered here)

### Template for Local CLAUDE.md

Here's a template for initializing a new project's `CLAUDE.md`:

````markdown
# [Project Name] – Context Guide

> **Workflow Methodology:** All workflow practices follow `~/.claude/CLAUDE.md`
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

### Infrastructure
- **Hosting:** AWS / GCP / Azure / Vercel
- **CI/CD:** GitHub Actions / GitLab CI
- **Monitoring:** [DataDog / Sentry / etc.]

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

## 🔌 External Integrations

### APIs & Services
- **Service A:** [Purpose, auth method, docs URL]
- **Service B:** [Purpose, auth method, docs URL]

### Environment Variables
Key environment variables (see `.env.example` for full list):
- `DATABASE_URL`: PostgreSQL connection string
- `REDIS_URL`: Redis connection string
- `API_KEY_X`: External service API key

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

---

## 🔍 Troubleshooting Common Issues

### Issue 1: [Common problem]
**Symptoms:** [What you see]
**Solution:** [How to fix]

### Issue 2: [Another common problem]
**Symptoms:** [What you see]
**Solution:** [How to fix]

---

## 📖 Additional Resources

- [Team Wiki/Confluence]
- [API Documentation]
- [Design System / Component Library]
- [Architecture Decision Records (ADRs)]
````

### Minimal Template (For Smaller Projects)

For simpler projects, use this condensed version:

````markdown
# [Project Name]

> **Workflow Methodology:** Follow `~/.claude/CLAUDE.md`

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

### When to Update Local CLAUDE.md

Update your project's `CLAUDE.md` when:
- Architecture changes significantly
- New major dependencies are added
- Team conventions are established or changed
- New domain concepts are introduced
- Integration points change

### Keep It Lean

Remember: Claude reads this on **every** session. Keep local CLAUDE.md files:
- **Concise** (aim for 500-1500 lines max)
- **Structured** (use headers and tables)
- **Current** (update when the project evolves)
- **Focused** (project context only, not workflow)

By separating workflow methodology (global) from project context (local), we achieve:
- **Consistency** across all projects
- **Efficiency** (no duplicated workflow instructions)
- **Maintainability** (update workflow once, applies everywhere)
- **Clarity** (clear separation of concerns)

---

## 🤖 Tool Output Guidance: Presenting PARA-Programming

This section instructs Claude Code (and other AI tools) on how to present PARA-Programming methodology to users in a helpful, consistent way.

### When to Proactively Show Guidance

Show PARA-Programming guidance in these situations:

1. **After Initialization** - Always show comprehensive output after `/para-init`
2. **User Asks for Help** - When user asks "how do I use PARA?" or similar
3. **User Seems Uncertain** - When user appears unsure about workflow
4. **After Archiving** - Brief reminder of next steps after `/para-archive`
5. **First Interaction** - If user mentions PARA but hasn't used it yet

### Standard Output Format

When presenting PARA-Programming guidance, use this structure:

#### For `/para-init` (Comprehensive Onboarding)

```markdown
## ✅ Directory Structure Created/Verified
[Tree view showing context/ structure with descriptions]

## ✅ Files Created/Updated
[List of what was created or modified]

## 📋 Quick Reference
**Workflow:** Plan → Review → Execute → Summarize → Archive

**Use PARA for:** Code changes, architecture decisions, complex tasks
**Skip PARA for:** Simple queries, code navigation, explanations

**Rule of thumb:** If it results in git changes, use PARA workflow.

## 🚀 Next Steps
1. Create your first plan: `/para-plan <task-description>`
2. Check workflow status: `/para-status`
3. Get help anytime: `/para-help`

## 📚 Available Commands
[List all 6 PARA commands with brief descriptions]

Your PARA-Programming environment is ready! 🎉
```

#### For General Guidance (Compact Version)

```markdown
## 📋 PARA-Programming Quick Reference

**Workflow:** Plan → Review → Execute → Summarize → Archive

**When to use PARA:**
- ✅ Code changes, features, bug fixes
- ✅ Architecture decisions
- ✅ File modifications
- ✅ Complex debugging

**When to skip PARA:**
- ❌ Simple queries ("What does X do?")
- ❌ Code navigation ("Show me X")
- ❌ Explanations ("How does X work?")

**Commands:**
- `/para-plan` - Create plan
- `/para-help` - Full guide
- `/para-status` - Check state

**Need help?** Run `/para-help` for the complete guide.
```

### Communication Principles

When interacting with users about PARA-Programming:

#### ✅ DO:
- **Be helpful, not overwhelming** - Show what they need now, not everything at once
- **Provide examples** - Show concrete use cases, not just theory
- **Include next steps** - Always tell them what to do next
- **Adapt to familiarity** - Compact version for repeat users, detailed for newcomers
- **Use visual structure** - Tree views, tables, clear sections
- **Reference commands** - Show actual commands they can run
- **Be encouraging** - Positive, supportive tone

#### ❌ DON'T:
- **Overwhelm with theory** - Keep explanations practical
- **Assume knowledge** - Explain concepts clearly
- **Skip examples** - Always show concrete use cases
- **Be vague** - Specific commands and steps
- **Use jargon unnecessarily** - Plain language where possible
- **Lecture** - Be conversational, not academic
- **Leave them stuck** - Always provide next actions

### Context-Aware Presentation

#### For CLI Tools (Claude Code)
- Use tree command output format for directory structures
- Format commands with backticks: `/para-init`
- Use markdown tables for comparisons
- Keep output scannable with clear headers

#### For GUI Tools (Cursor, Copilot)
- Use visual markers (✅ ❌ 📋 🚀)
- Consider collapsible sections if supported
- Use tables and lists for scannability
- Maintain same content, adapt presentation

### Timing and Frequency

**First Time Users:**
- Show comprehensive guidance after `/para-init`
- Offer `/para-help` in every response until they use it
- Provide decision support with `/para-check` reference

**Returning Users:**
- Compact reminders when needed
- Assume they know basics
- Focus on specific help they request

**All Users:**
- Always available via `/para-help`
- Status check via `/para-status`
- Decision support via `/para-check`

### Example Interactions

#### Example 1: User Asks About PARA
```
User: "How do I use PARA-Programming?"
Claude: I'll help you learn PARA-Programming! It's a structured workflow for working with AI assistants. Let me show you the basics:

[Shows compact version of guidance from above]

For the complete guide, run `/para-help`.
```

#### Example 2: After Running `/para-init`
```
[Claude automatically shows comprehensive onboarding output per template above]
```

#### Example 3: User Starts Task Without Planning
```
User: "Add authentication to the API"

Claude: I'll create a plan for implementing authentication. This requires code changes, so let's follow the PARA workflow.

[Claude runs /para-plan internally or prompts user to run it]
```

#### Example 4: User Asks Simple Question
```
User: "Where is the authentication middleware defined?"

Claude: The authentication middleware is in src/middleware/auth.ts:45-89.

[No PARA workflow - this is informational only]
```

---

### Summary: Key Points

**Goal:** Make PARA-Programming accessible and intuitive for all users, especially newcomers.

**Method:**
1. **Automatic guidance** after `/para-init`
2. **On-demand help** via `/para-help`
3. **Context-aware assistance** based on user familiarity
4. **Decision support** via `/para-check`

**Tone:** Helpful, encouraging, practical (not overwhelming or academic)

**Format:** Visual, scannable, action-oriented

**Outcome:** Users feel guided and confident using PARA-Programming methodology.

