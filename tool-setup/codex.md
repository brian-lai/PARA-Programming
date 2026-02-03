# OpenAI Codex CLI Setup

**Tier 1 – Actively Supported**

> OpenAI Codex CLI is a command-line tool for AI-assisted coding. It natively reads `AGENTS.md`.

---

## Quick Setup (1 minute)

### 1. AGENTS.md works directly

Codex CLI natively reads `AGENTS.md` – no symlink needed!

```bash
# Just ensure AGENTS.md is in your project root
ls AGENTS.md  # Should exist
```

### 2. Initialize context directory

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
touch context/context.md
```

### 3. Start using PARA workflow

```bash
codex  # Start Codex CLI in your project
# Then: "Create a plan for [your task]"
```

---

## Configuration Hierarchy

Codex CLI reads instructions from:

| Location | Purpose | Scope |
|----------|---------|-------|
| `./AGENTS.md` | Project instructions | This project |
| `~/.codex/AGENTS.md` | Global preferences | All projects |

### Recommended Setup

1. **Project root:** Keep full methodology in `AGENTS.md`
2. **Optional global:** Personal preferences in `~/.codex/AGENTS.md`

---

## Codex CLI Workflow with PARA

### Planning Phase

1. Start Codex CLI: `codex`
2. Describe your task
3. Codex creates plan in `context/plans/`
4. Review and approve

### Execution Phase

1. Codex implements changes
2. Track todos in `context/context.md`
3. Commit after each completed todo
4. Codex shows progress

### Summary Phase

1. Codex creates summary in `context/summaries/`
2. Review the documentation
3. Archive when complete

---

## Preprocessing Tools

Create tools in `context/servers/` for data preprocessing:

```typescript
// context/servers/summarize.ts
export async function summarizeDirectory(path: string) {
  // Read directory, extract key files
  // Return compact summary for Codex
  return {
    files: 25,
    keyFiles: ['src/index.ts', 'src/api.ts'],
    structure: 'monorepo with packages/'
  };
}
```

Reference in plans:
```markdown
## Data Sources
- Preprocessing: `summarize` on src/ directory
- Reference: `context/data/architecture.md`
```

---

## Git Workflow

Codex CLI follows standard PARA git workflow:

```bash
# Starting new plan
git checkout -b para/task-name

# After each todo
git add .
git commit -m "feat: Description of work"

# After all todos complete
# Run summarize, then archive
```

---

## Environment Variables

Configure Codex CLI behavior:

```bash
# In your shell profile or .env
export OPENAI_API_KEY=sk-...
export CODEX_MODEL=gpt-4  # or other model
```

---

## Example Project Structure

```
my-project/
├── AGENTS.md              # Full PARA methodology
├── context/
│   ├── context.md
│   ├── plans/
│   ├── summaries/
│   ├── archives/
│   ├── data/
│   └── servers/           # Preprocessing tools
├── src/
└── package.json
```

---

## Troubleshooting

### Codex not reading AGENTS.md

1. Ensure file is in project root: `ls AGENTS.md`
2. Check file permissions: `chmod 644 AGENTS.md`
3. Verify Codex is running in correct directory

### API errors

1. Check API key: `echo $OPENAI_API_KEY`
2. Verify model access
3. Check rate limits

---

## Tips for Codex + PARA

1. **Be specific in task descriptions** – Codex works better with clear goals
2. **Use preprocessing** – Create summaries for large codebases
3. **Track context** – Keep `context/context.md` updated
4. **Commit frequently** – After each todo for clear history

---

## Next Steps

1. Ensure `AGENTS.md` exists in project root
2. Start Codex CLI
3. Describe your task to create a plan
4. Review and approve the plan
5. Let Codex implement with PARA workflow

**Need help?** See the main [PARA-Programming documentation](../README.md).
