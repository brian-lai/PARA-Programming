# PARA-Programming for Codex CLI

**The complete guide to using PARA-Programming methodology with OpenAI's Codex CLI**

Codex CLI is OpenAI's command-line interface for code generation and assistance. This guide shows you how to integrate it with PARA-Programming for structured, auditable, and token-efficient development workflows.

---

## 📋 Table of Contents

- [Why Codex CLI for PARA-Programming?](#why-codex-cli-for-para-programming)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Understanding the CODEX.md System](#understanding-the-codexmd-system)
- [Workflow with Codex CLI](#workflow-with-codex-cli)
- [Best Practices](#best-practices)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)
- [Advanced Usage](#advanced-usage)

---

## Why Codex CLI for PARA-Programming?

Codex CLI earns a **⭐⭐⭐⭐⭐ Excellent** rating for PARA compatibility:

### Advantages

✅ **CODEX.md Support** - Can be configured to automatically read global `~/.codex/CODEX.md` and project-local `CODEX.md`
✅ **Powerful Code Understanding** - OpenAI's models excel at code comprehension and generation
✅ **Multi-File Operations** - Can work across multiple files simultaneously
✅ **Flexible Configuration** - Customizable system prompts and context loading
✅ **CLI Workflow** - Perfect for terminal-based developers
✅ **Token Efficiency** - Responds well to preprocessing and selective context loading

### Limitations

⚠️ **Configuration Required** - Needs setup to auto-load CODEX.md files (unlike Claude Code's native support)
⚠️ **CLI-Only** - No GUI (though this can be an advantage for automation)
⚠️ **API Costs** - Requires OpenAI API key with usage-based pricing
⚠️ **Manual Workflow Reminder** - May need explicit reminders to follow PARA methodology

### Perfect For

- **Professional developers** - Engineers who live in the terminal
- **OpenAI ecosystem users** - Teams already using OpenAI APIs
- **Complex projects** - Multi-file refactors and architectural changes
- **Token optimization** - Projects requiring minimal API costs
- **Preprocessing development** - Building and using data filtering tools

### The Codex Advantage

Codex CLI works excellently with PARA when configured:
- Can automatically load and follow `~/.codex/CODEX.md` with proper configuration
- Understands the Plan → Review → Execute → Summarize → Archive loop
- Can create and manage context files when instructed
- Works with the two-file system (global + local CODEX.md)

---

## Quick Start

> **⚡ Want to get started immediately?** See [QUICKSTART.md](QUICKSTART.md) for a 5-minute setup guide.

### Prerequisites

- Codex CLI installed
- OpenAI API access (API key with Codex/GPT-4 access)
- Basic familiarity with command line

### 5-Minute Setup

```bash
# 1. Create global CODEX.md (one-time setup)
mkdir -p ~/.codex
cp CODEX.md ~/.codex/CODEX.md

# 2. Navigate to your project
cd your-project/

# 3. Create context structure
mkdir -p context/{data,plans,summaries,archives,servers}

# 4. Initialize context.md
cat > context/context.md << 'EOF'
# Current Work Summary

---

```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "2025-11-15T10:00:00Z"
}
```
EOF

# 5. Create project CODEX.md
cat > CODEX.md << 'EOF'
# My Project

> **Workflow Methodology:** Follow `~/.codex/CODEX.md`

## About
[Brief description of your project]

## Tech Stack
- [Your technologies]

## Getting Started
```bash
npm install
npm start
```
EOF

# 6. Start Codex
codex
```

---

## Installation

### Install Codex CLI

```bash
# Using npm (if available via npm)
npm install -g openai-codex-cli

# Or follow OpenAI's official installation guide
# https://platform.openai.com/docs/guides/codex
```

### Configure API Access

```bash
# Set your OpenAI API key
export OPENAI_API_KEY="your-api-key-here"

# Add to your shell profile for persistence
echo 'export OPENAI_API_KEY="your-api-key-here"' >> ~/.bashrc
# or ~/.zshrc for zsh
```

### Configure PARA-Programming Integration

```bash
# Create Codex config directory
mkdir -p ~/.codex

# Configure Codex to auto-load CODEX.md files
cat > ~/.codex/config.json << 'EOF'
{
  "system_prompts": [
    {
      "path": "~/.codex/CODEX.md",
      "type": "methodology",
      "priority": "high"
    }
  ],
  "project_context_files": [
    "CODEX.md",
    "context/context.md"
  ],
  "auto_load_context": true
}
EOF
```

**Note:** Configuration format may vary based on your Codex CLI version. Check official Codex documentation for exact syntax.

---

## Understanding the CODEX.md System

Codex CLI uses a **two-file system** for context management:

### 1. Global CODEX.md (`~/.codex/CODEX.md`)

**Purpose:** Defines **HOW** to work (methodology, workflow, patterns)

**Location:** `~/.codex/CODEX.md` in your home directory

**Contents:**
- The Plan → Review → Execute → Summarize → Archive workflow
- Preprocessing integration patterns
- Token efficiency strategies
- File naming conventions
- Session hygiene rules

**Setup:** Copy once, use across all projects

```bash
mkdir -p ~/.codex
cp codex/CODEX.md ~/.codex/CODEX.md
```

### 2. Local CODEX.md (`<project>/CODEX.md`)

**Purpose:** Defines **WHAT** (project-specific context)

**Location:** In your project root directory

**Contents:**
- Project purpose and domain
- Tech stack and dependencies
- Architecture overview
- Code organization
- Team conventions
- Key files and their purposes

**Setup:** Create per project (see [templates/](templates/) for examples)

### How They Work Together

```
┌─────────────────────────────────────────────┐
│  Global: ~/.codex/CODEX.md                  │
│  "HOW to work"                              │
│  - Plan before executing                    │
│  - Always get human review                  │
│  - Summarize after completion               │
│  - Use context/ directory structure         │
└─────────────────────────────────────────────┘
                     +
┌─────────────────────────────────────────────┐
│  Local: <project>/CODEX.md                  │
│  "WHAT this project is"                     │
│  - Next.js + PostgreSQL + Prisma            │
│  - Microservices architecture               │
│  - Tests in __tests__ directories           │
│  - API routes in src/app/api/               │
└─────────────────────────────────────────────┘
                     =
┌─────────────────────────────────────────────┐
│  Codex CLI's Understanding                  │
│  "I know HOW to work (global) and           │
│   WHAT I'm working on (local)"              │
└─────────────────────────────────────────────┘
```

**Key Benefit:** Change workflow once (global), applies to all projects. Update project context (local) without duplicating methodology.

---

## Workflow with Codex CLI

### Starting a Session

```bash
cd your-project/
codex
```

Codex CLI will (with proper configuration):
1. ✅ Read `~/.codex/CODEX.md` (global methodology)
2. ✅ Read `<project>/CODEX.md` (project context)
3. ✅ Load `context/context.md` (current work state)
4. ✅ Understand the PARA workflow

### Typical Conversation

```
You: "Let's add user authentication following PARA methodology"

Codex: "I'll create a plan for adding user authentication.
Creating context/plans/2025-11-15-user-auth.md...

[Creates detailed plan]

I've created the plan at context/plans/2025-11-15-user-auth.md.

**Plan Summary:**
- Objective: Implement JWT-based auth with refresh tokens
- Approach: Middleware → JWT utilities → Protected routes → Tests
- Files to create: 4 new files
- Files to modify: 2 existing files

Please review the plan and let me know if it looks good before I proceed."

You: "Looks good, approved"

Codex: "Great! I'll implement step-by-step.

Step 1: Creating authentication middleware in src/middleware/auth.ts...
✅ Created (45 lines)

Step 2: Adding JWT utilities in src/utils/jwt.ts...
✅ Created (67 lines)

Step 3: Updating route protection in src/routes/api.ts...
✅ Modified (added lines 23-45)

Step 4: Adding test suite in tests/auth.test.ts...
✅ Created (124 lines)

All steps complete! Creating summary at context/summaries/2025-11-15-user-auth-summary.md...

✅ Summary complete. Authentication system is now working!
✅ All 24 tests passing

Should I archive the current context?"

You: "Yes, archive it"

Codex: "Archived to context/archives/2025-11-15-context.md.
Ready for the next task!"
```

### Key Workflow Points

**Explicit Reminders:** Unlike Claude Code's native PARA support, you may need to remind Codex to follow the methodology:

```
# Good prompts
"Following PARA methodology from ~/.codex/CODEX.md, let's add feature X"
"Using the PARA workflow, create a plan for refactoring Y"
"PARA mode: Fix bug Z"
```

**Context Loading:** Ensure Codex has loaded the context files:

```
"Before starting, please read:
1. ~/.codex/CODEX.md (methodology)
2. ./CODEX.md (project context)
3. context/context.md (current state)"
```

---

## Best Practices

### Global CODEX.md Maintenance

✅ **Do:**
- Keep it updated as your workflow evolves
- Document new preprocessing patterns you discover
- Share improvements with your team
- Version control it (keep in a dotfiles repo)

❌ **Don't:**
- Add project-specific information
- Make it too long (aim for 500-1500 lines)
- Change it frequently (workflow should be stable)

### Local CODEX.md Maintenance

✅ **Do:**
- Update when architecture changes
- Document new conventions as they're established
- Include key file locations and purposes
- Keep it current with the codebase

❌ **Don't:**
- Duplicate workflow instructions (that's in global)
- Include implementation details (that's in code)
- Let it go stale (review monthly)

### Context Directory Hygiene

```bash
# Archive old contexts regularly
mv context/context.md context/archives/$(date +%F)-context.md

# Clean up old data files (keep what's referenced)
cd context/data/
ls -lt | tail -n +20  # Review old files

# Keep servers/ organized by domain
context/servers/
├── github/
├── api/
├── db/
└── analysis/
```

### Token Efficiency Tips

1. **Use preprocessing for data filtering** - Don't load large files directly
2. **Reference by file:line** - Be specific, not broad
3. **Load selectively** - Only open files you need to modify
4. **Summarize first** - Create summaries in context/data/ for large datasets

### Prompting Best Practices

Since Codex may need explicit reminders:

**Start of session:**
```
"Load PARA methodology from ~/.codex/CODEX.md and project context from ./CODEX.md.
We'll follow the Plan → Review → Execute → Summarize → Archive workflow."
```

**For each task:**
```
"Following PARA workflow: [your task description]"
```

**If Codex forgets:**
```
"Before implementing, please create a plan in context/plans/ as per PARA methodology"
```

---

## Examples

### Example 1: Simple Feature Addition

```
You: "PARA workflow: Add a /health endpoint to check database connectivity"

Codex: "I'll create a plan for adding a health check endpoint.

[Creates context/plans/2025-11-15-health-endpoint.md]

The plan involves:
1. Create health check route in src/app/api/health/route.ts
2. Add database ping function
3. Return JSON with status and timestamp

Shall I proceed?"

You: "Yes"

Codex: [Implements]

Codex: "Complete! Summary at context/summaries/2025-11-15-health-endpoint-summary.md.
Health endpoint working at /api/health"
```

### Example 2: Complex Refactoring

```
You: "The UserService is too complex. Let's refactor it following PARA methodology"

Codex: "I'll analyze UserService and create a refactoring plan.

[Analyzes code]

Creating plan at context/plans/2025-11-15-refactor-user-service.md...

Plan summary:
- Current complexity: 15 (high)
- Proposed: Split into UserService + UserValidator + UserRepository
- Extract 5 helper methods
- Add tests for each new class

Review the plan?"

You: "Good, but keep validation methods in UserService"

Codex: "Updated the plan. Ready to proceed?"

You: "Yes"

Codex: [Refactors with tests between each step]

Codex: "Refactoring complete!
- Complexity reduced from 15 → 4
- All 47 existing tests still passing
- Added 23 new tests

Summary at context/summaries/2025-11-15-refactor-user-service-summary.md"
```

### Example 3: Using Preprocessing for Data Analysis

```
You: "Analyze our API logs from the last week to find slow endpoints (PARA mode)"

Codex: "I'll use a preprocessing script to analyze the logs.

Creating preprocessing tool: context/servers/logs/analyzeLogs.js

[Creates script that processes logs outside the LLM]

Running analysis on 500MB of logs...
[Processes externally, returns compact summary]

Analysis complete. Found 12 slow endpoints:
- /api/users/search: avg 2.3s (450 calls)
- /api/products/list: avg 1.8s (1200 calls)
- [...]

Creating plan to optimize the top 5...

Files created:
- context/data/2025-11-15-slow-endpoints-analysis.md (summary)
- context/plans/2025-11-15-optimize-slow-endpoints.md (plan)

Review the plan?"
```

---

## Troubleshooting

### Codex CLI doesn't follow PARA workflow

**Problem:** Codex implements without creating a plan

**Solution:**
1. Check that `~/.codex/CODEX.md` exists and is correct
2. Verify project `CODEX.md` references the global file
3. Be explicit in prompts: "Following PARA methodology from ~/.codex/CODEX.md, create a plan first"
4. Check Codex configuration to ensure auto-loading of context files

### Can't find global CODEX.md

**Problem:** Codex CLI says it doesn't see the methodology

**Solution:**
```bash
# Verify file exists
ls -la ~/.codex/CODEX.md

# If not, create it
mkdir -p ~/.codex
cp /path/to/PARA-Programming/codex/CODEX.md ~/.codex/

# Explicitly reference in prompt
"Please read ~/.codex/CODEX.md for workflow methodology"
```

### Context files not being created

**Problem:** Plans/summaries aren't being written

**Solution:**
```bash
# Create context structure
mkdir -p context/{data,plans,summaries,archives,servers}

# Initialize context.md
cat > context/context.md << 'EOF'
# Current Work Summary

---

```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "2025-11-15T10:00:00Z"
}
```
EOF

# Be explicit in prompt
"Create the plan file in context/plans/2025-11-15-task-name.md"
```

### Token costs too high

**Problem:** Using too many tokens per task

**Solution:**
1. Use preprocessing tools in context/servers/ to filter data
2. Create summaries in context/data/ instead of loading full files
3. Be explicit: "Only load files X, Y, Z"
4. Review workflow - are you loading unnecessary context?
5. Use smaller models for simple tasks, GPT-4 for complex ones

### Codex forgets the workflow mid-session

**Problem:** Starts implementing without planning

**Solution:**
```
"Stop. Before implementing, we need to follow PARA methodology:
1. Create plan in context/plans/
2. Get my review
3. Then implement

Please create the plan first."
```

---

## Advanced Usage

### Setting Up Preprocessing Tools

Create data filtering tools in `context/servers/`:

```javascript
// context/servers/repo/summarizeFiles.js
const glob = require('glob');

async function summarizeRepoFiles(pattern) {
  const files = await glob.glob(pattern);

  // Return only relevant summary, not full content
  return {
    fileCount: files.length,
    topLevelFiles: files.slice(0, 10),
    structure: inferStructure(files)
  };
}

function inferStructure(files) {
  // Analyze file patterns and return structure summary
  // ...
}

module.exports = { summarizeRepoFiles };
```

Reference in plans:

```markdown
## Data Sources
- Preprocessing: context/servers/repo/summarizeFiles.js (get structure)
- Output: context/data/2025-11-15-repo-structure.md
```

### Team Collaboration

**Share global methodology:**
```bash
# Team dotfiles repo
mkdir -p ~/.codex
curl https://your-company.com/dotfiles/CODEX.md > ~/.codex/CODEX.md
```

**Version control local context:**
```bash
# Commit project-specific context
git add CODEX.md
git add context/context.md
git commit -m "docs: update project context"

# .gitignore for sensitive data
echo "context/data/*.env" >> .gitignore
echo "context/archives/*" >> .gitignore
```

### Automation Scripts

```bash
#!/bin/bash
# scripts/para-archive.sh
# Archive completed work

DATE=$(date +%F-%H%M)

# Move context to archives
mv context/context.md context/archives/${DATE}-context.md

# Create fresh context
cat > context/context.md << EOF
# Current Work Summary

Ready for next task.

---

\`\`\`json
{
  "active_context": [],
  "completed_summaries": [
    "context/summaries/${DATE}-*.md"
  ],
  "last_updated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
\`\`\`
EOF

echo "✅ Archived to context/archives/${DATE}-context.md"
```

### CI/CD Integration

```yaml
# .github/workflows/codex-audit.yml
name: PARA Context Audit

on: [pull_request]

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Check for summary
        run: |
          if [ ! -f context/summaries/*-$(date +%F).md ]; then
            echo "::warning::No summary for today's changes"
          fi

      - name: Verify plan exists
        run: |
          # Ensure PR has corresponding plan
          git diff --name-only origin/main | grep "context/plans/"
```

---

## Templates

See the [templates/](templates/) directory for ready-to-use examples:

- **Project CODEX.md templates** for different tech stacks
- **Preprocessing tool examples** for common data filtering tasks
- **Context structure examples** for various project types

---

## Comparison with Other Tools

| Feature | Codex CLI | Claude Code | Cursor | Copilot |
|---------|-----------|-------------|--------|---------|
| **PARA Compatibility** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Auto-read CODEX.md** | ⚠️ Config needed | ✅ Native | ✅ Native | ⚠️ Limited |
| **Multi-file edits** | ✅ | ✅ | ✅ | ❌ |
| **Preprocessing support** | ✅ | ✅ (MCP) | ✅ | ❌ |
| **CLI-based** | ✅ | ✅ | ❌ | ❌ |
| **Workflow automation** | ✅ | ✅ | ⚠️ | ⚠️ |

---

## Next Steps

### Learn More
- 📖 [Full PARA-Programming Documentation](../README.md)
- 🚀 [5-Minute Quickstart Guide](QUICKSTART.md)
- 📝 [Template Library](templates/)

### Get Help
- 💬 [GitHub Discussions](../../discussions)
- 🐛 [Report Issues](../../issues)
- 🤝 [Contribute](../README.md#contributing)

---

## Quick Reference

```bash
# One-time global setup
mkdir -p ~/.codex
cp codex/CODEX.md ~/.codex/CODEX.md

# Per-project setup
mkdir -p context/{data,plans,summaries,archives,servers}
cp templates/basic-CODEX.md ./CODEX.md
# Edit CODEX.md with your project details

# Start working
codex
# Explicitly mention PARA methodology in prompts if needed
```

**The PARA Advantage with Codex CLI:**
- ✅ Powerful OpenAI models for code understanding
- ✅ Flexible configuration options
- ✅ Excellent for complex, multi-file projects
- ✅ Works great with explicit workflow reminders

**Happy PARA-Programming with Codex CLI! 🚀**
