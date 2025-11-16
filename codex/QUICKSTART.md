# Codex CLI Quickstart Guide

**Get up and running with PARA-Programming and Codex CLI in 5 minutes**

This guide will take you from zero to your first PARA-Programming session with Codex CLI.

---

## ⚡ Quick Navigation

- **Already have Codex CLI?** → [Skip to Setup](#step-1-install-global-codexmd)
- **New to PARA?** → [Read Overview First](README.md)
- **Want examples?** → [See Templates](templates/)

---

## Prerequisites

Before you begin, make sure you have:

- [ ] **Codex CLI installed** ([Installation guide](https://platform.openai.com/docs/guides/codex))
- [ ] **OpenAI API access** (API key with Codex access)
- [ ] **A project to work on** (any codebase works!)
- [ ] **5 minutes** of time

---

## Step 1: Install Global AGENTS.md

This is a **one-time setup** that applies to all your projects.

```bash
# Create .codex directory in your home folder
# (Alternatively use ~/.config/codex if that's your preference)
mkdir -p ~/.codex

# Copy the global AGENTS.md file
cp AGENTS.md ~/.codex/AGENTS.md

# Verify it was created
ls -la ~/.codex/AGENTS.md
```

**What this does:** Tells Codex CLI how to follow the PARA-Programming methodology (Plan → Review → Execute → Summarize → Archive) across all your projects.

**✅ You only need to do this once!** After this, every project will use the same workflow.

---

## Step 2: Configure Codex to Read AGENTS.md

Add this to your Codex CLI configuration to automatically load the global AGENTS.md:

```bash
# Create or edit your Codex config
# Location may vary - check Codex documentation for your OS
cat >> ~/.codex/config.json << 'EOF'
{
  "system_prompts": [
    {
      "path": "~/.codex/AGENTS.md",
      "type": "methodology"
    }
  ],
  "project_context_files": [
    "AGENTS.md",
    "context/context.md"
  ]
}
EOF
```

**Note:** Configuration location may vary depending on your Codex CLI version. Consult Codex documentation for the exact path.

---

## Step 3: Navigate to Your Project

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

## Step 4: Create Context Directory Structure

```bash
# Create all necessary directories
mkdir -p context/{data,plans,summaries,archives,servers}

# Initialize context.md
cat > context/context.md << 'EOF'
# Current Work Summary

Ready to start using PARA-Programming with Codex CLI.

---

```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "2025-11-15T10:00:00Z"
}
```
EOF

# Verify structure
tree context/ -L 1
# Should show:
# context/
# ├── archives/
# ├── data/
# ├── plans/
# ├── servers/
# ├── summaries/
# └── context.md
```

**What each directory is for:**
- **plans/** - Where Codex creates plans before executing
- **summaries/** - Where Codex documents what was done after completion
- **data/** - Reference files, configs, examples
- **archives/** - Historical snapshots of past work
- **servers/** - Preprocessing tools (advanced)

---

## Step 5: Create Project AGENTS.md

```bash
cat > AGENTS.md << 'EOF'
# My Project

> **Workflow Methodology:** Follow `~/.codex/AGENTS.md`

## About
A sample project for testing PARA-Programming with Codex CLI.

## Tech Stack
- Node.js (or your stack)
- [Add your technologies]

## Structure
```
src/
├── index.js      # Entry point
└── routes/       # API routes
```

## Key Files
- `src/index.js`: Application entry point

## Conventions
- Use camelCase for variables
- Add JSDoc comments to all functions

## Getting Started
```bash
npm install
npm start
```
EOF
```

---

## Step 6: Your First Task

Start Codex CLI and try this to verify everything works:

```bash
codex
```

Then in the Codex prompt:

```
You: "Following PARA methodology, create a plan for adding a health check endpoint"

Codex: "I'll create a plan for adding a health check endpoint.

Creating context/plans/2025-11-15-health-check.md...

[Creates a detailed plan]

I've created the plan at context/plans/2025-11-15-health-check.md.
Here's the summary:

**Objective:** Add /health endpoint that returns service status

**Approach:**
1. Create route handler in src/routes/health.js
2. Add basic status checks (database connectivity)
3. Return JSON response with status codes

**Files to Create:**
- src/routes/health.js (new)

**Files to Modify:**
- src/index.js (register new route)

Please review the plan. Should I proceed with implementation?"

You: "Looks good, proceed"

Codex: [Implements the plan]

Codex: "Implementation complete!

Created:
- src/routes/health.js (42 lines)

Modified:
- src/index.js (added route registration at line 23)

All changes ready for testing ✅

Creating summary at context/summaries/2025-11-15-health-check-summary.md...

Summary complete! The /health endpoint is now available at http://localhost:3000/health"
```

**🎉 Congratulations!** You just completed your first PARA-Programming workflow with Codex CLI!

---

## What Just Happened?

Let's break down what Codex did automatically:

1. **📋 Plan** - Created `context/plans/2025-11-15-health-check.md` with detailed approach
2. **👤 Review** - Asked for your approval before executing
3. **⚡ Execute** - Implemented the plan step-by-step
4. **📝 Summarize** - Created `context/summaries/2025-11-15-health-check-summary.md` documenting what was done
5. **🗄️ Archive** - (Would happen next when you start a new task)

All of this happened because:
- Codex read `~/.codex/AGENTS.md` and knows to follow the PARA workflow
- Codex read `./AGENTS.md` and understands your project structure
- Codex maintains the `context/` directory automatically

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

1. **Preprocessing Tools** - Create data filters in `context/servers/`
2. **Templates** - Check out `codex/templates/` for more examples
3. **Team Workflow** - Share your global AGENTS.md with teammates

### Customize Your Workflow

Edit `~/.codex/AGENTS.md` to:
- Add your own preprocessing patterns
- Adjust the workflow steps
- Include team-specific conventions

---

## Common First-Time Issues

### Issue: Codex doesn't follow PARA workflow

**Check:**
```bash
# Verify global file exists
ls -la ~/.codex/AGENTS.md

# Verify project file exists
ls -la ./AGENTS.md

# Check that project file references global
grep "Follow.*codex/AGENTS.md" AGENTS.md
```

**Fix:** Make sure your project `AGENTS.md` includes:
```markdown
> **Workflow Methodology:** Follow `~/.codex/AGENTS.md`
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
  "last_updated": "2025-11-15T10:00:00Z"
}
```
EOF
```

### Issue: Codex not reading AGENTS.md files

**Solution:** Ensure your Codex CLI is configured to load context files. Add to your prompt:
```
"Please read ~/.codex/AGENTS.md for workflow methodology and ./AGENTS.md for project context before proceeding"
```

Or configure Codex to auto-load these files (see Step 2).

---

## Quick Reference Checklist

### One-Time Setup (Do Once)
- [ ] Install Codex CLI
- [ ] Copy AGENTS.md to `~/.codex/AGENTS.md`
- [ ] Configure Codex to auto-load AGENTS.md (optional but recommended)

### Per-Project Setup (Do For Each Project)
- [ ] Create `context/` directory structure
- [ ] Initialize `context/context.md`
- [ ] Create project `AGENTS.md`
- [ ] Start `codex`

### Per-Task Workflow (Automatic with proper config!)
- [ ] Codex creates plan in `context/plans/`
- [ ] You review and approve
- [ ] Codex executes
- [ ] Codex creates summary in `context/summaries/`
- [ ] Archive when done

---

## File Structure Summary

After following this guide, your project should look like:

```
your-project/
├── AGENTS.md                            # Project context (you created)
├── context/
│   ├── context.md                      # Current work state (you created)
│   ├── plans/
│   │   └── 2025-11-15-health-check.md  # Plan (Codex created)
│   ├── summaries/
│   │   └── 2025-11-15-health-check-summary.md  # Summary (Codex created)
│   ├── data/                           # Reference files
│   ├── archives/                       # Past contexts
│   └── servers/                        # Preprocessing tools (advanced)
└── [your source code...]

~/.codex/
└── AGENTS.md                           # Global methodology (you created)
```

---

## What Makes Codex CLI Great for PARA?

Codex CLI works excellently with PARA-Programming:

✅ **Automatic AGENTS.md discovery** - Auto-reads AGENTS.md files
✅ **Structured prompting** - Responds well to methodology instructions
✅ **Multi-file operations** - Handles complex refactors
✅ **OpenAI's powerful models** - Excellent code understanding
✅ **CLI workflow** - Perfect for terminal-based developers

**This is why Codex CLI gets ⭐⭐⭐⭐⭐ for PARA compatibility!**

---

## Learn More

### Documentation
- 📖 [Full Codex CLI Guide](README.md)
- 📚 [Main PARA-Programming Docs](../README.md)
- 🎓 [Understanding AGENTS.md](README.md#understanding-the-agentsmd-system)

### Templates & Examples
- 📝 [Project Templates](templates/)
- 💡 [Example Workflows](README.md#examples)
- 🛠️ [Preprocessing Tool Examples](templates/preprocessing-tools/)

### Get Help
- 💬 [GitHub Discussions](../../discussions)
- 🐛 [Report Issues](../../issues)

---

## Ready to Go!

You now have:
- ✅ Global AGENTS.md defining workflow
- ✅ Project AGENTS.md defining your project
- ✅ Context directory structure
- ✅ Working PARA-Programming setup

**Start coding with Codex CLI and enjoy:**
- Consistent, auditable workflows
- Persistent project memory
- Token-efficient operations
- Professional documentation automatically generated

**Happy PARA-Programming! 🚀**

---

## Quick Command Reference

```bash
# One-time setup
mkdir -p ~/.codex
cp AGENTS.md ~/.codex/AGENTS.md

# Per-project setup
mkdir -p context/{data,plans,summaries,archives,servers}
cat > context/context.md << 'EOF'
# Current Work Summary
---
```json
{"active_context":[],"completed_summaries":[],"last_updated":"2025-11-15T10:00:00Z"}
```
EOF

# Create project AGENTS.md (edit after)
cp templates/basic-AGENTS.md ./AGENTS.md

# Start working
codex
```

Copy and paste these commands to get started in seconds! 🎯
