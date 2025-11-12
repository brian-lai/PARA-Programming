# PARA-Programming for Claude Code

**The complete guide to using PARA-Programming methodology with Claude Code CLI**

Claude Code is Anthropic's official CLI tool that provides the most integrated PARA-Programming experience. It's designed from the ground up to work with structured context, persistent memory, and the global/local CLAUDE.md file system.

---

## 📋 Table of Contents

- [Why Claude Code for PARA-Programming?](#why-claude-code-for-para-programming)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Understanding the CLAUDE.md System](#understanding-the-claudemd-system)
- [Workflow with Claude Code](#workflow-with-claude-code)
- [Best Practices](#best-practices)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)
- [Advanced Usage](#advanced-usage)

---

## Why Claude Code for PARA-Programming?

Claude Code earns a **⭐⭐⭐⭐⭐ Excellent** rating for PARA compatibility:

### Advantages

✅ **Native CLAUDE.md Support** - Automatically reads global `~/.claude/CLAUDE.md` and project-local `CLAUDE.md`
✅ **Full MCP Integration** - Built-in Model Context Protocol support for preprocessing
✅ **Multi-File Operations** - Can work across multiple files simultaneously
✅ **Persistent Context** - Maintains state and remembers project structure
✅ **CLI Workflow** - Perfect for terminal-based developers
✅ **Token Efficiency** - Designed to minimize context through smart loading

### Limitations

⚠️ **CLI-Only** - No GUI (though this can be an advantage for automation)
⚠️ **Requires API Access** - Needs Claude API key or subscription
⚠️ **Learning Curve** - More setup than IDE-integrated tools

### Perfect For

- **Professional developers** - Engineers who live in the terminal
- **Complex projects** - Multi-file refactors and architectural changes
- **Token optimization** - Projects requiring minimal API costs
- **Full workflow automation** - Scripts, CI/CD, automated planning
- **MCP development** - Building and using preprocessing tools

### The Claude Advantage

Claude Code is **PARA-native**:
- Automatically loads and follows `~/.claude/CLAUDE.md`
- Understands the Plan → Review → Execute → Summarize → Archive loop
- Can create and manage context files without explicit instruction
- Designed for the two-file system (global + local CLAUDE.md)

---

## Quick Start

> **⚡ Want to get started immediately?** See [QUICKSTART.md](QUICKSTART.md) for a 5-minute setup guide.

### Prerequisites

- Claude Code CLI installed
- Claude API access (API key or subscription)
- Basic familiarity with command line

### 5-Minute Setup

```bash
# 1. Create global CLAUDE.md (one-time setup)
mkdir -p ~/.claude
cp CLAUDE.md ~/.claude/CLAUDE.md

# 2. Navigate to your project
cd your-project/

# 3. Initialize claude code and create context structure
# this creates the project-scoped CLAUDE.md file as well
claude

# in the claude TUI
/init
```
EOF

# Start Building

Just start prompting claude what you want it to do and PARA-Program your way to a working product.


---

## Understanding the CLAUDE.md System

Claude Code uses a **two-file system** for context management:

### 1. Global CLAUDE.md (`~/.claude/CLAUDE.md`)

**Purpose:** Defines **HOW** to work (methodology, workflow, patterns)

**Location:** `~/.claude/CLAUDE.md` in your home directory

**Contents:**
- The Plan → Review → Execute → Summarize → Archive workflow
- MCP integration patterns
- Token efficiency strategies
- File naming conventions
- Session hygiene rules

**Setup:** Copy once, use across all projects

```bash
mkdir -p ~/.claude
cp claude/CLAUDE.md ~/.claude/CLAUDE.md
```

### 2. Local CLAUDE.md (`<project>/CLAUDE.md`)

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
│  Global: ~/.claude/CLAUDE.md                │
│  "HOW to work"                              │
│  - Plan before executing                    │
│  - Always get human review                  │
│  - Summarize after completion               │
│  - Use context/ directory structure         │
└─────────────────────────────────────────────┘
                     +
┌─────────────────────────────────────────────┐
│  Local: <project>/CLAUDE.md                 │
│  "WHAT this project is"                     │
│  - Next.js + PostgreSQL + Prisma            │
│  - Microservices architecture               │
│  - Tests in __tests__ directories           │
│  - API routes in src/app/api/               │
└─────────────────────────────────────────────┘
                     =
┌─────────────────────────────────────────────┐
│  Claude Code's Understanding                │
│  "I know HOW to work (global) and           │
│   WHAT I'm working on (local)"              │
└─────────────────────────────────────────────┘
```

**Key Benefit:** Change workflow once (global), applies to all projects. Update project context (local) without duplicating methodology.

---

## Workflow with Claude Code

### Starting a Session

```bash
cd your-project/
claude-code
```

Claude Code automatically:
1. ✅ Reads `~/.claude/CLAUDE.md` (global methodology)
2. ✅ Reads `<project>/CLAUDE.md` (project context)
3. ✅ Loads `context/context.md` (current work state)
4. ✅ Understands the PARA workflow

### Typical Conversation

```
You: "Let's add user authentication following PARA methodology"

Claude: "I'll create a plan for adding user authentication.
Creating context/plans/2025-11-12-user-auth.md...

[Creates detailed plan]

I've created the plan at context/plans/2025-11-12-user-auth.md.
Please review it and let me know if it looks good before I proceed."

You: "Looks good, approved"

Claude: "Great! I'll implement step-by-step.

Step 1: Creating authentication middleware in src/middleware/auth.ts...
[Implements]

Step 2: Adding JWT utilities in src/utils/jwt.ts...
[Implements]

All steps complete! Creating summary at context/summaries/2025-11-12-user-auth-summary.md...

Summary complete. Authentication system is now working!
Should I archive the current context?"

You: "Yes, archive it"

Claude: "Archived to context/archives/2025-11-12-context.md.
Ready for the next task!"
```

### Key Differences from Other Tools

**With Cursor/Copilot:** You often need to explicitly remind the AI about the workflow

**With Claude Code:** It automatically follows PARA because:
- Reads the global CLAUDE.md on startup
- Knows to create plans before executing
- Asks for human review automatically
- Creates summaries without prompting
- Manages the context directory structure

---

## Best Practices

### Global CLAUDE.md Maintenance

✅ **Do:**
- Keep it updated as your workflow evolves
- Document new MCP patterns you discover
- Share improvements with your team
- Version control it (keep in a dotfiles repo)

❌ **Don't:**
- Add project-specific information
- Make it too long (aim for 500-1500 lines)
- Change it frequently (workflow should be stable)

### Local CLAUDE.md Maintenance

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

1. **Use MCP for preprocessing** - Don't load large files directly
2. **Reference by file:line** - Be specific, not broad
3. **Load selectively** - Only open files you need to modify
4. **Summarize first** - Create summaries in context/data/ for large datasets

---

## Examples

### Example 1: Simple Feature Addition

```
You: "Add a /health endpoint to check database connectivity"

Claude: "I'll create a plan for adding a health check endpoint.

[Creates context/plans/2025-11-12-health-endpoint.md]

The plan involves:
1. Create health check route in src/app/api/health/route.ts
2. Add database ping function
3. Return JSON with status

Shall I proceed?"

You: "Yes"

Claude: [Implements]

Claude: "Complete! Summary at context/summaries/2025-11-12-health-endpoint-summary.md.
Health endpoint working at /api/health"
```

### Example 2: Complex Refactoring

```
You: "The UserService is too complex. Let's refactor it following PARA methodology"

Claude: "I'll analyze UserService and create a refactoring plan.

[Analyzes code using MCP to get complexity metrics]

Creating plan at context/plans/2025-11-12-refactor-user-service.md...

Plan summary:
- Current complexity: 15 (high)
- Split into UserService + UserValidator + UserRepository
- Extract 5 helper methods
- Add tests for each new class

Review the plan?"

You: "Good, but keep UserValidator methods in UserService"

Claude: "Updated the plan. Ready to proceed?"

You: "Yes"

Claude: [Refactors with tests between each step]

Claude: "Refactoring complete!
- Complexity reduced from 15 → 4
- All 47 existing tests still passing
- Added 23 new tests

Summary at context/summaries/2025-11-12-refactor-user-service-summary.md"
```

### Example 3: Using MCP for Preprocessing

```
You: "Analyze our API logs from the last week to find slow endpoints"

Claude: "I'll use an MCP tool to preprocess the logs.

[Uses context/servers/logs/analyzeLogs.ts]
[Processes 500MB of logs externally]
[Returns 2k token summary]

Analysis complete. Found 12 slow endpoints.
Creating plan to optimize the top 5...

context/data/2025-11-12-slow-endpoints-analysis.md (summary)
context/plans/2025-11-12-optimize-slow-endpoints.md (plan)

Review the plan?"
```

---

## Troubleshooting

### Claude Code doesn't follow PARA workflow

**Problem:** Claude implements without creating a plan

**Solution:**
1. Check that `~/.claude/CLAUDE.md` exists and is correct
2. Verify project `CLAUDE.md` references the global file
3. Try: "Following the PARA methodology from ~/.claude/CLAUDE.md, create a plan first"

### Can't find global CLAUDE.md

**Problem:** Claude Code says it doesn't see the methodology

**Solution:**
```bash
# Verify file exists
ls -la ~/.claude/CLAUDE.md

# If not, create it
mkdir -p ~/.claude
cp /path/to/PARA-Programming/claude/CLAUDE.md ~/.claude/

# Restart Claude Code
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
  "last_updated": "2025-11-12T10:00:00Z"
}
```
EOF
```

### Token costs too high

**Problem:** Using too many tokens per task

**Solution:**
1. Use MCP servers for preprocessing (context/servers/)
2. Create summaries in context/data/ instead of loading full files
3. Be explicit: "Only load files X, Y, Z"
4. Review your workflow - are you loading unnecessary context?

---

## Advanced Usage

### Setting Up MCP Servers

Create preprocessing tools in `context/servers/`:

```typescript
// context/servers/repo/summarizeFiles.ts
export async function summarizeRepoFiles(pattern: string) {
  const files = await glob(pattern);

  // Return only relevant summary, not full content
  return {
    fileCount: files.length,
    topLevelFiles: files.slice(0, 10),
    structure: inferStructure(files)
  };
}
```

Reference in plans:

```markdown
## Data Sources
- MCP: context/servers/repo/summarizeFiles.ts (get structure)
- Output: context/data/2025-11-12-repo-structure.md
```

### Team Collaboration

**Share global methodology:**
```bash
# Team dotfiles repo
mkdir -p ~/.claude
curl https://your-company.com/dotfiles/CLAUDE.md > ~/.claude/CLAUDE.md
```

**Version control local context:**
```bash
# Commit project-specific context
git add CLAUDE.md
git add context/context.md
git commit -m "docs: update project context"

# .gitignore for sensitive data
echo "context/data/*.env" >> .gitignore
echo "context/archives/*" >> .gitignore
```

### CI/CD Integration

```yaml
# .github/workflows/claude-audit.yml
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

---

## Templates

See the [templates/](templates/) directory for ready-to-use examples:

- **Project CLAUDE.md templates** for different tech stacks
- **MCP server examples** for common preprocessing tasks
- **Context structure examples** for various project types

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
mkdir -p ~/.claude
cp claude/CLAUDE.md ~/.claude/CLAUDE.md

# Per-project setup
mkdir -p context/{data,plans,summaries,archives,servers}
cp templates/basic-CLAUDE.md ./CLAUDE.md
# Edit CLAUDE.md with your project details

# Start working
claude-code
# Claude automatically follows PARA methodology!
```

**The PARA Advantage with Claude Code:**
- ✅ Zero configuration per-project (after global setup)
- ✅ Automatic workflow following
- ✅ Full MCP support for token efficiency
- ✅ Perfect for complex, multi-file projects

**Happy PARA-Programming with Claude Code! 🚀**
