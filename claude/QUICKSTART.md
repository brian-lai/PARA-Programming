# Claude Code Quickstart Guide

**Get up and running with PARA-Programming and Claude Code in 5 minutes**

This guide will take you from zero to your first PARA-Programming session with Claude Code.

---

## ⚡ Quick Navigation

- **Already have Claude Code?** → [Skip to Setup](#1-install-global-claudemd)
- **New to PARA?** → [Read Overview First](README.md)
- **Want examples?** → [See Templates](templates/)

---

## Prerequisites

Before you begin, make sure you have:

- [ ] **Claude Code CLI installed** ([Installation guide](https://docs.anthropic.com/claude/docs/claude-code))
- [ ] **Claude API access** (API key or subscription)
- [ ] **A project to work on** (any codebase works!)
- [ ] **5 minutes** of time

---

## Step 1: Install Global CLAUDE.md

This is a **one-time setup** that applies to all your projects.

```bash
# Create .claude directory in your home folder
mkdir -p ~/.claude

# Copy the global CLAUDE.md file
cp CLAUDE.md ~/.claude/CLAUDE.md

# Verify it was created
ls -la ~/.claude/CLAUDE.md
```

**What this does:** Tells Claude Code how to follow the PARA-Programming methodology (Plan → Review → Execute → Summarize → Archive) across all your projects.

**✅ You only need to do this once!** After this, every project will use the same workflow.

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

## Step 3: Create Context Directory Structure

```bash
# Initialize CLAUDE.md for your project
claude

/init
```

if all directories weren't created, you can also create manually
```bash
# Create all necessary directories
mkdir -p context/{data,plans,summaries,archives,servers}

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

Try this to verify everything works:

```
You: "Following PARA methodology, create a plan for adding a health check endpoint"

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

**🎉 Congratulations!** You just completed your first PARA-Programming workflow with Claude Code!

---

## What Just Happened?

Let's break down what Claude did automatically:

1. **📋 Plan** - Created `context/plans/2025-11-12-health-check.md` with detailed approach
2. **👤 Review** - Asked for your approval before executing
3. **⚡ Execute** - Implemented the plan step-by-step
4. **📝 Summarize** - Created `context/summaries/2025-11-12-health-check-summary.md` documenting what was done
5. **🗄️ Archive** - (Would happen next when you start a new task)

All of this happened because:
- Claude read `~/.claude/CLAUDE.md` and knows to follow the PARA workflow
- Claude read `./CLAUDE.md` and understands your project structure
- Claude maintains the `context/` directory automatically

---

## Next Steps

### Try More Complex Tasks

```
# Feature development
"Let's add user authentication following PARA methodology"

# Bug fixing
"Fix the memory leak in the WebSocket handler (PARA workflow)"

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

### Issue: Claude doesn't follow PARA workflow

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

## What Makes Claude Code Different?

Unlike Cursor or Copilot, Claude Code:

✅ **Automatically reads CLAUDE.md files** - No need to paste or reference
✅ **Follows PARA workflow natively** - Creates plans/summaries without prompting
✅ **Full MCP support** - Can use preprocessing tools for token efficiency
✅ **Multi-file operations** - Handles complex refactors across many files
✅ **Perfect memory** - Maintains project context across sessions

**This is why Claude Code gets ⭐⭐⭐⭐⭐ for PARA compatibility!**

---

## Learn More

### Documentation
- 📖 [Full Claude Code Guide](README.md)
- 📚 [Main PARA-Programming Docs](../README.md)
- 🎓 [Understanding CLAUDE.md](README.md#understanding-the-claudemd-system)

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
- ✅ Working PARA-Programming setup

**Start coding with Claude Code and enjoy:**
- Consistent, auditable workflows
- Persistent project memory
- Token-efficient operations
- Professional documentation automatically generated

**Happy PARA-Programming! 🚀**

---

## Quick Command Reference

```bash
# One-time setup
mkdir -p ~/.claude
cp CLAUDE.md ~/.claude/CLAUDE.md

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

Copy and paste these commands to get started in seconds! 🎯
