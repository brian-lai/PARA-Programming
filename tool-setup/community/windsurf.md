# Windsurf (Codeium) Setup

**Tier 2 – Community Supported**

> Windsurf is Codeium's AI-powered IDE. It reads rules from `.windsurf/rules/` and has native symlink support.

---

## Quick Setup (2 minutes)

### 1. Create symlink for AGENTS.md

Windsurf reads from `.windsurf/rules/`:

```bash
mkdir -p .windsurf/rules
ln -s ../../AGENTS.md .windsurf/rules/para-programming.md
```

### 2. Initialize context directory

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
touch context/context.md
```

### 3. Start using PARA workflow

Open your project in Windsurf, then in chat:
> "Create a plan for [your task]"

---

## Configuration

Windsurf reads instructions from multiple locations:

| Location | Purpose | Scope |
|----------|---------|-------|
| `.windsurf/rules/*.md` | Project rules | This workspace |
| `global_rules.md` | Global rules | All workspaces |
| Enterprise paths | Managed rules | Organization |

### File Size Limit

Each rule file has a **12,000 character limit**. For larger content, split into multiple files or use the most important sections.

### Auto-Discovery

Windsurf automatically discovers rules from:
- Current workspace
- Subdirectories
- Parent directories up to git root

---

## Enterprise Locations

For managed deployments:

| Platform | Path |
|----------|------|
| macOS | `/Library/Application Support/Windsurf/rules/*.md` |
| Linux/WSL | `/etc/windsurf/rules/*.md` |
| Windows | `C:\ProgramData\Windsurf\rules\*.md` |

---

## Example Project Structure

```
my-project/
├── AGENTS.md                     # Full PARA methodology
├── .windsurf/
│   └── rules/
│       └── para-programming.md   # Symlink → ../../AGENTS.md
├── context/
│   ├── context.md
│   ├── plans/
│   ├── summaries/
│   └── data/
└── src/
```

---

## Troubleshooting

### Windsurf not reading rules

1. Verify symlink: `readlink .windsurf/rules/para-programming.md`
2. Check file size under 12,000 characters
3. Restart Windsurf

### Rules not applying

1. Ensure `.windsurf/rules/` is in workspace root
2. Check file extension is `.md`
3. Verify file permissions

---

## Tips for Windsurf + PARA

1. **Use Cascade** – Windsurf's Cascade feature for multi-file editing
2. **Keep rules concise** – 12k char limit means prioritizing key content
3. **Split if needed** – Use multiple rule files for comprehensive coverage

---

## Next Steps

1. Create the `.windsurf/rules/` symlink
2. Open project in Windsurf
3. Use chat to create a plan
4. Follow PARA workflow

**Need help?** See the main [PARA-Programming documentation](../README.md).
