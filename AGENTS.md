# AGENTS.md – PARA-Programming Methodology

**Universal instructions for AI coding assistants**

> **Purpose:** This file defines the PARA-Programming workflow – a structured, auditable methodology for AI-assisted software development with persistent context management.
>
> **Compatibility:** Works with Claude Code, Cursor, OpenAI Codex CLI, GitHub Copilot, and other AI coding tools via symlinks.

---

## Quick Reference

| Workflow | Plan → Review → Execute → Summarize → Archive |
|----------|-----------------------------------------------|
| **Use for** | Code changes, features, bug fixes, refactoring, architecture decisions |
| **Skip for** | Simple queries, code navigation, explanations, quick lookups |
| **Rule of thumb** | If it results in git changes, use the PARA workflow |

---

## Core Concepts

### The Second Brain System

PARA-Programming structures human-AI collaboration as a *shared cognitive system*:

* **AI Agent = Active Reasoning** – Processes context, generates plans and code
* **Human = Intent & Judgment** – Provides direction, reviews, approves
* **Context Directory = Memory Layer** – Persists knowledge across sessions
* **Tool Integration = Execution Layer** – Handles preprocessing and automation

### Goals

1. **Accuracy** – Consistent, context-aware outputs across sessions
2. **Token Efficiency** – Minimal active context through persistent storage and preprocessing
3. **Auditability** – Every action and decision captured in structured files
4. **Scalability** – Knowledge persists and grows over time

---

## Directory Structure

Every project using PARA-Programming includes a `context/` directory:

```
project-root/
├── AGENTS.md                     # Project-specific context (this file or symlink)
├── context/
│   ├── context.md                # Active session state
│   ├── plans/                    # Pre-work planning documents
│   ├── summaries/                # Post-work reports
│   ├── archives/                 # Historical context snapshots
│   ├── data/                     # Input files, payloads, datasets
│   └── servers/                  # Tool wrappers (MCP, preprocessing)
```

### Directory Details

| Directory | Purpose | File Naming |
|-----------|---------|-------------|
| `context/plans/` | Planning docs before code changes | `YYYY-MM-DD-task-name.md` |
| `context/summaries/` | Reports after completion | `YYYY-MM-DD-task-name-summary.md` |
| `context/archives/` | Historical context snapshots | `YYYY-MM-DD-context.md` |
| `context/data/` | Reference files, datasets | `YYYY-MM-DD-descriptive-name.ext` |
| `context/servers/` | Tool wrappers, preprocessing | No date prefix (persistent tools) |

---

## Workflow Loop

```
(Plan) → (Review) → (Execute) → (Summarize) → (Archive)
              ↑                           ↓
        Human Review                 Context Refresh
```

### When to Use PARA Workflow

**Always use for:**
- All code changes – Features, bug fixes, refactoring, optimizations
- Architecture decisions – Adding libraries, changing patterns
- File modifications – Creating, editing, or deleting project files
- Configuration changes – Build configs, dependencies, environment
- Database changes – Migrations, schema updates
- Testing implementation – Writing or modifying tests
- Complex debugging – Requiring investigation and fixes

**Skip for:**
- Simple queries – "What does this function do?"
- Code navigation – "Show me the auth logic"
- Explanations – "How does this work?"
- Quick lookups – "What version is X?"

---

## Step-by-Step Workflow

### 1. Plan

**First**, ensure the context directory exists:
```bash
mkdir -p context/{data,plans,summaries,archives,servers}
```

**Then**, create a plan file: `context/plans/YYYY-MM-DD-task-name.md`

**Required sections:**
```markdown
# Plan: [Task Name]

## Objective
[Clear, specific goal in 1-2 sentences]

## Approach
1. [Step with specifics]
2. [Step with specifics]
3. [Continue...]

## Files to Modify
- `path/to/file.ext:lines` - [What changes and why]

## Files to Create
- `path/to/new/file.ext` - [Purpose]

## Risks & Edge Cases
- [Risk and mitigation]

## Success Criteria
- [ ] [Testable criterion]
- [ ] [Testable criterion]
```

### 2. Review

After creating the plan:

1. **Present** the plan summary to the human
2. **Wait** for explicit approval – "approved", "proceed", "looks good"
3. **Adjust** based on feedback if needed

**Never proceed without human approval.**

### 3. Execute

#### Git Workflow (Required for Git Repositories)

1. **Create a new branch** when starting:
   ```bash
   git checkout -b para/task-name
   ```

2. **Track todos in `context/context.md`** during execution

3. **Commit after EVERY completed todo**:
   ```bash
   git add .
   git commit -m "feat: Description of completed work"
   ```

**Why commit per todo:**
- **Auditability:** Every change tracked with clear intent
- **Rollback:** Easy to revert individual changes
- **Collaboration:** Clear history for team members
- **Context preservation:** Git history complements summaries

#### Implementation Guidelines

- Only load files actively being modified
- Create summaries in `context/data/` for large files before analysis
- Request specific context rather than loading everything
- Show progress as you work through steps
- Document any deviations from the plan

### 4. Summarize

Create a summary file: `context/summaries/YYYY-MM-DD-task-name-summary.md`

**Required sections:**
```markdown
# Summary: [Task Name]

**Date:** YYYY-MM-DD
**Status:** Complete | Partial | Blocked

## Changes Made

### Files Modified
- `path/file.ext:lines` - [Description]

### Files Created
- `path/new.ext` (N lines) - [Purpose]

## Rationale
[Why these changes were made]

## Deviations from Plan
[What changed and why]

## Test Results
[Pass/fail status, coverage]

## Key Learnings
[Important insights, gotchas]

## Follow-up Tasks
[Remaining work, if any]
```

### 5. Archive

When the task is complete:

1. **Move** context to archives:
   ```bash
   mv context/context.md context/archives/$(date +%F)-context.md
   ```

2. **Create fresh** `context/context.md` for the next task

3. **Update** the JSON tracker with completed summaries

---

## The Master File: `context/context.md`

This file tracks active work with human-readable summary and JSON metadata:

```markdown
# Current Work Summary

[Brief description of current focus]

**Branch:** `para/task-name`
**Plan:** context/plans/YYYY-MM-DD-task-name.md

## To-Do List
- [ ] Item 1
- [ ] Item 2

## Progress Notes
[Updates as work progresses]

---

```json
{
  "active_context": [
    "context/plans/YYYY-MM-DD-task-name.md"
  ],
  "completed_summaries": [],
  "execution_branch": "para/task-name",
  "last_updated": "YYYY-MM-DDTHH:MM:SSZ"
}
```
```

---

## Token Efficiency

### Principles

| Principle | Implementation |
|-----------|----------------|
| **Selective Context** | Only load files being actively modified |
| **Preprocessing** | Summarize large files before feeding to AI |
| **Lazy Loading** | Request context only when needed |
| **State Awareness** | Use `context/` directory to persist state across sessions |

### Target Token Budgets

- **Plan phase:** 500-1000 tokens
- **Active execution:** 1000-2000 tokens at once
- **Summary:** 300-800 tokens

**Core principle:** Think with the smallest possible context, not the largest.

---

## Tool Integration

### MCP and Preprocessing

Tools in `context/servers/` can handle preprocessing:
- Summarize large codebases before analysis
- Filter datasets to relevant subsets
- Transform data formats
- Execute external commands

**Example workflow:**
1. **Preprocessing tool** summarizes repo structure → 2-3 key files
2. **AI agent** receives compact summary (1-2k tokens)
3. **AI agent** generates plan or code changes
4. **Postprocessing tool** applies changes

### Reference in Plans

```markdown
## Data Sources
- Preprocessing: `context/servers/summarize.ts` on src/auth/*
- Reference: `context/data/architecture-overview.md`
```

---

## Quality Checklist

Before marking any task complete:

- [ ] All tests pass
- [ ] No compiler/linter errors
- [ ] Code follows project conventions
- [ ] Summary documents all changes
- [ ] No security vulnerabilities introduced
- [ ] Human has reviewed and approved

---

## Error Handling

If something goes wrong:

1. **Document** the error in `context/data/error-YYYY-MM-DD.md`
2. **Update** the plan with a new approach
3. **Ask** for guidance if unsure how to proceed
4. **Don't mark complete** if tests fail or functionality is broken

---

## Project-Specific Configuration

This file (`AGENTS.md`) can be extended with project-specific context:

```markdown
---
# Project-Specific Context (add below this line)

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
```

Or create a separate project file that references this methodology.

---

## Setup for Different Tools

This `AGENTS.md` file works directly with:
- **Cursor** – Reads `AGENTS.md` natively
- **OpenAI Codex CLI** – Reads `AGENTS.md` natively

For other tools, create symlinks:

```bash
# Claude Code
ln -s AGENTS.md CLAUDE.md

# GitHub Copilot
mkdir -p .github
ln -s ../AGENTS.md .github/copilot-instructions.md

# Windsurf (Codeium)
mkdir -p .windsurf/rules
ln -s ../../AGENTS.md .windsurf/rules/para-programming.md

# Continue.dev
mkdir -p .continue/rules
ln -s ../../AGENTS.md .continue/rules/para-programming.md
```

See `tool-setup/` for detailed setup guides per tool.

---

## Summary

PARA-Programming creates a **persistent, auditable, efficient development system** where human and AI work as a unified team:

- **Plan** before coding – No code without a reviewed plan
- **Human review** required – AI proposes, human approves
- **Minimal context** for efficiency – Load only what's needed
- **Complete documentation** of changes – Summaries capture everything
- **Historical preservation** – Archives maintain institutional knowledge

> *"Think with the smallest possible context, not the largest."*

---

**Ready to start?** Create your context directory and first plan:

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
# Then describe your task and create a plan
```
