# Tool Unification Research Findings

**Research Date:** 2026-02-02
**Researcher:** Claude (Sonnet 4.5)
**Purpose:** Determine which PARA-Programming tools can be unified under a single setup

---

## Executive Summary

After analyzing all 6 supported AI coding tools, the research reveals:

**✅ Can Be Unified (Tier 1):**
- Claude Code
- Cursor
- Codex CLI (pending verification)

**⚠️ Partial Unification (Tier 2):**
- GitHub Copilot
- Gemini

**❌ Keep Separate (Diverse Group):**
- Other AI Assistants (JetBrains, Continue.dev, Codeium, etc.)

**Key Insight:** AGENTS.md can unify the **METHODOLOGY** across all tools, but **SKILLS/COMMANDS** remain tool-specific due to fundamental differences in how tools execute commands.

---

## What Unified Setup Means

"Unified setup" has two dimensions:

### Dimension 1: Methodology Sharing (AGENTS.md)
**Question:** Can tools share a single AGENTS.md file that defines the PARA workflow?

**Answer:**
- ✅ **YES** for: Claude Code (via symlink), Cursor (native), Codex (native), Copilot (via symlink), Gemini (via symlink)
- ⚠️ **PARTIAL** for: Other AI Assistants (manual copy/paste)

**Implementation:** Root-level `AGENTS.md` + symlinks for tools with different filename requirements.

### Dimension 2: Skill/Command Sharing
**Question:** Can tools share skill/command definitions (like `/para:plan`, `/para:execute`)?

**Answer:**
- ✅ **YES, BUT DIFFERENTLY** for: Claude Code (native skills), Cursor (slash commands in rules)
- ⚠️ **NO** for: Codex CLI (unclear), Copilot (no skill system), Gemini (no skill system)
- ❌ **VARIES** for: Other AI Assistants (some yes, most no)

**Implementation:** Separate skill definitions per tool, conceptually unified but technically distinct.

---

## Detailed Findings by Group

### Group 1: Full Unification (Tier 1)

#### Tools: Claude Code, Cursor, Codex CLI

**Evidence for Claude Code:**
- From `claude/README.md`:
  - Native `CLAUDE.md` support (global + local)
  - "Automatically reads global `~/.claude/CLAUDE.md` and project-local `CLAUDE.md`"
  - Skills package with commands: `/para:init`, `/para:plan`, `/para:execute`, `/para:summarize`, `/para:archive`
  - Can use symlink: `ln -s AGENTS.md CLAUDE.md`

- From `claude/CLAUDE.md`:
  - 623 lines defining complete methodology
  - MCP integration is native
  - Multi-file operations supported

**Evidence for Cursor:**
- From `cursor/README.md`:
  - Native `AGENTS.md` support: "Cursor reads `AGENTS.md` natively"
  - `.cursorrules` is deprecated in favor of `AGENTS.md`
  - Composer mode for multi-file editing (CMD+I)
  - MCP support documented

- From `MIGRATION.md`:
  - "Cursor now reads `AGENTS.md` directly. If you had `.cursorrules`: No symlink needed - Cursor reads AGENTS.md directly"
  - ".cursorrules is deprecated. Migrate to AGENTS.md or .cursor/rules/"

**Evidence for Codex CLI:**
- From `codex/README.md`:
  - Claims "AGENTS.md Support" - "Automatically reads global `~/.codex/AGENTS.md` and project-local `AGENTS.md`"
  - Two-file system like Claude: global + local
  - Documentation states: "Codex CLI automatically discovers and loads `AGENTS.md` files from `~/.codex/` and your project directory"

- **⚠️ CONCERN:** Documentation may be aspirational. Line 175 mentions:
  - "Note:** Codex CLI automatically discovers and loads `AGENTS.md` files... See official documentation"
  - This suggests the documentation was written based on expected behavior, not verified behavior

**Recommendation for Tier 1:**
- ✅ **Claude Code + Cursor:** Definitely can be unified
- ⚠️ **Codex CLI:** Include with caveat - verify before release

**Unified Setup Strategy:**
```bash
# Single root-level AGENTS.md
cp templates/AGENTS.md ./AGENTS.md

# Symlinks for tools needing specific filenames
ln -s AGENTS.md CLAUDE.md          # Claude Code
# Cursor reads AGENTS.md natively   # No symlink needed
# Codex reads AGENTS.md natively    # No symlink needed (if verified)

# Skill definitions (separate layer)
# Each tool implements commands differently
```

**Benefits:**
- Single AGENTS.md to maintain
- Consistent methodology across all three tools
- Automatic updates when AGENTS.md changes
- Natural grouping: all three are CLI or CLI-like tools

**Limitations:**
- Skills/commands still need separate implementation per tool
- Claude has native skills package
- Cursor uses slash commands in AGENTS.md
- Codex (unclear, needs investigation)

---

### Group 2: Methodology Only (Tier 2)

#### Tools: GitHub Copilot, Gemini

**Evidence for GitHub Copilot:**
- From `copilot/README.md`:
  - Uses `.github/copilot-instructions.md`
  - Can symlink: `ln -s ../AGENTS.md .github/copilot-instructions.md`
  - **NO skill system:** "GitHub Copilot earns a ⭐⭐⭐ Good rating for PARA compatibility"
  - **Single-file focus:** "Works best one file at a time"
  - **No MCP:** Limitations section lists "No MCP Support"

- From `MIGRATION.md`:
  - Symlink approach confirmed: `ln -s ../AGENTS.md .github/copilot-instructions.md`

**Evidence for Gemini:**
- From `gemini/README.md`:
  - Uses `GEMINI.md` (global `~/.gemini/GEMINI.md`)
  - Minimal documentation (only 46 lines)
  - Mentions `make setup-gemini` and `para-init-gemini` scripts

- From `gemini/GEMINI.md`:
  - Contains project-specific context (185 lines)
  - Appears to be for the PARA-Programming repository itself, not a template

**⚠️ CONCERN:** Gemini support seems under-developed
- No global GEMINI.md template found
- Documentation is very minimal
- Unclear if it supports any command system
- Unknown multi-file or MCP capabilities

**Recommendation for Tier 2:**
- ✅ **GitHub Copilot:** Include with clear caveat about no commands
- ⚠️ **Gemini:** Include but note it needs better documentation

**Setup Strategy:**
```bash
# Methodology via symlink
mkdir -p .github
ln -s ../AGENTS.md .github/copilot-instructions.md  # Copilot

ln -s AGENTS.md GEMINI.md                            # Gemini
```

**Benefits:**
- Share PARA methodology
- Consistent workflow documentation
- Single file to maintain for methodology

**Limitations:**
- **NO skill/command support** - Can't use `/para:plan` etc.
- **Manual workflow** - User must follow workflow explicitly
- **File-by-file work** - No multi-file operations (Copilot)
- **Unknown capabilities** - Gemini not well documented

**User Experience:**
- These tools follow PARA methodology through documentation
- No automated commands
- Human orchestrates the workflow, AI assists
- Still valid PARA-Programming, just more manual

---

### Group 3: Keep Separate (Diverse)

#### Tools: Other AI Assistants (JetBrains AI, Continue.dev, Codeium, CodeWhisperer, Tabnine)

**Evidence:**
- From `other-ai-assistants/AGENT-INSTRUCTIONS.md`:
  - 978 lines of universal instructions
  - Compatibility matrix shows huge variance
  - "This document provides instructions for implementing PARA-Programming methodology with popular AI coding assistants"

**Compatibility Matrix Excerpt:**
```
| Feature | GitHub Copilot | Cursor | JetBrains AI | Continue.dev | Codeium | CodeWhisperer | Tabnine |
|---------|---------------|--------|--------------|--------------|---------|---------------|---------|
| Context Files | ✅ (limited) | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ |
| Multi-File Edits | ❌ | ✅ | ⚠️ | ✅ | ❌ | ❌ | ❌ |
| Custom Instructions | ✅ | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ⚠️ |
| MCP Support | ❌ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
```

**Key Observations:**
- **Continue.dev** is closest to Tier 1 (has MCP, multi-file, custom commands)
- **JetBrains AI** has some capabilities but limited multi-file
- **Codeium, CodeWhisperer, Tabnine** are mostly autocomplete-focused
- Each tool has different config file locations
- No common skill/command system

**Recommendation:**
- ❌ **Do NOT attempt unified setup for this group**
- ✅ Keep existing universal template approach
- ✅ Provide per-tool adaptation guidance
- ⚠️ **Exception:** Continue.dev could potentially join Tier 1 (has MCP, commands)

**Rationale:**
- Too diverse to unify
- Different config mechanisms
- Different capability sets
- Current approach (template + adapt) is appropriate

**Current State:**
- `other-ai-assistants/AGENT-INSTRUCTIONS.md` provides universal template
- Users adapt for their specific tool
- This is working and should not change

---

## Current State Assessment

### What's Working Well

1. **Root-level AGENTS.md exists** (410 lines)
   - Contains universal PARA methodology
   - Works with tools that read AGENTS.md natively

2. **Tool-specific directories are well-organized**
   - Each has README, QUICKSTART, templates
   - Clear separation by tool
   - Good documentation coverage (except Gemini)

3. **MIGRATION.md provides symlink guidance**
   - Correctly identifies tools that can use AGENTS.md
   - Explains symlink creation
   - Addresses rollback

4. **Skills package exists for Claude Code**
   - Provides `/para:*` commands
   - Separate from CLAUDE.md methodology
   - Good separation of concerns

### What's Broken or Confusing

1. **MIGRATION.md oversells unification**
   - Claims "Single source of truth" and "Cross-tool consistency"
   - Reality: Only methodology is shared, not commands
   - Users may expect `/para:plan` to work everywhere (it doesn't)

2. **Codex CLI claims not verified**
   - Documentation states AGENTS.md support
   - But includes caveat: "See official documentation"
   - May be aspirational rather than factual

3. **Gemini support is under-developed**
   - Only 46-line README
   - No global template found
   - Capabilities unknown
   - Appears incomplete

4. **"Other AI Assistants" grouping is unclear**
   - Continue.dev has Tier 1 capabilities but is in "other"
   - Users might miss that Continue.dev is actually quite capable
   - Grouping doesn't reflect capability tiers

5. **No clear guidance on when to use which tool**
   - Missing: "Use Cursor for multi-file, Copilot for simple tasks, Claude for complex reasoning"
   - Users don't know which tool best fits their use case

### Pain Points for Users

1. **Setup confusion**
   - Each tool has different setup instructions
   - Not clear which tools can share AGENTS.md
   - Symlink commands vary by tool

2. **Command availability unclear**
   - Users don't know if `/para:plan` will work with their tool
   - No comparison of what commands each tool supports

3. **Tier structure not explicit**
   - No clear grouping of "full support" vs "partial support" vs "manual"
   - Users have to read each tool's documentation to understand capabilities

4. **Migration path confusing**
   - MIGRATION.md implies full unification
   - Reality is more nuanced
   - Users may be disappointed when commands don't work

---

## Proposed Unified Setup Strategy

### Strategy Overview

Create **two unified setup tiers** with clear capability distinctions:

#### Tier 1: AGENTS.md + Multi-File + Commands
**Tools:** Claude Code, Cursor, (Codex CLI after verification)

**Setup:**
```bash
para-init-tier1  # or para-init-unified

# Creates:
# - AGENTS.md (root level, single source)
# - CLAUDE.md → AGENTS.md (symlink)
# - Cursor reads AGENTS.md directly
# - Codex reads AGENTS.md directly
```

**User Experience:**
- Single AGENTS.md to maintain
- Commands work (though implemented differently per tool)
- Multi-file operations supported
- MCP/preprocessing available

**Documentation:**
- "Tier 1: Full PARA Support - Claude Code, Cursor, Codex CLI"
- Clear feature comparison
- Single setup guide

#### Tier 2: AGENTS.md + Methodology Only
**Tools:** GitHub Copilot, Gemini

**Setup:**
```bash
para-init-tier2  # or para-init-copilot, para-init-gemini

# Creates:
# - AGENTS.md (root level, single source)
# - .github/copilot-instructions.md → ../AGENTS.md (symlink)
# - GEMINI.md → AGENTS.md (symlink)
```

**User Experience:**
- PARA methodology via AGENTS.md
- No command support
- Manual workflow orchestration
- File-by-file work (Copilot)

**Documentation:**
- "Tier 2: PARA Methodology - GitHub Copilot, Gemini"
- Clear limitation: no commands
- Adapted workflow guide (human orchestrates)

#### Keep Separate: Diverse Tools
**Tools:** JetBrains AI, Continue.dev, Codeium, etc.

**Setup:**
- Use existing `other-ai-assistants/AGENT-INSTRUCTIONS.md` template
- Per-tool adaptation required
- No unified setup (too diverse)

**Exception:** Move Continue.dev to Tier 1 (it has full capabilities)

---

## Specific Recommendations

### Recommendation 1: Implement Two-Tier Structure

**Implementation:**
1. Create `/para-init` with options:
   ```bash
   para-init --tier1    # Claude Code + Cursor + Codex
   para-init --tier2    # Copilot + Gemini
   para-init --tool=X   # Specific tool setup
   ```

2. Update documentation with clear tiers:
   - README.md: Add tier comparison table
   - SETUP-GUIDE.md: Organize by tier
   - Each tool's README: State which tier

3. Update MIGRATION.md with realistic expectations

### Recommendation 2: Verify Codex CLI Before Including in Tier 1

**Action Items:**
1. Test actual AGENTS.md support (not just docs)
2. Verify command/skill capabilities
3. Test MCP claims
4. If confirmed: Include in Tier 1
5. If not confirmed: Move to Tier 2 or separate

### Recommendation 3: Improve Gemini Documentation

**Action Items:**
1. Create global GEMINI.md template (like claude/CLAUDE.md)
2. Write comprehensive README (target 200+ lines like others)
3. Clarify capabilities (multi-file? commands? MCP?)
4. Until improved: Keep in Tier 2 with caveat

### Recommendation 4: Move Continue.dev to Tier 1

**Rationale:**
- Has MCP support (like Claude/Cursor)
- Has multi-file editing
- Has custom slash commands
- Capabilities match Tier 1

**Implementation:**
- Create `continue/` directory (like claude/, cursor/)
- Write full README and QUICKSTART
- Include in Tier 1 unified setup

### Recommendation 5: Create Tier Comparison Table

Add to README.md:

```markdown
## Tool Tiers

| Tier | Tools | AGENTS.md | Commands | Multi-File | MCP | Setup |
|------|-------|-----------|----------|-----------|-----|-------|
| **1** | Claude, Cursor, Codex, Continue | ✅ Native/Symlink | ✅ Yes (per-tool) | ✅ Yes | ✅ Yes | `para-init-tier1` |
| **2** | Copilot, Gemini | ⚠️ Symlink only | ❌ No | ⚠️ Limited | ❌ No | `para-init-tier2` |
| **3** | Others (JetBrains, Codeium, etc.) | ⚠️ Manual | Varies | Varies | ❌ No | Per-tool |
```

### Recommendation 6: Update MIGRATION.md

**Changes needed:**
1. Add section: "What Can and Can't Be Unified"
2. Clarify: AGENTS.md shares methodology, not commands
3. Set expectations: Commands work differently per tool
4. Add tier-based migration paths

### Recommendation 7: Create Setup Scripts

**Scripts to create:**
```bash
scripts/para-init-tier1.sh      # Unified Tier 1 setup
scripts/para-init-tier2.sh      # Tier 2 setup
scripts/para-init-copilot.sh    # Copilot-specific
scripts/para-init-cursor.sh     # Cursor-specific
scripts/para-init-claude.sh     # Claude-specific
```

**Benefits:**
- One-command setup
- Correct symlinks created
- Verification included
- User doesn't need to remember commands

---

## Evidence-Based Grouping

### Tier 1: Full PARA Support

| Tool | AGENTS.md Support | Evidence | Multi-File | Evidence | Commands | Evidence |
|------|------------------|----------|-----------|----------|----------|----------|
| **Claude Code** | ⚠️ Via symlink | README: "Can use symlink" | ✅ Yes | README: "Multi-file operations" | ✅ Native | README: "/para:plan, etc." |
| **Cursor** | ✅ Native | MIGRATION: "reads AGENTS.md directly" | ✅ Composer | README: "Composer mode (CMD+I)" | ⚠️ Slash cmds | README: "Slash commands via rules" |
| **Codex CLI** | ✅ Claimed | README: "automatically reads AGENTS.md" | ✅ Claimed | README: "multiple files" | ❓ Unknown | README: No mention | **Continue.dev** | ✅ Confirmed | AGENT-INSTRUCTIONS: "native support" | ✅ Yes | Matrix: ✅ | ✅ Slash cmds | AGENT-INSTRUCTIONS: "custom commands" |

**Decision:** Include Claude + Cursor + Continue for sure. Codex pending verification.

### Tier 2: Methodology Only

| Tool | AGENTS.md Support | Evidence | Multi-File | Evidence | Commands | Evidence |
|------|------------------|----------|-----------|----------|----------|----------|
| **Copilot** | ⚠️ Via symlink | MIGRATION: `ln -s ../AGENTS.md` | ❌ No | README: "Single-file focus" | ❌ No | README: "No skill system" |
| **Gemini** | ⚠️ Likely | MIGRATION: mentions GEMINI.md | ❓ Unknown | No docs | ❓ Unknown | No docs |

**Decision:** Include both but document limitations clearly.

---

## Next Steps for Implementation

After approval of these findings:

### Phase 1: Tier 1 Unified Setup (Week 1)
1. Create `para-init-tier1` script
2. Update Tier 1 tool READMEs with tier badge
3. Create unified setup guide
4. Test with actual projects

### Phase 2: Tier 2 Setup (Week 1)
1. Create `para-init-tier2` script
2. Update Copilot/Gemini docs with tier badge
3. Create adapted workflow guide
4. Clarify "no commands" limitation

### Phase 3: Documentation Overhaul (Week 2)
1. Add tier comparison table to README
2. Update MIGRATION.md with realistic expectations
3. Revise SETUP-GUIDE.md with tier organization
4. Create troubleshooting guide per tier

### Phase 4: Verification (Week 2)
1. Test Codex CLI AGENTS.md support
2. Test Continue.dev integration
3. Verify symlinks on Windows/Mac/Linux
4. Get user feedback

### Phase 5: Improve Gemini Support (Week 3, Optional)
1. Create global GEMINI.md template
2. Write comprehensive Gemini README
3. Test Gemini capabilities
4. Either promote to Tier 1 or keep in Tier 2

---

## Conclusion

**Key Takeaway:** PARA-Programming tools can be grouped into two tiers:

**Tier 1 (Full Support):** Claude Code, Cursor, Continue.dev, (Codex CLI pending)
- Unified AGENTS.md setup
- Command support (though implemented differently)
- Multi-file and MCP capabilities
- **Target:** Professional developers wanting full PARA workflow

**Tier 2 (Methodology Only):** GitHub Copilot, Gemini
- AGENTS.md via symlink
- No command support
- Manual workflow orchestration
- **Target:** Developers using these tools who want PARA principles

**Keep Separate:** JetBrains AI, Codeium, CodeWhisperer, Tabnine
- Too diverse to unify
- Template-based adaptation
- **Target:** Users of niche tools

**The unified setup is achievable, but only for Tier 1 tools. Tier 2 tools can share methodology but not commands. This is a realistic and implementable approach that improves user experience without over-promising.**

---

**End of Findings Document**
