# Continue.dev Setup

**Tier 2 – Community Supported**

> Continue.dev is an open-source AI code assistant that works with VS Code and JetBrains. It has excellent MCP support and reads rules from `.continue/rules/`.

---

## Quick Setup (2 minutes)

### 1. Create symlink for AGENTS.md

Continue.dev reads from `.continue/rules/`:

```bash
mkdir -p .continue/rules
ln -s ../../AGENTS.md .continue/rules/pret-a-program.md
```

### 2. Initialize context directory

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
touch context/context.md
```

### 3. Start using Pret workflow

Open VS Code with Continue, then in the chat panel:
> "Create a plan for [your task]"

---

## Configuration

Continue.dev reads instructions from:

| Location | Purpose | Scope |
|----------|---------|-------|
| `.continue/rules/*.md` | Project rules | This project |
| `~/.continue/rules/*.md` | Global rules | All projects |
| `~/.continue/config.json` | Configuration | All projects |

### Rule Files

Rules can use YAML frontmatter:

```yaml
---
name: Pret Workflow
globs: "**/*"
alwaysApply: true
description: Pret-a-Program methodology
---
[Content from AGENTS.md]
```

### Numbering for Priority

Prefix files with numbers to control order:

```
.continue/rules/
├── 01-pret-a-program.md    # Symlink → ../../AGENTS.md
├── 02-architecture.md        # Project architecture
└── 03-testing.md             # Testing conventions
```

---

## MCP Integration

Continue.dev has native MCP support. Configure in `.continuerc.json`:

```json
{
  "mcpServers": {
    "para-tools": {
      "command": "node",
      "args": ["context/servers/index.js"]
    }
  }
}
```

Or in `~/.continue/config.json` for global tools.

---

## Example Project Structure

```
my-project/
├── AGENTS.md                    # Full Pret methodology
├── .continue/
│   └── rules/
│       └── pret-a-program.md  # Symlink → ../../AGENTS.md
├── context/
│   ├── context.md
│   ├── plans/
│   ├── summaries/
│   └── servers/
└── src/
```

---

## Troubleshooting

### Continue not reading rules

1. Verify symlink: `readlink .continue/rules/pret-a-program.md`
2. Restart VS Code
3. Check Continue extension is enabled

### MCP tools not loading

1. Check `.continuerc.json` syntax
2. Verify tool scripts exist and are executable
3. Check Continue logs for errors

---

## Next Steps

1. Create the `.continue/rules/` symlink
2. Open VS Code with Continue extension
3. Use chat to create a plan
4. Follow Pret workflow

**Need help?** See the main [Pret-a-Program documentation](../README.md).
