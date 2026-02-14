# Command: para-init

Initialize PARA-Programming structure in the current project.

## What This Does

This command sets up the complete PARA-Programming directory structure and files:

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
/para-init
```

### Options

```
/para-init --template=basic    # Create minimal CLAUDE.md
/para-init --template=full     # Create comprehensive CLAUDE.md
```

## After Running

You'll have a complete PARA-Programming setup ready for your first task. Start by:

1. Editing `CLAUDE.md` with your project-specific context
2. Running `/para-plan` to create your first plan
3. Following the PARA workflow: Plan → Review → Execute → Summarize → Archive

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
## ✅ PARA-Programming Structure Initialized

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

**PARA Workflow:** Plan → Review → Execute → Summarize → Archive

| Use PARA For | Skip PARA For |
|--------------|---------------|
| Code changes, features, bug fixes | Simple queries ("What does X do?") |
| Architecture decisions | Code navigation ("Show me X") |
| Complex debugging | Explanations ("How does X work?") |
| File modifications | Quick lookups |
| Refactoring, optimizations | Read-only informational tasks |

**Rule of thumb:** If it results in git changes, use PARA workflow.

---

## 🚀 Next Steps

1. **Edit `CLAUDE.md`** with your project-specific context (architecture, tech stack, conventions)
2. **Create your first plan:** `/para-plan <task-description>`
3. **Check workflow status:** `/para-status`
4. **Get help anytime:** `/para-help`

---

## 📚 Available PARA Commands

- **`/para-plan`** - Create a new planning document
- **`/para-execute`** - Start execution: create branch and track to-dos
- **`/para-summarize`** - Generate post-work summary
- **`/para-archive`** - Archive current context
- **`/para-status`** - Check current workflow state
- **`/para-check`** - Decision helper (should I use PARA?)
- **`/para-help`** - Comprehensive PARA guide

---

## 💡 Getting Started Tips

**First time using PARA?**
1. Start with a small task to learn the workflow
2. Run `/para-help` to see the full guide
3. Use `/para-check` when unsure if a task needs PARA

**Example first task:**
```
/para-plan Add user authentication to API endpoints
```

Your PARA-Programming environment is ready! 🎉
```
