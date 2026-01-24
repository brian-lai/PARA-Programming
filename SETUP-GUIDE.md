# PARA-Programming Setup Guide

**Unified setup instructions for all AI coding assistants**

---

## The Unified Approach

PARA-Programming uses a **single `AGENTS.md` file** that works across all AI coding tools. Instead of maintaining separate configuration files, you:

1. Copy `AGENTS.md` to your project
2. Create a symlink for tools that expect different filenames
3. Start working with the PARA workflow

---

## Quick Setup (Any Tool)

```bash
# 1. Get AGENTS.md
curl -O https://raw.githubusercontent.com/brian-lai/para-programming/main/AGENTS.md

# 2. Initialize context directory
mkdir -p context/{data,plans,summaries,archives,servers}
touch context/context.md

# 3. Create symlink for your tool (see below)
```

---

## Tool-Specific Setup

### Tier 1: Actively Supported

These tools have full documentation and maintained guides.

#### Claude Code

Claude Code looks for `CLAUDE.md`:

```bash
ln -s AGENTS.md CLAUDE.md
```

**[→ Full Setup Guide](tool-setup/claude-code.md)**

Features:
- Global/project hierarchy support
- MCP integration
- Optional skill package for slash commands

#### Cursor

Cursor reads `AGENTS.md` directly - **no symlink needed!**

```bash
# Just ensure AGENTS.md exists in project root
ls AGENTS.md
```

**[→ Full Setup Guide](tool-setup/cursor.md)**

Features:
- Native AGENTS.md support
- Composer for multi-file editing
- `.cursor/rules/` for modular rules (optional)

#### GitHub Copilot

Copilot looks in `.github/`:

```bash
mkdir -p .github
ln -s ../AGENTS.md .github/copilot-instructions.md
```

**[→ Full Setup Guide](tool-setup/copilot.md)**

Features:
- Works in VS Code, JetBrains, Neovim
- Path-specific rules via `.github/instructions/`

#### OpenAI Codex CLI

Codex CLI reads `AGENTS.md` directly - **no symlink needed!**

```bash
# Just ensure AGENTS.md exists in project root
ls AGENTS.md
```

**[→ Full Setup Guide](tool-setup/codex.md)**

Features:
- Native AGENTS.md support
- Preprocessing tools in `context/servers/`

---

### Tier 2: Community Supported

These tools have setup guides with community contributions welcome.

#### Continue.dev

```bash
mkdir -p .continue/rules
ln -s ../../AGENTS.md .continue/rules/para-programming.md
```

**[→ Full Setup Guide](tool-setup/community/continue.md)**

#### Windsurf (Codeium)

```bash
mkdir -p .windsurf/rules
ln -s ../../AGENTS.md .windsurf/rules/para-programming.md
```

**[→ Full Setup Guide](tool-setup/community/windsurf.md)**

---

### Tier 3: Reference Only

For other tools, see patterns and adaptation guides:

**[→ Other Tools Reference](tool-setup/community/others.md)**

Includes: Aider, JetBrains AI, CodeWhisperer, Tabnine, Gemini

---

## Symlink Reference

| Tool | Command |
|------|---------|
| Claude Code | `ln -s AGENTS.md CLAUDE.md` |
| Cursor | *(reads AGENTS.md directly)* |
| GitHub Copilot | `mkdir -p .github && ln -s ../AGENTS.md .github/copilot-instructions.md` |
| Codex CLI | *(reads AGENTS.md directly)* |
| Continue.dev | `mkdir -p .continue/rules && ln -s ../../AGENTS.md .continue/rules/para-programming.md` |
| Windsurf | `mkdir -p .windsurf/rules && ln -s ../../AGENTS.md .windsurf/rules/para-programming.md` |

### Windows Symlinks

Windows requires Developer Mode or Admin privileges:

```cmd
mklink CLAUDE.md AGENTS.md
```

Or configure git to handle symlinks:
```bash
git config core.symlinks true
```

---

## Verify Installation

```bash
# Check AGENTS.md exists
ls -la AGENTS.md

# Check symlink (if created)
readlink CLAUDE.md  # Should show AGENTS.md

# Check context directory
ls context/
```

---

## Example Project Structure

After setup, your project should look like:

```
my-project/
├── AGENTS.md                         # PARA methodology (canonical)
├── CLAUDE.md                         # Symlink → AGENTS.md (for Claude Code)
├── .github/
│   └── copilot-instructions.md       # Symlink → ../AGENTS.md (for Copilot)
├── context/
│   ├── context.md                    # Current work state
│   ├── plans/                        # Pre-work plans
│   ├── summaries/                    # Post-work reports
│   ├── archives/                     # Historical contexts
│   ├── data/                         # Reference files
│   └── servers/                      # Tool wrappers
└── src/                              # Your code
```

---

## Test Your Setup

In your AI assistant, try:

> "Create a plan for adding user authentication"

The AI should:
1. Create a file in `context/plans/`
2. Include sections: Objective, Approach, Files to Modify, Risks, Success Criteria
3. Ask for your review before proceeding

---

## Claude Code Skill (Optional)

For Claude Code users, the skill package adds automated commands:

```bash
# Install skill
cp -r claude-skill ~/.claude/skills/para-programming
```

This enables:
- `/para:init` - Initialize PARA structure
- `/para:plan` - Create a plan
- `/para:execute` - Start execution with branch
- `/para:summarize` - Create summary
- `/para:archive` - Archive completed work
- `/para:status` - Check workflow status

**[→ Skill Documentation](claude-skill/)**

---

## Troubleshooting

### Agent doesn't read instructions

1. Verify file exists: `ls AGENTS.md`
2. Check symlink if applicable: `readlink CLAUDE.md`
3. Restart your editor/IDE
4. Check tool-specific guide for configuration location

### Agent skips planning step

Be explicit in your prompt:
> "Following PARA methodology, create a plan FIRST before implementing"

### Symlink doesn't work (Windows)

Enable Developer Mode or use Admin terminal, or copy the file:
```bash
cp AGENTS.md CLAUDE.md  # Copy instead of symlink
# Note: Changes to AGENTS.md won't auto-sync
```

### Context directory not used

Explicitly mention in prompts:
> "Create the plan in context/plans/task-name.md"

---

## Updating

With symlinks, updates are automatic:

```bash
# Navigate to PARA-Programming repository
cd para-programming

# Pull latest
git pull origin main

# Your symlinked AGENTS.md is updated!
```

If you copied instead of symlinking, manually update:
```bash
curl -O https://raw.githubusercontent.com/brian-lai/para-programming/main/AGENTS.md
```

---

## Next Steps

1. **Follow your tool's setup guide** from `tool-setup/`
2. **Start with a simple task** to test the workflow
3. **Review the examples** in `AGENTS.md` for workflow patterns

**Need help?** See [troubleshooting](#troubleshooting) or [open a discussion](https://github.com/brian-lai/para-programming/discussions).

---

## Quick Reference

```
📋 PARA Workflow
├── 1. Plan → Create context/plans/[task].md
├── 2. Review → Human approves
├── 3. Execute → AI implements
├── 4. Summarize → Create context/summaries/[task].md
└── 5. Archive → Move context.md to archives/

🗂 Directory Structure
project-root/
├── AGENTS.md              # Methodology (symlink for other names)
├── context/
│   ├── context.md         # Current work
│   ├── plans/             # Future work
│   ├── summaries/         # Past work
│   ├── archives/          # History
│   └── servers/           # Tool wrappers
└── [your code]

🔗 Symlinks
├── CLAUDE.md → AGENTS.md           # Claude Code
├── .github/copilot-instructions.md → ../AGENTS.md  # Copilot
├── .continue/rules/*.md → ../../AGENTS.md          # Continue
└── .windsurf/rules/*.md → ../../AGENTS.md          # Windsurf
```

---

**Ready to start?** Follow your tool's setup guide and begin with PARA workflow!
