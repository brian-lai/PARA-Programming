# Automated Setup Guide (Deprecated)

> **This guide is superseded by the `pret` CLI.** Install via `brew install brian-lai/pret-a-program/pret-a-program` or see [README.md](README.md) for setup instructions.
>
> The Makefile-based setup described below still works but is no longer the recommended approach.

**Legacy one-command installation for Pret-a-Program**

This guide shows you how to use the legacy automated setup system to install Pret-a-Program for your AI coding assistant.

---

## 🚀 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/pret-a-program/pret-a-program.git
cd pret-a-program

# 2. Run automated setup
make setup claude-skill  # For Claude Code (recommended)
make setup cursor        # For Cursor IDE
make setup copilot       # For GitHub Copilot

# 3. Done! Start coding with Pret methodology
```

---

## 📋 Available Commands

### Setup Commands

```bash
# Setup for specific assistant
make setup claude-skill  # Claude Code with skill commands
make setup claude        # Claude Code without skill (legacy)
make setup cursor        # Cursor IDE
make setup copilot       # GitHub Copilot

# Setup for all assistants at once
make setup-all
```

### Test & Verify

```bash
# Test your installation
make test

# Show help
make help
```

### Uninstall

```bash
# Uninstall specific assistant
make uninstall claude-skill
make uninstall cursor
make uninstall copilot

# Uninstall everything
make uninstall all
```

---

## 🎯 What Gets Installed

### Claude Code (with Skill)

```bash
make setup claude-skill
```

**Installs:**
- ✅ Global CLAUDE.md symlinked to `~/.claude/CLAUDE.md`
- ✅ 6 slash commands in `~/.claude/commands/`:
  - `/pret-init` - Initialize Pret structure
  - `/pret-plan` - Create a plan
  - `/pret-summarize` - Generate summary
  - `/pret-archive` - Archive context
  - `/pret-status` - Show status
  - `/pret-check` - Decision helper
- ✅ All templates

**Next Steps:**
1. Open your project: `cd your-project`
2. Start Claude Code: `claude`
3. Initialize Pret: `/pret-init`

### Cursor IDE

```bash
make setup cursor
```

**Installs:**
- ✅ `.cursorrules` symlinked to `~/.cursorrules`

**Next Steps:**
1. Open your project in Cursor
2. Open Composer (Cmd/Ctrl+I)
3. Ask: "Initialize Pret structure"

### GitHub Copilot

```bash
make setup copilot
```

**Installs:**
- ✅ `copilot-instructions.md` symlinked to `~/.github/copilot-instructions.md`

**Next Steps:**
1. Open your project in VS Code
2. Open Copilot Chat (Cmd/Ctrl+I)
3. Ask: "Initialize Pret structure"

---

## 🔗 Benefits of Automated Setup

### vs. Manual Setup

| Aspect | Automated | Manual |
|--------|-----------|--------|
| **Speed** | <10 seconds | 5-10 minutes |
| **Accuracy** | Always correct | Prone to typos |
| **Updates** | Automatic (symlinks) | Manual re-copy |
| **Verification** | Built-in testing | Manual checking |
| **Cross-platform** | Handles OS differences | Need OS-specific commands |

### Symlinks for Auto-Updates

The automated setup creates **symlinks** instead of copying files:

```bash
# Symlink example
~/.claude/CLAUDE.md -> /path/to/pret-a-program/CLAUDE.md
```

**Benefits:**
- ✅ `git pull` automatically updates your methodology
- ✅ Single source of truth
- ✅ No manual syncing needed
- ✅ Always have latest improvements

---

## 🧪 Testing Your Installation

After setup, verify everything works:

```bash
# Run automated tests
make test
```

**What it checks:**
- Global CLAUDE.md symlink exists and is readable
- Slash commands installed (if using Claude skill)
- Cursor rules symlink exists and is readable
- Copilot instructions symlink exists and is readable

**Example output:**
```
🧪 Testing Pret-a-Program Installation

▶ Testing Claude Code Setup
✅ Global CLAUDE.md symlink
✅ Global CLAUDE.md readable
✅ All 6 Pret commands found

▶ Testing Cursor Setup
✅ Cursor rules symlink
✅ Cursor rules readable

▶ Testing Copilot Setup
✅ Copilot instructions symlink
✅ Copilot instructions readable

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Test Results
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Passed: 8
Failed: 0

✅ All tests passed! ✨
```

---

## 🔄 Updating

One of the key benefits of automated setup is automatic updates:

```bash
# Navigate to repository
cd /path/to/pret-a-program

# Pull latest changes
git pull origin main

# Your symlinked files are automatically updated! ✨
```

**No need to re-run setup!**

### Update Commands Only

If new slash commands were added:

```bash
cp skills/claude-code/commands/*.md ~/.claude/commands/

# Or re-run setup
make setup claude-skill
```

---

## 🗑️ Uninstalling

Remove Pret-a-Program setup cleanly:

```bash
# Uninstall specific assistant
make uninstall claude-skill
make uninstall cursor
make uninstall copilot

# Uninstall everything (with confirmation)
make uninstall all
```

**What gets removed:**
- Symlinks to global files
- Slash commands (Claude Code)
- Configuration files

**What stays:**
- The cloned repository
- Your project `context/` directories
- Project-specific `CLAUDE.md` files

---

## 🔧 Troubleshooting

### Makefile Not Found

**Problem:** `make: No such file or directory`

**Solution:** Ensure you're in the repository directory:
```bash
cd /path/to/pret-a-program
make setup claude-skill
```

### Make Command Not Found

**Problem:** `make: command not found`

**Solution:** Install make:
- **macOS:** `xcode-select --install`
- **Linux:** `sudo apt install build-essential`
- **Windows:** Use Git Bash or WSL

### Permission Denied

**Problem:** Permission error when running scripts

**Solution:** Scripts should be executable automatically, but if not:
```bash
chmod +x scripts/*.sh
make setup claude-skill
```

### Symlink Broken

**Problem:** Symlink shows as broken

**Solution:**
```bash
# Check where symlink points
ls -la ~/.claude/CLAUDE.md

# Remove and recreate
rm ~/.claude/CLAUDE.md
cd /path/to/pret-a-program
make setup claude-skill
```

### Setup Failed

**Problem:** Setup script exits with error

**Solution:**
1. Check error message in output
2. Verify git is installed: `git --version`
3. Ensure you're in cloned repository
4. Try manual setup instead (see individual guides)
5. Report issue with error details

---

## 🎓 Advanced Usage

### Custom Installation Path

If you want to install to a different location:

```bash
# Edit script variables before running
export CLAUDE_DIR="$HOME/custom-path"
make setup claude-skill
```

### Selective Installation

Install only what you need:

```bash
# Just global methodology (no commands)
make setup claude

# Multiple assistants
make setup cursor
make setup copilot
```

### Script-Only Usage

Use scripts directly without make:

```bash
# Run scripts individually
bash scripts/setup-claude-skill.sh
bash scripts/setup-cursor.sh
bash scripts/setup-copilot.sh

# Test installation
bash scripts/test-setup.sh
```

---

## 📚 What's Next

After automated setup:

1. **Read the quickstart for your assistant:**
   - [Claude Code Quickstart](claude/QUICKSTART.md)
   - [Cursor Quickstart](cursor/QUICKSTART.md)
   - [Copilot Quickstart](copilot/QUICKSTART.md)

2. **Initialize your first project:**
   - Claude: `/pret-init`
   - Others: Ask to initialize Pret structure

3. **Start building:**
   - Create your first plan
   - Follow Pret workflow
   - Experience structured AI collaboration

---

## 🤝 Contributing

Found a bug or have an improvement for the setup system?

1. **Report issues:** [GitHub Issues](https://github.com/pret-a-program/pret-a-program/issues)
2. **Suggest improvements:** [GitHub Discussions](https://github.com/pret-a-program/pret-a-program/discussions)
3. **Submit PRs:** Contributions welcome!

---

## ⚡ Quick Reference

```bash
# Clone & setup
git clone https://github.com/pret-a-program/pret-a-program.git
cd pret-a-program
make setup claude-skill

# Test
make test

# Update (automatic via symlinks)
git pull origin main

# Uninstall
make uninstall claude-skill

# Help
make help
```

---

**Automated setup makes Pret-a-Program installation effortless! 🚀**

*For manual setup instructions, see the individual assistant guides.*
