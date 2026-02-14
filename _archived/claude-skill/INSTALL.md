# Installation Guide

Complete installation instructions for the PARA-Programming Claude Code skill.

---

## Prerequisites

Before installing, ensure you have:

- ✅ **Claude Code CLI** installed ([Get it here](https://claude.ai/claude-code))
- ✅ **Git** installed (for project version control)
- ✅ **Terminal access** (bash, zsh, or PowerShell)

---

## Installation Methods

### Method 1: Automated Installation (Recommended)

The quickest way to install:

```bash
# Clone or download the PARA-Programming repository
git clone https://github.com/para-programming/claude-skill.git
cd claude-skill

# Run the installation script
./claude-skill/scripts/install.sh
```

The script will:
1. Create `~/.claude/` directory if needed
2. Install global `CLAUDE.md` methodology file
3. Copy all slash commands to `~/.claude/commands/`
4. Display next steps

---

### Method 2: Manual Installation

If you prefer manual control:

#### Step 1: Install Global Methodology

```bash
# Ensure you're in the cloned repository
cd /path/to/para-programming

# Create Claude directory
mkdir -p ~/.claude

# Create symlink (recommended - automatic updates)
ln -s "$(pwd)/CLAUDE.md" ~/.claude/CLAUDE.md

# Verify the symlink
ls -la ~/.claude/CLAUDE.md
# Should show: ~/.claude/CLAUDE.md -> /path/to/para-programming/CLAUDE.md
```

**Why symlink instead of copy?**
- ✅ Automatic updates when you `git pull`
- ✅ Single source of truth
- ✅ No need to manually sync changes

#### Step 2: Install Slash Commands

```bash
# Create commands directory
mkdir -p ~/.claude/commands

# Copy all PARA commands
cp claude-skill/commands/*.md ~/.claude/commands/
```

#### Step 3: Verify Installation

```bash
# List installed commands
ls ~/.claude/commands/para-*.md

# Should show:
# para-archive.md
# para-check.md
# para-execute.md
# para-init.md
# para-plan.md
# para-status.md
# para-summarize.md
```

---

### Method 3: Future Skill Package

When Claude Code's plugin API is released:

```bash
claude install @para-programming/skill
```

This will automatically:
- Install global methodology
- Register all commands
- Set up templates
- Configure MCP tools

---

## Verification

### Test Installation

1. **Start Claude Code:**
   ```bash
   cd ~/test-project
   claude
   ```

2. **Check for PARA commands:**
   ```
   /help
   ```

   You should see:
   - `/para-init` - Initialize PARA structure
   - `/para-plan` - Create a plan
   - `/para-execute` - Start execution with branch and to-dos
   - `/para-summarize` - Generate summary
   - `/para-archive` - Archive context
   - `/para-status` - Show status
   - `/para-check` - Decision helper

3. **Test a command:**
   ```
   /para-check "test installation"
   ```

   Should respond with workflow guidance.

---

## Post-Installation Setup

### Initialize Your First Project

```bash
# Navigate to your project
cd your-project/

# Start Claude Code
claude

# Initialize PARA structure
/para-init

# OR with a specific template
/para-init --template=full
```

This creates:
```
your-project/
├── context/
│   ├── context.md
│   ├── data/
│   ├── plans/
│   ├── summaries/
│   ├── archives/
│   └── servers/
└── CLAUDE.md (if not present)
```

---

## Configuration

### Global CLAUDE.md

Located at: `~/.claude/CLAUDE.md`

**What it contains:**
- PARA workflow methodology
- When to use PARA vs. direct responses
- MCP integration patterns
- Token efficiency strategies

**Customization:**
You can edit this file to customize workflow for your team:

```bash
# Edit global methodology
$EDITOR ~/.claude/CLAUDE.md

# Restart Claude Code to apply changes
```

### Project CLAUDE.md

Located at: `<project-root>/CLAUDE.md`

**What it contains:**
- Project-specific architecture
- Tech stack and dependencies
- Code organization and conventions
- Key files and their purposes

**Customization:**
Edit per-project to describe your codebase:

```bash
# Use /para-init to create from template
/para-init --template=full

# Then edit for your project
$EDITOR CLAUDE.md
```

---

## Platform-Specific Notes

### macOS / Linux

- Default shell: bash or zsh
- Commands directory: `~/.claude/commands/`
- Scripts require execute permission: `chmod +x install.sh`

### Windows

- Use Git Bash, WSL, or PowerShell
- Commands directory: `C:\Users\YourName\.claude\commands\`
- May need to adjust script permissions

### Windows PowerShell Alternative

```powershell
# Create directories
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\commands"

# Copy files
Copy-Item "claude-skill\commands\*.md" "$env:USERPROFILE\.claude\commands\"
Copy-Item "CLAUDE.md" "$env:USERPROFILE\.claude\"
```

---

## Updating

### Update to Latest Version

```bash
# Pull latest changes
cd para-programming
git pull origin main

# Re-run install script
./claude-skill/scripts/install.sh

# Choose to overwrite when prompted
```

### Selective Updates

Update only specific components:

```bash
# Update global methodology only
cp CLAUDE.md ~/.claude/CLAUDE.md

# Update specific command
cp claude-skill/commands/para-init.md ~/.claude/commands/

# Update all commands
cp claude-skill/commands/*.md ~/.claude/commands/
```

---

## Uninstallation

### Automated Uninstall

```bash
# Run uninstall script
./claude-skill/scripts/uninstall.sh

# Removes commands, optionally keeps CLAUDE.md
```

### Manual Uninstall

```bash
# Remove commands
rm ~/.claude/commands/para-*.md

# Optionally remove global methodology
rm ~/.claude/CLAUDE.md
```

**Note:** This does NOT remove project `context/` directories or `CLAUDE.md` files in your projects. Those remain for reference and audit trail.

---

## Troubleshooting

### Commands Not Found

**Symptom:** `/para-init` shows "command not found"

**Solutions:**
1. Check commands are installed:
   ```bash
   ls ~/.claude/commands/para-*.md
   ```

2. Restart Claude Code:
   ```bash
   # Exit current session (Ctrl+D)
   # Start new session
   claude
   ```

3. Reinstall:
   ```bash
   ./claude-skill/scripts/install.sh
   ```

### Global CLAUDE.md Not Loading

**Symptom:** Claude doesn't follow PARA workflow automatically

**Solutions:**
1. Verify file exists:
   ```bash
   cat ~/.claude/CLAUDE.md | head -n 10
   ```

2. Check file permissions:
   ```bash
   ls -la ~/.claude/CLAUDE.md
   # Should be readable
   ```

3. Reinstall:
   ```bash
   cp CLAUDE.md ~/.claude/CLAUDE.md
   ```

### Permission Errors (Linux/Mac)

**Symptom:** "Permission denied" when running scripts

**Solution:**
```bash
chmod +x claude-skill/scripts/*.sh
```

### PATH Issues

**Symptom:** Can't find Claude Code CLI

**Solution:**
```bash
# Check if Claude Code is in PATH
which claude

# If not found, add to PATH or use full path
/path/to/claude
```

---

## Next Steps

After successful installation:

1. **Read the Quick Start:** [README.md](README.md#quick-start)
2. **Try the example workflow:** [examples/example-workflow.md](examples/example-workflow.md)
3. **Initialize your project:** Run `/para-init` in your project
4. **Start building:** Run `/para-plan` for your first task

---

## Support

- **Documentation:** [README.md](README.md)
- **Issues:** [GitHub Issues](https://github.com/para-programming/claude-skill/issues)
- **Community:** [GitHub Discussions](https://github.com/para-programming/claude-skill/discussions)

---

**Installation complete! 🎉**

You're ready to start PARA-Programming with Claude Code.
