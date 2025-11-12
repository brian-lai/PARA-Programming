# PARA-Programming Setup Guide

**Quick reference for setting up PARA-Programming with your preferred AI coding assistant**

---

## 🎯 Choose Your Guide

There are guides for the three most popular AI assistants. Each guide includes complete setup instructions, templates, and examples:

| AI Assistant | Where to Go |
|--------------|-------------|
| 🤖 **Claude Code** (CLI) | **[→ Claude Guide & Quickstart](claude/)** |
| ✨ **GitHub Copilot** (VSCode, JetBrains, Neovim) | **[→ Copilot Guide & Quickstart](copilot/)** |
| 🔮 **Cursor** (Standalone IDE) | **[→ Cursor Guide & Quickstart](cursor/)** |

---

## Other AI Assistants (Unofficial)

Using a different tool? Here are quick setup instructions for other popular AI assistants:

| If you use... | Then go to... |
|---------------|---------------|
| 🧠 **JetBrains AI Assistant** | [JetBrains Setup](#jetbrains-setup) |
| 🔄 **Continue.dev** | [Continue.dev Setup](#continuedev-setup) |
| ❓ **Other or unsure** | [Universal Setup](#universal-setup) |

---

## JetBrains Setup

### Prerequisites
- Any JetBrains IDE (IntelliJ, PyCharm, WebStorm, etc.)
- AI Assistant plugin installed

### Installation

```bash
# Navigate to your project
cd your-project/

# Create context directory structure
mkdir -p context/{data,plans,summaries,archives,servers}

# Copy AI instructions
mkdir -p .idea
curl -o .idea/ai-instructions.md \
  https://raw.githubusercontent.com/[your-repo]/PARA-Programming/main/examples/agent-configs/jetbrains-ai-instructions.md

# Initialize context.md
cat > context/context.md << 'EOF'
# Current Work Summary

Ready to start using PARA-Programming with JetBrains AI Assistant.

---

```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
```.
EOF
```

# Create project CLAUDE.md
cat > CLAUDE.md << 'EOF'
# Project Name

> **Workflow Methodology:** Follow `.idea/ai-instructions.md`

## About
[Brief description]

## Tech Stack
- [Your stack]

## Getting Started
```bash
# Your setup commands
```
EOF
```

### Configure in IDE

**Option A: Use Project File** (recommended)
- The `.idea/ai-instructions.md` file is automatically used

**Option B: IDE Settings**
1. Open Settings → Tools → AI Assistant
2. Paste content from `.idea/ai-instructions.md`
3. Save settings

### Test It

In JetBrains AI Assistant chat:

```
You: "Create a plan for refactoring the UserService class"
AI: "I'll analyze UserService and create a refactoring plan..."
```

### Next Steps
- [Full JetBrains Instructions](examples/agent-configs/jetbrains-ai-instructions.md)
- [IDE Refactoring Integration](examples/agent-configs/jetbrains-ai-instructions.md#ide-integration)

---

## Continue.dev Setup

### Prerequisites
- Continue.dev extension installed (VSCode or JetBrains)

### Installation

```bash
# Navigate to your project
cd your-project/

# Create context directory structure
mkdir -p context/{data,plans,summaries,archives,servers}

# Create Continue config
cat > .continuerc.json << 'EOF'
{
  "customInstructions": "Follow PARA-Programming methodology. See AGENT-INSTRUCTIONS.md for full details.",
  "contextProviders": [
    {
      "name": "code",
      "params": {
        "includeFiles": [
          "context/context.md",
          "context/plans/*.md",
          "CLAUDE.md"
        ]
      }
    }
  ]
}
EOF

# Initialize context.md
cat > context/context.md << 'EOF'
# Current Work Summary

Ready to start using PARA-Programming with Continue.dev.

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

### Test It

```
You: "/para-plan Add rate limiting to the API"
Continue: "Creating plan for rate limiting..."
```

### Next Steps
- [Universal Agent Instructions](AGENT-INSTRUCTIONS.md)
- [MCP Server Setup](AGENT-INSTRUCTIONS.md#mcp-integration)

---

## Universal Setup

For any AI assistant not listed above:

### 1. Create Context Structure

```bash
cd your-project/
mkdir -p context/{data,plans,summaries,archives,servers}

cat > context/context.md << 'EOF'
# Current Work Summary

Initializing PARA-Programming.

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

### 2. Read Universal Instructions

📖 **[AGENT-INSTRUCTIONS.md](AGENT-INSTRUCTIONS.md)** contains:
- Complete PARA methodology explanation
- Agent-agnostic workflow
- Adaptation guide for any tool
- Platform-specific tips

### 3. Train Your Agent

Copy relevant sections from `AGENT-INSTRUCTIONS.md` to:
- Your IDE's custom instructions
- Project-specific prompt files
- Team documentation

### 4. Start Small

Begin with the basic workflow:
1. Create plan manually
2. Ask agent to implement
3. Create summary manually
4. Archive when done

Gradually automate as you and your agent get comfortable.

---

## Example Workflows

### Workflow 1: Adding a New Feature

```
1. You: "Create a plan for adding user profile pictures"

2. Agent: [Creates context/plans/profile-pictures.md]
   "I've created a plan. Please review before I proceed."

3. You: [Reviews plan] "Looks good, approved"

4. Agent: [Implements step-by-step]
   "Step 1 complete: Added upload endpoint..."
   "Step 2 complete: Created image storage service..."
   "All steps done! Running tests... ✅ All pass"

5. Agent: [Creates context/summaries/profile-pictures-summary.md]
   "Summary created. Profile picture upload now working!"
```

### Workflow 2: Fixing a Bug

```
1. You: "Fix the memory leak in WebSocket handler"

2. Agent: [Analyzes issue]
   "Creating plan to fix memory leak in context/plans/fix-ws-leak.md
   Root cause: Event listeners not being removed"

3. You: "Approved"

4. Agent: [Implements fix with tests]
   "Fixed by adding cleanup in useEffect.
   Memory usage stable after 12-hour test."

5. Agent: [Creates summary]
   "Summary at context/summaries/fix-ws-leak-summary.md"
```

### Workflow 3: Refactoring

```
1. You: "Refactor AuthService - it's too complex"

2. Agent: [Analyzes code]
   "Creating refactoring plan...
   Current complexity: 12 (threshold: 10)
   Suggesting: Extract 3 methods, split into 2 classes"

3. You: [Reviews metrics] "Good, proceed"

4. Agent: [Refactors with tests between steps]
   "Step 1: Extracted validateCredentials() ✅ Tests pass
   Step 2: Extracted generateTokens() ✅ Tests pass
   Step 3: Created AuthValidator class ✅ Tests pass"

5. Agent: [Creates summary with before/after metrics]
   "Complexity reduced from 12 → 4
   All 47 tests still passing"
```

---

## Troubleshooting

### Agent doesn't follow the workflow

**Problem:** Agent implements without creating a plan

**Solution:** Be explicit in your prompt:
```
"Following PARA-Programming methodology, create a plan FIRST before implementing"
```

### Can't find configuration file

**Problem:** Agent says it doesn't see instructions

**Solutions:**
1. Check file is in correct location (see setup for your agent)
2. Verify filename is correct (`.cursorrules`, `.github/copilot-instructions.md`, etc.)
3. Restart IDE/editor
4. Manually paste instructions into agent settings

### Plans are too long

**Problem:** Plans exceed reasonable length

**Solution:** Add to your instructions:
```
"Keep plans concise: under 500 words, focus on approach and risks"
```

### Context directory not being used

**Problem:** Agent doesn't create files in context/

**Solution:** Explicitly mention in prompts:
```
"Create the plan in context/plans/[task-name].md"
```

---

## Next Steps

### Complete Guides
- 🤖 **[Claude Code Guide](claude/)** - Full setup for Claude CLI
- ✨ **[GitHub Copilot Guide](copilot/)** - Complete Copilot integration
- 🔮 **[Cursor Guide](cursor/)** - Full Cursor IDE setup

### Learn More
- 📖 [Full PARA-Programming Documentation](README.md)
- 🤖 [Universal Agent Instructions](AGENT-INSTRUCTIONS.md) (for other tools)

### Get Help
- 💬 [GitHub Discussions](../../discussions)
- 🐛 [Report Issues](../../issues)
- 🤝 [Contribute](README.md#contributing)

---

## Quick Reference Card

```
📋 PARA Workflow
├── 1. Plan → Create context/plans/[task].md
├── 2. Review → Human approves
├── 3. Execute → Agent implements
├── 4. Summarize → Create context/summaries/[task].md
└── 5. Archive → Move context.md to archives/

🗂 Directory Structure
project-root/
├── context/
│   ├── context.md        # Current work
│   ├── plans/            # Future work
│   ├── summaries/        # Past work
│   ├── archives/         # History
│   └── servers/          # MCP tools
└── CLAUDE.md             # Project context

⚙️ Configuration Files
├── ~/.claude/CLAUDE.md                 # Claude Code (see claude/ guide)
├── .github/copilot-instructions.md     # GitHub Copilot (see copilot/ guide)
├── .cursorrules                        # Cursor (see cursor/ guide)
├── .idea/ai-instructions.md            # JetBrains
└── .continuerc.json                    # Continue.dev

🎯 Core Principle
Plan → Review → Execute → Summarize → Archive
The workflow is consistent. Only tools change.
```

---

**Ready to start?** Choose your agent above and follow the setup guide!

**Questions?** See the [troubleshooting section](#troubleshooting) or [ask in discussions](../../discussions).

**Happy PARA-Programming! 🚀**
