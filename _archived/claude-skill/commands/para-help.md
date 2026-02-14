# Command: para-help

Display comprehensive PARA-Programming guide and reference.

## What This Does

Provides on-demand help for PARA-Programming methodology including:
- Complete workflow explanation
- All available commands with examples
- Decision tree for when to use PARA
- Common patterns and troubleshooting
- Links to full documentation

## Usage

```
/para-help
```

## Implementation

Display the following comprehensive guide:

---

# 📖 PARA-Programming Complete Guide

Welcome to PARA-Programming! This guide will help you master the workflow for building better software with AI assistants.

---

## 🎯 What is PARA-Programming?

PARA-Programming is a structured methodology for working with AI coding assistants. It ensures:
- **Accuracy** - Consistent, context-aware outputs across sessions
- **Token Efficiency** - Minimal active context through persistent storage
- **Auditability** - Every action and decision is captured
- **Scalability** - Your work history becomes a knowledge base

**Core Principle:** Plan before you code, capture what you learn.

---

## 🔁 The PARA Workflow

```
┌──────┐     ┌────────┐     ┌─────────┐     ┌───────────┐     ┌─────────┐
│ PLAN │ ──> │ REVIEW │ ──> │ EXECUTE │ ──> │ SUMMARIZE │ ──> │ ARCHIVE │
└──────┘     └────────┘     └─────────┘     └───────────┘     └─────────┘
     │            ↑               │                 │               │
     └────────────┴───────────────┴─────────────────┴───────────────┘
                        Continuous Improvement Loop
```

### Phase 1: PLAN
**What:** Create a detailed plan for your task
**Why:** Clarify scope, approach, and risks before writing code
**How:** `/para-plan <task-description>`
**Output:** `context/plans/YYYY-MM-DD-task-name.md`

### Phase 2: REVIEW
**What:** Human reviews and approves the plan
**Why:** Ensure AI understands intent and approach is sound
**How:** Read the plan file, provide feedback if needed
**Output:** Approved plan ready for execution

### Phase 3: EXECUTE
**What:** AI implements the plan, making code changes
**Why:** Structured execution prevents scope creep
**How:** AI uses tools to read, write, edit files
**Output:** Working code changes

### Phase 4: SUMMARIZE
**What:** Document what was done and why
**Why:** Capture learnings and create project history
**How:** `/para-summarize`
**Output:** `context/summaries/YYYY-MM-DD-task-name-summary.md`

### Phase 5: ARCHIVE
**What:** Archive current context and start fresh
**Why:** Keep context lean for next task
**How:** `/para-archive`
**Output:** `context/archives/YYYY-MM-DD-context.md`

---

## 🤔 When to Use PARA (Decision Tree)

```
Is this request asking for code/file changes?
├─ YES → Use PARA Workflow
│   Examples:
│   ✅ "Add user authentication to the API"
│   ✅ "Fix the memory leak in WebSocket handler"
│   ✅ "Refactor database queries for performance"
│   ✅ "Update configuration to use environment variables"
│
└─ NO → Is it asking about this project's code?
    ├─ YES → Provide direct answer with file references
    │   Examples:
    │   ✅ "Where is authentication middleware defined?"
    │   ✅ "Explain how the caching system works"
    │   ✅ "Show me all API endpoints"
    │
    └─ NO → Provide standard response
        Examples:
        ✅ "What's the difference between OAuth and JWT?"
        ✅ "How do I use React hooks?"
```

### ✅ ALWAYS Use PARA For:
- Code changes (features, bug fixes, refactoring)
- Architecture decisions (adding libraries, changing patterns)
- File modifications (creating, editing, deleting files)
- Configuration changes (build configs, dependencies)
- Database changes (migrations, schema updates)
- Testing implementation
- Complex debugging requiring code investigation

**Rule of thumb:** If it results in git changes to project files, use PARA.

### ❌ SKIP PARA For:
- Simple informational queries
- Codebase navigation
- Explanation requests
- General questions
- Quick lookups
- Read-only tasks

**Rule of thumb:** If it's read-only or informational, skip PARA.

---

## 📚 Available Commands

### Core Workflow Commands

#### `/para-init`
**Purpose:** Initialize PARA structure in a project
**When to use:** First time setting up PARA in a new project
**Example:**
```
/para-init
/para-init --template=full
```

#### `/para-plan`
**Purpose:** Create a new planning document
**When to use:** Starting any new task that changes code
**Example:**
```
/para-plan Add user authentication
/para-plan Fix memory leak in WebSocket handler
```

#### `/para-summarize`
**Purpose:** Generate post-work summary
**When to use:** After completing implementation
**Example:**
```
/para-summarize
```

#### `/para-archive`
**Purpose:** Archive current context and start fresh
**When to use:** After summarizing, before starting new task
**Example:**
```
/para-archive
```

### Helper Commands

#### `/para-status`
**Purpose:** Check current workflow state
**When to use:** Anytime you want to see what's active
**Example:**
```
/para-status
```
**Shows:**
- Active plans
- Completed summaries
- Current context state
- Last updated timestamp

#### `/para-check`
**Purpose:** Decision helper for PARA workflow
**When to use:** Unsure if your task needs PARA
**Example:**
```
/para-check Should I use PARA for "explain how auth works"?
```

#### `/para-help`
**Purpose:** Show this comprehensive guide
**When to use:** Anytime you need reference or refresh
**Example:**
```
/para-help
```

---

## 💡 Common Patterns

### Pattern 1: New Feature Development
```
1. /para-plan Add user profile page with avatar upload
2. Review plan (approve or request changes)
3. AI implements the feature
4. Test and verify
5. /para-summarize
6. /para-archive
```

### Pattern 2: Bug Investigation and Fix
```
1. /para-plan Debug and fix checkout payment failure
2. Review plan (AI will investigate first)
3. AI debugs and implements fix
4. Verify fix works
5. /para-summarize
6. /para-archive
```

### Pattern 3: Refactoring
```
1. /para-plan Refactor API layer to use async/await
2. Review plan (ensure no breaking changes)
3. AI refactors code
4. Run tests to verify
5. /para-summarize
6. /para-archive
```

### Pattern 4: Quick Question (NO PARA)
```
User: "Where is the authentication middleware?"
AI: The authentication middleware is in src/middleware/auth.ts:45-89
```

---

## 🚨 Common Anti-Patterns

### ❌ Anti-Pattern 1: Skipping Planning
**Problem:** Jumping straight to code without a plan
**Why it's bad:** Leads to scope creep, missed edge cases
**Solution:** Always `/para-plan` for code changes

### ❌ Anti-Pattern 2: Using PARA for Simple Questions
**Problem:** Creating plans for "Where is X defined?"
**Why it's bad:** Overhead without benefit, slows workflow
**Solution:** Use `/para-check` to verify if PARA is needed

### ❌ Anti-Pattern 3: Not Archiving
**Problem:** Letting context.md accumulate multiple tasks
**Why it's bad:** Context bloat, token waste, lost history
**Solution:** `/para-archive` after each task completion

### ❌ Anti-Pattern 4: Vague Plan Descriptions
**Problem:** `/para-plan Fix the bug`
**Why it's bad:** AI can't create useful plan without details
**Solution:** Be specific: `/para-plan Fix null pointer exception in checkout flow when user has no saved payment method`

---

## 🔧 Troubleshooting

### Issue: "I don't know if I should use PARA"
**Solution:** Run `/para-check` with your question, or use the decision tree above.

### Issue: "The plan doesn't match what I want"
**Solution:** Provide feedback on the plan during Review phase. AI will adjust.

### Issue: "Context is getting too large"
**Solution:** Archive more frequently. Run `/para-archive` after each task.

### Issue: "I forgot to create a plan"
**Solution:** Stop, create a plan now with `/para-plan`, then continue. It's never too late.

### Issue: "AI isn't following PARA workflow"
**Solution:** Check that methodology files are properly configured. Run `/para-init` if needed.

---

## 📂 File Structure Reference

```
project-root/
├── context/
│   ├── context.md              # Active session context
│   ├── data/                   # Input/output files, payloads, datasets
│   │   └── YYYY-MM-DD-*.json
│   ├── plans/                  # Pre-work plans
│   │   └── YYYY-MM-DD-task-name.md
│   ├── summaries/              # Post-work summaries
│   │   └── YYYY-MM-DD-task-name-summary.md
│   ├── archives/               # Archived contexts
│   │   └── YYYY-MM-DD-context.md
│   └── servers/                # MCP tool wrappers
│       └── [custom tools]
└── CLAUDE.md                   # Project-specific context
```

**File Naming Convention:** All context files use `YYYY-MM-DD-` prefix for chronological ordering.

---

## 🎓 Learning Resources

### Quick Start
- **Tutorial:** Follow the example in `/para-init` output
- **First Task:** Start with something small to learn the flow
- **Practice:** The more you use it, the more natural it becomes

### Documentation
- **Global Guide:** `~/.claude/CLAUDE.md` - Full methodology reference
- **Project Guide:** `CLAUDE.md` in your project - Project-specific context
- **Templates:** `context/plans/` and `context/summaries/` - See examples

### Getting Help
- **This guide:** `/para-help` anytime
- **Status check:** `/para-status` to see current state
- **Decision help:** `/para-check` when unsure

### Community
- **GitHub:** [PARA-Programming Repository](https://github.com/your-org/PARA-Programming)
- **Issues:** Report problems or request features
- **Discussions:** Share patterns and learnings

---

## 🚀 Next Steps

Ready to start? Here's what to do:

1. **If you haven't initialized:** Run `/para-init`
2. **For your first task:** Run `/para-plan <describe your task>`
3. **When stuck:** Run `/para-help` (you're here!) or `/para-check`
4. **After completing work:** Run `/para-summarize` then `/para-archive`

---

## 💭 Philosophy

> *"Claude should think with the smallest possible context, not the largest."*

PARA-Programming treats your collaboration with AI as a **Second Brain**:
- **Claude = Active Reasoning**
- **Human = Intent & Judgment**
- **Context Directory = Memory Layer**
- **MCP Servers = Tool/Execution Layer**

This ensures reasoning persists over time, token use remains low, and your project history becomes a valuable knowledge base.

---

**Happy coding with PARA-Programming! 🎉**

Need more help? Run `/para-help` anytime, or check `/para-status` to see where you are in the workflow.
