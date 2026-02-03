# Plan: Research Tool Control Models and Unification Strategy

**Created:** 2026-02-02
**Type:** Research and Analysis Plan
**Status:** Planning

---

## Objective

Research and categorize the currently supported AI coding tools to identify which tools share a standard model of control (single `AGENTS.md` file + skills/commands). Group tools by their control model to determine which can be unified under a single setup experience and which require separate approaches.


## Background

Currently, PARA-Programming supports multiple AI coding tools:
- **Claude Code** (claude/)
- **Cursor** (cursor/)
- **GitHub Copilot** (copilot/)
- **Codex CLI** (codex/)
- **Gemini** (gemini/)
- **Other AI Assistants** (other-ai-assistants/)

There's an existing unified `AGENTS.md` file at the root level, but we need to understand which tools can actually use this unified approach versus those that require tool-specific configurations.

## Approach

### Phase 1: Research Tool Control Models (This Plan)

#### Step 1: Document Tool Characteristics

For each supported tool, research and document:

1. **Primary Instruction Method**
   - What file(s) does it read for instructions?
   - Location of instruction files
   - File format requirements
   - Native vs. configured support

2. **Skill/Command System**
   - Does it support custom commands/skills?
   - How are commands defined and invoked?
   - Built-in command support vs. extensions

3. **Multi-File Editing Capabilities**
   - Can it edit multiple files in one operation?
   - How does it handle cross-file changes?

4. **Context Loading Mechanism**
   - How does it discover and load project context?
   - Auto-discovery vs. explicit references
   - Context window limitations

5. **MCP/Preprocessing Support**
   - Native MCP support?
   - Alternative preprocessing mechanisms?
   - Tool integration capabilities

#### Step 2: Create Comparison Matrix

Create a structured comparison in `context/data/2026-02-02-tool-comparison-matrix.md` with:

- **Control Model Column**: How instructions are provided
- **Skill System Column**: Command/skill support details
- **Native AGENTS.md Support**: Yes/No/Via Symlink
- **Unified Setup Feasibility**: High/Medium/Low
- **Preprocessing Support**: Native/Manual/None

#### Step 3: Group Tools by Control Model

Based on research, create groups:

**Group A: Unified AGENTS.md Support**
- Tools that natively read `AGENTS.md` OR can via symlink
- Support similar skill/command patterns
- Can share a single setup process

**Group B: Alternative Control Models**
- Tools requiring different instruction files
- Different skill/command mechanisms
- Need separate setup processes

**Group C: Hybrid/Special Cases**
- Tools that partially fit unified model
- Require additional configuration beyond AGENTS.md
- May benefit from hybrid approach

#### Step 4: Analyze Current Implementation

Review existing files to understand what's already unified:

1. **Root AGENTS.md** (410 lines)
   - What does it currently contain?
   - Which tools reference it?
   - What's working, what's not?

2. **Tool-Specific Files**
   - Compare `claude/CLAUDE.md`, `cursor/cursorrules`, `copilot/copilot-instructions.md`
   - Identify overlapping content
   - Find tool-specific requirements

3. **Migration Guide** (`MIGRATION.md`)
   - What migration path exists?
   - What assumptions were made?

#### Step 5: Create Findings Document

Document findings in `context/data/2026-02-02-tool-unification-findings.md`:

1. **Tools That Can Be Unified**
   - List with evidence
   - Shared characteristics
   - Unified setup approach

2. **Tools Requiring Separate Setup**
   - List with rationale
   - Unique requirements
   - Recommended approach

3. **Hybrid Cases**
   - Tools needing both unified + custom setup
   - Recommendations for handling

4. **Current State Assessment**
   - What's working well now?
   - What's broken or confusing?
   - Pain points for users

## Research Questions

### Critical Questions to Answer:

1. **Which tools natively support `AGENTS.md`?**
   - Claude Code: YES (native `CLAUDE.md` support)
   - Cursor: ? (`.cursorrules` vs `AGENTS.md`)
   - Codex: ? (claims `AGENTS.md` support in README)
   - Copilot: NO (uses `.github/copilot-instructions.md`)
   - Gemini: ? (check GEMINI.md for details)

2. **Which tools support skill-like commands?**
   - Claude Code: YES (skills system)
   - Cursor: PARTIAL? (slash commands in rules?)
   - Codex: ?
   - Copilot: NO (no skill system)
   - Gemini: ?

3. **Can symlinks bridge the gap?**
   - Which tools can use symlink from `AGENTS.md` → tool-specific file?
   - Are there any gotchas with symlinks?

4. **What preprocessing capabilities exist?**
   - Claude: MCP (Model Context Protocol)
   - Codex: Claims preprocessing support
   - Others: ?

5. **What's the simplest unified experience we can create?**
   - Single setup command for compatible tools?
   - Automatic symlink creation?
   - Shared skill definitions?

## Files to Research

### Primary Sources:
- ✅ `AGENTS.md` (root level)
- ✅ `claude/README.md` + `claude/CLAUDE.md`
- ✅ `cursor/README.md` + `cursor/cursorrules`
- ✅ `copilot/README.md` + `copilot/copilot-instructions.md`
- ✅ `codex/README.md` + `codex/AGENTS.md`
- 📋 `gemini/README.md` + `gemini/GEMINI.md`
- 📋 `other-ai-assistants/AGENT-INSTRUCTIONS.md`
- 📋 `MIGRATION.md`
- 📋 `tool-setup/` directory (all files)

### Secondary Sources:
- Each tool's official documentation (via web search if needed)
- Community examples in `tool-setup/community/`
- Template files in each tool directory

## Data Sources

### Internal Research (No External Dependencies)
1. Read and analyze all tool-specific README files
2. Compare instruction file formats
3. Review existing AGENTS.md and tool-specific configs
4. Analyze template files in each directory
5. Check MIGRATION.md for insights

### External Research (If Needed)
1. Official tool documentation (via WebSearch)
   - Cursor docs on `.cursorrules` vs `AGENTS.md`
   - Codex CLI documentation on context loading
   - Gemini Code Assist documentation
2. GitHub repositories for each tool
3. Community usage patterns

## Success Criteria

This research phase is complete when we have:

- [ ] **Comparison Matrix Created**
  - All 6 tools documented with control model details
  - Clear categorization by shared characteristics

- [ ] **Tool Groups Defined**
  - Group A: Tools for unified setup (list + justification)
  - Group B: Tools requiring separate setup (list + justification)
  - Group C: Hybrid cases (list + approach)

- [ ] **Findings Document Complete**
  - Evidence-based grouping
  - Clear rationale for each decision
  - Recommendations for next steps

- [ ] **Unified Setup Strategy Proposed**
  - Which tools can share setup process
  - What symlinks/configs are needed
  - How skill systems can be unified

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Tool documentation is incomplete | May misclassify tools | Cross-reference with actual tool behavior, community examples |
| Tools claim features they don't have | Wrong grouping | Test assumptions with small experiments if unclear |
| Unified approach may not work for all | Over-engineering | Be pragmatic - some tools may always need custom setup |
| Breaking existing working setups | User frustration | Document current state thoroughly before proposing changes |

## Deviations from Standard PARA Workflow

**Note:** This is a **research-only** plan. No code changes will be made in this phase.

- **No git branch needed** - Only creating analysis documents
- **No implementation** - Pure research and documentation
- **Output:** Markdown documents in `context/data/`

After this research is complete and reviewed, we'll create a separate implementation plan for the actual unification work.

## Timeline & Sequencing

1. **Research Phase (This Plan)** - Create comparison matrix and findings
2. **Review Phase** - Human reviews findings and groups
3. **Implementation Planning Phase** - Create plan for actual unification
4. **Implementation Phase** - Execute unification based on approved plan

## Output Files

This research will produce:

1. **`context/data/2026-02-02-tool-comparison-matrix.md`**
   - Structured comparison table
   - Control model details for each tool
   - Grouping rationale

2. **`context/data/2026-02-02-tool-unification-findings.md`**
   - Detailed findings and analysis
   - Tool groupings with evidence
   - Recommendations for unification approach
   - Current state assessment

3. **`context/summaries/2026-02-02-tool-unification-research-summary.md`**
   - Summary of research findings
   - Key insights and decisions
   - Next steps for implementation

## Follow-up Work

After this research is approved:

1. **Create Unified Setup Plan** - Design the actual setup experience
2. **Update Documentation** - Revise README and setup guides
3. **Create Migration Guide** - Help existing users transition
4. **Test Unified Setup** - Verify it works across tools

---

**This is a research and analysis plan. No code changes will be made. The goal is to understand tool capabilities and create a clear grouping strategy before implementing any unification.**
