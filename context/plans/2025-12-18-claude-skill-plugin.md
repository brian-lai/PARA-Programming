# Plan: Bundle Claude Skills as Distributable Plugin

**Date:** 2025-12-18
**Status:** Pending Review
**Objective:** Package the PARA-Programming Claude skills as a distributable plugin in a separate repository, following Claude Code's official plugin structure.

---

## Objective

Transform the existing `claude-skill/` directory into a proper Claude Code plugin that can be:
1. Distributed via GitHub as a plugin marketplace
2. Installed with `claude plugin install para-programming@para-programming`
3. Maintained separately from the main documentation repository
4. Updated independently while preserving methodology consistency

---

## Current State Analysis

### Existing Structure
```
para-programming/
├── claude-skill/
│   ├── README.md
│   ├── INSTALL.md
│   ├── skill.json (incorrect format - should be plugin.json)
│   ├── commands/
│   │   ├── para-init.md
│   │   ├── para-plan.md
│   │   ├── para-execute.md
│   │   ├── para-summarize.md
│   │   ├── para-archive.md
│   │   ├── para-status.md
│   │   ├── para-check.md
│   │   ├── para-init-gemini.md (cross-platform support)
│   │   └── init-para-claude.md (deprecated?)
│   ├── templates/
│   │   ├── plan-template.md
│   │   ├── summary-template.md
│   │   ├── context-template.md
│   │   ├── claude-basic-template.md
│   │   └── claude-full-template.md
│   ├── scripts/
│   │   ├── install.sh
│   │   └── uninstall.sh
│   ├── hooks/
│   │   └── para-session-start.sh
│   ├── examples/
│   │   └── example-workflow.md
│   ├── CHANGELOG.md
│   ├── RELEASE-NOTES.md
│   ├── UPGRADING.md
│   └── LICENSE
└── CLAUDE.md (global methodology - needs to be included)
```

### Key Components
- **7 slash commands** for PARA workflow
- **5 templates** for plan/summary/context files
- **Installation scripts** (currently manual)
- **Hooks** for session start
- **Global CLAUDE.md** methodology file

---

## Approach

### Phase 1: Repository Setup

**Create new repository: `para-programming-plugin`**

1. Initialize separate Git repository
2. Copy `claude-skill/` contents as base
3. Restructure to match Claude Code plugin specification
4. Add proper `.claude-plugin/plugin.json` manifest

### Phase 2: Plugin Structure Migration

**Transform to official plugin format:**

```
para-programming-plugin/
├── .claude-plugin/              # NEW: Plugin metadata
│   └── plugin.json              # REQUIRED: Plugin manifest
├── commands/                    # KEEP: Slash commands
│   ├── para-init.md
│   ├── para-plan.md
│   ├── para-execute.md
│   ├── para-summarize.md
│   ├── para-archive.md
│   ├── para-status.md
│   └── para-check.md
├── skills/                      # NEW: Agent Skills (optional future)
│   └── para-workflow/
│       └── SKILL.md
├── hooks/                       # CONVERT: Event handlers
│   └── hooks.json               # Change from .sh to hooks.json
├── templates/                   # KEEP: Resource files
│   ├── plan-template.md
│   ├── summary-template.md
│   ├── context-template.md
│   ├── claude-basic-template.md
│   └── claude-full-template.md
├── resources/                   # NEW: Additional resources
│   └── CLAUDE.md                # Global methodology file
├── scripts/                     # KEEP: Utility scripts
│   ├── install.sh               # Update for plugin usage
│   └── uninstall.sh             # Update for plugin usage
├── examples/                    # KEEP: Documentation
│   └── example-workflow.md
├── README.md                    # KEEP: Documentation
├── INSTALL.md                   # UPDATE: Plugin installation
├── CHANGELOG.md                 # KEEP: Version history
├── UPGRADING.md                 # UPDATE: Plugin upgrade process
└── LICENSE                      # KEEP: MIT License
```

### Phase 3: Plugin Manifest Creation

**Create `.claude-plugin/plugin.json`:**

```json
{
  "name": "para-programming",
  "version": "1.0.0",
  "description": "PARA-Programming methodology for Claude Code - structured context, persistent memory, and intelligent execution",
  "author": {
    "name": "PARA-Programming Community",
    "email": "hello@para-programming.dev"
  },
  "homepage": "https://github.com/para-programming/para-programming-plugin",
  "repository": "https://github.com/para-programming/para-programming-plugin",
  "license": "MIT",
  "keywords": [
    "para",
    "methodology",
    "workflow",
    "context",
    "planning",
    "ai-assisted-development"
  ],
  "hooks": "./hooks/hooks.json"
}
```

**Note:** Commands, templates, and skills are auto-discovered from their directories.

### Phase 4: Hooks Conversion

**Convert `hooks/para-session-start.sh` to `hooks/hooks.json`:**

```json
{
  "SessionStart": {
    "action": "shell",
    "command": "echo '🎯 PARA-Programming active. Use /para-status to see current context.'"
  }
}
```

### Phase 5: Documentation Updates

**Update documentation for plugin installation:**

1. **INSTALL.md**: Document plugin marketplace installation
2. **README.md**: Update installation section to show plugin commands
3. **UPGRADING.md**: Add plugin update procedures

**New installation flow:**
```bash
# Add PARA-Programming marketplace
claude plugin marketplace add para-programming/para-programming-plugin

# Install the plugin
claude plugin install para-programming@para-programming --scope user

# Initialize in project
cd your-project
claude
/para-init
```

### Phase 6: Global CLAUDE.md Handling

**Strategy for global methodology file:**

The plugin needs to install `CLAUDE.md` to `~/.claude/CLAUDE.md`. Options:

**Option A: Post-install hook**
- Add `PostInstall` hook to copy `resources/CLAUDE.md` to `~/.claude/`
- Automatic but less transparent

**Option B: Explicit command**
- Add `/para-install-global` command to set up global methodology
- User-initiated but more control

**Option C: Documentation-only**
- Keep manual installation in docs
- Most transparent but requires user action

**Recommendation:** Option B (explicit command) for transparency and control.

### Phase 7: Cross-Repository References

**Update main `para-programming` repository:**

1. Update `claude/QUICKSTART.md` to reference plugin
2. Update `SETUP-GUIDE.md` with plugin installation steps
3. Add link from `README.md` to plugin repository
4. Keep `claude-skill/` as legacy reference (deprecated notice)

**Maintain consistency:**
- Plugin version tags should align with methodology releases
- Changes to PARA workflow require updates in both repos
- CI/CD to test plugin installation

---

## Implementation Steps

### Step 1: Repository Creation
- [ ] Create `para-programming-plugin` repository on GitHub
- [ ] Initialize with README, LICENSE
- [ ] Set up branch protection on `main`
- [ ] Configure release workflow

### Step 2: Structure Migration
- [ ] Copy `claude-skill/` contents to new repo
- [ ] Create `.claude-plugin/` directory
- [ ] Create `plugin.json` manifest
- [ ] Move `CLAUDE.md` to `resources/`
- [ ] Convert hooks to `hooks.json` format

### Step 3: Command Updates
- [ ] Review each command for plugin compatibility
- [ ] Remove `init-para-claude.md` (deprecated)
- [ ] Verify `para-init-gemini.md` still needed
- [ ] Test all commands in plugin context

### Step 4: Documentation Rewrite
- [ ] Update INSTALL.md for plugin installation
- [ ] Update README.md with plugin commands
- [ ] Add plugin marketplace setup guide
- [ ] Document global CLAUDE.md installation strategy

### Step 5: Script Updates
- [ ] Update `install.sh` to use plugin CLI
- [ ] Update `uninstall.sh` for plugin removal
- [ ] Add `para-install-global` command (if Option B chosen)
- [ ] Test installation on clean system

### Step 6: Testing
- [ ] Test plugin installation from marketplace
- [ ] Test all commands in fresh project
- [ ] Test upgrade from manual installation to plugin
- [ ] Test cross-platform (macOS, Linux, Windows)

### Step 7: Release
- [ ] Create v1.0.0 tag
- [ ] Publish to GitHub releases
- [ ] Update main `para-programming` repo documentation
- [ ] Announce plugin availability

### Step 8: Deprecation of Manual Install
- [ ] Add deprecation notice to `claude-skill/` directory
- [ ] Redirect documentation to plugin installation
- [ ] Keep legacy docs for reference
- [ ] Plan removal timeline (6 months?)

---

## Risks & Mitigations

### Risk 1: Plugin API Instability
**Risk:** Claude Code plugin API may change, breaking our plugin.

**Mitigation:**
- Follow official plugin specification strictly
- Test against each new Claude Code release
- Maintain backward compatibility where possible
- Document supported Claude Code versions

### Risk 2: Global CLAUDE.md Management
**Risk:** Users may have existing `~/.claude/CLAUDE.md` that conflicts.

**Mitigation:**
- Detect existing file before installation
- Offer merge/backup options
- Provide explicit command for global setup
- Document manual installation as fallback

### Risk 3: Breaking Changes for Existing Users
**Risk:** Users with manual installation may break when switching to plugin.

**Mitigation:**
- Provide clear upgrade guide
- Support both installation methods temporarily
- Automatic migration tool/command
- Version compatibility matrix

### Risk 4: Marketplace Discovery
**Risk:** Users may not find the plugin in marketplace.

**Mitigation:**
- Clear documentation in main repo
- SEO-optimized plugin description
- Keywords in plugin.json
- Community promotion

### Risk 5: Template Access
**Risk:** Commands may not find templates in plugin structure.

**Mitigation:**
- Use relative paths from plugin root
- Test template loading thoroughly
- Document template customization
- Provide template override mechanism

### Risk 6: Two-Repository Sync
**Risk:** Methodology changes in main repo may not propagate to plugin.

**Mitigation:**
- CI/CD integration between repos
- Automated PR creation for sync
- Shared changelog
- Version tagging convention

---

## Success Criteria

### Installation
- ✅ Plugin installs with single command
- ✅ All commands available after installation
- ✅ Templates accessible to commands
- ✅ Hooks execute correctly
- ✅ Global CLAUDE.md deployed (with user consent)

### Functionality
- ✅ All 7 commands work identically to manual install
- ✅ `/para-init` creates proper structure
- ✅ `/para-plan` generates plans with templates
- ✅ `/para-execute` creates branches and tracks to-dos
- ✅ `/para-status` reads context correctly
- ✅ `/para-summarize` analyzes git changes
- ✅ `/para-archive` preserves context history

### Documentation
- ✅ Clear installation instructions
- ✅ Migration guide for existing users
- ✅ Plugin marketplace setup documented
- ✅ Troubleshooting section complete
- ✅ Links between main repo and plugin repo

### Distribution
- ✅ Published to GitHub releases
- ✅ Versioned with semantic versioning
- ✅ CHANGELOG maintained
- ✅ Community can install via marketplace
- ✅ Updates work smoothly

---

## Data Sources

### Technical References
- Claude Code plugin specification: [Plugins Documentation](https://code.claude.com/docs/en/plugins.md)
- Plugin manifest format: [Plugins Reference](https://code.claude.com/docs/en/plugins-reference.md)
- Hooks specification: [Hooks Documentation](https://code.claude.com/docs/en/hooks.md)
- Marketplace setup: [Plugin Marketplaces](https://code.claude.com/docs/en/plugin-marketplaces.md)

### Existing Code
- Current `claude-skill/` directory structure
- Existing `skill.json` (to be converted)
- Installation scripts (`install.sh`, `uninstall.sh`)
- All command markdown files
- Template files

### Related Documentation
- Main PARA-Programming README.md
- SETUP-GUIDE.md
- claude/QUICKSTART.md
- Global CLAUDE.md methodology

---

## MCP Tools

No MCP tools required for this task. This is primarily:
- File structure reorganization
- JSON manifest creation
- Documentation updates
- Git repository management

---

## Dependencies

### External
- Claude Code CLI (v1.0+)
- Git
- GitHub repository access
- Plugin marketplace availability

### Internal
- Agreement on global CLAUDE.md installation strategy (Option A/B/C)
- Decision on deprecated command cleanup
- Repository naming and organization structure
- Release versioning strategy

---

## Timeline Considerations

**No time estimates** - work proceeds based on these priorities:

1. **Critical:** Repository structure and plugin manifest
2. **High:** Command compatibility and testing
3. **High:** Documentation for plugin installation
4. **Medium:** Migration guide for existing users
5. **Medium:** CI/CD and automation
6. **Low:** Deprecation of manual install path

---

## Open Questions

1. **Global CLAUDE.md Strategy:** Which option (A/B/C) should we use?
2. **Repository Naming:** `para-programming-plugin` or `claude-skill` or `para-claude`?
3. **Deprecated Commands:** Remove `init-para-claude.md` and `para-init-gemini.md`?
4. **Skill vs Commands:** Should we create a `skills/para-workflow/` in addition to commands?
5. **Marketplace Naming:** Use `@para-programming` namespace or `@para-programming-community`?
6. **Version Strategy:** Start at v1.0.0 or v0.1.0 for beta testing?
7. **MCP Integration:** Should we add MCP servers for preprocessing in future?

---

## Next Steps

**Upon approval of this plan:**

1. **User Decision Required:** Choose global CLAUDE.md installation strategy
2. **User Decision Required:** Confirm repository naming
3. **Execute Step 1:** Create new repository
4. **Execute Step 2:** Migrate structure
5. **Request Review:** Structure validation before proceeding
6. **Continue implementation** following the step-by-step plan

---

**Estimated Scope:** Medium-large (multiple components, new repo, documentation)
**Risk Level:** Medium (plugin API compatibility, existing user migration)
**Reversibility:** High (can maintain manual installation in parallel)
