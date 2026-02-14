# Plan: Rebrand PARA-Programming to Pret-a-Program

## Objective

Rebrand the project from "PARA-Programming" to "Pret-a-Program" (inspired by "pret-a-porter" / ready-to-wear). Create a Homebrew-distributable CLI (`pret`) and universal skill commands for Claude Code, Codex CLI, and Cursor.

---

## Naming Conventions (Reference for All Tasks)

| Concept | Old | New |
|---------|-----|-----|
| Project display name | PARA-Programming | Pret-a-Program |
| Slug/package name | `para-programming` | `pret-a-program` |
| CLI command | _(none)_ | `pret` |
| Branch prefix | `para/` | `pret/` |
| Skill prefix | `/para-` | `/pret-` |
| Methodology name | PARA workflow | Pret workflow |
| Context directory | `context/` | `context/` _(unchanged)_ |

**Important distinction:** "PARA" as a methodology acronym (Plan, Archive, Review, etc.) gets replaced everywhere. But be careful with the word "para" in contexts like `--para` flags or `para/` branch prefixes — those become `pret`.

---

## Architecture Decision: Templates Live in One Place

Templates are stored canonically in `cli/lib/templates/`. Both the CLI and skills reference this single location:

- **CLI (`pret init`, `pret plan`, etc.):** Reads templates directly from `cli/lib/templates/`
- **Skills (Claude Code, Cursor, Codex):** Live in `skills/` directory, reference templates via relative paths or embed the methodology inline (since skills are prompt files, not shell scripts)
- **Homebrew install:** Copies `cli/lib/templates/` to `$(brew --prefix)/share/pret-a-program/templates/`

No symlinks between template directories. No duplication.

---

## Architecture Decision: CLI vs Skills

These are **two different things** that serve different audiences:

| | CLI (`pret`) | Skills (`/pret-*`) |
|---|---|---|
| **What** | Shell scripts that create files/dirs | AI prompt instructions that guide agent behavior |
| **Run by** | Human in terminal | AI agent inside coding tool |
| **Example** | `pret init` → creates `context/` dirs + template files | `/pret-init` → tells Claude to create dirs, explain the workflow, display next steps |
| **Install** | `brew install pret-a-program` | `pret install-skills` or manual copy |

The CLI commands do the **mechanical** file/git operations. The skill commands provide **context and guidance** to AI agents about how to follow the methodology.

---

## Architecture Decision: `~/.claude/CLAUDE.md`

The global `~/.claude/CLAUDE.md` currently contains the full PARA methodology (~300 lines). After rebrand:

- `pret install-skills --claude` will offer to **replace** it with the rebranded version
- Backs up existing file to `~/.claude/CLAUDE.md.bak` before replacing
- The content is functionally identical, just rebranded

---

## Task Breakdown

### PR 1: CLI + Skills Foundation (Tasks 1-4)

### Task 1: Build `pret` CLI skeleton with `pret init`

**Scope:** Create the CLI entry point, shared utilities, and the first working command.

**New files to create:**

```
cli/
├── bin/
│   └── pret                    # Main entry point + command router
├── lib/
│   ├── common.sh               # Colors, print functions, OS detection (adapt from scripts/common.sh)
│   └── commands/
│       └── init.sh             # pret init implementation
```

**`cli/bin/pret` specification:**

```bash
#!/usr/bin/env bash
# Resolve lib path (supports both local dev and Homebrew install)
PRET_LIBEXEC="${PRET_LIBEXEC:-@@LIBEXEC@@}"  # Replaced by Homebrew, or defaults to relative
PRET_VERSION="2.0.0"

# Source common utilities
source "$PRET_LIBEXEC/common.sh"

# Command router
case "${1:-}" in
  init)           shift; source "$PRET_LIBEXEC/commands/init.sh"; cmd_init "$@" ;;
  plan)           shift; source "$PRET_LIBEXEC/commands/plan.sh"; cmd_plan "$@" ;;
  execute)        shift; source "$PRET_LIBEXEC/commands/execute.sh"; cmd_execute "$@" ;;
  summarize)      shift; source "$PRET_LIBEXEC/commands/summarize.sh"; cmd_summarize "$@" ;;
  archive)        shift; source "$PRET_LIBEXEC/commands/archive.sh"; cmd_archive "$@" ;;
  status)         shift; source "$PRET_LIBEXEC/commands/status.sh"; cmd_status "$@" ;;
  check)          shift; source "$PRET_LIBEXEC/commands/check.sh"; cmd_check "$@" ;;
  install-skills) shift; source "$PRET_LIBEXEC/commands/install-skills.sh"; cmd_install_skills "$@" ;;
  --version|-v)   echo "pret $PRET_VERSION" ;;
  --help|-h|"")   show_help ;;
  *)              echo "Unknown command: $1"; show_help; exit 1 ;;
esac
```

**`cli/lib/commands/init.sh` specification:**

```bash
cmd_init() {
  # Parse --template=basic|full flag (default: basic)
  # 1. Create context/ subdirectories: data, plans, summaries, archives, servers
  # 2. Create context/context.md from template (skip if exists)
  # 3. Create AGENTS.md from template (skip if exists)
  # 4. Print success message with next steps
  # Does NOT auto-install skills (that's a separate command)
}
```

**`cli/lib/common.sh` specification:**
- Adapt from existing `scripts/common.sh` (colors, print_header, print_success, etc.)
- Add `resolve_templates_dir()` — finds templates relative to script or via `PRET_SHARE` env var
- Add `get_date()` — returns `YYYY-MM-DD`
- Remove exported functions (not needed, scripts source directly)

**Test criteria:**
- `cli/bin/pret --version` prints version
- `cli/bin/pret init` in empty dir creates `context/{data,plans,summaries,archives,servers}/` and `context/context.md`
- `cli/bin/pret init` in existing project doesn't overwrite existing files
- `cli/bin/pret` with no args shows help

**Files modified:** 0
**Files created:** 3

---

### Task 2: Add remaining CLI commands

**Scope:** Implement `plan`, `execute`, `summarize`, `archive`, `status`, `check`.

**New files to create:**

```
cli/lib/commands/
├── plan.sh
├── execute.sh
├── summarize.sh
├── archive.sh
├── status.sh
└── check.sh
```

**Command specifications:**

**`cmd_plan <task-name>`:**
1. Require `<task-name>` argument (error if missing)
2. Generate filename: `context/plans/$(date +%F)-<task-name>.md`
3. Copy plan template, replacing `[Task Name]` placeholder with task name
4. Update `context/context.md`: add plan to `active_context`, update `last_updated`
5. Print: "Plan created at context/plans/... — edit it, then run `pret execute`"

**`cmd_execute [--phase=N] [--branch=name] [--no-branch]`:**
1. Read `context/context.md` to find active plan
2. Error if no active plan found
3. Derive branch name from plan filename: `pret/<task-name>` (or `pret/<task-name>-phase-N`)
4. If in git repo and `--no-branch` not set: `git checkout -b <branch>`
5. Update `context/context.md`: set `execution_branch`, update status
6. Print: "Branch created. Start implementing your plan. Commit after each step."

**`cmd_summarize [--phase=N]`:**
1. Read `context/context.md` to find active plan
2. Generate filename: `context/summaries/$(date +%F)-<task-name>-summary.md`
3. Copy summary template, replacing `[Task Name]` placeholder
4. Update `context/context.md`: add to `completed_summaries`
5. Print: "Summary template created at ... — fill it in with your results."

**`cmd_archive [--fresh] [--seed]`:**
1. Move `context/context.md` → `context/archives/$(date +%F)-$(date +%H%M)-context.md`
2. Create fresh `context/context.md` from template
3. If `--seed`: carry forward `completed_summaries` from archived context
4. Print: "Context archived. Ready for next task."

**`cmd_status`:**
1. Read `context/context.md`
2. Parse JSON block (use grep/sed — no jq dependency)
3. Display: active plan, branch, phase, last updated, todo progress
4. If no context.md: "No active context. Run `pret init` to get started."

**`cmd_check`:**
1. Print decision tree:
   - "Will this result in git changes? → Use `pret plan`"
   - "Is it read-only/informational? → Just answer directly"
2. No file I/O, purely informational

**Test criteria:**
- `pret plan my-feature` creates dated plan file with correct name
- `pret execute` creates git branch from plan name
- `pret summarize` creates dated summary file
- `pret archive` moves context.md to archives/
- `pret status` displays current state
- `pret check` prints decision guidance
- All commands error gracefully when prerequisites aren't met

**Files modified:** 0 (just adding new files alongside Task 1's skeleton)
**Files created:** 6

---

### Task 3: Add templates for CLI

**Scope:** Create the template files that CLI commands copy/populate.

**New files to create:**

```
cli/lib/templates/
├── agents.md               # AGENTS.md template for new projects (rebranded from current AGENTS.md)
├── context.md              # context/context.md initial content
├── plan.md                 # Plan template (rebranded from claude-skill/templates/plan-template.md)
├── summary.md              # Summary template (rebranded from claude-skill/templates/summary-template.md)
├── phased-plan-master.md   # Master plan template (rebranded)
└── phased-plan-sub.md      # Phase sub-plan template (rebranded)
```

**Source for each template:**
- `agents.md` ← Rebrand `AGENTS.md` (shrink to ~200 lines for template use; full version stays at project root)
- `context.md` ← Rebrand the JSON structure in `claude-skill/templates/context-template.md`
- `plan.md` ← Rebrand `claude-skill/templates/plan-template.md`
- `summary.md` ← Rebrand `claude-skill/templates/summary-template.md`
- `phased-plan-master.md` ← Rebrand `claude-skill/templates/phased-plan-master-template.md`
- `phased-plan-sub.md` ← Rebrand `claude-skill/templates/phased-plan-sub-template.md`

**Rebranding rules for templates:**
- "PARA-Programming" → "Pret-a-Program"
- "PARA workflow" → "Pret workflow"
- "PARA" (as methodology) → "Pret"
- `/para-plan` → `/pret-plan` (etc.)
- `para/task-name` → `pret/task-name` (branch names)
- Keep all structural content identical

**Files modified:** 0
**Files created:** 6

---

### Task 4: Restructure skills directory

**Scope:** Move `claude-skill/` → `skills/claude-code/`, rename commands, add Cursor and Codex skill files.

**Step 1: Move and rename Claude Code skills**

```
skills/
├── claude-code/
│   ├── skill.json                  # Updated manifest (rename para → pret)
│   ├── commands/
│   │   ├── pret-init.md           # Rebranded from para-init.md
│   │   ├── pret-plan.md           # Rebranded from para-plan.md
│   │   ├── pret-execute.md        # Rebranded from para-execute.md
│   │   ├── pret-summarize.md      # Rebranded from para-summarize.md
│   │   ├── pret-archive.md        # Rebranded from para-archive.md
│   │   ├── pret-status.md         # Rebranded from para-status.md
│   │   └── pret-check.md          # Rebranded from para-check.md
│   ├── templates/                  # Copy from cli/lib/templates/ (not symlinks)
│   ├── docs/                       # Move from claude-skill/docs/
│   ├── hooks/                      # Move from claude-skill/hooks/
│   └── README.md                   # Rebranded
```

**`skill.json` changes:**
```json
{
  "name": "pret-a-program",
  "version": "2.0.0",
  "description": "Pret-a-Program methodology for Claude Code",
  "namespace": "@pret-a-program",
  "commands": [
    {"name": "pret-init", "file": "commands/pret-init.md"},
    {"name": "pret-plan", "file": "commands/pret-plan.md"},
    ...
  ]
}
```

**Rebranding rules for skill command .md files:**
- Same text replacements as templates (PARA → Pret, para → pret)
- Update command references: `/para-init` → `/pret-init`, etc.
- Update branch references: `para/` → `pret/`
- Keep all implementation logic identical

**Step 2: Create Cursor skill**

```
skills/cursor/
├── rules/
│   └── pret-a-program.md    # Condensed methodology as Cursor rule
└── README.md                 # How to install for Cursor
```

`pret-a-program.md` content: A condensed version (~150 lines) of the AGENTS.md methodology, formatted for Cursor's rules system. No frontmatter needed (always-apply rule).

**Step 3: Create Codex skill**

```
skills/codex/
├── AGENTS.md                 # Same as root AGENTS.md (Codex reads this natively)
└── README.md                 # How to install for Codex
```

**Step 4: Add `pret install-skills` command**

```
cli/lib/commands/install-skills.sh
```

**`cmd_install_skills [--claude] [--cursor] [--codex] [--all]`:**
1. Detect which tools are installed (check for `claude`, `cursor`, `codex` in PATH)
2. If no flags: prompt user to select from detected tools
3. `--claude`: Copy `skills/claude-code/` to `~/.claude/skills/pret-a-program/`
4. `--cursor`: Copy `skills/cursor/rules/pret-a-program.md` to `.cursor/rules/pret-a-program.md` in PWD
5. `--codex`: Copy `skills/codex/AGENTS.md` to `AGENTS.md` in PWD (skip if exists)
6. `--all`: Do all detected

**Resolve skill source path:** When installed via Homebrew, skills are at `$(brew --prefix)/share/pret-a-program/skills/`. When running from repo, skills are at `../skills/` relative to CLI.

**Files modified:** 0 (old `claude-skill/` stays until cleanup)
**Files created:** ~20 (commands, skill files, READMEs)

---

### PR 2: Rebrand Existing Documentation (Tasks 5-6)

### Task 5: Rebrand root documentation

**Scope:** Find-and-replace rebrand in the 6 root markdown files + CLAUDE.md.

**Files to modify:**

| File | Size | Approach |
|------|------|----------|
| `README.md` | 34KB | Full rebrand. Update install instructions to show `brew install pret-a-program`. Update all PARA → Pret references. Update directory examples. |
| `AGENTS.md` | 10KB | Rebrand methodology name and all references. This is the canonical methodology file. |
| `CLAUDE.md` | 21KB | Rebrand all references. Update template examples. Update command references. |
| `SETUP-GUIDE.md` | 7.4KB | Rebrand + simplify. Primary install method is now `brew install pret-a-program && pret init`. Keep manual setup as alternative. |
| `AUTOMATED-SETUP.md` | 7.9KB | Add deprecation notice at top: "This is superseded by the `pret` CLI. See README for install instructions." Then rebrand remaining content. |
| `MIGRATION.md` | 5.8KB | Rebrand + add section for migrating from PARA v1 → Pret v2. |
| `docs/index.md` | 10.2KB | Rebrand for GitHub Pages. |
| `docs/_config.yml` | ~10 lines | Update title/description. |

**Find-and-replace patterns (apply to all files above):**

| Pattern | Replacement | Notes |
|---------|-------------|-------|
| `PARA-Programming` | `Pret-a-Program` | Display name |
| `para-programming` | `pret-a-program` | Slug form |
| `@para-programming` | `@pret-a-program` | Namespace |
| `PARA workflow` | `Pret workflow` | Methodology reference |
| `PARA methodology` | `Pret methodology` | Methodology reference |
| `PARA structure` | `Pret structure` | Structure reference |
| `/para-init` | `/pret-init` | Skill commands |
| `/para-plan` | `/pret-plan` | Skill commands |
| `/para-execute` | `/pret-execute` | Skill commands |
| `/para-summarize` | `/pret-summarize` | Skill commands |
| `/para-archive` | `/pret-archive` | Skill commands |
| `/para-status` | `/pret-status` | Skill commands |
| `/para-check` | `/pret-check` | Skill commands |
| `/para-help` | `/pret-help` | Skill commands |
| `para/task-name` | `pret/task-name` | Branch naming |
| `para/<task-name>` | `pret/<task-name>` | Branch naming |
| `para/unified` | `pret/unified` | Existing branch refs |
| `make setup` | `pret install-skills` | Install command |

**Do NOT replace:**
- "PARA" when it refers to Tiago Forte's system in explanatory text (context-dependent, handle manually)
- URLs containing "PARA-Programming" in GitHub links (will be updated after repo rename)

**Files modified:** 8
**Files created:** 0

---

### Task 6: Rebrand secondary files

**Scope:** Rebrand scripts, tool-setup guides, examples, archived content, and Makefile.

**Files to modify:**

| Directory | Files | Approach |
|-----------|-------|----------|
| `scripts/common.sh` | 1 | Rebrand print messages. "PARA-Programming" → "Pret-a-Program" in all strings. |
| `scripts/setup-*.sh` | 6 | Rebrand messages. Add deprecation header comment: "# Deprecated: Use `pret install-skills` instead" |
| `scripts/update-*.sh` | 5 | Same deprecation + rebrand |
| `scripts/test-setup.sh` | 1 | Rebrand test messages |
| `tool-setup/claude-code.md` | 1 | Rebrand all references |
| `tool-setup/cursor.md` | 1 | Rebrand all references |
| `tool-setup/copilot.md` | 1 | Rebrand all references |
| `tool-setup/codex.md` | 1 | Rebrand all references |
| `tool-setup/community/*.md` | 3 | Rebrand all references |
| `examples/README.md` | 1 | Rebrand |
| `examples/plans/*.md` | 2 | Rebrand |
| `examples/summaries/*.md` | 2 | Rebrand |
| `examples/workflows/*.md` | 1 | Rebrand |
| `_archived/README.md` | 1 | Rebrand deprecation notice |
| `Makefile` | 1 | Rebrand messages. Keep targets functional but add comment about `pret` CLI being the preferred method. |

**Same find-and-replace patterns as Task 5.**

**Files modified:** ~28
**Files created:** 0

---

### PR 3: Distribution & Polish (Tasks 7-8)

### Task 7: Homebrew formula + shell completions

**Scope:** Create Homebrew formula, bash/zsh completions, and the tap repository structure.

**New files to create:**

```
homebrew/
├── Formula/
│   └── pret-a-program.rb
└── README.md

cli/completions/
├── pret.bash
└── pret.zsh
```

**`homebrew/Formula/pret-a-program.rb`:**
- Standard Homebrew formula for a shell-script CLI
- Installs `cli/bin/pret` to `$(brew --prefix)/bin/`
- Installs `cli/lib/` to `$(brew --prefix)/libexec/pret-a-program/`
- Installs `skills/` to `$(brew --prefix)/share/pret-a-program/skills/`
- Installs completions to standard Homebrew completion dirs
- Uses `inreplace` to set `PRET_LIBEXEC` and `PRET_SHARE` paths in the `pret` script

**`cli/completions/pret.bash`:**
```bash
_pret() {
  local commands="init plan execute summarize archive status check install-skills"
  COMPREPLY=($(compgen -W "$commands" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _pret pret
```

**`cli/completions/pret.zsh`:**
```zsh
#compdef pret
_pret() {
  local commands=(
    'init:Initialize Pret-a-Program in current project'
    'plan:Create a new plan document'
    'execute:Start execution with branch and tracking'
    'summarize:Generate post-work summary'
    'archive:Archive current context'
    'status:Show current workflow state'
    'check:Decision helper for workflow selection'
    'install-skills:Install AI tool skills'
  )
  _describe 'command' commands
}
_pret
```

**Note:** The Homebrew tap repository (`brian-lai/homebrew-pret`) is a **separate repo** that needs to be created on GitHub manually. The formula file here serves as the source. After tagging a release in this repo, the formula's `url` and `sha256` need updating. This can be automated with GitHub Actions later.

**Files modified:** 1 (`cli/bin/pret` — add `PRET_SHARE` variable alongside `PRET_LIBEXEC`)
**Files created:** 4

---

### Task 8: Migration guide + cleanup + global CLAUDE.md

**Scope:** Create migration guide, archive old `claude-skill/` directory, update `~/.claude/CLAUDE.md`.

**New files to create:**

```
UPGRADING-FROM-PARA.md       # Migration guide for existing users
```

**`UPGRADING-FROM-PARA.md` sections:**
1. What changed (PARA-Programming → Pret-a-Program)
2. Why the rename
3. Automatic migration: `pret init` in existing projects (preserves context/ if it exists)
4. Manual steps:
   - Update branch prefixes: `git branch -m para/foo pret/foo`
   - Update AGENTS.md references
   - Remove old Claude skill: `rm -rf ~/.claude/skills/para-programming/`
   - Install new skill: `pret install-skills --claude`
5. What stays the same: `context/` directory structure, file formats, workflow steps

**Cleanup:**
- Move `claude-skill/` → `_archived/claude-skill/` (don't delete, preserve history)
- Update `_archived/README.md` to mention it

**Global `~/.claude/CLAUDE.md` update:**
- This is a **manual step** documented in the migration guide
- The `pret install-skills --claude` command will offer to update it
- Content: same structure as current, with PARA → Pret rebrand throughout

**Files modified:** 1 (`_archived/README.md`)
**Files created:** 1 (`UPGRADING-FROM-PARA.md`)
**Files moved:** `claude-skill/` → `_archived/claude-skill/`

---

## PR Strategy

| PR | Tasks | Branch | Description |
|----|-------|--------|-------------|
| **PR 1** | Tasks 1-4 | `pret/cli-and-skills` | New CLI + skills (additive, no breaking changes) |
| **PR 2** | Tasks 5-6 | `pret/rebrand-docs` | Rebrand all documentation (pure text changes) |
| **PR 3** | Tasks 7-8 | `pret/distribution` | Homebrew formula + migration guide + cleanup |

PRs are ordered so each builds on the previous. PR 1 is purely additive (new files only). PR 2 is text changes to existing files. PR 3 ties it all together.

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| `pret` name collision | Users can't install | Check `brew search pret` and `which pret` before committing to name |
| Shell compatibility | Breaks on Linux/older bash | Use POSIX-compatible constructs, test with bash 3.2+ (macOS default) |
| Overzealous find-replace | Breaks content meaning | Manual review of each file in Tasks 5-6; don't blindly replace "PARA" when it refers to Tiago Forte's system |
| Homebrew tap setup | Requires separate repo + release tag | Document as manual step; formula works locally first |
| Skill format drift | Claude Code skill format changes | Pin to known-working format; skill.json structure is stable |

---

## Success Criteria

- [ ] `pret --version` prints `2.0.0`
- [ ] `pret init` scaffolds `context/` in empty directory
- [ ] `pret plan my-feature` creates `context/plans/2026-02-12-my-feature.md`
- [ ] `pret execute` creates `pret/my-feature` branch
- [ ] `pret summarize` creates `context/summaries/2026-02-12-my-feature-summary.md`
- [ ] `pret archive` moves context.md to `context/archives/`
- [ ] `pret status` displays current state from context.md
- [ ] `pret install-skills --claude` installs skill to `~/.claude/skills/`
- [ ] `/pret-init` works as Claude Code slash command
- [ ] Zero references to "PARA-Programming" remain (except in `_archived/` and migration guide)
- [ ] `brew install pret-a-program` works via tap (after tap repo created)
- [ ] Tab completion works for bash and zsh
