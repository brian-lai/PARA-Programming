# Command: pret-init

Initialize Pret-a-Program structure in the current project.

## What This Does

This command sets up the complete Pret-a-Program directory structure and files:

1. Creates `context/` directory with subdirectories:
   - `context/data/` - Input files, payloads, datasets
   - `context/plans/` - Pre-work planning documents
   - `context/summaries/` - Post-work reports
   - `context/archives/` - Historical context snapshots
   - `context/servers/` - MCP tool wrappers

2. Creates `context/context.md` with initial structure

3. Creates project `CLAUDE.md` (if it doesn't exist) with reference to global methodology

4. Displays next steps for getting started

## Usage

```
/pret-init
```

### Options

```
/pret-init --template=basic    # Create minimal CLAUDE.md
/pret-init --template=full     # Create comprehensive CLAUDE.md
```

## After Running

You'll have a complete Pret-a-Program setup ready for your first task. Start by:

1. Editing `CLAUDE.md` with your project-specific context
2. Running `/pret-plan` to create your first plan
3. Following the Pret workflow: Plan → Review → Execute → Summarize → Archive

## Implementation

Create the following directory structure:

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
```

Create `context/context.md`:

````markdown
# Current Work Summary

Ready to start first task.

---
```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "TIMESTAMP"
}
```
````

If `CLAUDE.md` doesn't exist, create it from template based on `--template` option (default: basic).

After completing setup, display the following comprehensive success message:

---

## Success Output

After initialization completes, display:

```markdown
## ✅ Pret-a-Program Structure Initialized

### Directory Structure Created

```
context/
├── archives/     # Historical context snapshots
├── data/         # Input files, payloads, datasets
├── plans/        # Pre-work planning documents
├── servers/      # MCP tool wrappers
├── summaries/    # Post-work reports
└── context.md    # Active session context
```

### Files Created/Updated

- **`context/context.md`** - Fresh context file ready for first task
- **`CLAUDE.md`** - Project-specific methodology (if it didn't exist)

---

## 📋 Quick Reference

**Pret Workflow:** Plan → Review → Execute → Summarize → Archive

| Use Pret For | Skip Pret For |
|--------------|---------------|
| Code changes, features, bug fixes | Simple queries ("What does X do?") |
| Architecture decisions | Code navigation ("Show me X") |
| Complex debugging | Explanations ("How does X work?") |
| File modifications | Quick lookups |
| Refactoring, optimizations | Read-only informational tasks |

**Rule of thumb:** If it results in git changes, use Pret workflow.

---

## 🚀 Next Steps

1. **Edit `CLAUDE.md`** with your project-specific context (architecture, tech stack, conventions)
2. **Create your first plan:** `/pret-plan <task-description>`
3. **Check workflow status:** `/pret-status`
4. **Get help anytime:** `/pret-help`

---

## 📚 Available Pret Commands

- **`/pret-plan`** - Create a new planning document
- **`/pret-execute`** - Start execution: create branch and track to-dos
- **`/pret-summarize`** - Generate post-work summary
- **`/pret-archive`** - Archive current context
- **`/pret-status`** - Check current workflow state
- **`/pret-check`** - Decision helper (should I use Pret?)
- **`/pret-help`** - Comprehensive Pret guide

---

## 💡 Getting Started Tips

**First time using Pret?**
1. Start with a small task to learn the workflow
2. Run `/pret-help` to see the full guide
3. Use `/pret-check` when unsure if a task needs Pret

**Example first task:**
```
/pret-plan Add user authentication to API endpoints
```

Your Pret-a-Program environment is ready! 🎉
```
