# Other AI Tools Reference

**Tier 3 – Reference Only**

> These tools have varying levels of support for custom instructions. Use the patterns below as starting points.

---

## Aider

Aider uses YAML configuration, not markdown instructions.

### Configuration

Create `.aider.conf.yml` in project root:

```yaml
# .aider.conf.yml
model: gpt-4
auto-commits: true
dark-mode: true
```

### Using Pret with Aider

Pret methodology can be followed manually:
1. Create plans in `context/plans/` before starting Aider
2. Reference plans in your prompts
3. Create summaries after completion
4. Use Aider's git integration for commits

### Reference

- [Aider Configuration Docs](https://aider.chat/docs/config.html)

---

## JetBrains AI Assistant

Built into JetBrains IDEs with limited customization.

### Configuration

1. Open Settings → Tools → AI Assistant
2. Add custom instructions in the settings UI
3. Or create `.idea/ai-assistant.md`

### Using Pret with JetBrains AI

Copy key sections from `AGENTS.md` into the AI Assistant settings:
- Core workflow (Plan → Review → Execute → Summarize → Archive)
- When to use Pret vs skip
- Quality checklist

### Limitations

- No file-based configuration outside settings
- Instructions are per-user, not per-project
- Limited context window

---

## Amazon CodeWhisperer

Primarily focused on code completions, limited custom instructions.

### Using Pret with CodeWhisperer

1. Use comments to guide completions:
   ```python
   # Following Pret plan: context/plans/task.md
   # Step 1: Create authentication middleware
   def auth_middleware():
       # CodeWhisperer suggests implementation
   ```

2. Manually maintain Pret workflow:
   - Create plans before coding
   - Use CodeWhisperer for implementation
   - Create summaries after

### Limitations

- No project-level custom instructions
- Best for code completion, not orchestration

---

## Tabnine

AI code completion with limited customization.

### Using Pret with Tabnine

1. Use Tabnine for code completions
2. Manually manage Pret workflow:
   - Plans in `context/plans/`
   - Summaries in `context/summaries/`

3. Guide completions with comments:
   ```typescript
   // Plan: Add user authentication
   // Using JWT tokens with refresh support
   const generateToken = // Tabnine suggests
   ```

### Limitations

- Primarily autocomplete-focused
- No project-level instructions

---

## Google Gemini

Google's AI with some IDE integrations.

### Configuration

Depends on the specific integration:
- **Gemini in VS Code:** May read workspace settings
- **Gemini CLI:** May support configuration files

### Using Pret with Gemini

Copy AGENTS.md content to:
- `~/.gemini/GEMINI.md` for global instructions
- Project root for workspace instructions

Check specific integration documentation for supported formats.

---

## General Patterns for Unsupported Tools

### Pattern 1: Comment-Driven

```python
# Pret plan: context/plans/2025-01-24-task.md
# Objective: Add user authentication
# Step 1: Create JWT middleware

def jwt_middleware():
    # AI tool suggests implementation
```

### Pattern 2: Copy-Paste Context

Start each session by pasting key Pret sections:
1. Paste workflow overview
2. Paste current plan
3. Reference context files explicitly

### Pattern 3: Manual Orchestration

Use the AI for code generation while manually:
1. Creating plans before coding
2. Tracking todos in `context/context.md`
3. Creating summaries after completion
4. Archiving completed work

---

## Adapting AGENTS.md for Any Tool

If your tool supports custom instructions in any form:

1. **Start with the core workflow:**
   ```
   Plan → Review → Execute → Summarize → Archive
   ```

2. **Add when-to-use guidance:**
   - Use for code changes
   - Skip for questions

3. **Include quality checklist:**
   - Tests pass
   - No errors
   - Documentation updated

4. **Adapt to tool's format:**
   - Markdown → Copy as-is
   - YAML → Convert key points
   - Settings UI → Paste relevant sections

---

## Contributing

Have experience with a tool not listed here?

1. Test Pret methodology with the tool
2. Document configuration approach
3. Add to this file or create separate guide
4. Submit PR to Pret-a-Program repository

---

## Next Steps

For best Pret support, consider:
1. **Tier 1 tools** (Claude Code, Cursor, Copilot, Codex) for full integration
2. **Tier 2 tools** (Continue, Windsurf) for good integration
3. **Manual workflow** for unsupported tools

**Need help?** See the main [Pret-a-Program documentation](../README.md).
