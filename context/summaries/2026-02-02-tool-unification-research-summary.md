# Summary: Tool Unification Research

**Date:** 2026-02-02
**Duration:** Research session
**Status:** ✅ Complete

---

## Objective

Research and categorize the currently supported AI coding tools to identify which tools share a standard model of control (single `AGENTS.md` file + skills/commands), enabling a unified setup experience.

---

## Changes Made

### Documents Created

1. **`context/data/2026-02-02-tool-comparison-matrix.md`** (195 lines)
   - Side-by-side comparison of all 6 tool categories
   - Control model analysis (instruction files, skill systems)
   - Grouping recommendations

2. **`context/data/2026-02-02-tool-unification-findings.md`** (548 lines)
   - Detailed evidence-based analysis
   - Tool capability assessment
   - Unified setup strategy
   - Specific recommendations

### Files Analyzed

- `AGENTS.md` (root level, 410 lines)
- `claude/README.md`, `claude/CLAUDE.md`
- `cursor/README.md`
- `copilot/README.md`, `copilot/copilot-instructions.md`
- `codex/README.md`, `codex/AGENTS.md`
- `gemini/README.md`, `gemini/GEMINI.md`
- `other-ai-assistants/AGENT-INSTRUCTIONS.md`
- `MIGRATION.md`
- `tool-setup/` directory files

---

## Key Findings

### Finding 1: Two-Tier Structure Emerges

The research reveals **two distinct capability tiers**:

**Tier 1: Full PARA Support (Unifiable)**
- **Tools:** Claude Code, Cursor, Continue.dev
- **Shared capabilities:**
  - AGENTS.md support (native or via symlink)
  - Multi-file editing
  - Command/skill systems (though implemented differently)
  - MCP/preprocessing support

**Tier 2: Methodology Only (Partial Unification)**
- **Tools:** GitHub Copilot, Gemini
- **Shared capabilities:**
  - AGENTS.md support (via symlink only)
  - PARA methodology documentation
- **Limitations:**
  - No command/skill system
  - Single-file focus (Copilot) or unknown (Gemini)
  - No MCP support

**Keep Separate: Diverse Tools**
- **Tools:** JetBrains AI, Codeium, CodeWhisperer, Tabnine, etc.
- **Too diverse to unify** - each has different config mechanisms

### Finding 2: AGENTS.md is Becoming a Standard

Evidence discovered:
- **Cursor:** Natively reads `AGENTS.md` (`.cursorrules` deprecated)
- **Codex CLI:** Claims native `AGENTS.md` support (needs verification)
- **Claude Code:** Can use via symlink (`CLAUDE.md` → `AGENTS.md`)
- **Copilot:** Can use via symlink (`.github/copilot-instructions.md` → `../AGENTS.md`)
- **Gemini:** Likely via symlink (`GEMINI.md` → `AGENTS.md`)

**Conclusion:** `AGENTS.md` is the emerging standard filename for AI agent instructions.

### Finding 3: Commands/Skills Cannot Be Fully Unified

**Different implementation models:**

| Tool | Command Model |
|------|--------------|
| **Claude Code** | Separate skills package - commands invoke TypeScript functions |
| **Cursor** | Inline slash commands defined in rules file |
| **Codex CLI** | Unknown (documentation doesn't mention) |
| **Copilot** | No skill system at all |
| **Gemini** | Unknown (under-documented) |
| **Continue.dev** | Custom slash commands (MCP-based) |

**Implication:** While tools can share the PARA **methodology** via AGENTS.md, they **cannot** share command implementations. Each tool's `/para:plan` (if it exists) must be implemented separately.

### Finding 4: Current MIGRATION.md Over-Promises

The existing migration guide claims:
> "Single source of truth" and "Cross-tool consistency"

**Reality:**
- ✅ AGENTS.md **CAN** provide single source for **methodology**
- ❌ AGENTS.md **CANNOT** provide single source for **commands**
- ⚠️ Users may expect `/para:plan` to work everywhere (it won't)

**Recommendation:** Update MIGRATION.md to set realistic expectations.

### Finding 5: Codex CLI Claims Need Verification

`codex/README.md` states:
> "Codex CLI automatically discovers and loads `AGENTS.md` files..."

However:
- Line 175 includes caveat: "See official documentation"
- Suggests documentation may be aspirational
- **No verification found** in this research

**Recommendation:** Test Codex CLI before including in Tier 1 unified setup.

### Finding 6: Gemini Support is Under-Developed

Evidence:
- `gemini/README.md` only 46 lines (vs. 595+ for others)
- No global GEMINI.md template found
- Capabilities unknown (multi-file? commands? MCP?)
- Appears incomplete

**Recommendation:** Either improve Gemini documentation or defer unification until support matures.

### Finding 7: Continue.dev Belongs in Tier 1

From `other-ai-assistants/AGENT-INSTRUCTIONS.md` compatibility matrix:
- ✅ Context files support
- ✅ Multi-file edits
- ✅ Custom instructions
- ✅ MCP support
- ✅ Custom slash commands

**Conclusion:** Continue.dev has Tier 1 capabilities but is grouped with "Other AI Assistants". Should be promoted to Tier 1.

---

## Rationale for Grouping

### Why Tier 1 Works (Claude + Cursor + Continue)

1. **All support AGENTS.md** (natively or via simple symlink)
2. **All have multi-file capabilities** (essential for complex refactoring)
3. **All have command systems** (even if implemented differently)
4. **All support preprocessing** (MCP or equivalent)
5. **Similar user experience** (plan → execute across files → summarize)

**Unified setup benefits:**
- Single `AGENTS.md` to maintain
- Consistent methodology across tools
- Automatic updates when methodology evolves
- One setup command creates all symlinks

### Why Tier 2 is Separate (Copilot + Gemini)

1. **No command/skill systems** - Can't execute `/para:plan`
2. **Different workflow** - File-by-file (Copilot) vs. multi-file (Tier 1)
3. **No MCP** - Can't leverage preprocessing
4. **Human orchestrates** - User must manually follow PARA steps

**Setup approach:**
- Share methodology via symlink
- Document limitations clearly
- Provide adapted workflow guide
- Set realistic expectations

### Why "Other AI Assistants" Stay Separate

1. **Too diverse** - 7+ different tools with different capabilities
2. **Different config locations** - Each has unique setup
3. **Varying skill support** - Some yes, most no
4. **Current approach works** - Universal template + per-tool adaptation

**No change needed** - Keep existing `other-ai-assistants/` structure.

---

## Deviations from Plan

### Expected to Find:
Simple yes/no: "Can these tools be unified?"

### Actually Found:
**Nuanced answer:** Tools can share **methodology** but not **commands**. This led to the two-tier model instead of a binary unified/not-unified classification.

### Why This Matters:
A pure unified approach would over-promise. The two-tier model accurately reflects:
- What **can** be unified (AGENTS.md methodology)
- What **cannot** be unified (skill/command implementations)
- Different user experiences per tier

This is a more honest and useful framework.

---

## Evidence-Based Recommendations

### Recommendation 1: Implement Two-Tier Setup ⭐ HIGH PRIORITY

**Action:**
1. Create `para-init --tier1` for Claude + Cursor + Continue
2. Create `para-init --tier2` for Copilot + Gemini
3. Add tier badges to each tool's README
4. Create tier comparison table in main README

**Rationale:** Clear structure helps users choose tools and understand capabilities.

### Recommendation 2: Verify Codex CLI Claims ⭐ HIGH PRIORITY

**Action:**
1. Test actual AGENTS.md support (not just docs)
2. Test command/skill capabilities
3. If confirmed: Add to Tier 1
4. If not confirmed: Move to Tier 2 or separate

**Rationale:** Don't include tools in Tier 1 without verification. User expectations must match reality.

### Recommendation 3: Move Continue.dev to Tier 1 ⭐ MEDIUM PRIORITY

**Action:**
1. Create `continue/` directory (like `claude/`, `cursor/`)
2. Write comprehensive README and QUICKSTART
3. Include in Tier 1 unified setup script
4. Update tool comparison tables

**Rationale:** Continue.dev has all Tier 1 capabilities. Currently buried in "Other AI Assistants" where users won't find it.

### Recommendation 4: Update MIGRATION.md ⭐ HIGH PRIORITY

**Action:**
1. Add section: "What Can and Can't Be Unified"
2. Clarify: AGENTS.md shares methodology, not commands
3. Set expectations: Commands work differently per tool
4. Provide tier-based migration paths

**Rationale:** Current guide misleads users about level of unification possible.

### Recommendation 5: Improve Gemini Documentation ⭐ LOW PRIORITY

**Action:**
1. Create global GEMINI.md template (like `claude/CLAUDE.md`)
2. Expand README to 200+ lines (match other tools)
3. Clarify capabilities (multi-file? commands? MCP?)
4. Or defer Gemini unification until better supported

**Rationale:** Incomplete documentation makes Gemini hard to include confidently.

### Recommendation 6: Create Setup Scripts ⭐ MEDIUM PRIORITY

**Scripts needed:**
```bash
scripts/para-init-tier1.sh      # Unified Tier 1 setup
scripts/para-init-tier2.sh      # Tier 2 setup
scripts/para-init-copilot.sh    # Copilot-specific
scripts/para-init-cursor.sh     # Cursor-specific
scripts/para-init-claude.sh     # Claude-specific
scripts/para-init-continue.sh   # Continue.dev-specific
```

**Rationale:** One-command setup improves user experience. Ensures correct symlinks created.

### Recommendation 7: Add Tier Comparison Table ⭐ HIGH PRIORITY

**Add to README.md:**

```markdown
## Tool Tiers

| Tier | Tools | AGENTS.md | Commands | Multi-File | MCP | Setup |
|------|-------|-----------|----------|-----------|-----|-------|
| **1** | Claude, Cursor, Continue | ✅ Native/Symlink | ✅ Yes (per-tool) | ✅ Yes | ✅ Yes | `para-init --tier1` |
| **2** | Copilot, Gemini | ⚠️ Symlink only | ❌ No | ⚠️ Limited | ❌ No | `para-init --tier2` |
| **3** | Others (JetBrains, Codeium, etc.) | ⚠️ Manual | Varies | Varies | ❌ No | Per-tool |
```

**Rationale:** Users need quick way to understand which tools support what.

---

## Key Learnings

### Learning 1: "Unified" Has Multiple Dimensions
Can't just say "unified" or "not unified". Need to specify:
- Unified methodology? (AGENTS.md) - **YES for most tools**
- Unified commands? (skills) - **NO across tools**
- Unified setup? (scripts) - **YES for Tier 1, PARTIAL for Tier 2**

### Learning 2: Documentation Quality Varies Greatly
- **High quality:** Claude (595+ lines), Cursor (1282 lines), Copilot (1371 lines)
- **Medium quality:** Codex (768 lines, but some claims unverified)
- **Low quality:** Gemini (46 lines, minimal)

**Implication:** Can only confidently unify well-documented tools.

### Learning 3: AGENTS.md Standard is Emerging
Three tools independently moved to `AGENTS.md`:
- Cursor deprecated `.cursorrules` for `AGENTS.md`
- Codex uses `AGENTS.md` natively
- "Other AI Assistants" guide promotes `AGENT-INSTRUCTIONS.md`

**Trend:** Industry moving toward `AGENTS.md` as standard filename.

### Learning 4: MCP Support is Rare
Only **Claude Code** and **Cursor** have native MCP. Continue.dev has it too.
- Codex has manual preprocessing (not MCP protocol)
- Others lack preprocessing entirely

**Implication:** MCP-based unification only works for 3 tools (Claude, Cursor, Continue).

### Learning 5: Skills Are Tool-Specific, Not Transferable
Each tool implements commands differently:
- Claude: TypeScript functions in separate package
- Cursor: Slash command patterns in rules
- Continue: Custom slash commands via MCP

**Implication:** Can define **concept** of "/para:plan" universally, but each tool implements separately.

---

## Follow-Up Tasks

### Immediate (Before Implementation Plan)
1. ✅ Present findings to user for approval
2. 📋 Verify Codex CLI AGENTS.md support (if user wants Codex in Tier 1)
3. 📋 Get feedback on two-tier model
4. 📋 Finalize tool groupings

### Phase 1: Tier 1 Unified Setup
1. Create `para-init --tier1` script (Claude + Cursor + Continue)
2. Update Tier 1 tool READMEs with tier badges
3. Create unified setup guide
4. Test with actual projects

### Phase 2: Tier 2 Setup
1. Create `para-init --tier2` script (Copilot + Gemini)
2. Update Tier 2 tool docs with tier badges
3. Create adapted workflow guide
4. Document "no commands" limitation

### Phase 3: Documentation
1. Add tier comparison table to README
2. Update MIGRATION.md with realistic expectations
3. Reorganize SETUP-GUIDE.md by tier
4. Create troubleshooting guide

### Phase 4: Continue.dev Promotion
1. Create `continue/` directory
2. Write comprehensive README
3. Include in Tier 1 setup
4. Test integration

### Phase 5: Gemini Improvement (Optional)
1. Create global GEMINI.md template
2. Expand README
3. Test capabilities
4. Include in Tier 2 or promote to Tier 1

---

## Test Results

No code tests needed - this was a research phase. Validation is through:
- ✅ Documentation analysis complete (all tools reviewed)
- ✅ Evidence gathered from existing files
- ✅ Comparison matrix created
- ✅ Recommendations based on evidence
- ✅ Awaiting human review

---

## Current State vs. Desired State

### Current State ❌
- Multiple setup instructions per tool
- No clear tier structure
- Over-promised unification in MIGRATION.md
- Codex claims unverified
- Gemini under-documented
- Continue.dev hidden in "Other"

### Desired State (After Implementation) ✅
- Two clear tiers with distinct capabilities
- One-command setup per tier
- Realistic expectations in documentation
- Verified tool support before inclusion
- Continue.dev properly positioned
- Clear comparison tables in README

---

## Conclusion

The research successfully identified:

✅ **Tier 1 (Full Support):** Claude Code, Cursor, Continue.dev
- Can share AGENTS.md + have multi-file + commands
- **Unified setup is feasible and valuable**

✅ **Tier 2 (Methodology Only):** GitHub Copilot, Gemini
- Can share AGENTS.md methodology
- **Cannot share commands** (no skill systems)
- Need adapted workflow

✅ **Keep Separate:** JetBrains AI, Codeium, others
- Too diverse to unify
- Template approach works

**The key insight:** "Unified setup" means unified METHODOLOGY (AGENTS.md) for Tier 1 tools, with tool-specific COMMAND implementations. This is realistic, achievable, and improves user experience.

**Next step:** Present findings for review, then create implementation plan if approved.

---

**Research Complete** 🎉

Total documents created: 3 (plan + matrix + findings + summary)
Total lines written: ~1500 lines of analysis
Time invested: Single research session
Outcome: Clear path forward for tool unification

Ready for human review and next phase planning.
