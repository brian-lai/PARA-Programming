# AGENTS.md - Pret-a-Program Methodology

**Universal instructions for AI coding assistants**

> **Purpose:** Defines the Pret-a-Program workflow - a structured, auditable methodology for AI-assisted development with persistent context management.
>
> **Compatibility:** Works with Claude Code, Cursor, OpenAI Codex CLI, GitHub Copilot, and other AI coding tools.

---

## Quick Reference

| Workflow | Plan -> Review -> Execute -> Summarize -> Archive |
|----------|---------------------------------------------------|
| **Use for** | Code changes, features, bug fixes, refactoring, architecture decisions |
| **Skip for** | Simple queries, code navigation, explanations, quick lookups |
| **Rule of thumb** | If it results in git changes, use the Pret workflow |

---

## Directory Structure

```
project-root/
├── AGENTS.md                     # This file
├── context/
│   ├── context.md                # Active session state
│   ├── plans/                    # Pre-work planning documents
│   ├── summaries/                # Post-work reports
│   ├── archives/                 # Historical context snapshots
│   ├── data/                     # Input files, datasets
│   └── servers/                  # Tool wrappers (MCP, preprocessing)
```

All context files use `YYYY-MM-DD-descriptive-name` naming for chronological ordering.

---

## Workflow

```
(Plan) -> (Review) -> (Execute) -> (Summarize) -> (Archive)
               ^                          |
         Human Review                Context Refresh
```

### 1. Plan

Create: `context/plans/YYYY-MM-DD-task-name.md`

Required sections: Objective, Approach, Files to Modify, Risks, Success Criteria.

### 2. Review

Present the plan. **Wait for explicit human approval** before proceeding.

### 3. Execute

1. Create branch: `git checkout -b pret/task-name`
2. Track progress in `context/context.md`
3. **Commit after every completed step**
4. Document deviations from plan

### 4. Summarize

Create: `context/summaries/YYYY-MM-DD-task-name-summary.md`

Document: Changes made, rationale, test results, key learnings.

### 5. Archive

Move `context/context.md` to `context/archives/YYYY-MM-DD-context.md` and start fresh.

---

## Token Efficiency

- Only load files being actively modified
- Summarize large files before analysis
- Request context only when needed
- Think with the smallest possible context, not the largest

---

## Project-Specific Context

Add your project details below this line:

---

## About This Project

[Project description]

## Architecture

[High-level system design]

## Tech Stack

- [Language/Framework]
- [Database]
- [Key libraries]

## Conventions

- [Coding standards]
- [Git practices]
- [Testing requirements]
