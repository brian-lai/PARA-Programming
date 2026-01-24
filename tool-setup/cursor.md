# Cursor Setup

**Tier 1 – Actively Supported**

> Cursor is an AI-native IDE with excellent multi-file editing (Composer) and native support for `AGENTS.md`.

---

## Quick Setup (1 minute)

### 1. AGENTS.md works directly

Cursor natively reads `AGENTS.md` – no symlink needed!

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

Open your project in Cursor, then in Chat:
> "Create a plan for [your task]"

---

## How Cursor Reads Instructions

Cursor supports multiple instruction methods:

| Method | Location | Use Case |
|--------|----------|----------|
| **AGENTS.md** | Project root | Full methodology (recommended) |
| **Project Rules** | `.cursor/rules/*.md` | Modular, topic-specific rules |
| **Legacy** | `.cursorrules` | **Deprecated** – migrate to above |

### Recommended: Use AGENTS.md

The `AGENTS.md` file in project root is the simplest approach:
- Works immediately
- Shared with team via git
- Compatible with other tools (Codex, etc.)

---

## Using Project Rules (Alternative)

For complex projects, use `.cursor/rules/` for modular instructions:

```
.cursor/
└── rules/
    ├── para-workflow.md      # Symlink → ../AGENTS.md
    ├── architecture.mdc      # Project architecture
    └── testing.mdc           # Testing conventions
```

### .mdc Files (Cursor-specific)

Cursor supports `.mdc` files with frontmatter:

```markdown
---
description: API design patterns for this project
globs:
  - src/api/**
  - src/routes/**
alwaysApply: false
---

# API Patterns

[Content only loaded when working on API files]
```

**Frontmatter options:**
- `description` – Shown in Cursor UI
- `globs` – File patterns to apply to
- `alwaysApply` – Load for all files (default: false)

---

## Migrating from .cursorrules

The `.cursorrules` file is **deprecated**. Migrate to `AGENTS.md`:

```bash
# If you have existing .cursorrules
cat .cursorrules >> AGENTS.md  # Append content
rm .cursorrules                 # Remove deprecated file
```

Or if `.cursorrules` has project-specific content:
```bash
# Keep AGENTS.md for methodology
# Move project specifics to .cursor/rules/project.mdc
mv .cursorrules .cursor/rules/project.mdc
```

---

## Cursor Workflow with PARA

### Planning Phase (Use Chat)

1. Describe task in Chat sidebar
2. Cursor creates plan in `context/plans/`
3. Review plan in editor
4. Approve to proceed

### Execution Phase (Use Composer)

1. After approval, open Composer (Cmd+I)
2. Reference the plan: `@context/plans/2025-01-24-task.md`
3. Composer implements across multiple files
4. Review diffs before accepting

### Summary Phase (Use Chat)

1. Return to Chat after implementation
2. Ask Cursor to create summary
3. Verify in `context/summaries/`

---

## Using @-Mentions Efficiently

Be strategic with context:

**Good (minimal context):**
```
@context/plans/task.md @src/api/auth.ts
Implement step 1 from the plan
```

**Bad (too much context):**
```
@src @lib @components
Add authentication somehow
```

### Useful @-mentions

- `@context/plans/...` – Reference active plan
- `@context/data/...` – Reference preprocessed summaries
- `@file.ts` – Specific file
- `@folder/` – Directory contents

---

## MCP Integration

Cursor supports MCP servers. Configure in Cursor settings or create tools in `context/servers/`:

```typescript
// context/servers/analyze.ts
export function analyzeComponents() {
  // Return summary of component architecture
  return { components: 47, complexity: 'medium' };
}
```

Reference in plans:
```markdown
## Data Sources
- MCP: `analyzeComponents` for architecture overview
```

---

## Keyboard Shortcuts

| Action | Shortcut | Use Case |
|--------|----------|----------|
| **Composer** | Cmd+I | Multi-file implementation |
| **Chat** | Cmd+L | Planning, discussion, summaries |
| **Inline Edit** | Cmd+K | Single-file focused edits |

### When to Use Each

- **Chat** – Planning, asking questions, generating summaries
- **Composer** – Implementing plans across multiple files
- **Cmd+K** – Quick single-file edits within a larger plan

---

## Example Project Structure

```
my-project/
├── AGENTS.md              # Full PARA methodology
├── .cursor/
│   └── rules/             # Optional: modular rules
│       └── testing.mdc
├── context/
│   ├── context.md
│   ├── plans/
│   ├── summaries/
│   ├── archives/
│   └── data/
├── src/
└── package.json
```

---

## Troubleshooting

### Cursor not reading AGENTS.md

1. Ensure file is in project root
2. Restart Cursor (File → Reload Window)
3. Check Cursor settings for custom instructions

### Composer making unexpected changes

1. Always create plan first
2. Review all diffs before accepting
3. Use targeted @-mentions to limit scope

### Chat context too large

1. Create summaries in `context/data/` for large files
2. Reference summaries instead of full files
3. Close unused files to reduce automatic context

---

## Tips for Cursor + PARA

1. **Keep plan open** in split pane during implementation
2. **Use Composer** for multi-file changes, not Chat
3. **Review diffs carefully** before accepting Composer changes
4. **Create summaries** for large codebases to reduce context

---

## Next Steps

1. Open project in Cursor
2. Describe your task in Chat
3. Review the plan Cursor creates
4. Use Composer to implement
5. Check `context/summaries/` for documentation

**Need help?** See the main [PARA-Programming documentation](../README.md).
