# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

> **Workflow Methodology:** This repository DEFINES the Pret-a-Program workflow. Do not follow the global `~/.claude/CLAUDE.md` methodology when working on this project - you are working on the methodology itself.

---

## 📌 Quick Reference

| Property | Value |
|----------|-------|
| **Purpose** | Documentation and templates for Pret-a-Program methodology |
| **Type** | Documentation repository (no runtime code) |
| **Primary Format** | Markdown |
| **Target Audience** | Developers using AI coding assistants (Claude, Copilot, Cursor, etc.) |

---

## 🎯 What This Project Does

Pret-a-Program is a methodology for AI-assisted software development that combines:
- **PARA Method** organizational principles (Projects, Areas, Resources, Archives)
- **Pair Programming** collaborative approach adapted for human-AI collaboration
- **Structured context management** via `context/` directories
- **Token efficiency** through MCP (Model Context Protocol) integration
- **Persistent memory** across development sessions

This repository contains the official documentation, setup guides, templates, and examples for implementing Pret-a-Program with various AI assistants.

---

## 📂 Repository Structure

```
pret-a-program/
├── README.md                    # Main overview and complete documentation
├── SETUP-GUIDE.md              # Quick setup reference for different AI assistants
│
├── claude/                     # Claude Code-specific guide
│   ├── README.md              # Full Claude implementation guide
│   ├── QUICKSTART.md          # 5-minute setup
│   └── CLAUDE.md              # Global methodology file (to copy to ~/.claude/)
│
├── codex/                      # Codex CLI-specific guide
│   ├── README.md              # Full Codex implementation guide
│   ├── QUICKSTART.md          # 5-minute setup
│   ├── CODEX.md               # Global methodology file (to copy to ~/.codex/)
│   └── templates/             # Project templates and preprocessing examples
│
├── copilot/                    # GitHub Copilot-specific guide
│   ├── README.md              # Full Copilot implementation guide
│   ├── QUICKSTART.md          # 5-minute setup
│   ├── copilot-instructions.md # Instructions file (to copy to .github/)
│   └── templates/             # Markdown templates for plans, summaries, etc.
│
├── cursor/                     # Cursor IDE-specific guide
│   ├── README.md              # Full Cursor implementation guide
│   ├── QUICKSTART.md          # 5-minute setup
│   └── templates/             # Markdown templates
│
└── other-ai-assistants/        # Universal agent instructions
    ├── AGENT-INSTRUCTIONS.md  # Platform-agnostic methodology
    └── examples/              # Example configurations for various tools
```

---

## 🛠 Key Documentation Files

### Core Documentation
- **README.md** (1014 lines): The complete Pret-a-Program guide
  - Comprehensive overview of methodology
  - Detailed workflow explanations with examples
  - MCP integration patterns
  - Best practices and FAQs

- **SETUP-GUIDE.md** (393 lines): Quick reference for initial setup
  - Links to platform-specific guides
  - Universal setup instructions
  - Troubleshooting common issues

### Platform-Specific Guides

Each AI assistant has its own directory with:
1. **README.md**: Complete implementation guide
2. **QUICKSTART.md**: Fast 5-10 minute setup
3. **Platform-specific files**: Configuration files users copy to their projects
4. **templates/**: Reusable markdown templates

### Global Methodology File

- **claude/CLAUDE.md** (623 lines): The source of truth for Pret workflow
  - Users copy this to `~/.claude/CLAUDE.md`
  - Defines the five-step workflow (Plan → Review → Execute → Summarize → Archive)
  - MCP integration patterns
  - Token efficiency strategies
  - Context directory structure

---

## 🎨 Editing Guidelines

### Documentation Principles

1. **Consistency is critical**: This is a methodology that users rely on. Changes must maintain consistency across:
   - README.md (main documentation)
   - claude/CLAUDE.md (global workflow file)
   - Platform-specific guides (copilot/, cursor/, etc.)
   - AGENT-INSTRUCTIONS.md (universal guide)

2. **Examples over theory**: Every concept should have a concrete example
   - Show real file paths, real code snippets
   - Use realistic scenarios (authentication, dark mode, bug fixes)
   - Include both "good" and "bad" examples where helpful

3. **Platform-specific accuracy**: When editing platform guides:
   - Test instructions for that specific IDE/tool
   - Use correct file paths for that platform (.cursorrules, .github/copilot-instructions.md, etc.)
   - Respect platform limitations (e.g., Copilot can't do multi-file edits)

4. **Keep it scannable**:
   - Use tables for comparisons
   - Use headers liberally
   - Include quick reference sections
   - Add emoji sparingly for navigation (📋, 🎯, 🛠, etc.)

### When Making Changes

Before modifying documentation:
1. **Identify scope**: Does this change affect just one platform or the core methodology?
2. **Update consistently**: If changing core workflow, update ALL guides
3. **Preserve structure**: Don't reorganize without strong justification
4. **Test examples**: Ensure code examples are valid and work

### Common Edit Patterns

| Change Type | Files to Update |
|-------------|----------------|
| **Core workflow change** | README.md, claude/CLAUDE.md, codex/CODEX.md, copilot/copilot-instructions.md, AGENT-INSTRUCTIONS.md |
| **New platform support** | Create new directory, add to SETUP-GUIDE.md, update README.md |
| **Template improvement** | Update in all template directories (copilot/templates/, cursor/templates/, codex/templates/, etc.) |
| **Example update** | Usually just README.md or specific platform guide |
| **MCP/preprocessing pattern change** | README.md, claude/CLAUDE.md (MCP), codex/CODEX.md (preprocessing) |

---

## 📝 File Naming Conventions

### Documentation Files
- **README.md**: Primary documentation for a directory
- **QUICKSTART.md**: Fast setup guide (aim for 5-10 minutes)
- **SETUP-GUIDE.md**: Comprehensive setup instructions
- Platform-specific names: `copilot-instructions.md`, `CLAUDE.md`, etc.

### Templates
- Located in `*/templates/` directories
- Named by purpose: `plan-template.md`, `summary-template.md`, `context-template.md`
- Should be copy-paste ready

### Directory Names
- Lowercase with hyphens: `other-ai-assistants/`, not `Other_AI_Assistants/`
- Platform names match conventions: `copilot/` (lowercase), `claude/` (lowercase)

---

## 🧩 Terminology & Concepts

### Pret-a-Program Concepts

| Term | Definition |
|------|----------|
| **PARA** | Projects, Areas, Resources, Archives - organizational method from Tiago Forte |
| **Second Brain** | The combined system of human, AI, context directory, and MCP tools |
| **Context Directory** | The `context/` folder structure for persistent memory |
| **MCP** | Model Context Protocol - tool integration for preprocessing and execution |
| **Five-Step Workflow** | Plan → Review → Execute → Summarize → Archive |
| **Token Efficiency** | Minimizing context window usage through preprocessing and selective loading |

### File Types in context/ Directory

| Directory | Purpose | Filename Pattern |
|-----------|---------|-----------------|
| `context/plans/` | Pre-work planning documents | `YYYY-MM-DD-task-name.md` |
| `context/summaries/` | Post-work reports | `YYYY-MM-DD-task-name-summary.md` |
| `context/data/` | Input/output files, payloads | `YYYY-MM-DD-descriptive-name.ext` |
| `context/archives/` | Historical context snapshots | `YYYY-MM-DD-context.md` |
| `context/servers/` | MCP tool wrappers | No date prefix (persistent tools) |

---

## ✍️ Writing Style

### Voice and Tone
- **Direct and practical**: Users are developers who want to get started quickly
- **Authoritative but approachable**: This is a methodology, not a suggestion
- **Example-driven**: Show, don't just tell
- **Consistent terminology**: Use the same terms throughout (don't switch between "agent" and "AI assistant" randomly)

### Formatting Conventions
- **Bold** for emphasis on key concepts
- `Code blocks` for file paths, commands, and code
- > Blockquotes for important notes or Claude's responses
- Tables for comparisons and structured data
- ✅ ❌ ⚠️ for clear yes/no/partial indicators

### Command Examples
Always provide complete, copy-paste-ready commands:

```bash
# Good: Full context with comments
mkdir -p context/{data,plans,summaries,archives,servers}
cat > context/context.md << 'EOF'
# Current Work Summary
...
EOF

# Bad: Incomplete or vague
# Create the directories and file
```

---

## 🔍 Common Maintenance Tasks

### Adding a New AI Assistant Guide

1. Create directory: `new-assistant/`
2. Copy structure from existing guide (e.g., `copilot/`)
3. Create README.md, QUICKSTART.md, and platform-specific config
4. Add entry to SETUP-GUIDE.md compatibility matrix
5. Link from main README.md
6. Update agent compatibility table in AGENT-INSTRUCTIONS.md

### Updating the Core Workflow

1. Update claude/CLAUDE.md first (source of truth)
2. Update README.md workflow section
3. Update all platform-specific guides (copilot/, cursor/, etc.)
4. Update AGENT-INSTRUCTIONS.md
5. Check all examples still align with new workflow

### Fixing Inconsistencies

Common areas where inconsistencies creep in:
- File path examples (ensure they match the documented structure)
- Workflow step names (always use: Plan, Review, Execute, Summarize, Archive)
- Directory names (context/plans/ not context/plan/)
- Date formats (YYYY-MM-DD, not MM-DD-YYYY)

---

## 🚫 What NOT to Do

### Don't Add Runtime Code
This is a **documentation repository**. It should not contain:
- npm packages or package.json
- Executable scripts (except maybe simple documentation generation)
- Programming language implementations
- Database schemas or migrations

### Don't Fragment the Methodology
The core Pret workflow must stay consistent. Don't create:
- Alternative workflows without strong justification
- Platform-specific methodology variations (only implementation details vary)
- Competing terminology for the same concepts

### Don't Sacrifice Accessibility
Keep documentation:
- Scannable (headers, tables, lists)
- Self-contained (don't require reading all 1000 lines to understand one section)
- Navigable (clear table of contents, cross-references)

---

## 🧪 Testing Documentation Changes

Before committing documentation changes:

1. **Read as a newcomer**: Would someone new to Pret-a-Program understand this?
2. **Follow the instructions**: Can you actually complete the setup steps?
3. **Check examples**: Do all code examples work? Are file paths correct?
4. **Verify links**: Do all internal references point to existing sections?
5. **Check consistency**: Does this align with the terminology used elsewhere?

---

## 💡 Contributing Philosophy

This repository follows its own methodology (meta!):

### For Large Changes
1. **Create a plan** in `context/plans/YYYY-MM-DD-change-description.md`
   - What are you changing and why?
   - Which files will be modified?
   - How will this affect users?
2. **Get feedback** before implementation
3. **Make changes** following consistency guidelines
4. **Document in summary** at `context/summaries/YYYY-MM-DD-change-description.md`
5. **Archive context** when complete

### For Small Changes
- Typo fixes, link corrections, minor clarifications can skip the formal workflow
- But still maintain consistency and test the changes

---

## 📖 Additional Context

### Project Origins
- Inspired by Tiago Forte's PARA method for knowledge management
- Adapted for AI-assisted development with Claude Code
- Designed to work across multiple AI assistants (tool-agnostic methodology)

### Target Users
1. **Individual developers** using AI coding assistants
2. **Engineering teams** standardizing AI-assisted development
3. **Consultants** managing multiple client projects
4. **Educators** teaching AI-assisted development practices

### Related Resources
- [Tiago Forte's PARA Method](https://fortelabs.com/blog/para/)
- [Model Context Protocol Spec](https://modelcontextprotocol.io/)
- [Anthropic Claude Documentation](https://docs.anthropic.com/claude/docs)

---

## ⚡ Quick Commands Reference

This repository has no build system or test suite. Common tasks:

### View Directory Structure
```bash
tree -L 2 -I 'node_modules|.git'
```

### Find All Templates
```bash
find . -name "*-template.md"
```

### Check for Broken Internal Links
```bash
# Look for .md references
grep -r "](.*\.md" --include="*.md"
```

### Word Count for Main Docs
```bash
wc -l README.md SETUP-GUIDE.md claude/CLAUDE.md
```

---

## 🎯 Success Criteria for Changes

A good documentation change:
- ✅ Maintains consistency across all platform guides
- ✅ Includes concrete examples where appropriate
- ✅ Preserves the five-step workflow structure
- ✅ Is easy to scan and navigate
- ✅ Works when copy-pasted (for code/command examples)
- ✅ Improves clarity without adding unnecessary length
- ✅ Aligns with Pret-a-Program terminology and principles

---

**Remember**: Users depend on this documentation to structure their entire AI-assisted development workflow. Precision, consistency, and clarity are paramount.
