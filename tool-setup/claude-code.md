# Claude Code Setup

**Tier 1 – Actively Supported**

> Claude Code is Anthropic's official CLI tool for Claude. It has excellent support for project-level instructions and MCP integration.

---

## Quick Setup (2 minutes)

### 1. Create symlink for AGENTS.md

Claude Code looks for `CLAUDE.md` files:

```bash
# In your project root
ln -s AGENTS.md CLAUDE.md
```

### 2. Initialize context directory

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
touch context/context.md
```

### 3. Start using Pret workflow

```bash
claude  # Start Claude Code in your project
# Then: "Create a plan for [your task]"
```

---

## Configuration Hierarchy

Claude Code reads instructions from multiple locations (highest to lowest precedence):

| Location | Purpose | Scope |
|----------|---------|-------|
| `./CLAUDE.md` or `./.claude/CLAUDE.md` | Project instructions | This project only |
| `./.claude/rules/*.md` | Modular topic rules | This project only |
| `~/.claude/CLAUDE.md` | Global personal preferences | All your projects |
| `./CLAUDE.local.md` | Personal project prefs (gitignored) | This project, your machine |

### Recommended Setup

1. **Project root:** Symlink `CLAUDE.md` → `AGENTS.md` (shared with team)
2. **Global:** Copy full Pret methodology to `~/.claude/CLAUDE.md`
3. **Local overrides:** Use `CLAUDE.local.md` for personal preferences

---

## Global vs Project Configuration

### Option A: Everything in AGENTS.md (Recommended for teams)

Keep full methodology in `AGENTS.md` at project root. Every team member gets the same instructions.

```bash
ln -s AGENTS.md CLAUDE.md
```

### Option B: Global methodology + Project context (Recommended for individuals)

1. Copy full methodology to `~/.claude/CLAUDE.md`
2. Keep project-specific context in `AGENTS.md`:

```markdown
# Project AGENTS.md

> **Workflow:** Follow ~/.claude/CLAUDE.md for Pret methodology

## About This Project
[Project-specific context here...]
```

---

## MCP Integration

Claude Code has native MCP (Model Context Protocol) support. Create tools in `context/servers/`:

```typescript
// context/servers/summarize-code.ts
export async function summarizeDirectory(path: string) {
  // Preprocess: read directory, extract key information
  // Return compact summary for Claude
  return { files: 10, keyFiles: ['src/index.ts', 'src/api.ts'] };
}
```

Reference in plans:
```markdown
## Data Sources
- MCP: `summarize-code` to analyze src/ directory
```

---

## Claude Code Skills

For automated Pret commands, install the skill package:

```bash
# From Pret-a-Program repository
cp -r skills/claude-code ~/.claude/skills/pret-a-program
```

This enables slash commands:
- `/pret:init` – Initialize Pret structure
- `/pret:plan` – Create a plan
- `/pret:execute` – Start execution
- `/pret:summarize` – Create summary
- `/pret:archive` – Archive completed work
- `/pret:status` – Check workflow status

---

## File Discovery

Claude Code automatically discovers:
- `CLAUDE.md` in project root
- `.claude/CLAUDE.md` in project root
- All `.md` files in `.claude/rules/`
- Parent directory `CLAUDE.md` files (up to git root)

### Using .claude/rules/ for Modular Instructions

For complex projects, split instructions:

```
.claude/
├── rules/
│   ├── 01-workflow.md      # Pret methodology (symlink to AGENTS.md)
│   ├── 02-architecture.md  # Project architecture
│   ├── 03-testing.md       # Testing conventions
│   └── 04-api-patterns.md  # API design patterns
```

Each file can have frontmatter for conditional loading:
```yaml
---
paths:
  - src/api/**
  - src/routes/**
---
# API Patterns
[Content only loaded when working on API files]
```

---

## Symlinks on Different Platforms

### macOS / Linux
```bash
ln -s AGENTS.md CLAUDE.md
```

### Windows (requires Developer Mode or Admin)
```cmd
mklink CLAUDE.md AGENTS.md
```

Or use Git to handle symlinks:
```bash
git config core.symlinks true
```

---

## Troubleshooting

### Claude Code not reading CLAUDE.md

1. Verify file exists: `ls -la CLAUDE.md`
2. Check symlink: `readlink CLAUDE.md` should show `AGENTS.md`
3. Ensure Claude Code is running in project root

### MCP tools not loading

1. Check `context/servers/` exists
2. Verify tool files are valid TypeScript/JavaScript
3. Check Claude Code MCP configuration

### Multiple CLAUDE.md files conflicting

Claude Code merges all discovered files. If you have conflicts:
1. Use `.claude/rules/` with numbered prefixes for priority
2. Or consolidate into single `CLAUDE.md`

---

## Example Project Structure

```
my-project/
├── AGENTS.md              # Full Pret methodology (canonical)
├── CLAUDE.md              # Symlink → AGENTS.md
├── context/
│   ├── context.md
│   ├── plans/
│   ├── summaries/
│   ├── archives/
│   ├── data/
│   └── servers/           # MCP tools
├── src/
└── package.json
```

---

## Next Steps

1. Create your first plan: Start Claude Code, describe your task
2. Review the plan when presented
3. Watch Claude execute with Pret workflow
4. Check `context/summaries/` for documentation

**Need help?** See the main [Pret-a-Program documentation](../README.md).
