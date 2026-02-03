# Plan: Smart para-init with Auto-Detection

**Created:** 2026-02-02
**Type:** Implementation Plan
**Status:** Planning

---

## Objective

Implement an intelligent `para-init` command that auto-detects installed AI coding tools and automatically configures PARA-Programming without requiring users to understand "tiers" or implementation details.

**Key Goals:**
1. Single command UX: `para-init` (no flags needed)
2. Auto-detect all installed AI coding tools
3. Handle Claude Code specially (point to plugin, don't configure files)
4. Configure file-based tools (Cursor, Continue, Copilot, Gemini) automatically
5. Provide clear guidance without exposing tier concepts

---

## Approach

### 1. Detection Logic

Create `scripts/detect-tools.sh` that identifies:

**Plugin-Based Tools (External Setup):**
- **Claude Code** → Detect via:
  - `~/.claude/CLAUDE.md` exists
  - `$CLAUDE_CODE_VERSION` env var
  - **Action:** Point to `github.com/brian-lai/para-programming-plugin`

**File-Based Tools (This Repo Handles):**

**Tier 1 (Full PARA Support):**
- **Cursor** → Detect via:
  - `.cursor/` directory exists
  - `cursor` command available
  - **Action:** Create `AGENTS.md` (Cursor reads natively)

- **Continue.dev** → Detect via:
  - `.continue/` directory exists
  - `.continuerc.json` exists
  - **Action:** Create `AGENTS.md` (Continue reads natively)

**Tier 2 (Methodology Only):**
- **GitHub Copilot** → Detect via:
  - `.github/copilot-instructions.md` exists
  - `gh copilot --version` succeeds
  - **Action:** Create `AGENTS.md` + symlink from `.github/copilot-instructions.md`

- **Gemini** → Detect via:
  - `GEMINI.md` already exists
  - Google Cloud CLI with AI plugin?
  - **Action:** Create `AGENTS.md` + symlink from `GEMINI.md`

**Output Format:**
```bash
PLUGIN:claude
FILE_BASED_TIER1:cursor,continue
FILE_BASED_TIER2:copilot,gemini
```

### 2. Main Entry Point: para-init

Create `scripts/para-init` that:

1. **Detect tools** using `scripts/detect-tools.sh`
2. **Handle Claude Code** if detected:
   - Display plugin installation instructions
   - Provide GitHub repo link
   - Don't configure any files for Claude Code
3. **Configure file-based tools**:
   - If only one tool detected → Auto-configure without prompting
   - If multiple tools detected → Show selection menu
   - Create appropriate files based on selections
4. **Display results** with next steps per tool

### 3. Setup Scripts by Capability Tier

**Tier 1 Setup: `scripts/setup-tier1.sh`**
```bash
# For: Cursor, Continue.dev
# Creates:
# - AGENTS.md (single source of truth)
# - No symlinks needed (tools read AGENTS.md natively)
```

**Tier 2 Setup: `scripts/setup-tier2.sh`**
```bash
# For: GitHub Copilot, Gemini
# Creates:
# - AGENTS.md (single source of truth)
# - .github/copilot-instructions.md → ../AGENTS.md (symlink)
# - GEMINI.md → AGENTS.md (symlink)
```

### 4. AGENTS.md Template

Create master template at `templates/AGENTS.md` containing:
- Complete PARA-Programming methodology
- Five-step workflow (Plan → Review → Execute → Summarize → Archive)
- Context directory structure
- Decision tree (when to use PARA vs. not)
- MCP/preprocessing guidance
- File naming conventions

This becomes the single source of truth that all file-based tools share.

### 5. User Experience Flow

**Scenario 1: Claude Code User**
```bash
$ para-init
Detecting AI coding tools...
✓ Found: Claude Code

Claude Code uses a native plugin for PARA-Programming.

Install the plugin:
  https://github.com/brian-lai/para-programming-plugin

Or use Claude Code's plugin manager:
  /install brian-lai/para-programming-plugin

✅ After installation, restart Claude Code and you're ready!
```

**Scenario 2: Cursor User**
```bash
$ para-init
Detecting AI coding tools...
✓ Found: Cursor

Setting up PARA-Programming for Cursor...
  ✓ Created AGENTS.md
  ✓ Cursor will read AGENTS.md automatically

✅ Setup complete! Cursor is ready for PARA-Programming.

Tool Capabilities:
  • Full workflow support with slash commands
  • Multi-file editing
  • MCP preprocessing

Next steps:
  1. Restart Cursor to load configuration
  2. Try: /para:plan "your first task"
  3. See: AGENTS.md for complete methodology
```

**Scenario 3: Multiple Tools**
```bash
$ para-init
Detecting AI coding tools...
✓ Found: Claude Code
✓ Found: Cursor
✓ Found: GitHub Copilot

Setup recommendations:
  • Claude Code: Install native plugin (see below)
  • Cursor: Configure with AGENTS.md
  • GitHub Copilot: Configure with AGENTS.md (methodology only)

Configure Cursor and GitHub Copilot now? [Y/n] y

Setting up for: Cursor, GitHub Copilot
  ✓ Created AGENTS.md (shared by all tools)
  ✓ Cursor reads AGENTS.md directly
  ✓ Created .github/copilot-instructions.md → ../AGENTS.md (symlink)

✅ Setup complete!

Tool Capabilities:
  • Cursor: Full workflow with slash commands
  • GitHub Copilot: Methodology only (manual workflow)

For Claude Code, install the native plugin:
  https://github.com/brian-lai/para-programming-plugin

Next steps:
  1. Restart Cursor and reload VS Code
  2. In Cursor: Try /para:plan "your task"
  3. In Copilot: Follow methodology in AGENTS.md
```

**Scenario 4: Copilot Only (Tier 2)**
```bash
$ para-init
Detecting AI coding tools...
✓ Found: GitHub Copilot

Setting up PARA-Programming for GitHub Copilot...
  ✓ Created AGENTS.md
  ✓ Created .github/copilot-instructions.md → ../AGENTS.md (symlink)

✅ Setup complete!

⚠️  Note: GitHub Copilot supports PARA methodology but not slash commands.
    You'll follow the five-step workflow manually.

Tool Capabilities:
  • Read AGENTS.md for complete methodology
  • Single-file editing focus
  • Manual workflow orchestration (no /para:plan commands)

Next steps:
  1. Reload VS Code to load new instructions
  2. Read AGENTS.md to understand the workflow
  3. Create plans manually in context/plans/
```

### 6. Optional Override Flags

For power users who want explicit control:
```bash
para-init --tool=cursor          # Configure only Cursor
para-init --tools=cursor,copilot # Configure specific tools
para-init --all                  # Configure all detected tools
para-init --skip-claude          # Skip Claude Code plugin message
```

---

## Implementation Phases

This work should be broken into phases for easier review and testing.

### Phase 1: Detection & Core Logic
**Files to create/modify:**
- `scripts/detect-tools.sh` - Detection logic
- `scripts/para-init` - Main entry point (handles display and orchestration)
- Test detection on machines with various tool combinations

**Success criteria:**
- Detection correctly identifies all installed tools
- Plugin vs. file-based tools correctly categorized
- Detection output format is parseable

### Phase 2: File-Based Setup Scripts
**Files to create/modify:**
- `scripts/setup-tier1.sh` - Cursor, Continue.dev setup
- `scripts/setup-tier2.sh` - Copilot, Gemini setup
- `templates/AGENTS.md` - Master template (single source of truth)

**Success criteria:**
- Tier 1 creates AGENTS.md without symlinks
- Tier 2 creates AGENTS.md + proper symlinks
- Files have correct permissions
- Symlinks are relative paths (not absolute)

### Phase 3: User Experience & Display
**Files to create/modify:**
- Enhance `scripts/para-init` with:
  - Interactive selection menu for multiple tools
  - Clear status messages and progress indicators
  - Tool-specific "next steps" guidance
  - Capability explanations (without exposing "tiers")

**Success criteria:**
- Single-tool setup is seamless (no prompts)
- Multi-tool setup has clear selection UI
- Claude Code users get plugin instructions
- Users understand their tool's capabilities

### Phase 4: Documentation Updates
**Files to create/modify:**
- `README.md`:
  - Add "Quick Start" section featuring `para-init`
  - Add "Plugin vs. File-Based" distinction
  - Update tool compatibility table
- `MIGRATION.md`:
  - Update Claude Code migration path (point to plugin)
  - Clarify what can/can't be unified
  - Add realistic expectations section
- `tool-setup/` directory:
  - Update individual tool READMEs to mention `para-init`
  - Keep as reference but de-emphasize manual setup

**Success criteria:**
- README clearly explains `para-init` as primary setup method
- Claude Code plugin is prominently featured
- Tool-specific docs remain available as reference
- Migration guide sets realistic expectations

---

## Risks

1. **Detection may fail on some systems**
   - Mitigation: Provide manual override flags (`--tool=...`)
   - Fallback: Show instructions for manual setup

2. **Symlink creation may fail on Windows**
   - Mitigation: Detect OS, use different strategy on Windows
   - Alternative: Copy files instead of symlink (with warning about sync)

3. **Users may not understand why Claude Code is different**
   - Mitigation: Clear explanation in output about native plugin benefits
   - Documentation: FAQ explaining plugin vs. file-based approach

4. **Continue.dev detection may be unreliable**
   - Need to verify actual detection signals
   - May need to test with real Continue.dev installation

5. **Codex CLI still unverified**
   - Should NOT include in Tier 1 until verified
   - Document as "coming soon" if it truly supports AGENTS.md

---

## Data Sources

**Existing Files to Reference:**
- `AGENTS.md` (current root-level file) - 410 lines
- `claude/CLAUDE.md` - Global methodology file
- `cursor/README.md` - Cursor-specific setup instructions
- `copilot/README.md` - Copilot-specific setup instructions
- `continue/README.md` - Continue.dev setup (if exists)
- `tool-setup/*.md` - Individual tool setup guides

**Research Documents:**
- `context/data/2026-02-02-tool-comparison-matrix.md`
- `context/data/2026-02-02-tool-unification-findings.md`

**Templates Needed:**
- Master `AGENTS.md` template (combines methodology from all sources)

---

## MCP Tools

No MCP tools required for this implementation (pure bash scripting).

---

## Success Criteria

### Functional
- ✅ `para-init` detects all supported tools correctly
- ✅ Single-tool setup completes without user input (except Claude Code)
- ✅ Multi-tool setup presents clear selection menu
- ✅ Claude Code shows plugin installation instructions (no file setup)
- ✅ Tier 1 tools get AGENTS.md without symlinks
- ✅ Tier 2 tools get AGENTS.md + proper symlinks
- ✅ All symlinks use relative paths
- ✅ Works on macOS and Linux (Windows symlinks handled gracefully)

### User Experience
- ✅ Users never think about "tiers"
- ✅ Output clearly explains each tool's capabilities
- ✅ Next steps are specific to selected tools
- ✅ Error messages are actionable
- ✅ Manual override flags work for power users

### Documentation
- ✅ README features `para-init` as primary setup method
- ✅ Claude Code plugin prominently linked
- ✅ Migration guide sets realistic expectations
- ✅ Tool-specific docs remain as reference

### Code Quality
- ✅ Detection logic is robust and testable
- ✅ Scripts are POSIX-compliant (or clearly document bash requirement)
- ✅ Error handling for all failure modes
- ✅ Idempotent (safe to run multiple times)

---

## Review Checklist

Before implementation:
- [ ] Verify Continue.dev detection approach
- [ ] Decide on Codex CLI inclusion (pending verification)
- [ ] Confirm Gemini detection strategy
- [ ] Review template AGENTS.md content
- [ ] Confirm Windows symlink handling strategy
- [ ] Review phased approach (is breakdown appropriate?)

After implementation:
- [ ] Test on machine with Claude Code only
- [ ] Test on machine with Cursor only
- [ ] Test on machine with multiple tools
- [ ] Test on machine with no tools (error handling)
- [ ] Test manual override flags
- [ ] Test idempotence (run twice, verify no errors)
- [ ] Test symlink creation (verify relative paths)
- [ ] Review all user-facing messages for clarity

---

## Notes

**Key Design Decisions:**

1. **Claude Code is special** - Plugin-based setup is fundamentally different from file-based. Don't try to unify.

2. **Tiers are invisible to users** - Implementation detail. Users see "Full support" vs. "Methodology only" if we need to communicate capabilities.

3. **AGENTS.md is single source** - All file-based tools share one file. Symlinks for tools that need different filenames.

4. **Detection over configuration** - Prefer smart defaults. Advanced users can override.

5. **Phased execution recommended** - This touches core setup experience. Benefit from incremental review.

**Open Questions:**

1. Should we verify Codex CLI AGENTS.md support before including in Tier 1?
   - **Recommendation:** Yes, defer until verified

2. What's the best way to detect Continue.dev reliably?
   - **Recommendation:** Research actual Continue.dev installation artifacts

3. Should we support Windows natively or document limitations?
   - **Recommendation:** Detect Windows, warn about symlinks, offer copy alternative

4. Should Gemini stay in Tier 2 given under-developed documentation?
   - **Recommendation:** Yes, but mark as "experimental" until docs improve

---

**Next Steps After Approval:**

1. Choose execution approach:
   - Phased (recommended): Execute Phase 1, get feedback, iterate
   - All-at-once: Execute entire plan in one session

2. Verify open questions above

3. Begin Phase 1: Detection logic implementation
