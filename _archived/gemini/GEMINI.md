# GEMINI.md

This file provides guidance to Gemini when working with code in this repository.

> **Workflow Methodology:** This repository DEFINES the PARA-Programming workflow. Do not follow the global `~/.gemini/GEMINI.md` methodology when working on this project - you are working on the methodology itself.

---

## 📌 Quick Reference

| Property | Value |
|----------|-------|
| **Purpose** | Documentation and templates for PARA-Programming methodology |
| **Type** | Documentation repository (no runtime code) |
| **Primary Format** | Markdown |
| **Target Audience** | Developers using AI coding assistants (Gemini, Claude, Copilot, Cursor, etc.) |

---

## 🎯 What This Project Does

PARA-Programming is a methodology for AI-assisted software development that combines:
- **PARA Method** organizational principles (Projects, Areas, Resources, Archives)
- **Pair Programming** collaborative approach adapted for human-AI collaboration
- **Structured context management** via `context/` directories
- **Token efficiency** through MCP (Model Context Protocol) integration
- **Persistent memory** across development sessions

This repository contains the official documentation, setup guides, templates, and examples for implementing PARA-Programming with various AI assistants.

---

## 📂 Repository Structure

```
para-programming/
├── README.md                    # Main overview and complete documentation
├── SETUP-GUIDE.md              # Quick setup reference for different AI assistants
│
├── gemini/                     # Gemini-specific guide
│   ├── README.md              # Full Gemini implementation guide
│   ├── QUICKSTART.md          # 5-minute setup
│   └── GEMINI.md              # Global methodology file (to copy to ~/.gemini/)
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
- **README.md**: The complete PARA-Programming guide
- **SETUP-GUIDE.md**: Quick reference for initial setup

### Platform-Specific Guides

Each AI assistant has its own directory with:
1. **README.md**: Complete implementation guide
2. **QUICKSTART.md**: Fast 5-10 minute setup
3. **Platform-specific files**: Configuration files users copy to their projects
4. **templates/**: Reusable markdown templates

### Global Methodology File

- **gemini/GEMINI.md**: The source of truth for PARA workflow
  - Users copy this to `~/.gemini/GEMINI.md`
  - Defines the five-step workflow (Plan → Review → Execute → Summarize → Archive)
  - Token efficiency strategies
  - Context directory structure

---

## 🎨 Editing Guidelines

### Documentation Principles

1. **Consistency is critical**: This is a methodology that users rely on. Changes must maintain consistency across all guides.
2. **Examples over theory**: Every concept should have a concrete example.
3. **Platform-specific accuracy**: When editing platform guides, test instructions for that specific IDE/tool.
4. **Keep it scannable**: Use tables, headers, and lists to make the content easy to digest.

---

## 📝 File Naming Conventions

### Documentation Files
- **README.md**: Primary documentation for a directory
- **QUICKSTART.md**: Fast setup guide (aim for 5-10 minutes)
- **SETUP-GUIDE.md**: Comprehensive setup instructions
- Platform-specific names: `copilot-instructions.md`, `CLAUDE.md`, `GEMINI.md`, etc.

### Templates
- Located in `*/templates/` directories
- Named by purpose: `plan-template.md`, `summary-template.md`, `context-template.md`
- Should be copy-paste ready

### Directory Names
- Lowercase with hyphens: `other-ai-assistants/`, not `Other_AI_Assistants/`
- Platform names match conventions: `gemini/`, `copilot/` (lowercase), `claude/` (lowercase)

---

## 🧩 Terminology & Concepts

### PARA-Programming Concepts

| Term | Definition |
|------|----------|
| **PARA** | Projects, Areas, Resources, Archives - organizational method from Tiago Forte |
| **Second Brain** | The combined system of human, AI, context directory, and MCP tools |
| **Context Directory** | The `context/` folder structure for persistent memory |
| **Five-Step Workflow** | Plan → Review → Execute → Summarize → Archive |
| **Token Efficiency** | Minimizing context window usage through preprocessing and selective loading |

### File Types in context/ Directory

| Directory | Purpose | Filename Pattern |
|-----------|---------|-----------------|
| `context/plans/` | Pre-work planning documents | `YYYY-MM-DD-task-name.md` |
| `context/summaries/` | Post-work reports | `YYYY-MM-DD-task-name-summary.md` |
| `context/data/` | Input/output files, payloads | `YYYY-MM-DD-descriptive-name.ext` |
| `context/archives/` | Historical context snapshots | `YYYY-MM-DD-context.md` |

---

## ✍️ Writing Style

### Voice and Tone
- **Direct and practical**: Users are developers who want to get started quickly.
- **Authoritative but approachable**: This is a methodology, not a suggestion.
- **Example-driven**: Show, don't just tell.
- **Consistent terminology**: Use the same terms throughout.

---

## 🚫 What NOT to Do

### Don't Add Runtime Code
This is a **documentation repository**. It should not contain runtime code.

### Don't Fragment the Methodology
The core PARA workflow must stay consistent.

---

## 🎯 Success Criteria for Changes

A good documentation change:
- ✅ Maintains consistency across all platform guides
- ✅ Includes concrete examples where appropriate
- ✅ Preserves the five-step workflow structure
- ✅ Is easy to scan and navigate
- ✅ Works when copy-pasted (for code/command examples)
- ✅ Improves clarity without adding unnecessary length
- ✅ Aligns with PARA-Programming terminology and principles

---

**Remember**: Users depend on this documentation to structure their entire AI-assisted development workflow. Precision, consistency, and clarity are paramount.
