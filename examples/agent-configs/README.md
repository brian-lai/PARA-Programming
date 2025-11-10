# Agent Configuration Examples

This directory contains ready-to-use configuration files for implementing PARA-Programming methodology across different AI coding assistants and IDEs.

## 📁 Available Configurations

| File | Agent/IDE | Installation |
|------|-----------|--------------|
| `github-copilot-instructions.md` | GitHub Copilot (VSCode, JetBrains, Neovim) | Copy to `.github/copilot-instructions.md` |
| `cursor-rules.md` | Cursor IDE | Copy to `.cursorrules` |
| `jetbrains-ai-instructions.md` | JetBrains AI Assistant | Add to AI Assistant settings or `.idea/ai-instructions.md` |

## 🚀 Quick Start

### 1. Choose Your IDE/Agent

Pick the configuration file that matches your development environment:

- **Using GitHub Copilot?** → Use `github-copilot-instructions.md`
- **Using Cursor?** → Use `cursor-rules.md`
- **Using JetBrains IDE?** → Use `jetbrains-ai-instructions.md`
- **Using something else?** → See the [main agent instructions](../../AGENT-INSTRUCTIONS.md) for universal guidance

### 2. Install Configuration

#### GitHub Copilot (VSCode)

```bash
# In your project root
mkdir -p .github
cp github-copilot-instructions.md .github/copilot-instructions.md
```

#### Cursor

```bash
# In your project root
cp cursor-rules.md .cursorrules
```

#### JetBrains AI Assistant

**Option A: IDE Settings**
1. Open Settings → Tools → AI Assistant
2. Paste content from `jetbrains-ai-instructions.md`

**Option B: Project File**
```bash
# In your project root
mkdir -p .idea
cp jetbrains-ai-instructions.md .idea/ai-instructions.md
```

### 3. Initialize PARA Structure

```bash
# Create context directory
mkdir -p context/{data,plans,summaries,archives,servers}

# Initialize context file
cat > context/context.md << 'EOF'
# Current Work Summary

Ready to start PARA-Programming workflow.

---

```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
```
EOF
```

### 4. Create Project CLAUDE.md

See [templates](../templates/) for project-specific CLAUDE.md examples, or use this minimal version:

```bash
cat > CLAUDE.md << 'EOF'
# Project Name

> **Workflow Methodology:** Follow the agent-specific instructions in this repository

## About
[Brief description of your project]

## Tech Stack
- [Your primary language/framework]
- [Key dependencies]

## Structure
- `src/` - Source code
- `tests/` - Test files
- `context/` - PARA-Programming context files

## Getting Started
```bash
# Your setup commands
npm install
npm run dev
```
EOF
```

### 5. Test Your Setup

Try this with your AI assistant:

```
You: "Create a plan for adding a health check endpoint"

AI: [Should create a plan in context/plans/health-check.md]

You: [Review plan] "Approved"

AI: [Implements plan following the workflow]

AI: [Creates summary in context/summaries/health-check-summary.md]
```

If your AI follows this workflow, you're all set! 🎉

## 📖 What's Included in Each Configuration

All configurations include:

### Core PARA Workflow
1. **Plan Phase** - Creating structured plans before coding
2. **Review Phase** - Human approval gate
3. **Execute Phase** - Implementation with minimal context
4. **Summarize Phase** - Documentation of changes
5. **Archive Phase** - Historical preservation

### IDE-Specific Features

**GitHub Copilot:**
- VSCode integration notes
- Chat and inline completion guidance
- Multi-file context limitations
- Workarounds for missing features

**Cursor:**
- Composer mode (multi-file edits)
- CMD+K mode (single-file edits)
- MCP server integration
- Codebase indexing guidance

**JetBrains:**
- IDE refactoring integration
- Test runner usage
- Code inspection leveraging
- Multi-language project support

### Token Efficiency Guidelines

All configs include strategies for:
- Selective context loading
- Preprocessing large files
- Creating summaries instead of loading full files
- Target token budgets per phase

### Quality Standards

Each config enforces:
- Test execution requirements
- Code quality checks
- Security considerations
- Documentation standards

## 🎯 Usage Examples

### Example 1: Feature Implementation

**User prompt:**
```
"Add user authentication with JWT tokens"
```

**Expected agent behavior:**

1. **Creates plan** in `context/plans/user-auth.md`
2. **Asks for review**: "Please review the plan before I proceed"
3. **Waits for approval**
4. **Implements** step-by-step with progress updates
5. **Creates summary** in `context/summaries/user-auth-summary.md`
6. **Updates** `context/context.md` with completion

### Example 2: Bug Fix

**User prompt:**
```
"Fix the memory leak in the WebSocket connection handler"
```

**Expected agent behavior:**

1. **Creates plan** with analysis of the issue
2. **Identifies** files to modify and testing strategy
3. **Asks for approval**
4. **Fixes** the bug with explanation
5. **Runs tests** to verify fix
6. **Documents** in summary what caused the leak and how it was fixed

### Example 3: Refactoring

**User prompt:**
```
"Refactor the UserService class - it's too complex"
```

**Expected agent behavior:**

1. **Analyzes** current complexity
2. **Creates plan** with specific refactoring steps (extract methods, split classes, etc.)
3. **Uses IDE refactorings** when available (JetBrains, Cursor)
4. **Tests after each step**
5. **Documents** complexity before/after metrics

## 🔧 Customization

### Adjusting Token Budgets

If your agent has different context limits, adjust these values in the config:

```markdown
**Target token budgets:**
- Plan: 500-1000 tokens      # Adjust based on your needs
- Execute: 1000-2000 tokens  # Your agent's context window
- Summary: 300-800 tokens    # Can be shorter/longer
```

### Adding Project-Specific Rules

Add your own sections to the configuration files:

```markdown
## Project-Specific Rules

### Security
- Always use parameterized queries (no string concatenation)
- Validate all user inputs
- Never log sensitive data

### Performance
- All API endpoints must respond in <200ms
- Database queries must use appropriate indexes
- Cache frequently accessed data

### Testing
- Minimum 90% code coverage for new code
- All edge cases must have tests
- Integration tests for all API endpoints
```

### IDE-Specific Enhancements

Each config can be enhanced with tool-specific features:

**For Cursor users:**
```markdown
## Custom MCP Tools

Available in context/servers/:
- `summarizeCode.js` - Condenses large files
- `findPatterns.js` - Locates architectural patterns
- `analyzePerformance.js` - Identifies bottlenecks

Reference these in plans for efficient preprocessing.
```

**For JetBrains users:**
```markdown
## IDE Plugins to Use

- SonarLint: For code quality
- CheckStyle: For style enforcement
- JaCoCo: For coverage reports

Mention plugin results in summaries.
```

## 🐛 Troubleshooting

### Agent doesn't follow the workflow

**Problem:** Agent ignores instructions and implements directly

**Solutions:**
1. Be explicit in prompts: "Following PARA methodology, create a plan first"
2. Check configuration file is in correct location
3. Try: "Read the agent instructions and confirm you'll follow them"

### Plans are too verbose

**Problem:** Plans exceed reasonable length

**Solutions:**
1. Add to config: "Keep plans under 500 words"
2. Use minimal plan template (included in configs)
3. Break large tasks into smaller plans

### Agent doesn't wait for approval

**Problem:** Implements before human review

**Solutions:**
1. Emphasize in prompt: "Create plan and WAIT for my approval"
2. Check the "Review Phase" section is present in config
3. After plan creation, explicitly say "Do not proceed until I approve"

### Context is too large

**Problem:** Agent loads entire codebase

**Solutions:**
1. Be explicit: "Only load these files: [list]"
2. Create summaries first: "Summarize X before we work on it"
3. Use token budget reminders in prompts

## 📚 Additional Resources

### Main Documentation
- [AGENT-INSTRUCTIONS.md](../../AGENT-INSTRUCTIONS.md) - Universal agent guide
- [README.md](../../README.md) - Full PARA-Programming documentation
- [claude/CLAUDE.md](../../claude/CLAUDE.md) - Global methodology template

### Templates
- [Project CLAUDE.md templates](../templates/) - Project-specific context files
- [Plan templates](../templates/plans/) - Example planning documents
- [Summary templates](../templates/summaries/) - Example summary documents

### Community
- [GitHub Discussions](../../discussions) - Ask questions, share experiences
- [GitHub Issues](../../issues) - Report bugs, request features

## 🤝 Contributing

Have you improved these configurations? Please contribute!

### What to Contribute

- **Agent-specific optimizations** - Better token usage, workflow improvements
- **New agent configs** - Continue.dev, Codeium, Amazon CodeWhisperer, Tabnine
- **Real-world examples** - Successful workflows from your projects
- **Troubleshooting tips** - Solutions to common problems

### How to Contribute

1. Fork the repository
2. Create your improved config in `examples/agent-configs/`
3. Test it thoroughly with real projects
4. Submit a PR with:
   - The config file
   - Installation instructions
   - Example usage
   - Any known limitations

## 📝 Version History

### Current Version
- ✅ GitHub Copilot (VSCode, JetBrains)
- ✅ Cursor IDE
- ✅ JetBrains AI Assistant

### Coming Soon
- Continue.dev configuration
- Codeium configuration
- Amazon CodeWhisperer configuration
- Tabnine configuration

Check back for updates or contribute your own!

## ⭐ Quick Reference

| Task | Command |
|------|---------|
| Start new task | "Create a plan for [task description]" |
| Review plan | "I've reviewed the plan, approved" |
| Check status | "What's the current status in context/context.md?" |
| Create summary | "Implementation complete, create summary" |
| Archive session | "Archive the current context" |

---

**Remember:** The methodology is consistent across all agents. Only the implementation details change. Choose your tools, keep your principles! 🚀
