# PARA-Programming Claude Code Skill

**⭐ Recommended: The easiest way to use PARA-Programming**

This skill provides slash commands and automation tools that make the PARA-Programming methodology easy to use within Claude Code sessions. It eliminates manual setup, enforces workflow consistency, and helps you build better software with AI.

**Why this skill?**
- ✅ Maximum automation with slash commands
- ✅ Smart workflow guidance and decision helpers
- ✅ Full MCP support for token efficiency
- ✅ One-command setup: `make setup claude-skill`

**Note:** While we recommend this skill for the best experience, the PARA methodology works with any AI assistant. The workflow is universal—only the automation level differs. See the [main README](../README.md) for other platforms.

---

## 🚀 Quick Start

### Prerequisites

- Claude Code CLI installed
- Git repository for your project
- Global CLAUDE.md file at `~/.claude/CLAUDE.md` (see [Installation](#installation))

### Installation

#### Method 1: Manual Installation (Current)

1. **Install global methodology file:**

```bash
# Clone the repository (if you haven't already)
git clone https://github.com/para-programming/para-programming.git
cd para-programming

# Create symlink (recommended - gets automatic updates)
mkdir -p ~/.claude
ln -s "$(pwd)/CLAUDE.md" ~/.claude/CLAUDE.md

# Verify symlink
ls -la ~/.claude/CLAUDE.md
# Should show: ~/.claude/CLAUDE.md -> /path/to/para-programming/CLAUDE.md
```

**Why symlink?** When you `git pull` to update the repo, your global methodology automatically gets the latest improvements!

2. **Copy slash commands to your Claude Code commands directory:**

```bash
# Create commands directory if it doesn't exist
mkdir -p ~/.claude/commands

# Copy all PARA commands (still copied, not symlinked)
cp claude-skill/commands/*.md ~/.claude/commands/
```

**Note:** Commands are copied (not symlinked) so you can customize them if needed.

3. **Verify installation:**

```bash
# Start Claude Code and check available commands
claude

# In Claude Code:
/help
# You should see para-init, para-plan, para-summarize, etc.
```

#### Method 2: Skill Package (Future)

When the Claude Code plugin API is released:

```bash
claude install @para-programming/skill
```

### Initialize Your First Project

```bash
# Navigate to your project
cd your-project/

# Start Claude Code
claude

# Initialize PARA structure
/para-init

# Start your first task
/para-plan "implement user authentication"
```

---

## 📋 Available Commands

### `/para-init`

Initialize PARA-Programming structure in your project.

```
/para-init                    # Basic setup
/para-init --template=basic   # Minimal CLAUDE.md
/para-init --template=full    # Comprehensive CLAUDE.md
```

**Creates:**
- `context/` directory with subdirectories
- `context/context.md` with JSON structure
- `CLAUDE.md` (if it doesn't exist)

### `/para-plan`

Create a structured plan for your task.

```
/para-plan add-user-auth
/para-plan fix-memory-leak
/para-plan "refactor API layer"
```

**Creates:**
- `context/plans/YYYY-MM-DD-task-name.md`
- Populates with template (Objective, Approach, Risks, etc.)
- Updates `context/context.md`
- Requests human review

### `/para-summarize`

Generate summary after completing work.

```
/para-summarize
```

**Analyzes:**
- Git changes (files modified/added/deleted)
- Active plan from context
- Test results

**Creates:**
- `context/summaries/YYYY-MM-DD-task-name-summary.md`
- Documents what changed, why, and learnings

### `/para-archive`

Archive completed work and reset context.

```
/para-archive                 # Archive current context
/para-archive --fresh         # Create empty context
/para-archive --seed          # Carry forward relevant context
```

**Actions:**
- Moves `context/context.md` to `context/archives/YYYY-MM-DD-HHMM-context.md`
- Creates fresh `context/context.md`
- Preserves audit trail

### `/para-status`

Show current PARA workflow state.

```
/para-status                  # Basic status
/para-status --verbose        # Include file previews
/para-status --files          # List all context files
```

**Displays:**
- Current work summary
- Active plans
- Completed summaries
- Last updated timestamp
- Suggested next action

### `/para-check`

Decision helper for workflow application.

```
/para-check "Add user authentication"
/para-check "Where is the auth middleware?"
/para-check "Explain JWT tokens"
```

**Determines:**
- Should PARA workflow be used?
- What type of request is this?
- What action should be taken?

---

## 🔁 The PARA Workflow

```
(Plan) → (Review) → (Execute) → (Summarize) → (Archive)
              ↑                           ↓
        Human Review                 Context Refresh
```

### When to Use PARA Workflow

**✅ ALWAYS for:**
- Code changes (features, bugs, refactoring)
- Architecture decisions
- Configuration changes
- Database modifications
- Testing implementation
- Security work
- Performance optimizations

**❌ SKIP for:**
- Informational queries ("Where is X?")
- Code explanations ("How does Y work?")
- General questions (unrelated to project)
- Navigation ("Show me Z")

**Rule of thumb:** If it results in git changes, use PARA workflow.

---

## 📁 Directory Structure

After running `/para-init`:

```
your-project/
├── context/
│   ├── context.md              # Active session state
│   ├── data/                   # Input files, datasets
│   ├── plans/                  # Pre-work planning docs
│   ├── summaries/              # Post-work reports
│   ├── archives/               # Historical snapshots
│   └── servers/                # MCP tool wrappers
├── CLAUDE.md                   # Project-specific context
└── [your project files...]
```

---

## 💡 Example Usage

### Complete Workflow Example

```bash
# 1. Start Claude Code in your project
claude

# 2. Initialize PARA (first time only)
/para-init

# 3. Check current status
/para-status

# 4. Decide if task needs PARA workflow
/para-check "Add user authentication to API"
# Output: ✅ USE PARA WORKFLOW

# 5. Create a plan
/para-plan add-user-auth

# [Claude creates context/plans/2025-11-24-add-user-auth.md]
# [Human reviews and approves]

# 6. Claude executes the plan
# [Implementation happens following the plan]

# 7. Generate summary
/para-summarize

# [Claude analyzes git diff and creates summary]

# 8. Check status
/para-status
# Output: Ready to archive

# 9. Archive and prepare for next task
/para-archive
```

### Quick Informational Query (Skip PARA)

```bash
# Check if you need PARA workflow
/para-check "Where is the authentication middleware defined?"
# Output: ❌ SKIP PARA WORKFLOW

# Claude answers directly:
# "The authentication middleware is in src/middleware/auth.ts:45-89"
```

---

## 🎯 Best Practices

### Do's ✅

- **Always plan before executing** - Use `/para-plan` for all project work
- **Keep plans concise** - 1-2 pages max, focus on approach
- **Review before execution** - Human validation prevents mistakes
- **Summarize after completion** - Capture learnings in `/para-summarize`
- **Archive regularly** - Use `/para-archive` when switching tasks
- **Check status frequently** - Use `/para-status` to stay oriented

### Don'ts ❌

- **Don't skip planning** - Complex work needs structured approach
- **Don't skip PARA for code changes** - Methodology ensures quality
- **Don't let context grow stale** - Archive when task is complete
- **Don't use PARA for simple queries** - It's overhead for navigation
- **Don't forget to commit** - Git changes before archiving

---

## 🛠 Customization

### Modify Templates

Templates are in `claude-skill/templates/`:

- `plan-template.md` - Customize plan structure
- `summary-template.md` - Customize summary format
- `context-template.md` - Customize context.md structure
- `claude-basic-template.md` - Minimal project CLAUDE.md
- `claude-full-template.md` - Comprehensive project CLAUDE.md

Edit these to match your team's preferences.

### Add Custom Commands

Create new commands in `~/.claude/commands/`:

```markdown
# Command: my-custom-command

[Description of what it does]

## Usage
/my-custom-command [args]

## Implementation
[Instructions for Claude to execute]
```

---

## 📚 Documentation

- **[PARA-Programming Methodology](../README.md)** - Full methodology guide
- **[Global CLAUDE.md](../CLAUDE.md)** - Workflow reference
- **[Setup Guide](../SETUP-GUIDE.md)** - Detailed setup instructions
- **[Claude Code Guide](../claude/README.md)** - Claude-specific guidance

---

## 🔧 Troubleshooting

### Commands Not Found

**Problem:** `/para-init` not recognized

**Solution:**
```bash
# Verify commands are installed
ls ~/.claude/commands/para-*.md

# If not, copy them:
cp claude-skill/commands/*.md ~/.claude/commands/

# Restart Claude Code
```

### CLAUDE.md Not Loading

**Problem:** Claude doesn't follow PARA workflow

**Solution:**
```bash
# Check global file exists
ls ~/.claude/CLAUDE.md

# If not, create it:
mkdir -p ~/.claude
cp CLAUDE.md ~/.claude/CLAUDE.md
```

### Context Files Not Created

**Problem:** Plans/summaries not being written

**Solution:**
```bash
# Ensure context structure exists
mkdir -p context/{data,plans,summaries,archives,servers}

# Run /para-init again if needed
```

---

## 🤝 Contributing

We welcome contributions to improve the PARA-Programming skill!

### Areas for Contribution

- **Additional commands** - New workflow helpers
- **MCP tools** - Automation utilities
- **Templates** - For different tech stacks
- **Documentation** - Improvements and examples
- **Bug fixes** - Report and fix issues

### How to Contribute

1. Fork the repository
2. Create a feature branch
3. Follow PARA methodology (create a plan!)
4. Submit a pull request

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

- **Tiago Forte** - For the PARA method that inspired this
- **Anthropic** - For Claude and Claude Code
- **The community** - For feedback and contributions

---

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/para-programming/claude-skill/issues)
- **Discussions:** [GitHub Discussions](https://github.com/para-programming/claude-skill/discussions)
- **Documentation:** [PARA-Programming Guide](../README.md)

---

**Happy PARA-Programming with Claude Code! 🚀**

Build better software, faster, with structured AI collaboration.
