# Migration Guide

**Upgrading to Pret-a-Program**

---

## Migrating from PARA-Programming v1

If you were using the previous "PARA-Programming" branding, here's what changed:

| Before | After |
|--------|-------|
| PARA-Programming | Pret-a-Program |
| `para/` branch prefix | `pret/` branch prefix |
| `/para-*` slash commands | `/pret-*` slash commands |
| `claude-skill/` directory | `skills/claude-code/` |
| `make setup` | `pret install-skills` |
| Manual `mkdir -p context/...` | `pret init` |

### Quick Migration

```bash
# 1. Install the new CLI
brew install brian-lai/pret-a-program

# 2. Re-initialize (preserves existing context/)
pret init

# 3. Update AI tool skills
pret install-skills --claude   # Replaces old claude-skill
pret install-skills --cursor   # New
pret install-skills --codex    # New

# 4. Rename branches (optional)
git branch -m para/my-feature pret/my-feature

# 5. Remove old skill installation
rm -rf ~/.claude/skills/para-programming/
```

**What stays the same:** The `context/` directory structure, file formats, and workflow steps (Plan, Review, Execute, Summarize, Archive) are all unchanged.

---

## Migrating from Tool-Specific Configuration

This section covers migrating from per-tool config files to the unified `AGENTS.md` approach.

### Overview

Pret-a-Program uses a **single `AGENTS.md` file** that works across all AI coding tools. This guide helps you migrate from the previous tool-specific configuration files.

---

## What Changed

### Before (Multiple Files)

```
# Each tool had its own methodology file:
~/.claude/CLAUDE.md           # Claude Code
~/.codex/AGENTS.md            # Codex CLI
~/.gemini/GEMINI.md           # Gemini
.cursorrules                  # Cursor (per-project)
.github/copilot-instructions.md  # Copilot (per-project)
```

### After (Single Source)

```
# One file, symlinked for each tool:
AGENTS.md                     # Single source of truth

# Symlinks:
CLAUDE.md → AGENTS.md
.github/copilot-instructions.md → ../AGENTS.md
```

---

## Migration Steps

### Step 1: Get the New AGENTS.md

```bash
# In your project root
curl -O https://raw.githubusercontent.com/brian-lai/pret-a-program/main/AGENTS.md
```

Or if you cloned the repository:
```bash
cp /path/to/pret-a-program/AGENTS.md ./
```

### Step 2: Create Symlinks

Replace your tool-specific files with symlinks:

#### Claude Code

```bash
# Backup existing file (optional)
mv CLAUDE.md CLAUDE.md.bak

# Create symlink
ln -s AGENTS.md CLAUDE.md
```

If you had global `~/.claude/CLAUDE.md`:
```bash
# Option A: Keep methodology in each project (recommended)
# Just use project-level AGENTS.md + symlink

# Option B: Global methodology
ln -s /path/to/pret-a-program/AGENTS.md ~/.claude/CLAUDE.md
```

#### Cursor

Cursor now reads `AGENTS.md` directly. If you had `.cursorrules`:

```bash
# Backup (optional)
mv .cursorrules .cursorrules.bak

# No symlink needed - Cursor reads AGENTS.md directly
```

Note: `.cursorrules` is deprecated. Migrate to `AGENTS.md` or `.cursor/rules/`.

#### GitHub Copilot

```bash
# Backup existing (optional)
mv .github/copilot-instructions.md .github/copilot-instructions.md.bak

# Create symlink
ln -s ../AGENTS.md .github/copilot-instructions.md
```

#### Codex CLI

Codex reads `AGENTS.md` directly. If you had `~/.codex/AGENTS.md`:

```bash
# The project-level AGENTS.md takes precedence
# No changes needed - it already reads AGENTS.md
```

### Step 3: Merge Project-Specific Content

If your old files contained project-specific context (not just methodology), add it to `AGENTS.md`:

```markdown
# AGENTS.md

[... Pret methodology content ...]

---
# Project-Specific Context (add below this line)

## About This Project
[Your project description]

## Architecture
[Your architecture notes]

## Conventions
[Your conventions]
```

Or keep it in a separate file and reference in your prompts.

### Step 4: Verify Setup

```bash
# Check AGENTS.md exists
ls -la AGENTS.md

# Check symlinks
readlink CLAUDE.md  # Should show: AGENTS.md
readlink .github/copilot-instructions.md  # Should show: ../AGENTS.md

# Test with your AI tool
```

### Step 5: Clean Up (Optional)

After verifying everything works:

```bash
# Remove backup files
rm CLAUDE.md.bak
rm .cursorrules.bak
rm .github/copilot-instructions.md.bak

# Remove old global files (if migrating to project-level)
rm ~/.claude/CLAUDE.md
rm ~/.codex/AGENTS.md
rm ~/.gemini/GEMINI.md
```

---

## Preserving Custom Content

### If You Had Custom Methodology

If you modified the Pret methodology, you have options:

1. **Contribute upstream**: Submit a PR with your improvements
2. **Fork the repository**: Maintain your own version
3. **Extend locally**: Add custom sections to the bottom of `AGENTS.md`

### If You Had Project Context

Move project-specific content to the bottom of `AGENTS.md` or a separate file:

```markdown
# AGENTS.md

[... standard Pret methodology ...]

---
# Project: My App

## Tech Stack
- Next.js 14
- PostgreSQL
- Redis

## Conventions
- Use Server Components by default
- API routes in src/app/api/
```

---

## Tool-Specific Notes

### Claude Code

The skill package still works with this setup:
- `/pret:init` - Works normally
- `/pret:plan` - Works normally
- Commands read from `CLAUDE.md` symlink

### Cursor

Benefits of migration:
- `.cursorrules` is deprecated
- `AGENTS.md` is the new standard
- Shared with Codex CLI (same file works for both)

### GitHub Copilot

The symlink approach means:
- Updates to `AGENTS.md` automatically apply
- No more duplicate content to maintain

---

## Troubleshooting

### Symlink not working

```bash
# Check if symlink exists
ls -la CLAUDE.md

# If broken, recreate
rm CLAUDE.md
ln -s AGENTS.md CLAUDE.md
```

### Windows symlink issues

Windows requires Developer Mode or Admin:
```cmd
mklink CLAUDE.md AGENTS.md
```

Or just copy the file:
```bash
cp AGENTS.md CLAUDE.md
# Note: Won't auto-update
```

### Tool not reading new file

1. Restart your editor/IDE
2. Check file permissions: `chmod 644 AGENTS.md`
3. Verify tool is configured to read the expected location

### Merge conflicts

If you have custom content in old files:
1. Copy custom content to a temp file
2. Create symlink
3. Add custom content to bottom of `AGENTS.md`

---

## Rollback

If you need to revert:

```bash
# Remove symlinks
rm CLAUDE.md
rm .github/copilot-instructions.md

# Restore backups
mv CLAUDE.md.bak CLAUDE.md
mv .github/copilot-instructions.md.bak .github/copilot-instructions.md
```

---

## Benefits of Migration

After migrating, you get:

1. **Single source of truth** - One file to maintain
2. **Automatic updates** - Pull AGENTS.md changes, symlinks update
3. **Cross-tool consistency** - Same methodology everywhere
4. **Simpler setup** - New projects just need one file + symlinks
5. **Future-proof** - AGENTS.md is emerging as a cross-tool standard

---

## Questions?

- **Setup issues**: See [tool-setup/](tool-setup/) for detailed guides
- **General help**: [GitHub Discussions](https://github.com/brian-lai/pret-a-program/discussions)
- **Bug reports**: [GitHub Issues](https://github.com/brian-lai/pret-a-program/issues)
