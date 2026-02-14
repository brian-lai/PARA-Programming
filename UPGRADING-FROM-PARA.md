# Upgrading from PARA-Programming to Pret-a-Program

This guide helps existing PARA-Programming users migrate to the rebranded Pret-a-Program (v2.0).

---

## What Changed

| Before (v1) | After (v2) |
|-------------|------------|
| **PARA-Programming** | **Pret-a-Program** |
| No CLI tool | `pret` CLI (`brew install pret-a-program`) |
| `para/` branch prefix | `pret/` branch prefix |
| `/para-*` slash commands | `/pret-*` slash commands |
| `claude-skill/` directory | `skills/claude-code/` |
| `make setup claude-skill` | `pret install-skills --claude` |
| Manual `mkdir -p context/...` | `pret init` |

## What Stayed the Same

- `context/` directory structure (unchanged)
- File formats for plans, summaries, archives (unchanged)
- Workflow steps: Plan, Review, Execute, Summarize, Archive (unchanged)
- `AGENTS.md` file format (unchanged)
- `context/context.md` JSON structure (unchanged)

---

## Quick Migration

```bash
# 1. Install the pret CLI
brew install brian-lai/pret/pret-a-program

# 2. Re-initialize your project (preserves existing context/)
cd your-project
pret init

# 3. Install updated AI tool skills
pret install-skills --claude   # Replaces old claude-skill installation
pret install-skills --cursor   # New: Cursor rules
pret install-skills --codex    # New: Codex AGENTS.md

# 4. Rename active branches (optional)
git branch -m para/my-feature pret/my-feature

# 5. Remove old skill installation
rm -rf ~/.claude/skills/para-programming/
```

---

## Step-by-Step Migration

### 1. Install the New CLI

```bash
# Via Homebrew (recommended)
brew tap brian-lai/pret
brew install pret-a-program

# Verify installation
pret --version  # Should show 2.0.0
```

Or run directly from the repository:

```bash
git clone https://github.com/brian-lai/pret-a-program.git
export PATH="$PWD/pret-a-program/cli/bin:$PATH"
```

### 2. Update Your Project

Run `pret init` in your project directory. This is safe to run in existing projects:

```bash
cd your-project
pret init
```

It will:
- Create any missing `context/` subdirectories
- Create `AGENTS.md` if it doesn't exist (won't overwrite existing)
- Create `context/context.md` if it doesn't exist (won't overwrite existing)

### 3. Update AI Tool Skills

The old `claude-skill/` directory has been replaced by `skills/claude-code/`.

```bash
# Remove old installation
rm -rf ~/.claude/skills/para-programming/

# Install new skills
pret install-skills --claude
```

For Cursor and Codex (new in v2):

```bash
pret install-skills --cursor   # Installs .cursor/rules/pret-a-program.md
pret install-skills --codex    # Copies AGENTS.md to project root
```

### 4. Update Branch Names (Optional)

If you have active branches with the `para/` prefix:

```bash
# Rename a single branch
git branch -m para/my-feature pret/my-feature

# Rename all para/ branches (bash)
for branch in $(git branch --list 'para/*'); do
  git branch -m "$branch" "pret/${branch#para/}"
done
```

### 5. Update Global CLAUDE.md (Optional)

If you have `~/.claude/CLAUDE.md` with the old PARA-Programming methodology:

```bash
# The pret install-skills --claude command offers to update this
pret install-skills --claude
```

### 6. Clean Up

```bash
# Remove old Makefile-based setup artifacts (if any)
# The Makefile still works but pret CLI is now preferred

# Remove old global claude-skill references
rm -rf ~/.claude/skills/para-programming/
rm -rf ~/.claude/commands/para-*.md
```

---

## FAQ

### Will my existing context/ files still work?

Yes. The `context/` directory structure, file naming conventions (`YYYY-MM-DD-task-name.md`), and `context.md` JSON format are all unchanged.

### Do I need to update existing plans and summaries?

No. Existing plans and summaries in `context/plans/` and `context/summaries/` work as-is. Only the workflow commands and branch naming have changed.

### What if I have both old and new versions?

The `pret` CLI is completely separate from the old `make setup` system. They don't conflict. You can migrate gradually.

### Can I still use `make setup`?

Yes, the Makefile still works but is considered legacy. The `pret` CLI is the recommended approach going forward.

---

## Rollback

If you need to revert to the old setup:

```bash
# Remove pret CLI
brew uninstall pret-a-program

# Restore old skill
cp -r path/to/para-programming/claude-skill/ ~/.claude/skills/para-programming/

# Rename branches back
git branch -m pret/my-feature para/my-feature
```

---

## Need Help?

- [GitHub Issues](https://github.com/brian-lai/pret-a-program/issues)
- [GitHub Discussions](https://github.com/brian-lai/pret-a-program/discussions)
