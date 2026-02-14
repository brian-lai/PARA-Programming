# Pret-a-Program for Cursor

Cursor rules file providing the Pret-a-Program methodology.

## Installation

### Via `pret` CLI (recommended)

```bash
pret install-skills --cursor
```

### Manual

Copy the rules file to your project:

```bash
mkdir -p .cursor/rules
cp skills/cursor/rules/pret-a-program.md .cursor/rules/
```

## How It Works

Cursor reads `.cursor/rules/*.md` files as project instructions. The `pret-a-program.md` file provides the methodology that guides Cursor's AI to follow the structured workflow.

## Usage

Once installed, Cursor will automatically follow the Pret workflow when you ask it to make code changes. Start by describing your task in the Chat sidebar.
