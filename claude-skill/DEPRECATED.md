# ⚠️ DEPRECATED: Manual Installation Method

**This directory contains the legacy manual installation method for PARA-Programming with Claude Code.**

---

## 🎯 Use the Plugin Instead

The PARA-Programming commands are now available as an **official Claude Code plugin** with easier installation and automatic updates.

### New Installation Method

```bash
# Add the PARA-Programming marketplace
/plugin marketplace add brian-lai/para-programming-plugin

# Install the plugin
/plugin install para-programming@brian-lai/para-programming-plugin

# Start using in your project
cd your-project
claude
/para-programming:para-init
```

### Plugin Repository

**GitHub:** https://github.com/brian-lai/para-programming-plugin

---

## Why Use the Plugin?

### Benefits

✅ **One-command installation** - No manual file copying
✅ **Automatic updates** - Stay current with latest improvements
✅ **Official plugin structure** - Follows Claude Code best practices
✅ **Better discoverability** - Available through plugin marketplace
✅ **Simplified maintenance** - Separate from documentation repository

### Migration Guide

If you're currently using the manual installation:

1. **Backup your customizations** (if any):
   ```bash
   cp ~/.claude/commands/para-*.md ~/para-commands-backup/
   ```

2. **Remove manual installation**:
   ```bash
   rm ~/.claude/commands/para-*.md
   ```

3. **Install the plugin**:
   ```bash
   /plugin install para-programming@brian-lai/para-programming-plugin
   ```

4. **Your projects are unaffected** - The `context/` directories and workflow remain unchanged

---

## Legacy Documentation

This directory will remain for:
- Historical reference
- Understanding plugin structure
- Custom modifications (advanced users)

### Files in This Directory

- `commands/` - Slash command implementations
- `templates/` - File templates for plans, summaries, context
- `scripts/` - Installation/uninstallation scripts
- `hooks/` - Session start hooks
- `examples/` - Example workflows

---

## Support

For plugin installation issues:
- **Plugin Issues:** https://github.com/brian-lai/para-programming-plugin/issues
- **General Questions:** https://github.com/brian-lai/para-programming/issues

---

## Deprecation Timeline

- **December 2024:** Plugin released, manual installation deprecated
- **June 2025:** Manual installation documentation archived
- **December 2025:** Legacy directory may be removed

We recommend migrating to the plugin as soon as possible for the best experience.

---

**Thank you for using PARA-Programming! 🚀**
