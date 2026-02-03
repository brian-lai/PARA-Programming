# Tool Comparison Matrix

**Research Date:** 2026-02-02
**Purpose:** Compare control models of all PARA-Programming supported tools

---

## Summary Table

| Tool | Primary Instruction File | Skill/Command System | Native AGENTS.md | Multi-File Editing | MCP/Preprocessing | Unified Setup Feasibility |
|------|-------------------------|---------------------|------------------|-------------------|-------------------|--------------------------|
| **Claude Code** | `CLAUDE.md` (global + local) | ✅ Skills (/para:plan, etc.) | ⚠️ Via symlink | ✅ Yes | ✅ MCP Native | **HIGH** |
| **Cursor** | `AGENTS.md` (native), `.cursorrules` (deprecated) | ⚠️ Slash commands in rules | ✅ Yes (native) | ✅ Composer mode | ✅ MCP support | **HIGH** |
| **Codex CLI** | `AGENTS.md` (claimed native) | ❓ Unknown | ✅ Yes (claimed) | ✅ Yes | ⚠️ Manual preprocessing | **HIGH** |
| **GitHub Copilot** | `.github/copilot-instructions.md` | ❌ No skill system | ⚠️ Via symlink only | ❌ No | ❌ No | **MEDIUM** |
| **Gemini** | `GEMINI.md` | ❓ Unknown | ⚠️ Via symlink | ❓ Unknown | ❓ Unknown | **MEDIUM** |
| **Other AI Assistants** | `AGENT-INSTRUCTIONS.md` (universal) | Varies by tool | ⚠️ Manual copy/paste | Varies | ❌ Usually no | **LOW** (diverse group) |

**Legend:**
- ✅ Full native support
- ⚠️ Partial support or requires configuration
- ❌ Not supported
- ❓ Insufficient information (needs verification)

---

## Detailed Analysis by Tool

### 1. Claude Code

**Documentation Reviewed:**
- `claude/README.md` (595 lines)
- `claude/CLAUDE.md` (623 lines)
- `tool-setup/claude-code.md`

**Control Model:**
- **Primary File:** `CLAUDE.md` (both global `~/.claude/CLAUDE.md` and project-level)
- **Two-file system:** Global methodology + local project context
- **AGENTS.md Support:** Can use symlink (`ln -s AGENTS.md CLAUDE.md`)

**Skill/Command System:**
- ✅ **Native skills package:** `/para:init`, `/para:plan`, `/para:execute`, `/para:summarize`, `/para:archive`, `/para:help`
- ✅ Skills are defined separately from CLAUDE.md
- ✅ User invokes via slash commands

**Multi-File Capabilities:**
- ✅ Can edit multiple files in one operation
- ✅ Designed for complex multi-file refactoring

**MCP/Preprocessing:**
- ✅ **Native MCP support** - Model Context Protocol is a first-class feature
- ✅ Tools defined in `context/servers/`
- ✅ Preprocessing happens outside LLM, returns compact summaries

**Unified Setup Feasibility: HIGH**

**Rationale:**
- Can use AGENTS.md via symlink
- Already has skill system (commands separate from methodology file)
- Excellent candidate for unified approach
- **Key requirement:** Symlink AGENTS.md → CLAUDE.md

---

### 2. Cursor

**Documentation Reviewed:**
- `cursor/README.md` (1282 lines)
- `cursor/cursorrules` (if exists in templates)
- `tool-setup/cursor.md`

**Control Model:**
- **Primary File:** `AGENTS.md` (native support) OR `.cursorrules` (deprecated)
- **AGENTS.md Support:** ✅ Native - Cursor reads AGENTS.md directly
- **Migration path:** `.cursorrules` is being phased out in favor of `AGENTS.md`

**Skill/Command System:**
- ⚠️ **Slash commands via `.cursorrules`** - Can define custom commands in the rules file
- ⚠️ Not a formal "skill" system like Claude Code
- ⚠️ Commands are embedded in the instruction file, not separate

**Multi-File Capabilities:**
- ✅ **Composer Mode (CMD+I)** - Multi-file editing is a core feature
- ✅ Can modify 10+ files simultaneously
- ✅ Shows diffs across all files

**MCP/Preprocessing:**
- ✅ **MCP support** - Full Model Context Protocol integration
- ✅ Can use tools in `context/servers/`
- ✅ Similar to Claude Code's preprocessing capabilities

**Unified Setup Feasibility: HIGH**

**Rationale:**
- **NATIVE AGENTS.md support** - No symlink needed
- Can define commands within AGENTS.md (as slash command patterns)
- Excellent multi-file and MCP support
- Already aligned with unified approach
- **Key advantage:** Reads AGENTS.md without any setup

---

### 3. Codex CLI (OpenAI)

**Documentation Reviewed:**
- `codex/README.md` (768 lines)
- `codex/AGENTS.md` (in codex/ directory, template for global)
- `tool-setup/codex.md`

**Control Model:**
- **Primary File:** `AGENTS.md` (claimed native support)
- **Two-file system:** Global `~/.codex/AGENTS.md` + project-level `AGENTS.md`
- **AGENTS.md Support:** ✅ Documentation claims native support

**Skill/Command System:**
- ❓ **Unknown** - Documentation doesn't mention a skill/command system
- Likely requires explicit prompts: "Following PARA workflow: ..."
- May need reminders to follow methodology

**Multi-File Capabilities:**
- ✅ Documentation claims multi-file operations
- ✅ "Can work across multiple files simultaneously"

**MCP/Preprocessing:**
- ⚠️ **Manual preprocessing** - Not native MCP
- ⚠️ Documentation mentions preprocessing but via custom scripts
- ⚠️ Uses `context/servers/` but executes manually, not via MCP protocol

**Unified Setup Feasibility: HIGH**

**Rationale:**
- Claims native AGENTS.md support
- Already uses AGENTS.md naming convention
- **However:** Needs verification - documentation may be aspirational
- **Key concern:** No clear skill system like Claude Code
- **Key advantage:** Already aligned with AGENTS.md standard

---

### 4. GitHub Copilot

**Documentation Reviewed:**
- `copilot/README.md` (1371 lines)
- `copilot/copilot-instructions.md` (template for `.github/`)
- `tool-setup/copilot.md`

**Control Model:**
- **Primary File:** `.github/copilot-instructions.md`
- **AGENTS.md Support:** ⚠️ Only via symlink: `ln -s ../AGENTS.md .github/copilot-instructions.md`
- **Per-project only** - No global instruction file

**Skill/Command System:**
- ❌ **No skill system** - GitHub Copilot doesn't support custom commands
- ❌ No `/para:plan` or similar
- ⚠️ Can define "when user types X, do Y" patterns in instructions, but not true commands

**Multi-File Capabilities:**
- ❌ **Single-file focus** - Copilot works best one file at a time
- ❌ No Composer-like feature
- ⚠️ Chat mode can suggest multi-file changes but can't apply them

**MCP/Preprocessing:**
- ❌ **No MCP support**
- ❌ No preprocessing capabilities
- ⚠️ Can use `@workspace` to load context, but loads everything (not selective)

**Unified Setup Feasibility: MEDIUM**

**Rationale:**
- Can use AGENTS.md via symlink to `.github/copilot-instructions.md`
- **Major limitation:** No skill system means commands can't be shared
- **Major limitation:** Single-file focus differs from other tools
- **Key requirement:** Symlink + accept different workflow (file-by-file)
- **Conclusion:** Can share METHODOLOGY via AGENTS.md, but not COMMANDS

---

### 5. Gemini

**Documentation Reviewed:**
- `gemini/README.md` (46 lines)
- `gemini/GEMINI.md` (185 lines - project-specific)
- No global GEMINI.md template found

**Control Model:**
- **Primary File:** `GEMINI.md` (global `~/.gemini/GEMINI.md` + project-level)
- **AGENTS.md Support:** ⚠️ Via symlink likely possible
- **Setup:** Documentation mentions `make setup-gemini` and `para-init-gemini`

**Skill/Command System:**
- ❓ **Unknown** - Documentation doesn't describe commands
- README mentions "para-init-gemini" command but unclear if that's Gemini-native or a shell script

**Multi-File Capabilities:**
- ❓ **Unknown** - Not documented

**MCP/Preprocessing:**
- ❓ **Unknown** - Not documented

**Unified Setup Feasibility: MEDIUM**

**Rationale:**
- Documentation is minimal (README only 46 lines)
- Can likely use AGENTS.md via symlink
- **Major gap:** Insufficient information about capabilities
- **Key concern:** Tool seems under-documented compared to others
- **Recommendation:** Needs further investigation OR defer unification until Gemini support matures

---

### 6. Other AI Assistants (Universal Category)

**Documentation Reviewed:**
- `other-ai-assistants/AGENT-INSTRUCTIONS.md` (978 lines)
- This is a catch-all for: JetBrains AI, Continue.dev, Codeium, CodeWhisperer, Tabnine, etc.

**Control Model:**
- **Primary File:** `AGENT-INSTRUCTIONS.md` (universal template)
- **Per-tool adaptation:** Each tool has different config locations
- **AGENTS.md Support:** ⚠️ Varies - some tools auto-discover, others need manual copy

**Skill/Command System:**
- **Varies by tool:**
  - Continue.dev: ✅ Supports custom slash commands
  - JetBrains AI: ⚠️ Limited command support
  - Codeium: ❌ No custom commands
  - Tabnine: ❌ Autocomplete-focused, no commands

**Multi-File Capabilities:**
- **Varies by tool:**
  - Continue.dev: ✅ Multi-file edits
  - JetBrains AI: ⚠️ Limited multi-file
  - Others: ❌ Mostly single-file

**MCP/Preprocessing:**
- **Varies by tool:**
  - Continue.dev: ✅ Native MCP support
  - Others: ❌ Usually no MCP

**Unified Setup Feasibility: LOW**

**Rationale:**
- **Too diverse** - Each tool has different capabilities
- **No common skill system** - Can't share commands across this group
- **Different control models** - Some use config files, some use chat instructions
- **Recommendation:** Keep as separate category with universal instructions
- **Approach:** Provide AGENT-INSTRUCTIONS.md as a template, users adapt per tool

---

## Control Model Groups

Based on research, tools fall into these groups:

### Group A: Unified AGENTS.md + Skills
**Tools:** Claude Code, Cursor, Codex CLI

**Shared Characteristics:**
- All support (or claim to support) AGENTS.md natively or via symlink
- All have multi-file editing capabilities
- All support or could support skill/command patterns
- All have or could have preprocessing/MCP support

**Unified Setup Approach:**
1. Single root-level `AGENTS.md` file
2. Symlinks for tools that need specific filenames:
   - Claude Code: `ln -s AGENTS.md CLAUDE.md`
   - Codex CLI: Already reads AGENTS.md
   - Cursor: Already reads AGENTS.md
3. Shared skill definitions (where applicable)
4. Single setup command creates all symlinks

**Example Setup:**
```bash
# para-init-unified
cp templates/AGENTS.md ./AGENTS.md
ln -s AGENTS.md CLAUDE.md
# Cursor and Codex read AGENTS.md directly, no symlink needed
```

---

### Group B: AGENTS.md via Symlink Only (No Shared Skills)
**Tools:** GitHub Copilot, Gemini

**Shared Characteristics:**
- Can use AGENTS.md methodology via symlink
- **Cannot** share skill/command system (lack native skill support)
- Workflow is file-by-file or chat-based
- Limited or no MCP support

**Setup Approach:**
1. Share METHODOLOGY via AGENTS.md symlink
2. Accept that commands won't work (no skill system)
3. Separate setup instructions for each

**Example Setup:**
```bash
# Copilot
mkdir -p .github
ln -s ../AGENTS.md .github/copilot-instructions.md

# Gemini
ln -s AGENTS.md GEMINI.md
```

**Note:** These tools get the PARA methodology but can't use `/para:plan` style commands.

---

### Group C: Diverse Tools (Manual Adaptation)
**Tools:** Other AI Assistants (JetBrains, Continue.dev, Codeium, etc.)

**Approach:**
- Provide universal `AGENT-INSTRUCTIONS.md` template
- Users adapt per their specific tool
- No automated unified setup (too diverse)
- Documentation guides per-tool adaptation

**Recommendation:** Keep existing `other-ai-assistants/` directory as-is.

---

## Key Findings

### Finding 1: AGENTS.md is Becoming a Standard
- **Cursor** and **Codex CLI** natively read `AGENTS.md`
- **Claude Code** can use it via symlink
- This is the emerging standard filename

### Finding 2: Skill Systems Differ Fundamentally
- **Claude Code**: Separate skill package, formal `/command` system
- **Cursor**: Inline commands via rules file
- **Codex CLI**: Unknown (needs verification)
- **Copilot, Gemini, Others**: No formal skill system

### Finding 3: Three-Tier Capability Model
1. **Full PARA** (Claude, Cursor, Codex): Methodology + Multi-file + Skills/Commands
2. **PARA Methodology Only** (Copilot, Gemini): Can follow workflow but not via commands
3. **PARA with Adaptation** (Others): Require per-tool customization

### Finding 4: MCP Support is Limited
- Only **Claude Code** and **Cursor** have native MCP
- **Codex CLI** has manual preprocessing (not MCP protocol)
- Others lack preprocessing entirely

### Finding 5: Current Migration Guide is Misleading
The existing `MIGRATION.md` claims:
- "Single source of truth" via AGENTS.md
- "Cross-tool consistency"

**Reality:**
- AGENTS.md works for **methodology** (the workflow steps)
- AGENTS.md does **NOT** work for **skills/commands** (different implementations)
- Some tools (Copilot) can't execute commands at all

---

## Recommendations

### Recommendation 1: Create Two Tiers
**Tier 1: Unified AGENTS.md + Skill Support**
- Tools: Claude Code, Cursor, (Codex CLI if verified)
- Single setup script
- Shared AGENTS.md
- Skill/command layer (where each tool implements commands differently but they're defined in one place)

**Tier 2: AGENTS.md Methodology Only**
- Tools: Copilot, Gemini
- Share methodology via symlink
- No skill/command support
- Accept file-by-file workflow

### Recommendation 2: Verify Codex CLI Claims
Before including Codex in Tier 1:
- Test actual AGENTS.md support (not just documentation claims)
- Verify command/skill capabilities
- Test MCP/preprocessing claims

### Recommendation 3: Update MIGRATION.md
Current migration guide over-promises:
- Clarify that skills/commands are NOT unified
- Explain the difference between methodology sharing and command sharing
- Set realistic expectations

### Recommendation 4: Keep "Other AI Assistants" Separate
The diversity is too great:
- JetBrains, Continue.dev, Codeium, Tabnine are all different
- No unified setup is realistic
- Current approach (universal template + per-tool adaptation) is best

---

## Next Steps

After this research is approved:

1. **Create Tier 1 Unified Setup** (Claude + Cursor + possibly Codex)
   - Single AGENTS.md file
   - Automated symlink creation
   - Shared skill definitions (but separate implementations)

2. **Create Tier 2 Methodology Setup** (Copilot + Gemini)
   - AGENTS.md via symlink
   - No skill support
   - Adjusted documentation

3. **Update Documentation**
   - Revise MIGRATION.md with realistic expectations
   - Update README with tier structure
   - Create setup guides per tier

4. **Test Unified Setup**
   - Verify AGENTS.md works across Tier 1 tools
   - Confirm symlinks work on Windows/Mac/Linux
   - Test with actual projects

---

**End of Comparison Matrix**
