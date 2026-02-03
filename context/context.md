# Current Work Summary

Implementation Planning: Smart para-init with Auto-Detection

**Plan:** context/plans/2026-02-02-smart-para-init-auto-detection.md

---

## Objective

Implement an intelligent `para-init` command that auto-detects AI coding tools and configures PARA-Programming automatically, without exposing "tier" concepts to users.

**Key UX Improvement:** Replace `--tier1` / `--tier2` flags with smart detection.

## Background

Based on completed research (2026-02-02):
- ✅ Analyzed 6 AI coding tools
- ✅ Identified two capability tiers
- ✅ Discovered Claude Code uses native plugin (not file-based setup)

## Implementation Approach

### Tool Handling Strategy

**Plugin-Based (External):**
- **Claude Code** → Point to `github.com/brian-lai/para-programming-plugin`
  - Don't configure files in this repo
  - Display installation instructions

**File-Based (This Repo):**
- **Tier 1**: Cursor, Continue.dev → Create `AGENTS.md` (no symlinks)
- **Tier 2**: Copilot, Gemini → Create `AGENTS.md` + symlinks

### Phased Execution Plan

**Phase 1: Detection & Core Logic**
- Create `scripts/detect-tools.sh`
- Create `scripts/para-init` entry point
- Test detection accuracy

**Phase 2: File-Based Setup Scripts**
- Create `scripts/setup-tier1.sh`
- Create `scripts/setup-tier2.sh`
- Create `templates/AGENTS.md` master template

**Phase 3: User Experience & Display**
- Interactive selection menu
- Tool-specific guidance
- Claude Code plugin instructions

**Phase 4: Documentation Updates**
- Update README with `para-init` as primary method
- Update MIGRATION.md (realistic expectations)
- Update tool-specific docs

## Open Questions

1. Verify Codex CLI AGENTS.md support before including in Tier 1?
2. Best way to detect Continue.dev reliably?
3. Windows symlink handling strategy?
4. Keep Gemini in Tier 2 given under-developed docs?

## Next Step

Awaiting approval to begin Phase 1 implementation.

---

```json
{
  "active_context": [
    "context/plans/2026-02-02-smart-para-init-auto-detection.md"
  ],
  "completed_work": [
    {
      "plan": "context/plans/2026-02-02-tool-unification-research.md",
      "summary": "context/summaries/2026-02-02-tool-unification-research-summary.md",
      "status": "complete"
    }
  ],
  "phased_execution": {
    "master_plan": "context/plans/2026-02-02-smart-para-init-auto-detection.md",
    "phases": [
      {
        "phase": 1,
        "description": "Detection & Core Logic",
        "status": "pending"
      },
      {
        "phase": 2,
        "description": "File-Based Setup Scripts",
        "status": "pending"
      },
      {
        "phase": 3,
        "description": "User Experience & Display",
        "status": "pending"
      },
      {
        "phase": 4,
        "description": "Documentation Updates",
        "status": "pending"
      }
    ],
    "current_phase": null
  },
  "last_updated": "2026-02-02T23:15:00Z"
}
```
