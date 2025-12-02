# Universal Agent Instructions for PARA-Programming

**A unified methodology for AI-assisted development across all coding assistants and IDEs**

> **Core Principle:** The PARA-Programming workflow remains consistent regardless of which AI agent you use. Only the implementation details change.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Agent Compatibility Matrix](#agent-compatibility-matrix)
- [Universal Instructions](#universal-instructions)
- [IDE-Specific Setup](#ide-specific-setup)
- [Workflow Adaptation Guide](#workflow-adaptation-guide)
- [Platform-Specific Features](#platform-specific-features)

---

## Overview

This document provides instructions for implementing PARA-Programming methodology with popular AI coding assistants:

- **GitHub Copilot** (VSCode, JetBrains, Neovim)
- **Cursor** (Standalone IDE)
- **JetBrains AI Assistant** (IntelliJ, PyCharm, WebStorm, etc.)
- **Continue.dev** (VSCode, JetBrains)
- **Codeium** (Multi-IDE)
- **Amazon CodeWhisperer** (VSCode, JetBrains)
- **Tabnine** (Multi-IDE)

### Core PARA Principles (Agent-Agnostic)

These principles apply to **all** agents:

1. **Plan before executing** - No matter which agent, always create a plan first
2. **Human review gate** - Always pause for approval before implementation
3. **Persistent context** - Use the `context/` directory structure
4. **Token efficiency** - Preprocess large data, load selectively
5. **Audit trail** - Document all changes in summaries
6. **Archive completed work** - Move context files to archives

---

## Agent Compatibility Matrix

| Feature | GitHub Copilot | Cursor | JetBrains AI | Continue.dev | Codeium | CodeWhisperer | Tabnine |
|---------|---------------|--------|--------------|--------------|---------|---------------|---------|
| **Context Files** | ✅ (limited) | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ |
| **Multi-File Edits** | ❌ | ✅ | ⚠️ | ✅ | ❌ | ❌ | ❌ |
| **Custom Instructions** | ✅ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ |
| **MCP Support** | ❌ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
| **Chat Interface** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ |
| **PARA Compatibility** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐⭐ |

**Legend:**
- ✅ Full support
- ⚠️ Partial support or workaround needed
- ❌ Not supported
- ⭐ = 1-5 star PARA compatibility rating

---

## Universal Instructions

### Base Agent Prompt (Copy to Your IDE Settings)

Use this as the foundation for **any** AI coding assistant. Adapt the configuration section for your specific IDE:

````markdown
# AI Agent Instructions - PARA-Programming Methodology

You are an AI coding assistant following the PARA-Programming methodology. Your purpose is to help the developer write code efficiently while maintaining a structured, auditable, and token-efficient workflow.

## Core Workflow: Plan → Review → Execute → Summarize → Archive

Follow this loop for ALL significant coding tasks (3+ steps or non-trivial complexity):

### 1. Plan Phase
When the developer requests a feature, fix, or refactor:

1. **First, ensure the context directory exists:** If `context/` and its subdirectories don't exist, create them:
   ```bash
   mkdir -p context/{data,plans,summaries,archives,servers}
   ```
2. **Create a plan file** in `context/plans/[task-name].md`
3. **Include these sections:**
   - **Objective:** What are we trying to achieve?
   - **Approach:** How will we implement it? (step-by-step)
   - **Files to modify:** List all files that will change
   - **New files to create:** List any new files needed
   - **Risks/Edge cases:** What could go wrong?
   - **Data sources:** What context files or documentation do we need?
   - **Success criteria:** How do we know it's done?

3. **Example plan structure:**
```markdown
# Plan: Add User Authentication

## Objective
Implement JWT-based authentication with refresh token support.

## Approach
1. Create authentication middleware in `src/middleware/auth.ts`
2. Add JWT generation utilities in `src/utils/jwt.ts`
3. Update user model to include refresh tokens
4. Add auth routes for login/logout/refresh
5. Protect existing API routes with auth middleware

## Files to Modify
- `src/models/User.ts` - Add refreshToken field
- `src/routes/api.ts` - Apply auth middleware
- `package.json` - Add jsonwebtoken dependency

## New Files to Create
- `src/middleware/auth.ts` - JWT validation middleware
- `src/utils/jwt.ts` - Token generation/validation
- `src/routes/auth.ts` - Auth endpoints
- `tests/auth.test.ts` - Auth test suite

## Risks/Edge Cases
- Token expiration during active sessions
- Refresh token rotation for security
- Rate limiting on auth endpoints
- Concurrent request handling with same token

## Data Sources
- `context/data/jwt-config.json` (if exists)
- JWT best practices documentation

## Success Criteria
- [ ] Users can log in and receive tokens
- [ ] Protected routes reject unauthenticated requests
- [ ] Refresh token flow works correctly
- [ ] All tests pass
- [ ] No security vulnerabilities
```

### 2. Review Phase
After creating the plan:

1. **Present the plan** to the developer
2. **Ask explicitly:** "Please review this plan in `context/plans/[task-name].md`. Does it align with your intent? Any changes needed?"
3. **Wait for approval** - DO NOT proceed without confirmation
4. **Adjust based on feedback** if needed

### 3. Execute Phase
After plan approval:

#### Git Workflow (CRITICAL - Apply When Working in Git Repositories)

**When working in a git repository, you MUST follow these git practices:**

1. **ALWAYS create a new branch** when starting a new plan:
   ```bash
   git checkout -b feature/task-name-YYYY-MM-DD
   ```
   - Branch name should reflect the task from the plan
   - Include date for easy tracking
   - Examples: `feature/auth-refactor-2025-12-02`, `fix/memory-leak-2025-12-02`

2. **Track todos in `context/context.md`** during execution:
   - All work items must be documented as todos in `context/context.md`
   - Update todo status as you progress through the plan
   - Keep the todo list synchronized with your actual progress

3. **Commit after EVERY completed todo**:
   - When a todo is marked complete, immediately create a git commit
   - **Commit message MUST be the todo item text**
   - Examples:
     ```bash
     git add .
     git commit -m "Create authentication middleware in src/middleware/auth.ts"
     ```
   - This creates an atomic, auditable history of all changes
   - Each commit represents a single, complete unit of work

**Why this matters:**
- **Auditability:** Every change is tracked with clear intent
- **Rollback:** Easy to revert individual changes if needed
- **Collaboration:** Clear history helps team members understand evolution
- **Context preservation:** Git history complements PARA summaries

**Example workflow:**
```bash
# Starting new plan
git checkout -b feature/add-rate-limiting-2025-12-02

# Working through todos in context/context.md
# ✅ Todo 1: Add rate-limit-redis dependency
git add package.json package-lock.json
git commit -m "Add rate-limit-redis dependency"

# ✅ Todo 2: Create rate limiting middleware
git add src/middleware/rateLimit.ts
git commit -m "Create rate limiting middleware"

# ✅ Todo 3: Apply middleware to API routes
git add src/routes/api.ts
git commit -m "Apply middleware to API routes"

# Continue until all todos complete...
```

#### Implementation Guidelines

1. **Implement the plan** step-by-step
2. **Keep context minimal:**
   - Only load files you're actively modifying
   - If you need to understand a large codebase, create a summary in `context/data/` first
   - Request specific context from the developer rather than loading everything
3. **Show progress** as you work through the steps
4. **Handle errors** and adjust the plan if needed (document changes)

### 4. Summarize Phase
After implementation is complete:

1. **Create a summary file** in `context/summaries/[task-name]-summary.md`
2. **Include these sections:**
   - **Date & Duration:** When and how long
   - **Status:** ✅ Complete / ⚠️ Partial / ❌ Blocked
   - **Changes Made:** List all modified/created files with brief descriptions
   - **Rationale:** Why these changes were made
   - **Deviations from Plan:** What changed and why
   - **Test Results:** What tests passed/failed
   - **Key Learnings:** Important insights or decisions
   - **Follow-up Tasks:** What needs to happen next (if anything)

3. **Example summary structure:**
```markdown
# Summary: User Authentication Implementation

**Date:** 2025-11-09
**Duration:** 2 hours
**Status:** ✅ Complete

## Changes Made

### Files Modified
- `src/models/User.ts:45-67` - Added refreshToken field and methods
- `src/routes/api.ts:12-18` - Applied auth middleware to protected routes
- `package.json:23` - Added jsonwebtoken@9.0.0 dependency

### Files Created
- `src/middleware/auth.ts` (87 lines) - JWT validation middleware
- `src/utils/jwt.ts` (54 lines) - Token utilities
- `src/routes/auth.ts` (123 lines) - Auth endpoints (login/logout/refresh)
- `tests/auth.test.ts` (156 lines) - Comprehensive auth tests

## Rationale

Chose JWT over session-based auth because:
- Stateless design fits the existing API architecture
- Easier horizontal scaling without shared session state
- Client can be mobile apps or SPAs without cookie limitations

Implemented refresh tokens to balance security (short-lived access tokens) with UX (don't require frequent re-login).

## Deviations from Plan

- Added rate limiting middleware (not in original plan) after realizing auth endpoints are vulnerable to brute force
- Used RS256 instead of HS256 for better key rotation support
- Added IP allowlisting configuration for future admin route protection

## Test Results

✅ 28/28 tests passing
✅ Code coverage: 94%
✅ Security audit: No vulnerabilities
✅ Integration tests with existing API routes: Passing

## Key Learnings

- The existing user model had a unique constraint on email that we leveraged
- Found a more efficient token validation pattern using middleware composition
- Discovered that some routes should remain public (health check, metrics)

## Follow-up Tasks

1. Add rate limiting to auth endpoints (high priority)
2. Consider IP allowlisting for admin routes
3. Set up token rotation schedule in production
4. Add monitoring for failed auth attempts
```

### 5. Archive Phase
When the task is completely done:

1. **Move context.md** to archives:
   ```bash
   mv context/context.md context/archives/context-[YYYY-MM-DD-HHMM].md
   ```
2. **Create fresh context.md** for the next task
3. **Update the JSON tracker** in context.md with completed summaries

## Context Directory Structure

Every project using PARA-Programming should have:

```
project-root/
├── context/
│   ├── context.md              # Current session state
│   ├── data/                   # Reference files, configs, examples
│   ├── plans/                  # Planning documents (before execution)
│   ├── summaries/              # Post-execution reports
│   ├── archives/               # Historical context snapshots
│   └── servers/                # MCP tools (if supported by your IDE)
└── CLAUDE.md                   # Project-specific context
```

## Current Session Tracking (context/context.md)

Always maintain `context/context.md` with this structure:

```markdown
# Current Work Summary
[Brief description of what you're working on]

---
```json
{
  "active_context": [
    "context/plans/current-task.md",
    "context/data/relevant-data.json"
  ],
  "completed_summaries": [
    "context/summaries/previous-task.md"
  ],
  "last_updated": "2025-11-09T14:30:00Z"
}
```
```

## Token Efficiency Guidelines

**Minimize context size at every step:**

1. **Don't load entire codebases** - Only open files you need to modify
2. **Preprocess large data:**
   - If analyzing a large file, create a summary in `context/data/summary.md` first
   - Reference the summary instead of the full file
3. **Use targeted searches:**
   - Instead of "read all files", ask: "search for authentication logic"
   - Create small excerpts in `context/data/` for reference
4. **Lazy load context:**
   - Start with minimal context
   - Request additional context only when needed
   - Release context after using it

**Target token budgets per phase:**
- Plan: 500-1000 tokens
- Execute: 1000-2000 tokens active at once
- Summarize: 300-800 tokens

## When to Skip the Workflow

You CAN skip the full Plan→Review→Execute→Summarize→Archive loop for:

- **Trivial single-line changes** (fixing typos, updating constants)
- **Obvious bug fixes** that touch 1-2 lines
- **Formatting/linting** automated changes
- **Documentation updates** that don't affect code behavior

For everything else: **FOLLOW THE FULL WORKFLOW**

## Developer Communication

- **Be explicit** about which phase you're in
- **Always ask for review** before executing plans
- **Provide file:line references** when discussing code
- **Summarize what you did** after making changes
- **Flag deviations** from the plan immediately

## Error Handling

If something goes wrong during execution:

1. **Document the error** in `context/data/error-[timestamp].md`
2. **Update the plan** with a new approach
3. **Ask for guidance** if you're unsure how to proceed
4. **Don't mark as complete** if tests fail or functionality is broken

## Quality Standards

Before marking any task as complete:

- [ ] All tests pass
- [ ] No linting errors
- [ ] No security vulnerabilities introduced
- [ ] Documentation updated if needed
- [ ] Summary written with all changes documented
- [ ] Developer has reviewed and approved

---

## Remember

You are not just writing code—you are building a **persistent, auditable, efficient development system** where the developer and AI work as a unified team with shared memory (context directory) and clear processes (the 5-step loop).

**Think with the smallest possible context, not the largest.**
````

---

## IDE-Specific Setup

### GitHub Copilot (VSCode)

**Location:** `.github/copilot-instructions.md` in project root

**Setup:**
1. Create `.github/copilot-instructions.md`
2. Copy the Universal Instructions above
3. Add this VSCode-specific section:

```markdown
## VSCode-Specific Notes

### File Creation
When creating plan/summary files:
- Use the "Create New File" command
- Save immediately after creation
- Show the file path in chat so I can verify

### Multi-File Context
- I can only see files you explicitly open
- Tell me which files to open for context
- Close files when done to keep context clean

### Limitations
- No MCP support - we'll handle preprocessing manually
- Single-file focus - work on one file at a time when possible
- Tell me explicitly which file you're editing
```

**Installation:**
```bash
mkdir -p .github
# Copy the content to .github/copilot-instructions.md
```

---

### Cursor

**Location:** `.cursorrules` in project root

**Setup:**
1. Create `.cursorrules` file
2. Copy the Universal Instructions
3. Add Cursor-specific enhancements:

```markdown
## Cursor-Specific Features

### Composer Mode
When using Composer for multi-file edits:
- Still create plan first in context/plans/
- Use Composer to implement across multiple files
- Create summary after Composer completes

### CMD+K Mode
For single-file edits with CMD+K:
- Skip planning for trivial changes
- Use full workflow for complex refactors
- Reference context/plans/ file in the prompt

### MCP Integration
Cursor supports MCP servers. When available:
- Use MCP tools in context/servers/ for preprocessing
- Reference MCP tools in plans
- Document which MCP tools were used in summaries

### Codebase Indexing
Cursor indexes the entire codebase. However:
- Still practice token efficiency
- Don't reference unnecessary files
- Load context selectively even though it's available
```

**Installation:**
```bash
# Copy the content to .cursorrules
```

---

### JetBrains AI Assistant (IntelliJ, PyCharm, WebStorm, etc.)

**Location:** `.idea/ai-assistant.md` (or use AI Assistant settings)

**Setup:**
1. Open AI Assistant settings (Settings → Tools → AI Assistant)
2. Create custom instruction file
3. Reference the Universal Instructions

```markdown
## JetBrains-Specific Notes

### Context Collection
JetBrains AI uses intelligent context:
- It sees your current file and related files
- Still be explicit about what context you need
- Don't rely on automatic context—specify files in plans

### Refactoring Integration
When planning refactors:
- Mention if using JetBrains refactoring tools
- AI can work with IDE refactor results
- Document refactorings in summaries

### Test Integration
JetBrains has strong test runners:
- Run tests after implementation
- Include test results in summaries
- Use coverage tools to verify changes

### Multi-Language Projects
For polyglot projects:
- Specify language in each plan section
- Use appropriate conventions per language
- Keep plans modular by language/component
```

**Installation:**
```bash
mkdir -p .idea
# Add content to AI Assistant settings or .idea/ai-assistant.md
```

---

### Continue.dev (VSCode & JetBrains)

**Location:** `.continuerc.json` or config.json

**Setup:**
Continue has excellent MCP support. Configuration example:

```json
{
  "customInstructions": "Follow PARA-Programming methodology from AGENT-INSTRUCTIONS.md in project root",
  "contextProviders": [
    {
      "name": "code",
      "params": {
        "includeFiles": [
          "context/context.md",
          "context/plans/*.md",
          "context/data/*.md"
        ]
      }
    }
  ],
  "mcpServers": {
    "para-preprocessing": {
      "command": "node",
      "args": ["context/servers/index.js"]
    }
  }
}
```

Add to instructions:

```markdown
## Continue.dev-Specific Features

### MCP Support
Continue supports MCP natively:
- Create preprocessing tools in context/servers/
- Register them in .continuerc.json
- Use them in plans and execution

### Context Providers
Continue can auto-load context:
- Configure to always include context/context.md
- Auto-load relevant plan files
- Still practice token efficiency despite automation

### Slash Commands
Create custom commands:
- `/para-plan` - Start a new plan
- `/para-summarize` - Generate summary
- `/para-archive` - Archive current context
```

---

### Codeium

**Location:** `.codeium/instructions.md`

**Setup:**
```bash
mkdir -p .codeium
# Copy Universal Instructions to .codeium/instructions.md
```

Add Codeium-specific notes:

```markdown
## Codeium-Specific Notes

### Autocomplete Mode
Codeium excels at autocomplete:
- Use full workflow for complex tasks
- Autocomplete is fine for routine code
- Don't need plans for autocomplete suggestions

### Chat Mode
When using Codeium Chat:
- Follow full PARA workflow
- Reference context files explicitly
- Create plans/summaries as normal

### Context Limits
Codeium has smaller context windows:
- Be extra aggressive with token efficiency
- Create more summaries in context/data/
- Break down plans into smaller chunks
```

---

## Workflow Adaptation Guide

### For Agents with Limited Context Support

**Problem:** Agent can't read context files automatically

**Solution:**
1. Manually copy plan into chat when starting
2. Keep plans shorter (under 500 words)
3. Use chat history as implicit context
4. Create summaries in chat, then save to file

**Example:**
```
Developer: "Let's add user authentication. Here's the plan from context/plans/auth.md:
[paste plan content]

Please review and let me know if this looks good."

Agent: [reviews plan]

Developer: "Approved, proceed."

Agent: [implements]

Developer: "Create the summary now."

Agent: [generates summary]

Developer: [saves to context/summaries/auth-summary.md]
```

---

### For Agents with MCP Support (Cursor, Continue.dev)

**Advantage:** Can use preprocessing tools

**Workflow:**
1. Create MCP tools in `context/servers/` for common tasks:
   - `summarizeCode.js` - Condense large files
   - `searchArchitecture.js` - Find relevant components
   - `analyzeChanges.js` - Understand recent commits

2. Reference MCP tools in plans:
```markdown
## Data Sources
- MCP: `summarizeCode` on src/auth/* (before reading)
- MCP: `searchArchitecture` for authentication patterns
```

3. Agent uses tools during execution automatically

4. Document tool usage in summaries

---

### For Inline Autocomplete-Focused Agents (Tabnine, GitHub Copilot)

**Reality:** These agents work best for code completion, not planning

**Adapted Workflow:**
1. **Human creates plans** - You write `context/plans/[task].md` manually
2. **Agent assists implementation** - Use autocomplete during coding
3. **Human creates summaries** - You write `context/summaries/[task].md` manually
4. **Archive together** - You maintain context/context.md

**This is still PARA-Programming!** The principles apply even if the human does more of the orchestration.

---

## Platform-Specific Features

### Using Git Integration

Most IDEs have git integration. Enhance PARA workflow:

**In Plans:**
```markdown
## Git Strategy
- Branch: `feature/user-auth`
- Commits: One per major step
- Commit message format: Conventional Commits
```

**In Summaries:**
```markdown
## Git History
- Commit 1 (abc123): Add User model changes
- Commit 2 (def456): Implement auth middleware
- Commit 3 (ghi789): Add auth routes and tests
- PR: #123 (link)
```

---

### Using IDE Test Runners

**In Plans:**
```markdown
## Testing Strategy
- Unit tests: Jest in watch mode
- Integration tests: After all changes
- Coverage target: >90% for new code
```

**In Summaries:**
```markdown
## Test Results
- Unit tests: 28/28 passed
- Integration tests: 12/12 passed
- Coverage: 94% (target: 90%) ✅
- Performance: All endpoints <100ms ✅
```

---

### Using IDE Refactoring Tools

**In Plans:**
```markdown
## Approach
1. Use IDE "Extract Method" refactoring on calculateTotal
2. Use "Rename Symbol" to change userId → userIdentifier
3. Manually split UserService into UserService and AuthService
```

**In Summaries:**
```markdown
## Refactorings Performed
- IDE Extract Method: 3 methods extracted (lines 45-67, 89-102, 134-156)
- IDE Rename: userId → userIdentifier (47 occurrences across 12 files)
- Manual split: UserService.ts → UserService.ts + AuthService.ts
```

---

## Quick Start Checklist

To adopt PARA-Programming with your AI agent:

### One-Time Setup
- [ ] Choose your AI agent from the list above
- [ ] Create `context/` directory structure in your project
- [ ] Copy Universal Instructions to your IDE's config location
- [ ] Customize with IDE-specific notes
- [ ] Initialize `context/context.md`
- [ ] Create project `CLAUDE.md` (or equivalent)

### Per-Session Setup
- [ ] Open `context/context.md` to see current state
- [ ] Load any referenced plan files
- [ ] Start with a clear understanding of active context

### Per-Task Workflow
- [ ] Create plan in `context/plans/[task].md`
- [ ] Get human approval
- [ ] Execute the plan
- [ ] Create summary in `context/summaries/[task].md`
- [ ] Update `context/context.md` with completion
- [ ] Archive when session is done

---

## Examples by Agent

### Example: GitHub Copilot Chat Workflow

```
Developer: "@workspace Let's add user authentication. Please create a plan following PARA methodology."

Copilot: "I'll create a plan for adding user authentication. Let me create context/plans/user-auth.md:

[Creates detailed plan]

I've created the plan at context/plans/user-auth.md. Please review it and let me know if you'd like any changes before I proceed."

Developer: "Looks good, approved."

Copilot: "Great! I'll now implement the plan step by step. I'll start with creating the User model changes..."

[Implementation happens]

Copilot: "Implementation complete! I'll now create a summary at context/summaries/user-auth-summary.md:

[Creates detailed summary]

Summary saved. Here's what was done: [brief recap]"

Developer: "Perfect, thanks!"
```

---

### Example: Cursor Composer Workflow

```
Developer: [Opens Composer] "Add user authentication following PARA methodology"

Cursor: "I'll start by creating a plan. Creating context/plans/user-auth.md..."

[Plan appears in Composer]

Cursor: "Here's the plan. Should I proceed?"

Developer: [Reviews plan] "Yes, proceed"

Cursor: [Uses Composer to edit multiple files simultaneously]

Cursor: "Implementation complete across 4 files. Creating summary..."

[Summary generated]

Cursor: "Done! Summary saved to context/summaries/user-auth-summary.md. All tests passing ✅"
```

---

### Example: JetBrains AI Assistant Workflow

```
Developer: [Opens AI Assistant chat] "Create a plan for adding user authentication in context/plans/"

AI Assistant: [Creates plan file]

AI Assistant: "Plan created. Here's the summary: [brief overview]. Ready to proceed?"

Developer: "Yes"

AI Assistant: "I'll implement step by step. First, modifying User.ts..."

[Implementation happens with IDE refactoring tools]

AI Assistant: "Implementation complete. Running tests... All tests passed ✅. Shall I create the summary?"

Developer: "Yes"

AI Assistant: [Creates summary] "Summary saved to context/summaries/user-auth-summary.md. Would you like to review it?"
```

---

## Troubleshooting

### "My agent doesn't support context files"

**Solution:** Maintain files manually, paste into chat when needed

### "My agent loads too much context automatically"

**Solution:** In plans, explicitly state: "Only load these files: [list]. Ignore all others."

### "Plans are too verbose for my agent's context window"

**Solution:** Use the "minimal plan" template:
```markdown
# Plan: [Task]
**Goal:** [One sentence]
**Files:** [List]
**Steps:** [Numbered list, 5 max]
**Risks:** [Brief bullets]
```

### "My agent doesn't ask for review"

**Solution:** Use explicit prompts: "Create plan and wait for my approval before proceeding"

### "Summaries are too long"

**Solution:** Use the "minimal summary" template:
```markdown
# Summary: [Task]
**Status:** [Complete/Partial/Blocked]
**Changed:** [File list]
**Why:** [One paragraph]
**Tests:** [Pass/Fail]
**Next:** [Follow-ups if any]
```

---

## Advanced Patterns

### Multi-Agent Workflows

Using different agents for different phases:

- **Planning:** Claude Code (best at structured thinking)
- **Implementation:** Cursor (best at multi-file edits)
- **Review:** GitHub Copilot (integrated with PRs)

The `context/` directory enables handoffs between agents!

### Team Collaboration

Multiple developers using different agents on same project:

1. Everyone follows PARA methodology
2. Context directory is committed to git
3. Each person uses their preferred agent
4. Consistency maintained through shared plans/summaries

### Hybrid Human-AI Work

For complex tasks:

1. Human creates plan
2. AI implements parts with guidance
3. Human implements critical sections
4. AI creates summary draft
5. Human finalizes summary

**This is still PARA!** The workflow adapts to capability boundaries.

---

## Conclusion

PARA-Programming is **methodology-first, tool-agnostic**. The five-step workflow and context directory structure work with any AI agent:

- **Plan** → Always plan before acting
- **Review** → Always get human approval
- **Execute** → Always implement with minimal context
- **Summarize** → Always document what happened
- **Archive** → Always preserve history

The specific agent you use affects **how** you implement each step, not **whether** you implement it.

**Choose your tools. Keep your principles.**

---

## Resources

- [PARA-Programming Main Documentation](../README.md)
- [Global CLAUDE.md Template](../claude/CLAUDE.md)
- [Agent Configuration Examples](other-ai-assitants/examples/agent-configs/)
- [Community Contributions](../../discussions)

---

## Contributing

Have you adapted PARA-Programming for an agent not listed here? Please contribute:

1. Create example configuration
2. Document agent-specific features
3. Add to the compatibility matrix
4. Share workflows and tips

Help make PARA-Programming work for everyone, regardless of their tool choice!
