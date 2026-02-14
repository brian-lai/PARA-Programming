# Summary: Rebrand PARA-Programming to Pret-a-Program

**Date:** 2026-02-12 to 2026-02-14
**Plan:** context/plans/2026-02-12-pret-a-program-rebrand.md
**PRs:** #13 (Phase 1), #14 (Phase 2), #15 (Phase 3)

---

## What Was Implemented

### Phase 1 — CLI + Skills Foundation (PR #13)

Created the `pret` CLI tool and reorganized skills for multi-tool support.

**New files created:**
- `cli/bin/pret` — Main CLI entry point with command router (116 lines)
- `cli/lib/common.sh` — Shared utilities: colors, printing, context parsing (170 lines)
- `cli/lib/commands/init.sh` — `pret init` command (117 lines)
- `cli/lib/commands/plan.sh` — `pret plan` command (147 lines)
- `cli/lib/commands/execute.sh` — `pret execute` command (150 lines)
- `cli/lib/commands/summarize.sh` — `pret summarize` command (116 lines)
- `cli/lib/commands/archive.sh` — `pret archive` command (111 lines)
- `cli/lib/commands/status.sh` — `pret status` command (103 lines)
- `cli/lib/commands/check.sh` — `pret check` command (52 lines)
- `cli/lib/commands/install-skills.sh` — `pret install-skills` command (210 lines)
- `cli/lib/templates/` — 6 template files (agents.md, context.md, plan.md, summary.md, phased-plan-master.md, phased-plan-sub.md)
- `skills/claude-code/` — Rebranded Claude Code skill (skill.json, README, 7 commands, 6 templates)
- `skills/cursor/` — Cursor rules file and README
- `skills/codex/` — Codex AGENTS.md and README

### Phase 2 — Rebrand Documentation (PR #14)

Applied find-and-replace patterns across all documentation files.

**Files modified: 31 total**
- 8 root documentation files (README.md, AGENTS.md, CLAUDE.md, SETUP-GUIDE.md, AUTOMATED-SETUP.md, MIGRATION.md, docs/index.md, docs/_config.yml)
- 14 scripts (deprecation headers added to setup/update scripts)
- 7 tool-setup guides
- 1 Makefile
- Added PARA v1 migration section to MIGRATION.md
- Added deprecation notice to AUTOMATED-SETUP.md

### Phase 3 — Distribution & Polish (PR #15)

Added Homebrew distribution, migration guide, and completed full rebrand.

**New files created:**
- `homebrew/Formula/pret-a-program.rb` — Homebrew formula with inreplace for path resolution
- `homebrew/README.md` — Publishing instructions for Homebrew tap
- `cli/completions/pret.bash` — Bash completion with subcommand options
- `cli/completions/pret.zsh` — Zsh completion with descriptions and flags
- `UPGRADING-FROM-PARA.md` — Complete migration guide for PARA v1 users
- `_archived/README.md` — Index of archived directories

**Files moved:**
- `claude-skill/` → `_archived/claude-skill/` (33 files preserved for history)

**Additional rebranding (discovered during Phase 3):**
- `claude/` directory (3 files)
- `codex/` directory (3 files)
- `copilot/` directory (4 files)
- `cursor/` directory (4 files)
- `gemini/` directory (4 files, plus filename rename)
- `other-ai-assistants/` directory (5 files)

---

## Decisions Made and Rationale

1. **CLI is shell scripts, not a compiled binary** — Keeps dependencies minimal (just bash). Homebrew can distribute it without a build step.

2. **Templates stored in `cli/lib/templates/`** — Single canonical location. Skills directories contain copies (not symlinks) for portability.

3. **Path resolution via `PRET_LIBEXEC`/`PRET_SHARE` env vars** — Supports both local dev (`$SCRIPT_DIR/../lib`) and Homebrew install (replaced by `inreplace` during formula installation).

4. **`set -euo pipefail` with careful error handling** — Several bugs were found and fixed where `grep -c` and pipeline failures triggered unexpected exits. Pattern: `result=$(grep ...) || result=0` and `|| true` for optional greps.

5. **Legacy Makefile preserved** — Marked as deprecated but still functional. No breaking changes for existing users.

6. **PARA references to Tiago Forte's method preserved** — Only the methodology brand name was changed. References to the original PARA Method (Projects, Areas, Resources, Archives) by Tiago Forte were intentionally kept.

---

## Challenges Encountered

1. **`set -euo pipefail` with grep**: `grep -c` returns exit code 1 when no matches, causing script termination. Required careful handling with `|| true` and `|| var=0` patterns.

2. **Unicode en-dash in docs/index.md**: The file used `PARA‑Programming` (U+2011 non-breaking hyphen) which standard `sed` patterns didn't match. Required a separate sed pass with the actual Unicode character.

3. **Scope creep in rebranding**: The original plan listed ~36 files for rebranding, but the actual repo had many more unrebranded files in `claude/`, `codex/`, `copilot/`, `cursor/`, `gemini/`, and `other-ai-assistants/`. These were discovered and handled in Phase 3.

4. **`make setup` → `pret install-skills` overzealous replacement**: The global sed of `make setup` → `pret install-skills` created invalid commands in AUTOMATED-SETUP.md (which documents the Make system). Fixed by reverting those specific replacements.

5. **Makefile target names incorrectly renamed**: `claude-skill` Make target names were replaced with `skills/claude-code` (invalid Make targets). Fixed by selectively reverting.

6. **Merge conflicts on PR #13**: Main had moved forward during Phase 1 execution, causing conflicts in `context/context.md`. Resolved by writing clean context.

---

## Metrics

- **Total PRs:** 3
- **Total commits:** ~12
- **Files created:** ~35
- **Files modified:** ~90
- **Files moved:** 33 (claude-skill/ → _archived/)
- **Lines changed:** ~2,000+ additions, ~1,000+ deletions

---

## What's Left (Not in Scope)

1. **Create Homebrew tap repo** (`brian-lai/homebrew-pret`) on GitHub
2. **Tag v2.0.0 release** and update formula SHA256
3. **Update `~/.claude/CLAUDE.md`** (personal global config) to reference Pret
4. **Rename GitHub repo** from `PARA-Programming` to `pret-a-program` (optional)
