# GitHub Copilot Setup

**Tier 1 – Actively Supported**

> GitHub Copilot works within VS Code, JetBrains IDEs, and other editors. It reads custom instructions from `.github/copilot-instructions.md`.

---

## Quick Setup (2 minutes)

### 1. Create symlink for AGENTS.md

GitHub Copilot looks for `.github/copilot-instructions.md`:

```bash
# In your project root
mkdir -p .github
ln -s ../AGENTS.md .github/copilot-instructions.md
```

### 2. Initialize context directory

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
touch context/context.md
```

### 3. Start using PARA workflow

Open VS Code with Copilot, then in Copilot Chat:
> "Create a plan for [your task]"

---

## Configuration Options

GitHub Copilot reads instructions from:

| Location | Purpose | Priority |
|----------|---------|----------|
| `.github/copilot-instructions.md` | Repository instructions | Medium |
| `.github/instructions/*.instructions.md` | Path-specific rules | High |
| Personal settings | User preferences | Lowest |
| Organization settings | Org-wide rules | Highest |

### Recommended: Symlink to AGENTS.md

```bash
mkdir -p .github
ln -s ../AGENTS.md .github/copilot-instructions.md
```

This way:
- Team shares the same methodology
- Updates to `AGENTS.md` automatically apply
- Compatible with other tools

---

## Path-Specific Instructions

For different rules in different parts of your codebase:

```
.github/
├── copilot-instructions.md    # Main instructions (symlink → AGENTS.md)
└── instructions/
    ├── api.instructions.md    # API-specific rules
    └── tests.instructions.md  # Testing rules
```

Each file uses YAML frontmatter:

```yaml
---
applyTo: "src/api/**"
---
# API Development Rules

When working on API files:
- Follow RESTful conventions
- Include request validation
- Add OpenAPI documentation
```

---

## Copilot Workflow with PARA

### Key Difference: Copilot Suggests, You Type

Unlike Cursor or Claude Code, Copilot primarily:
- Suggests code as you type (inline completions)
- Provides guidance in Chat
- Does not directly write files

### Planning Phase (Copilot Chat)

1. Open Copilot Chat panel
2. Describe your task
3. Ask Copilot to create a plan
4. **You create** the file: `context/plans/2025-01-24-task.md`
5. Review and approve

### Execution Phase (Inline + Chat)

1. Open files specified in plan
2. Start typing – Copilot suggests implementations
3. Accept/modify suggestions
4. Ask Chat for guidance when stuck
5. **Work file-by-file** (Copilot's strength)

### Summary Phase (Copilot Chat)

1. Ask Copilot to summarize changes
2. **You create** the file: `context/summaries/2025-01-24-task-summary.md`

---

## Using Copilot Chat Effectively

### Reference Context Explicitly

```
@workspace Based on the plan in context/plans/task.md, implement the auth middleware
```

### Use @workspace for Codebase Questions

```
@workspace Where is authentication implemented?
@workspace What patterns are used for API routes?
```

### Keep Plan Open

Split your editor:
- Left: `context/plans/task.md`
- Right: Implementation file
- Copilot sees both for better suggestions

---

## Implementation Order Pattern

Copilot works best **file-by-file**. Include this in your plans:

```markdown
## Implementation Order (CRITICAL for Copilot)
1. `src/models/User.ts` - Start here
2. `src/services/AuthService.ts` - Then this
3. `src/routes/auth.ts` - Then this
4. `tests/auth.test.ts` - Finally tests

**Work on ONE file at a time. Test after each file.**
```

Then follow the order:
1. Open File 1
2. Implement with Copilot suggestions
3. Test
4. Open File 2
5. Repeat

---

## Guiding Copilot with Comments

Use comments to get better suggestions:

```typescript
// Following plan step 1: Create JWT validation middleware
// Need: verify token, extract user, handle errors
export const authMiddleware = // Copilot suggests...
```

```typescript
// Step 2 from plan: Add refresh token support
// Based on context/plans/auth.md
const refreshToken = // Copilot suggests...
```

---

## Symlinks on Different Platforms

### macOS / Linux
```bash
mkdir -p .github
ln -s ../AGENTS.md .github/copilot-instructions.md
```

### Windows (requires Developer Mode)
```cmd
mklink .github\copilot-instructions.md ..\AGENTS.md
```

### Alternative: Copy (if symlinks don't work)
```bash
cp AGENTS.md .github/copilot-instructions.md
# Note: Must manually sync changes
```

---

## Example Project Structure

```
my-project/
├── AGENTS.md                          # Full PARA methodology (canonical)
├── .github/
│   ├── copilot-instructions.md        # Symlink → ../AGENTS.md
│   └── instructions/                  # Optional path-specific rules
│       └── api.instructions.md
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

### Copilot not reading instructions

1. Verify file exists: `ls -la .github/copilot-instructions.md`
2. Check symlink: `readlink .github/copilot-instructions.md`
3. Reload VS Code window
4. Check Copilot is enabled (icon in status bar)

### Suggestions not following methodology

1. Reference plan explicitly in Chat: `@context/plans/task.md`
2. Add guiding comments in code
3. Keep plan file open in editor

### Chat not aware of codebase

1. Use `@workspace` prefix for codebase queries
2. Open relevant files in tabs
3. Reference specific files: `@src/auth/middleware.ts`

---

## Tips for Copilot + PARA

1. **You drive the workflow** – Copilot assists, doesn't orchestrate
2. **File-by-file is your friend** – Work through implementation order
3. **Comments guide suggestions** – More context = better completions
4. **Keep plan visible** – Split pane with plan open
5. **Use Chat for planning** – Inline for implementation

---

## Next Steps

1. Create the `.github/` symlink
2. Open project in VS Code
3. Use Copilot Chat to discuss your task
4. Create plan file manually
5. Implement file-by-file with Copilot suggestions

**Need help?** See the main [PARA-Programming documentation](../README.md).
