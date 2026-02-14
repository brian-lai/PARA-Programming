# Pret-a-Program for Codex CLI

OpenAI Codex CLI natively reads `AGENTS.md` - no special installation needed.

## Installation

### Via `pret` CLI (recommended)

```bash
pret install-skills --codex
```

This copies the AGENTS.md template to your project root (if it doesn't already exist).

### Manual

Ensure `AGENTS.md` exists in your project root:

```bash
# If you ran pret init, AGENTS.md already exists
ls AGENTS.md

# Otherwise, copy from skills
cp skills/codex/AGENTS.md ./AGENTS.md
```

## How It Works

Codex CLI reads `AGENTS.md` from the project root automatically. The file contains the full Pret-a-Program methodology that guides Codex to follow the structured workflow.

## Usage

Start Codex CLI in your project directory and describe your task. Codex will follow the Pret workflow automatically.
