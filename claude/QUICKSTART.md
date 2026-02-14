# Claude Code Quickstart Guide

**Get up and running with Pret-a-Program and Claude Code in under 5 minutes**

This guide will take you from zero to your first Pret-a-Program session with Claude Code.

---

## 🌟 About This Guide

Pret-a-Program is a **methodology** that works with any AI assistant. This guide shows you how to use it with Claude Code—the **recommended platform** for the best experience.

**Why Claude Code?**
- ✅ Native CLAUDE.md file support
- ✅ Full MCP integration for token efficiency
- ✅ Multi-file operations
- ✅ Perfect for the Pret workflow

**Two Setup Options:**
1. **Skill (Recommended)** - Automated commands, maximum productivity
2. **Manual** - More control, learn the methodology deeply

---

## ⚡ Quick Navigation

- **Want the fastest setup?** → [Use the Skill](#option-a-automated-installation-fastest) (⭐ Recommended)
- **Prefer manual control?** → [Manual Setup](#option-c-legacy-method-no-skill)
- **New to Pret?** → [Read Overview First](README.md)
- **Want examples?** → [See Templates](templates/)

---

## Prerequisites

Before you begin, make sure you have:

- [ ] **Claude Code CLI installed** ([Installation guide](https://docs.anthropic.com/claude/docs/claude-code))
- [ ] **Claude API access** (API key or subscription)
- [ ] **A project to work on** (any codebase works!)
- [ ] **2-5 minutes** of time (depends on method)

---

## 🚀 Step 1: Install Pret-a-Program

### ⭐ Recommended: Use the Skill (Maximum Automation)

The Pret-a-Program skill provides **automated slash commands** that make the methodology easy to use.

### Option A: Automated Installation (Fastest)

```bash
# Clone the repository
git clone https://github.com/pret-a-program/pret-a-program.git
cd pret-a-program

# Run the installation script
./skills/claude-code/scripts/install.sh
```

**What this does:**
- Creates symlink `~/.claude/CLAUDE.md` → `$(pwd)/CLAUDE.md`
- Copies slash commands to `~/.claude/commands/`
- When you `git pull`, your methodology auto-updates!

**What this installs:**
- ✅ Global `CLAUDE.md` methodology file
- ✅ `/pret-init` - Initialize Pret structure in projects
- ✅ `/pret-plan` - Create structured planning documents
- ✅ `/pret-summarize` - Generate summaries automatically
- ✅ `/pret-archive` - Archive completed contexts
- ✅ `/pret-status` - Display current workflow state
- ✅ `/pret-check` - Decision helper for workflow application

**✅ Done!** Skip to [Step 2](#step-2-navigate-to-your-project) and use `/pret-init` instead of manual setup.

---

### Option B: Manual Installation

```bash
# Ensure you're in the cloned repo
cd /path/to/pret-a-program

# Create directories
mkdir -p ~/.claude/commands

# Create symlink for global methodology (recommended)
ln -s "$(pwd)/CLAUDE.md" ~/.claude/CLAUDE.md

# Copy slash commands
cp skills/claude-code/commands/*.md ~/.claude/commands/

# Verify installation
ls -la ~/.claude/CLAUDE.md        # Should show symlink
ls ~/.claude/commands/pret-*.md   # Should show 6 commands
```

**Symlink benefit:** Automatic updates when you `git pull`!

**✅ Done!** Skip to [Step 2](#step-2-navigate-to-your-project) and use `/pret-init` instead of manual setup.

---

### Option C: Legacy Method (No Skill)

If you prefer not to use the skill, you can install just the global methodology:

```bash
# Ensure you're in the cloned repo
cd /path/to/pret-a-program

# Create .claude directory in your home folder
mkdir -p ~/.claude

# Create symlink to global CLAUDE.md (recommended)
ln -s "$(pwd)/CLAUDE.md" ~/.claude/CLAUDE.md

# Verify the symlink
ls -la ~/.claude/CLAUDE.md
# Should show: ~/.claude/CLAUDE.md -> /path/to/pret-a-program/CLAUDE.md
```

**What this does:** Tells Claude Code how to follow the Pret-a-Program methodology (Plan → Review → Execute → Summarize → Archive) across all your projects.

**✅ You only need to do this once!** After this, every project will use the same workflow.

**Note:** With this method, you'll need to manually create context directories and files (see [Step 3](#step-3-create-context-directory-structure)).

---

### 💡 Which Method Should You Choose?

| Method | Best For | Automation Level | Learning Curve |
|--------|----------|------------------|----------------|
| **Skill (Option A/B)** | Most users, maximum productivity | ⭐⭐⭐⭐⭐ Full | Low - commands guide you |
| **Manual (Option C)** | Deep learners, custom workflows | ⭐⭐ Minimal | Medium - learn by doing |

**Our recommendation:** Start with the skill (Option A). It automates the workflow while teaching you the methodology. You can always switch to manual later if you want more control.

**Remember:** The underlying Pret methodology is identical in both approaches—only the automation differs. And the same methodology works across all AI assistants, not just Claude Code!

---

## Step 2: Navigate to Your Project

```bash
cd /path/to/your-project
```

If you don't have a project yet, create a test one:

```bash
mkdir ~/para-test-project
cd ~/para-test-project
npm init -y  # or your language's equivalent
```

---

## Step 3: Initialize Pret Structure

### If You Installed the Skill (Recommended)

```bash
# Start Claude Code
claude

# Initialize Pret structure with one command
/pret-init
```

**That's it!** The command automatically creates:
- ✅ `context/` directory with all subdirectories
- ✅ `context/context.md` with JSON structure
- ✅ `CLAUDE.md` (if it doesn't exist)

Skip to [Step 4](#step-4-your-first-task)!

---

### If You Used Legacy Method (No Skill)

Create the structure manually:

```bash
# Create all necessary directories
mkdir -p context/{data,plans,summaries,archives,servers}

# Create initial context.md
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

# Verify structure
tree context/
# Should show:
# context/
# ├── archives/
# ├── data/
# ├── plans/
# ├── servers/
# └── summaries/
```

**What each directory is for:**
- **plans/** - Where Claude creates plans before executing
- **summaries/** - Where Claude documents what was done after completion
- **data/** - Reference files, configs, examples
- **archives/** - Historical snapshots of past work
- **servers/** - MCP preprocessing tools (advanced)

---

## Step 4: Your First Task

### If You Installed the Skill

Use the slash commands for a streamlined experience:

```
You: "/pret-plan add-health-check-endpoint"

Claude: "I'll create a plan for adding a health check endpoint.

Creating context/plans/2025-11-12-add-health-check-endpoint.md...

[Creates a detailed plan with standard template]

I've created the plan at context/plans/2025-11-12-add-health-check-endpoint.md.

Please review it and let me know if it looks good before I proceed."

You: "Looks good, proceed"

Claude: [Implements the plan]

You: "/pret-summarize"

Claude: "Analyzing changes and creating summary...

Summary created at context/summaries/2025-11-12-add-health-check-endpoint-summary.md

All tests passing ✅"

You: "/pret-status"

Claude: "📊 Pret Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Completed Summaries:
   → context/summaries/2025-11-12-add-health-check-endpoint-summary.md

🎯 Next Action:
   Run /pret-archive to clean up and prepare for next task"
```

**🎉 That's the skill workflow!** Much faster than manual Pret.

---

### If You Used Legacy Method (No Skill)

Try this to verify everything works:

```
You: "Following Pret methodology, create a plan for adding a health check endpoint"

Claude: "I'll create a plan for adding a health check endpoint.

Creating context/plans/2025-11-12-health-check.md...

[Creates a detailed plan]

I've created the plan at context/plans/2025-11-12-health-check.md.
Here's the summary:

**Objective:** Add /health endpoint that returns service status

**Approach:**
1. Create route handler in src/routes/health.ts
2. Add basic status checks (database, external services)
3. Return JSON response with status codes

**Files to Create:**
- src/routes/health.ts (new)

**Files to Modify:**
- src/app.ts (register new route)

Please review the plan. Should I proceed with implementation?"

You: "Looks good, proceed"

Claude: [Implements the plan]

Claude: "Implementation complete!

Created:
- src/routes/health.ts (42 lines)

Modified:
- src/app.ts (added route registration at line 23)

All tests passing ✅

Creating summary at context/summaries/2025-11-12-health-check-summary.md...

Summary complete! The /health endpoint is now available at http://localhost:3000/health"
```

**🎉 Congratulations!** You just completed your first Pret-a-Program workflow with Claude Code!

---

## What Just Happened?

Let's break down what Claude did automatically:

1. **📋 Plan** - Created `context/plans/2025-11-12-health-check.md` with detailed approach
2. **👤 Review** - Asked for your approval before executing
3. **⚡ Execute** - Implemented the plan step-by-step
4. **📝 Summarize** - Created `context/summaries/2025-11-12-health-check-summary.md` documenting what was done
5. **🗄️ Archive** - (Would happen next when you start a new task)

All of this happened because:
- Claude read `~/.claude/CLAUDE.md` and knows to follow the Pret workflow
- Claude read `./CLAUDE.md` and understands your project structure
- Claude maintains the `context/` directory automatically

---

## Next Steps

### Try More Complex Tasks

```
# Feature development
"Let's add user authentication following Pret methodology"

# Bug fixing
"Fix the memory leak in the WebSocket handler (Pret workflow)"

# Refactoring
"The UserService class is too complex. Let's refactor it."

# Analysis
"Analyze our API response times and suggest optimizations"
```

### Explore Advanced Features

1. **MCP Servers** - Create preprocessing tools in `context/servers/`
2. **Templates** - Check out `claude/templates/` for more examples
3. **Team Workflow** - Share your global CLAUDE.md with teammates

### Customize Your Workflow

Edit `~/.claude/CLAUDE.md` to:
- Add your own MCP patterns
- Adjust the workflow steps
- Include team-specific conventions

---

## Common First-Time Issues

### Issue: Claude doesn't follow Pret workflow

**Check:**
```bash
# Verify global file exists
ls -la ~/.claude/CLAUDE.md

# Verify project file exists
ls -la ./CLAUDE.md

# Check that project file references global
grep "Follow.*claude/CLAUDE.md" CLAUDE.md
```

**Fix:** Make sure your project `CLAUDE.md` includes:
```markdown
> **Workflow Methodology:** Follow `~/.claude/CLAUDE.md`
```

### Issue: Context directory not being used

**Check:**
```bash
# Verify structure exists
ls -la context/
```

**Fix:**
```bash
mkdir -p context/{data,plans,summaries,archives,servers}
```

### Issue: "Can't find context.md"

**Fix:**
```bash
# Create it
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

---

## Quick Reference Checklist

### One-Time Setup (Do Once)
- [ ] Install Claude Code CLI
- [ ] Copy CLAUDE.md to `~/.claude/CLAUDE.md`

### Per-Project Setup (Do For Each Project)
- [ ] Create `context/` directory structure
- [ ] Initialize `context/context.md`
- [ ] Create project `CLAUDE.md`
- [ ] Start `claude-code`

### Per-Task Workflow (Automatic!)
- [ ] Claude creates plan in `context/plans/`
- [ ] You review and approve
- [ ] Claude executes
- [ ] Claude creates summary in `context/summaries/`
- [ ] Archive when done

---

## File Structure Summary

After following this guide, your project should look like:

```
your-project/
├── CLAUDE.md                           # Project context (you created)
├── context/
│   ├── context.md                      # Current work state (you created)
│   ├── plans/
│   │   └── 2025-11-12-health-check.md  # Plan (Claude created)
│   ├── summaries/
│   │   └── 2025-11-12-health-check-summary.md  # Summary (Claude created)
│   ├── data/                           # Reference files
│   ├── archives/                       # Past contexts
│   └── servers/                        # MCP tools (advanced)
└── [your source code...]

~/.claude/
└── CLAUDE.md                           # Global methodology (you created)
```

---

## Why We Recommend Claude Code (But It's Not Required!)

Claude Code offers the best experience for Pret-a-Program:

✅ **Automatically reads CLAUDE.md files** - No need to paste or reference
✅ **Follows Pret workflow natively** - Creates plans/summaries without prompting
✅ **Full MCP support** - Can use preprocessing tools for token efficiency
✅ **Multi-file operations** - Handles complex refactors across many files
✅ **Perfect memory** - Maintains project context across sessions

**This is why Claude Code gets ⭐⭐⭐⭐⭐ for Pret compatibility!**

**However:** The Pret methodology works identically with Cursor (⭐⭐⭐⭐), Copilot (⭐⭐⭐), and any other AI assistant. The workflow is universal—only the automation level differs. Use what fits your workflow!

---

## Learn More

### Documentation
- 🚀 [**Claude Code Skill Guide**](../skills/claude-code/README.md) - Using slash commands
- 📖 [Full Claude Code Guide](README.md)
- 📚 [Main Pret-a-Program Docs](../README.md)
- 🎓 [Understanding CLAUDE.md](README.md#understanding-the-claudemd-system)
- 🔧 [Skill Installation Guide](../skills/claude-code/INSTALL.md)

### Templates & Examples
- 📝 [Project Templates](templates/)
- 💡 [Example Workflows](README.md#examples)
- 🛠️ [MCP Server Examples](templates/mcp-servers/)

### Get Help
- 💬 [GitHub Discussions](../../discussions)
- 🐛 [Report Issues](../../issues)

---

## Ready to Go!

You now have:
- ✅ Global CLAUDE.md defining workflow
- ✅ Project CLAUDE.md defining your project
- ✅ Context directory structure
- ✅ Working Pret-a-Program setup

**Start coding with Claude Code and enjoy:**
- Consistent, auditable workflows
- Persistent project memory
- Token-efficient operations
- Professional documentation automatically generated

**Happy Pret-a-Program! 🚀**

---

## Quick Command Reference

### With Skill (Recommended)

```bash
# One-time setup
./skills/claude-code/scripts/install.sh

# Per-project setup
cd your-project/
claude
/pret-init

# Working with Pret
/pret-plan "your task"        # Create plan
# [Review and approve]
# [Claude implements]
/pret-summarize               # Generate summary
/pret-archive                 # Clean up
/pret-status                  # Check status anytime
/pret-check "query"           # Should I use Pret for this?
```

### Without Skill (Legacy)

```bash
# One-time setup (in cloned repo directory)
cd /path/to/pret-a-program
mkdir -p ~/.claude
ln -s "$(pwd)/CLAUDE.md" ~/.claude/CLAUDE.md

# Per-project setup
mkdir -p context/{data,plans,summaries,archives,servers}
cat > context/context.md << 'EOF'
# Current Work Summary
---
```json
{"active_context":[],"completed_summaries":[],"last_updated":"2025-11-12T10:00:00Z"}
```
EOF

# Create project CLAUDE.md (edit after)
cp templates/basic-CLAUDE.md ./CLAUDE.md

# Start working
claude-code
```

**💡 Tip:** Use the skill for the best experience! Installation takes <2 minutes.
