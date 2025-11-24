# PARA-Programming

**A systematic methodology for AI-assisted development using structured context, persistent memory, and intelligent execution.**

PARA-Programming combines the organizational principles of [Tiago Forte's PARA method](https://fortelabs.com/blog/para/) (Projects, Areas, Resources, Archives) with the collaborative nature of pair programming to create an efficient, auditable, and scalable approach to working with AI coding assistants like Claude.

---

> **🚀 Ready to start now?** Get up and running in 10 seconds:
>
> ```bash
> git clone https://github.com/para-programming/para-programming.git
> cd para-programming
> make setup claude-skill  # or: cursor, copilot
> ```
>
> **[→ Automated Setup Guide](AUTOMATED-SETUP.md)** - One-command installation
>
> **[→ Manual Setup Guide](SETUP-GUIDE.md)** - Step-by-step instructions

---

## Table of Contents

- [What is PARA-Programming?](#what-is-para-programming)
- [Why PARA-Programming?](#why-para-programming)
- [Core Principles](#core-principles)
- [The PARA Structure](#the-para-structure)
- [The Workflow Loop](#the-workflow-loop)
- [Getting Started](#getting-started)
- [IDE & Agent Setup](#ide--agent-setup)
- [Token Efficiency & MCP Integration](#token-efficiency--mcp-integration)
- [Examples](#examples)
- [Best Practices](#best-practices)
- [Contributing](#contributing)

---

## What is PARA-Programming?

PARA-Programming is a methodology for organizing AI-assisted software development into a structured, persistent, and token-efficient workflow. It treats your collaboration with AI as a **shared cognitive system**:

- **AI = Active Reasoning** – Analyzing, planning, and generating code
- **Human = Intent & Judgment** – Providing goals, reviewing decisions, and validating outputs
- **Context Directory = Memory Layer** – Persistent storage of plans, data, and summaries
- **MCP Servers = Execution Layer** – Tools that preprocess data and execute tasks outside the AI's context window

By separating **what to do** (project context) from **how to work** (methodology), PARA-Programming enables consistent, efficient, and auditable collaboration across all your projects.

### The Name

**PARA-Programming** draws inspiration from two sources:

1. **PARA Method** – Tiago Forte's knowledge management system that organizes information into Projects, Areas, Resources, and Archives
2. **Pair Programming** – The collaborative practice of two developers working together, adapted here for human-AI collaboration

---

## Why PARA-Programming?

### Traditional Problems with AI Coding Assistants

- **Context loss** between sessions
- **Token waste** from repeatedly loading the same information
- **No audit trail** of what was changed and why
- **Inconsistent methodology** across projects
- **Lack of preprocessing** leading to information overload

### The PARA-Programming Solution

| Problem | PARA-Programming Solution |
|---------|---------------------------|
| Context loss | Structured `context/` directory with persistent plans, summaries, and archives |
| Token waste | MCP preprocessing and selective context loading (1-2k tokens per step) |
| No audit trail | Every action captured in plans, summaries, and archives with timestamps |
| Inconsistent methodology | Global `CLAUDE.md` defines workflow across all projects |
| Information overload | MCP servers preprocess and filter data before it reaches the AI |

---

## Core Principles

### 1. Separation of Concerns

**Global vs. Local Context:**
- **Global** (`~/.claude/CLAUDE.md`): Workflow methodology, MCP patterns, token efficiency strategies
- **Local** (`<project>/CLAUDE.md`): Project-specific architecture, tech stack, conventions

### 2. Persistent Memory

All work artifacts are stored in a structured `context/` directory:
- **Plans** before execution
- **Data** for reference
- **Summaries** after completion
- **Archives** for historical record

### 3. Token Efficiency

Keep AI context minimal through:
- **Preprocessing** large datasets in MCP servers
- **Selective loading** of only relevant information
- **Summarization** instead of full data dumps
- Target: ≤1-2k tokens of active context per step

### 4. Auditability

Every action includes:
- **What** was done
- **Why** it was done
- **When** it was done
- **Which tools** were used

### 5. The Second Brain Model

```
┌─────────────────────────────────────────┐
│         Human (Intent & Judgment)       │
└────────────────┬────────────────────────┘
                 │
┌────────────────▼────────────────────────┐
│      AI (Active Reasoning Layer)        │
└────────┬───────────────────────┬────────┘
         │                       │
┌────────▼────────┐    ┌────────▼─────────┐
│  Context Dir    │    │   MCP Servers    │
│  (Memory)       │    │   (Execution)    │
│                 │    │                  │
│ • Plans         │    │ • Preprocessing  │
│ • Data          │    │ • Tool wrappers  │
│ • Summaries     │    │ • API calls      │
│ • Archives      │    │ • File ops       │
└─────────────────┘    └──────────────────┘
```

---

## The PARA Structure

### Directory Layout

Every project following PARA-Programming includes:

```
project-root/
├── context/
│   ├── context.md              # Active session state
│   ├── data/                   # Input files, payloads, datasets
│   ├── plans/                  # Pre-work planning documents
│   ├── summaries/              # Post-work reports
│   ├── archives/               # Historical context snapshots
│   └── servers/                # MCP tool wrappers
├── CLAUDE.md                   # Project-specific context
└── [your project files...]
```

### The Master File: `context/context.md`

Tracks the current state of work with both human-readable and machine-parseable sections:

````markdown
# Current Work Summary
Implementing authentication system with OAuth2 support.

---
```json
{
  "active_context": [
    "context/plans/oauth2-implementation.md",
    "context/data/oauth-config.json",
    "context/servers/auth/validateToken.ts"
  ],
  "completed_summaries": [
    "context/summaries/user-model-setup.md"
  ],
  "last_updated": "2025-11-09T14:30:00Z"
}
```
````

### Context Directory Breakdown

| Directory | Purpose | Example Contents |
|-----------|---------|------------------|
| `context/data/` | Input/output files, API payloads, datasets | `api-response.json`, `test-data.csv`, `schema.sql` |
| `context/plans/` | Pre-execution planning documents | `feature-spec.md`, `refactor-approach.md`, `bug-fix-plan.md` |
| `context/summaries/` | Post-execution reports | `migration-results.md`, `performance-improvements.md` |
| `context/archives/` | Historical snapshots of `context.md` | `context-2025-11-09-1430.md` |
| `context/servers/` | MCP tool wrappers for preprocessing | `github/fetchRepo.ts`, `api/summarizeResponse.ts` |

---

## The Workflow Loop

```
┌──────┐      ┌────────┐      ┌─────────┐      ┌───────────┐      ┌─────────┐
│ Plan │─────▶│ Review │─────▶│ Execute │─────▶│ Summarize │─────▶│ Archive │
└──────┘      └───┬────┘      └─────────┘      └───────────┘      └─────────┘
                  │                                    │
                  │                                    │
            ┌─────▼──────┐                     ┌───────▼────────┐
            │   Human    │                     │    Context     │
            │  Approval  │                     │    Refresh     │
            └────────────┘                     └────────────────┘
```

### Step 1: Plan

**AI creates a planning document** in `context/plans/` that includes:
- Objective
- Approach/methodology
- Risks and edge cases
- Data sources required
- MCP tools to be used
- Success criteria

**Example:** `context/plans/add-user-authentication.md`

```markdown
# Plan: Add User Authentication

## Objective
Implement JWT-based authentication for the API with refresh token support.

## Approach
1. Create user authentication middleware
2. Implement JWT generation and validation
3. Add refresh token endpoint
4. Update existing routes to require authentication

## Risks
- Token expiration handling
- Secure storage of refresh tokens
- Rate limiting on auth endpoints

## Data Sources
- context/data/jwt-config.json
- Existing user model in src/models/User.ts

## MCP Tools
- context/servers/crypto/generateToken.ts
- context/servers/db/userOperations.ts

## Success Criteria
- [ ] All auth tests passing
- [ ] Token refresh flow working
- [ ] Protected routes return 401 for unauthenticated requests
```

### Step 2: Review

**Human validates the plan** before execution:
- Does it align with project goals?
- Are the technical choices sound?
- Are all edge cases considered?
- Are the right MCP tools specified?

AI pauses and requests explicit approval.

### Step 3: Execute

**AI implements the plan** using:
- Direct code changes
- MCP servers for preprocessing (filtering CSVs, summarizing API responses, etc.)
- Only relevant, preprocessed data in context (keeping token count low)

**Example MCP preprocessing:**

```typescript
// context/servers/github/fetchRepo.ts
export async function fetchRepoSummary(repo: string) {
  const files = await github.listFiles(repo);

  // Preprocess: filter and compress BEFORE sending to AI
  const relevantFiles = files
    .filter(f => !f.includes('node_modules'))
    .filter(f => f.endsWith('.ts') || f.endsWith('.md'))
    .slice(0, 50);

  return {
    totalFiles: files.length,
    relevantFiles,
    structure: inferStructure(relevantFiles)
  };
}
```

### Step 4: Summarize

**AI creates a summary** in `context/summaries/` that captures:
- What changed
- Why those changes were made
- Which MCP tools were used
- Key learnings or decisions
- Links to relevant code

**Example:** `context/summaries/user-auth-implementation.md`

```markdown
# Summary: User Authentication Implementation

**Date:** 2025-11-09
**Duration:** 45 minutes
**Status:** ✅ Complete

## Changes Made

### Files Modified
- `src/middleware/auth.ts:1-87` – New authentication middleware
- `src/routes/api.ts:23-45` – Protected route configuration
- `src/models/User.ts:67-89` – Added refresh token field

### Files Created
- `src/utils/jwt.ts` – JWT generation and validation utilities
- `tests/auth.test.ts` – Authentication test suite

## Rationale

Chose JWT over session-based auth for stateless API design. Implemented refresh tokens to balance security (short-lived access tokens) with UX (don't require frequent re-login).

## MCP Tools Used
- `context/servers/crypto/generateToken.ts` – Secure token generation
- `context/servers/db/userOperations.ts` – Database user lookups

## Key Learnings
- Need to add rate limiting to prevent brute force attacks (follow-up task)
- Consider adding IP allowlisting for admin routes

## Test Results
✅ 24/24 tests passing
✅ Code coverage: 94%
```

### Step 5: Archive

**Move context to archives** and refresh for next task:

```bash
# Archive the completed context
mv context/context.md context/archives/context-$(date +%F-%H%M).md

# Start fresh (or seed with ongoing context if needed)
echo "# Current Work Summary\n[Next task...]\n" > context/context.md
```

This creates a full audit trail while keeping active context clean.

---

## Getting Started

> **📖 Prefer detailed setup instructions?** See the **[Setup Guide](SETUP-GUIDE.md)** for step-by-step instructions tailored to your specific AI assistant.

This section provides a quick overview of the setup process. For complete guides with templates and examples, see the dedicated guides for [Claude](claude/), [Copilot](copilot/), or [Cursor](cursor/).

### 1. Set Up Global Methodology

Copy the global `CLAUDE.md` to your home directory:

```bash
cp CLAUDE.md ~/.claude/CLAUDE.md
```

This file defines **how** you work with AI across all projects.

### 2. Initialize Your Project

Create the PARA structure in your project:

```bash
cd your-project/
mkdir -p context/{data,plans,summaries,archives,servers}
touch context/context.md
```

### 3. Create Project Context File

Create a `CLAUDE.md` in your project root with project-specific information:

````markdown
# My Project

> **Workflow Methodology:** Follow `~/.claude/CLAUDE.md`

## About
A web application for task management with real-time collaboration.

## Tech Stack
- Next.js 14 (React framework)
- PostgreSQL (database)
- Prisma (ORM)
- Socket.io (real-time features)

## Structure
```
src/
├── app/          # Next.js app directory
├── components/   # React components
├── lib/          # Shared utilities
└── server/       # API routes and server logic
```

## Key Files
- `src/lib/db.ts`: Database connection setup
- `src/server/socket.ts`: WebSocket event handlers

## Conventions
- Use Server Components by default
- API routes in `src/app/api/`
- Tailwind for styling

## Getting Started
```bash
npm install
npm run dev
```
````

### 4. Start Your First Task

Seed your `context/context.md`:

````markdown
# Current Work Summary
Setting up user authentication system.

---
```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "2025-11-09T10:00:00Z"
}
```
````

### 5. Follow the Workflow Loop

Tell your AI assistant:

> "Follow the PARA-Programming methodology from `~/.claude/CLAUDE.md`. Let's implement user authentication. Start by creating a plan."

The AI will:
1. Create a plan in `context/plans/`
2. Ask for your review
3. Execute the plan
4. Write a summary in `context/summaries/`
5. Archive the context

---

## IDE & Agent Setup

PARA-Programming works with **any AI coding assistant**. The methodology remains consistent—only the setup varies.

### 🎯 Choose Your Guide

We provide **comprehensive, dedicated guides** for the three most popular AI assistants:

| AI Assistant | IDE | Guide | What's Included |
|--------------|-----|-------|-----------------|
| **🤖 Claude Code** | CLI | **[→ Claude Guide](claude/)** | Global methodology, project templates, MCP integration, quickstart |
| **🔷 Codex CLI** | CLI | **[→ Codex Guide](codex/)** | Global methodology, project templates, preprocessing patterns, quickstart |
| **✨ GitHub Copilot** | VSCode, JetBrains, Neovim | **[→ Copilot Guide](copilot/)** | Instructions file, templates, examples, quickstart |
| **🔮 Cursor** | Standalone IDE | **[→ Cursor Guide](cursor/)** | Cursor rules, Composer integration, templates, quickstart |

**Each guide contains:**
- ✅ Complete setup instructions
- ✅ Configuration files and templates
- ✅ Quickstart tutorials
- ✅ Working examples
- ✅ Best practices and tips

### Quick Setup

**1. Choose your AI assistant** from the table above and open its guide

**2. Follow the quickstart** in that guide (typically 5-10 minutes)

**3. Start using PARA-Programming** with the five-step workflow

### Using Another AI Assistant?

For other tools (JetBrains AI, Continue.dev, Codeium, etc.):

📖 **[Universal Agent Instructions →](other-ai-assitants/AGENT-INSTRUCTIONS.md)**

This guide shows how to adapt PARA-Programming to any AI assistant:
- Agent compatibility matrix
- Workflow adaptations for different capabilities
- Platform-specific features and workarounds
- Examples for multiple AI assistants

### Key Principle: Methodology First, Tools Second

**PARA-Programming is tool-agnostic.** The five-step workflow (Plan → Review → Execute → Summarize → Archive) remains the same across all tools. Only the implementation details change.

---

## Token Efficiency & MCP Integration

### The Token Problem

Modern LLMs have large context windows (100k-200k tokens), but:
- **Loading everything is wasteful** – Most information isn't relevant to the current task
- **Costs scale linearly** – More tokens = more money and slower responses
- **Context overflow** – Large codebases can't fit entirely in context

### The PARA Solution: Hybrid Architecture

```
┌──────────────────────────────────────────────┐
│  Large Data (100k+ tokens)                   │
│  • Full codebase                             │
│  • API documentation                         │
│  • Large datasets                            │
└─────────────────┬────────────────────────────┘
                  │
         ┌────────▼─────────┐
         │   MCP Server     │ ◄── Preprocess, filter, summarize
         │  (Preprocessing) │
         └────────┬─────────┘
                  │
         ┌────────▼─────────┐
         │  Small Context   │ ◄── 1-2k tokens sent to AI
         │  (Relevant only) │
         └────────┬─────────┘
                  │
         ┌────────▼─────────┐
         │   AI Reasoning   │ ◄── Works with minimal, relevant context
         └──────────────────┘
```

### Example: Efficient Repository Analysis

**Without PARA-Programming (wasteful):**
```
Input: Entire 50,000-line codebase (150k tokens)
AI: Analyze entire codebase to find authentication logic
Cost: $0.30 per query
Speed: 15 seconds
```

**With PARA-Programming (efficient):**
```
1. MCP Server: Scan codebase, filter for auth-related files
2. MCP Server: Extract and summarize key functions
3. Send to AI: Summary of 3 relevant files (2k tokens)
4. AI: Analyze summarized context and provide insights
Cost: $0.01 per query
Speed: 2 seconds
```

### MCP Efficiency Principles

| Principle | Implementation | Benefit |
|-----------|----------------|---------|
| **Persistent Execution** | Code in `context/servers/` handles heavy operations | AI stays stateless and fast |
| **Selective Context** | Load only what's needed for current task | Minimal token usage |
| **Preprocessing** | Transform/summarize before prompting | Reduce noise, increase signal |
| **Lazy Loading** | Dynamically load tools at runtime | No upfront overhead |
| **State Awareness** | MCP maintains state between steps | AI doesn't need to remember everything |

### Example MCP Wrapper: Smart API Summarizer

```typescript
// context/servers/api/summarizeResponse.ts
import { mcpClient } from './sdk';

export async function fetchAndSummarizeAPI(endpoint: string) {
  // Fetch large API response
  const response = await mcpClient.fetch(endpoint);
  const data = await response.json();

  // Preprocess: Extract only what matters
  const summary = {
    recordCount: data.items.length,
    schema: inferSchema(data.items[0]),
    sample: data.items.slice(0, 3),
    metadata: {
      timestamp: data.timestamp,
      version: data.version
    }
  };

  // Return compact summary instead of full dataset
  return summary;
}

function inferSchema(obj: any): Record<string, string> {
  return Object.fromEntries(
    Object.entries(obj).map(([key, value]) =>
      [key, typeof value]
    )
  );
}
```

**Usage in workflow:**

```typescript
// Instead of sending 50k tokens of API data to AI...
const fullData = await fetch('/api/users'); // 50k tokens

// ...preprocess and send only 500 tokens
const summary = await fetchAndSummarizeAPI('/api/users');
// AI receives: { recordCount: 1247, schema: {...}, sample: [...] }
```

---

## Examples

### Example 1: Adding a Feature

**Task:** Add real-time notifications to a web app

**1. Plan** (`context/plans/realtime-notifications.md`):
```markdown
# Plan: Real-Time Notifications

## Objective
Add WebSocket-based notification system for user actions.

## Approach
1. Set up Socket.io server
2. Create notification event handlers
3. Build notification UI component
4. Integrate with existing user actions (likes, comments, follows)

## MCP Tools
- context/servers/websocket/setupServer.ts
- context/servers/db/notificationQueries.ts
```

**2. Review:** Human approves plan

**3. Execute:** AI implements using MCP servers

**4. Summarize** (`context/summaries/realtime-notifications-complete.md`):
```markdown
# Summary: Real-Time Notifications

## Changes
- Added Socket.io server setup in src/server/socket.ts
- Created NotificationBadge component
- Integrated with user action events

## MCP Tools Used
- Preprocessed existing event system to identify integration points
- Used websocket/setupServer.ts for boilerplate generation

## Results
✅ Notifications appear in real-time
✅ All tests passing
✅ Handles 1000+ concurrent connections
```

**5. Archive:** Context moved to `context/archives/context-2025-11-09-1145.md`

### Example 2: Debugging Production Issue

**1. Plan** (`context/plans/debug-memory-leak.md`):
```markdown
# Plan: Debug Memory Leak

## Objective
Identify and fix memory leak causing server crashes after 6 hours.

## Approach
1. Analyze heap dumps from production
2. Identify leaked object types
3. Trace to source code
4. Implement fix and verify

## Data Sources
- context/data/heap-dump-2025-11-09.heapsnapshot
- context/data/monitoring-logs.json

## MCP Tools
- context/servers/profiling/analyzeHeap.ts (preprocesses heap dump)
```

**2. Review:** Approved

**3. Execute:**
- MCP server analyzes 500MB heap dump
- Returns 2k token summary: "5000+ listener objects not being removed"
- AI identifies source: event listeners in WebSocket component

**4. Summarize** (`context/summaries/memory-leak-fixed.md`):
```markdown
# Summary: Memory Leak Fix

## Root Cause
WebSocket event listeners were not being cleaned up on component unmount.

## Fix
Added cleanup function to useEffect hook to remove listeners.

## Files Changed
- src/hooks/useWebSocket.ts:45-52

## Verification
- Ran 12-hour stress test
- Memory usage stable at 120MB (previously growing to 2GB)
```

### Example 3: Code Review & Refactoring

**1. Plan** (`context/plans/refactor-auth-module.md`):
```markdown
# Plan: Refactor Authentication Module

## Objective
Improve code quality and test coverage of auth module.

## Approach
1. Analyze current implementation
2. Identify code smells and duplication
3. Extract reusable utilities
4. Add missing tests

## MCP Tools
- context/servers/analysis/codeMetrics.ts
```

**2. Execute with MCP preprocessing:**
```typescript
// MCP server analyzes code and returns summary
{
  "duplicatedCode": [
    "Token validation logic appears 4 times",
    "User lookup pattern repeated in 3 functions"
  ],
  "missingTests": ["Refresh token expiration", "Invalid signature handling"],
  "complexity": { "high": ["validateAndRefresh()"], "medium": [...] }
}
```

**3. AI refactors based on 2k token summary instead of reading full 5k line codebase**

---

## Best Practices

### Do's ✅

- **Keep plans concise** – 1-2 pages max, focus on approach and risks
- **Preprocess aggressively** – Filter and summarize in MCP before sending to AI
- **Archive regularly** – Don't let `context/context.md` grow unbounded
- **Update local CLAUDE.md** – Keep project context current as architecture evolves
- **Review before execution** – Human judgment prevents costly mistakes
- **Document MCP tools** – Each server should have clear purpose and usage

### Don'ts ❌

- **Don't duplicate workflow in local files** – Reference global `~/.claude/CLAUDE.md`
- **Don't skip the planning step** – Always plan before executing
- **Don't send raw data to AI** – Always preprocess through MCP first
- **Don't let context grow stale** – Archive completed work promptly
- **Don't forget timestamps** – Every plan, summary, and archive needs dates
- **Don't mix concerns** – Keep workflow (global) separate from project context (local)

### Token Budget Guidelines

Aim for these token budgets per workflow step:

| Step | Target Token Count | Content |
|------|-------------------|---------|
| **Plan** | 500-1000 tokens | Objective, approach, risks, tools |
| **Execute** | 1000-2000 tokens | Preprocessed data summaries, relevant code snippets |
| **Summarize** | 300-800 tokens | What changed, why, results, learnings |

**Total per task: ~2000-4000 tokens** vs. 50k+ tokens with naive approach

### MCP Server Organization

Organize your MCP tools by domain:

```
context/servers/
├── github/
│   ├── fetchRepo.ts
│   └── analyzeStructure.ts
├── api/
│   ├── summarizeResponse.ts
│   └── validateSchema.ts
├── db/
│   ├── queryOptimizer.ts
│   └── schemaInference.ts
├── analysis/
│   ├── codeMetrics.ts
│   └── securityScan.ts
└── utils/
    ├── tokenCounter.ts
    └── logger.ts
```

---

## Real-World Adoption

### For Individual Developers

**Use Case:** Managing multiple side projects with consistent workflow

**Benefits:**
- Quickly context-switch between projects
- Maintain detailed history of decisions
- Minimize token costs with efficient context loading
- Build reusable MCP tools across projects

### For Teams

**Use Case:** Standardizing AI-assisted development across engineering org

**Benefits:**
- Consistent methodology across team members
- Auditable trail of AI-generated code changes
- Knowledge sharing through summaries and archives
- Efficient onboarding (new devs read archived contexts)

### For Consultants

**Use Case:** Managing multiple client projects with different tech stacks

**Benefits:**
- Each client has their own local `CLAUDE.md`
- Global workflow stays consistent
- Easy to hand off projects (context directory documents everything)
- Transparent process for client auditing

---

## Comparison with Other Approaches

| Approach | Context Management | Token Efficiency | Auditability | Scalability |
|----------|-------------------|------------------|--------------|-------------|
| **Naive prompting** | ❌ Lost between sessions | ❌ Loads everything | ❌ No record | ❌ Doesn't scale |
| **Copy-paste workflow** | ⚠️ Manual context assembly | ❌ Repetitive loading | ⚠️ Partial (in chat) | ❌ High maintenance |
| **Custom RAG system** | ✅ Vector DB storage | ⚠️ Requires indexing | ❌ Black box | ⚠️ Complex setup |
| **PARA-Programming** | ✅ Structured files + MCP | ✅ Preprocessed context | ✅ Full audit trail | ✅ Works across projects |

---

## Advanced Topics

### Multi-Project Context Sharing

Share MCP servers across projects:

```bash
# Symlink shared MCP tools
ln -s ~/.claude/shared-servers/ ./context/servers/shared

# Reference in local CLAUDE.md
"Shared MCP tools available in context/servers/shared/"
```

### CI/CD Integration

Add PARA artifacts to your CI pipeline:

```yaml
# .github/workflows/claude-audit.yml
name: Claude Context Audit

on: [pull_request]

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Check for summary
        run: |
          if [ ! -f context/summaries/*-$(date +%F).md ]; then
            echo "::warning::No summary found for today's changes"
          fi
      - name: Verify plan exists
        run: |
          # Ensure every PR has a corresponding plan
          # (your custom logic here)
```

### Team Knowledge Base

Archive directories become searchable knowledge bases:

```bash
# Search all past contexts
grep -r "authentication" context/archives/

# Find when a decision was made
grep -r "why we chose JWT" context/summaries/
```

---

## FAQ

### Q: Do I need MCP to use PARA-Programming?

**A:** No, but MCP significantly enhances efficiency. You can start with just the Plan → Review → Execute → Summarize → Archive workflow and add MCP preprocessing later.

### Q: How is this different from just using a good prompt?

**A:** PARA-Programming is a **methodology**, not a prompt. It provides:
- Persistent structure across sessions
- Separation of global workflow from project context
- Audit trail of all changes
- Token efficiency through preprocessing
- Scalability across multiple projects

### Q: Can I use this with GitHub Copilot / Cursor / other tools?

**A:** Yes! PARA-Programming is tool-agnostic. The `context/` directory and `CLAUDE.md` files work with any AI coding assistant. The methodology adapts to your tool of choice.

### Q: How much time does this add to development?

**A:** Initial setup: ~15 minutes per project. Per-task overhead: ~2-5 minutes (planning + summarizing). However, this is offset by:
- Faster debugging (complete audit trail)
- Reduced rework (human review before execution)
- Lower token costs (efficient context loading)
- Better knowledge retention (summaries and archives)

### Q: What if my project doesn't need all this structure?

**A:** Start minimal! Even just adopting the Plan → Review → Execute loop provides value. Add summaries, archives, and MCP servers as your project grows in complexity.

---

## Contributing

We welcome contributions to improve PARA-Programming! Areas for contribution:

- **MCP Server Examples** – Share your preprocessing tools
- **Local CLAUDE.md Templates** – For different tech stacks (Python, Go, Rust, etc.)
- **Case Studies** – Real-world adoption stories
- **Tooling** – Scripts to automate context management
- **Documentation** – Clarifications, examples, translations

### How to Contribute

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/amazing-contribution`)
3. Make your changes following the PARA-Programming methodology
   - Create a plan in `context/plans/`
   - Implement your changes
   - Write a summary in `context/summaries/`
4. Commit your changes (`git commit -m 'Add amazing contribution'`)
5. Push to the branch (`git push origin feature/amazing-contribution`)
6. Open a Pull Request

### Style Guidelines

- Follow the existing structure and formatting
- Include examples for any new concepts
- Keep documentation concise but complete
- Test any MCP server code before submitting

---

## Resources

### Official Documentation
- [Claude Code Documentation](https://docs.anthropic.com/claude/docs)
- [Model Context Protocol (MCP) Spec](https://modelcontextprotocol.io/)
- [PARA Method by Tiago Forte](https://fortelabs.com/blog/para/)

### Related Projects
- [aider](https://github.com/paul-gauthier/aider) – AI pair programming in the terminal
- [continue.dev](https://continue.dev/) – Open-source AI code assistant
- [Cursor](https://cursor.sh/) – AI-first code editor

### Community
- [Discussions](../../discussions) – Ask questions, share experiences
- [Issues](../../issues) – Report bugs or request features

---

## License

MIT License - see [LICENSE](LICENSE) for details

---

## Acknowledgments

- **Tiago Forte** – For the PARA method that inspired this methodology
- **Anthropic** – For Claude and the Model Context Protocol
- **The AI coding community** – For pushing the boundaries of human-AI collaboration

---

## Quick Start Checklist

> **💡 New to PARA-Programming?** For detailed, step-by-step setup instructions, see the **[Setup Guide →](SETUP-GUIDE.md)**

Ready to adopt PARA-Programming? Follow this checklist:

- [ ] Copy `CLAUDE.md` to `~/.claude/CLAUDE.md` (global workflow)
- [ ] Create `context/` directory structure in your project
- [ ] Write a local `CLAUDE.md` for your project (architecture, tech stack, conventions)
- [ ] Initialize `context/context.md` with your first task
- [ ] Create your first plan in `context/plans/`
- [ ] Execute with human review
- [ ] Write your first summary in `context/summaries/`
- [ ] Archive your context when complete
- [ ] (Optional) Set up your first MCP server for preprocessing

**Welcome to PARA-Programming! Build better software, faster, with AI.**

---

<div align="center">

**[Quick Setup →](SETUP-GUIDE.md)** • **[Get Started](#getting-started)** • **[Read the Docs](CLAUDE.md)** • **[Join Discussions](../../discussions)**

Made with ⚡ by developers who believe AI should augment human intelligence, not replace it.

</div>
