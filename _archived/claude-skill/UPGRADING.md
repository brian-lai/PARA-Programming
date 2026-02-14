# Upgrading Guide

How to update your PARA-Programming skill installation to get the latest features and improvements.

---

## 🔄 Quick Update

### If You Used Symlink Installation (Recommended)

```bash
# Navigate to your cloned repo
cd /path/to/para-programming

# Pull latest changes
git pull origin main

# Your global CLAUDE.md is automatically updated! ✨

# Optionally update commands (if new commands were added)
cp claude-skill/commands/*.md ~/.claude/commands/
```

**That's it!** The symlink ensures your global methodology is always current.

---

### If You Copied Files (Legacy)

```bash
# Navigate to your cloned repo
cd /path/to/para-programming

# Pull latest changes
git pull origin main

# Re-run installation to update everything
./claude-skill/scripts/install.sh

# Choose to overwrite when prompted
```

---

## 🔗 Migrating to Symlink (Recommended)

If you initially copied files and want to switch to symlinks for automatic updates:

### Step 1: Remove Old Copy

```bash
# Backup existing file (optional)
mv ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup

# Or just remove it
rm ~/.claude/CLAUDE.md
```

### Step 2: Create Symlink

```bash
# Navigate to cloned repo
cd /path/to/para-programming

# Create symlink
ln -s "$(pwd)/CLAUDE.md" ~/.claude/CLAUDE.md

# Verify
ls -la ~/.claude/CLAUDE.md
# Should show: ~/.claude/CLAUDE.md -> /path/to/para-programming/CLAUDE.md
```

### Step 3: Test

```bash
# Start Claude Code
claude

# Test a command
/para-status
```

✅ **Done!** You're now on the symlink update path.

---

## 📦 What Gets Updated

### Automatically (with symlink)
- ✅ Global CLAUDE.md methodology
- ✅ Workflow rules and decision trees
- ✅ MCP patterns and best practices
- ✅ Token efficiency strategies

### Manually (requires copy)
- Slash commands in `~/.claude/commands/`
- Templates in `claude-skill/templates/`
- Installation scripts

---

## 🆕 Checking for Updates

### View Changelog

```bash
cd /path/to/para-programming
cat claude-skill/CHANGELOG.md
```

### Check Your Version

```bash
# Check git tags
git tag -l

# Check latest commit
git log -1 --oneline

# Check if updates available
git fetch
git status
```

### Update to Specific Version

```bash
# List available versions
git tag -l

# Update to specific version
git checkout v1.2.0

# Or stay on latest
git checkout main
git pull
```

---

## 🔧 Updating Individual Components

### Update Slash Commands Only

```bash
cd /path/to/para-programming
git pull origin main
cp claude-skill/commands/*.md ~/.claude/commands/
```

### Update Specific Command

```bash
# Update just one command
cp claude-skill/commands/para-plan.md ~/.claude/commands/
```

### Update Templates

```bash
# Templates are used by commands, not stored globally
# Pull latest changes and they'll be used next time
git pull origin main
```

---

## 🆘 Troubleshooting Updates

### Symlink Broken

**Symptom:** `ls -la ~/.claude/CLAUDE.md` shows broken link

**Fix:**
```bash
# Remove broken link
rm ~/.claude/CLAUDE.md

# Recreate from correct location
cd /path/to/para-programming
ln -s "$(pwd)/CLAUDE.md" ~/.claude/CLAUDE.md
```

### Moved Repository

**Symptom:** Symlink points to old location

**Fix:**
```bash
# Remove old symlink
rm ~/.claude/CLAUDE.md

# Create new symlink from new location
cd /path/to/new-location/para-programming
ln -s "$(pwd)/CLAUDE.md" ~/.claude/CLAUDE.md
```

### Git Conflicts

**Symptom:** `git pull` shows conflicts

**Fix:**
```bash
# If you didn't modify the repo files:
git reset --hard origin/main

# If you did modify files, stash changes:
git stash
git pull origin main
git stash pop  # Re-apply your changes if needed
```

### Commands Not Updating

**Symptom:** Commands still show old behavior

**Fix:**
```bash
# Commands are copied, not symlinked
# Manually update them:
cd /path/to/para-programming
cp claude-skill/commands/*.md ~/.claude/commands/

# Restart Claude Code
```

---

## 📅 Update Recommendations

### How Often to Update

- **Weekly**: If actively developing with PARA-Programming
- **Monthly**: For stable production use
- **Per Release**: Watch GitHub releases for major updates

### Staying Informed

```bash
# Watch the repository for releases
# (On GitHub: Watch → Custom → Releases only)

# Or check manually:
cd /path/to/para-programming
git fetch --tags
git tag -l | tail -5  # Show last 5 versions
```

---

## 🔔 Breaking Changes

We follow semantic versioning:

- **v1.x.x → v2.x.x**: May have breaking changes (check CHANGELOG)
- **v1.1.x → v1.2.x**: New features, backward compatible
- **v1.1.1 → v1.1.2**: Bug fixes, backward compatible

### Before Major Updates

1. Read `CHANGELOG.md` for breaking changes
2. Backup your `context/` directories if concerned
3. Test in a non-critical project first
4. Update when ready

---

## ✅ Update Checklist

After updating, verify:

- [ ] Symlink still points to correct location
- [ ] Commands work: `/para-status`
- [ ] Global CLAUDE.md has latest content
- [ ] No git conflicts or issues
- [ ] Documentation reflects current version

---

## 💡 Pro Tips

### Automatic Updates (Advanced)

Create a cron job or scheduled task:

```bash
# Add to crontab (weekly update)
0 9 * * 1 cd /path/to/para-programming && git pull origin main
```

### Multiple Projects

If using PARA across many machines:

```bash
# Clone once per machine
# All projects on that machine share the symlinked methodology
# Update once, affects all projects
```

### Custom Modifications

If you need custom workflow rules:

```bash
# Fork the repository
# Modify CLAUDE.md in your fork
# Symlink to your fork instead:
ln -s /path/to/your-fork/CLAUDE.md ~/.claude/CLAUDE.md
```

---

## 🤝 Contributing Updates

Found a bug or have an improvement?

1. Create an issue on GitHub
2. Or submit a pull request
3. Your improvement helps everyone!

---

**Stay updated and enjoy the latest PARA-Programming features! 🚀**
