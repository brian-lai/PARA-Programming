# Plan: Unify Configuration with AGENTS.md Standard

## Objective

Consolidate the fragmented tool-specific configuration files into a single `AGENTS.md` standard with symlinks for tool compatibility, simplify the directory structure, and clearly tier tool support.

## Background Research

### Current State
The project has 6 separate directories for different AI tools:
- `claude/` - Claude Code (CLAUDE.md)
- `cursor/` - Cursor IDE (.cursorrules - **deprecated**)
- `copilot/` - GitHub Copilot (copilot-instructions.md)
- `codex/` - OpenAI Codex CLI (AGENTS.md)
- `gemini/` - Google Gemini (GEMINI.md)
- `other-ai-assistants/` - Universal guide

### Tool Configuration Requirements (Research Findings)

| Tool | Config File | Format | Location | Symlinks |
|------|-------------|--------|----------|----------|
| **Claude Code** | `CLAUDE.md` | Markdown | Project root or `~/.claude/` | Yes (in `.claude/rules/`) |
| **OpenAI Codex CLI** | `AGENTS.md` | Markdown | Project root | Yes (standard filesystem) |
| **Cursor** | `AGENTS.md` or `.cursor/rules/*.md` | Markdown | Project root or `.cursor/rules/` | Yes |
| **GitHub Copilot** | `copilot-instructions.md` | Markdown | `.github/` directory | Unknown (likely yes) |
| **Windsurf (Codeium)** | `*.md` | Markdown | `.windsurf/rules/` | Yes |
| **Continue.dev** | `*.md` | Markdown | `.continue/rules/` | Yes |
| **Aider** | `.aider.conf.yml` | YAML | Home or project root | N/A (different format) |

### Key Insight: AGENTS.md is Emerging as a Standard

1. **Cursor** now supports `AGENTS.md` natively (`.cursorrules` is **deprecated**)
2. **OpenAI Codex CLI** uses `AGENTS.md`
3. Both tools read plain markdown without special frontmatter
4. Symlinks work on all major platforms (macOS, Linux, Windows with Dev Mode)

### Tool Popularity (for tiering)

**Tier 1 - Actively Supported (high usage):**
- Claude Code
- Cursor
- GitHub Copilot
- OpenAI Codex CLI

**Tier 2 - Community Supported (moderate/growing usage):**
- Continue.dev
- Windsurf (Codeium)

**Tier 3 - Reference Only (lower usage or different paradigm):**
- Aider (YAML config, different approach)
- JetBrains AI (built-in, limited customization)
- Amazon CodeWhisperer
- Tabnine
- Google Gemini (limited external tooling)

---

## Approach

### Phase 1: Create Unified AGENTS.md

1. Create a single canonical `AGENTS.md` file at project root that:
   - Contains the full PARA-Programming methodology
   - Is tool-agnostic in wording (avoid tool-specific terminology)
   - Works natively with Cursor and Codex
   - Can be symlinked for other tools

2. The unified file structure:
   ```
   PARA-Programming/
   ├── AGENTS.md                    # Single source of truth
   ├── README.md                    # Project overview
   ├── SETUP-GUIDE.md              # Unified setup for all tools
   │
   ├── examples/                    # Usage examples
   │   ├── plans/
   │   ├── summaries/
   │   └── workflows/
   │
   └── tool-setup/                  # Tool-specific SETUP only
       ├── claude-code.md           # How to set up for Claude
       ├── cursor.md                # How to set up for Cursor
       ├── copilot.md               # How to set up for Copilot
       ├── codex.md                 # How to set up for Codex
       └── community/               # Community-supported tools
           ├── continue.md
           ├── windsurf.md
           └── others.md
   ```

### Phase 2: Symlink Strategy

For each tool, create symlinks from `AGENTS.md` to the expected filename:

```bash
# Claude Code
ln -s AGENTS.md CLAUDE.md

# Cursor (native AGENTS.md support - no symlink needed)
# Already reads AGENTS.md directly

# GitHub Copilot (requires .github/ location)
mkdir -p .github
ln -s ../AGENTS.md .github/copilot-instructions.md

# OpenAI Codex CLI (native AGENTS.md support - no symlink needed)
# Already reads AGENTS.md directly

# Windsurf
mkdir -p .windsurf/rules
ln -s ../../AGENTS.md .windsurf/rules/para-programming.md

# Continue.dev
mkdir -p .continue/rules
ln -s ../../AGENTS.md .continue/rules/para-programming.md
```

### Phase 3: Simplify Directory Structure

**Current directories to consolidate:**
- `claude/` → Merge into `tool-setup/claude-code.md`
- `cursor/` → Merge into `tool-setup/cursor.md`
- `copilot/` → Merge into `tool-setup/copilot.md`
- `codex/` → Merge into `tool-setup/codex.md`
- `gemini/` → Move to `tool-setup/community/`
- `other-ai-assistants/` → Merge into `tool-setup/community/`

**Keep separate:**
- `claude-skill/` - This is a Claude Code skill package, not just documentation

### Phase 4: Update Documentation

1. Update `README.md`:
   - Explain the unified AGENTS.md approach
   - Document symlink strategy
   - Tier the supported tools

2. Update `SETUP-GUIDE.md`:
   - Single setup flow for all tools
   - Tool-specific symlink commands

3. Create migration guide for existing users

---

## Files to Modify

- `README.md` - Update to reflect new structure
- `SETUP-GUIDE.md` - Consolidate setup instructions
- `CLAUDE.md` (root) - Transform into AGENTS.md

## Files to Create

- `AGENTS.md` - New unified methodology file (based on existing content)
- `tool-setup/claude-code.md` - Claude-specific setup
- `tool-setup/cursor.md` - Cursor-specific setup
- `tool-setup/copilot.md` - Copilot-specific setup
- `tool-setup/codex.md` - Codex-specific setup
- `tool-setup/community/continue.md` - Continue.dev setup
- `tool-setup/community/windsurf.md` - Windsurf setup
- `tool-setup/community/others.md` - Other tools reference
- `examples/` directory with sample plans/summaries
- `MIGRATION.md` - Guide for existing users

## Files/Directories to Remove (or Archive)

- `claude/` directory (content migrated to `tool-setup/`)
- `cursor/` directory (content migrated to `tool-setup/`)
- `copilot/` directory (content migrated to `tool-setup/`)
- `codex/` directory (content migrated to `tool-setup/`)
- `gemini/` directory (content migrated to `tool-setup/community/`)
- `other-ai-assistants/` directory (content migrated to `tool-setup/`)

**Keep:**
- `claude-skill/` - This is a separate package
- `docs/` - GitHub Pages
- `context/` - PARA-Programming's own context
- `scripts/` - Utility scripts

---

## Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| Breaking existing users' setups | Create MIGRATION.md with clear upgrade path |
| Symlinks not supported on some systems | Document alternatives (copy file, or use native support) |
| Tool updates changing expected filenames | Document fallback approaches |
| Content loss during migration | Phase approach, archive old directories first |
| Templates scattered across directories | Consolidate into `examples/` directory |

---

## Success Criteria

- [ ] Single `AGENTS.md` file serves all tools
- [ ] Symlink strategy documented and working for Tier 1 tools
- [ ] Directory count reduced from 6+ tool directories to 1 `tool-setup/`
- [ ] Clear tiering: Tier 1 (actively supported), Tier 2 (community), Tier 3 (reference)
- [ ] Migration path documented for existing users
- [ ] Templates consolidated into `examples/` directory
- [ ] README clearly explains the unified approach
- [ ] Setup guide provides single workflow for all tools

---

## Open Questions for User

1. **Templates**: Should we keep tool-specific templates or consolidate? The content is 95% identical across tools.

2. **claude-skill**: Keep as separate directory or integrate into main structure?

3. **Backward compatibility**: Should we keep symlinks from old locations (e.g., `claude/CLAUDE.md` → `AGENTS.md`) during transition?

4. **Phased rollout**: Do you want this as a single PR or broken into phases?

---

## Recommended Phased Approach

**Phase 1 (This PR):**
- Create `AGENTS.md` from existing content
- Create `tool-setup/` structure with setup guides
- Update README and SETUP-GUIDE
- Create MIGRATION.md

**Phase 2 (Separate PR):**
- Archive old directories
- Update all internal links
- Consolidate templates into `examples/`

**Phase 3 (Separate PR):**
- Remove archived directories
- Final cleanup

This allows for testing and rollback between phases.

---

## Estimated Scope

- **Files to create**: ~10-12 new files
- **Files to modify**: ~3-4 existing files
- **Files to archive/remove**: ~6 directories (deferred to Phase 2)
- **Documentation updates**: Significant (README, SETUP-GUIDE, new guides)

This is a **phased plan** given the scope affects the entire project structure.
