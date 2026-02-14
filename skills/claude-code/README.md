# Pret-a-Program Skill for Claude Code

Adds `/pret-*` slash commands to Claude Code for structured AI-assisted development.

## Commands

| Command | Description |
|---------|-------------|
| `/pret-init` | Initialize Pret-a-Program in current project |
| `/pret-plan` | Create a new planning document |
| `/pret-execute` | Start execution with branch and tracking |
| `/pret-summarize` | Generate post-work summary |
| `/pret-archive` | Archive context and reset |
| `/pret-status` | Show current workflow state |
| `/pret-check` | Decision helper: should I use Pret? |

## Installation

### Via `pret` CLI (recommended)

```bash
pret install-skills --claude
```

### Manual

Copy this directory to your Claude Code skills location:

```bash
cp -r skills/claude-code/ ~/.claude/skills/pret-a-program/
```

## Usage

After installation, use the commands in any Claude Code session:

```
/pret-init          # Set up project structure
/pret-plan my-task  # Create a plan
/pret-execute       # Start implementation
/pret-summarize     # Document results
/pret-archive       # Clean up for next task
```
