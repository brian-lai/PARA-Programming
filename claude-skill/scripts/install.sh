#!/bin/bash
#
# PARA-Programming Skill Installation Script
# Installs slash commands and global CLAUDE.md for Claude Code
#

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  PARA-Programming Skill Installer"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    CYGWIN*|MINGW*|MSYS*) MACHINE=Windows;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo "🖥️  Detected OS: ${MACHINE}"
echo ""

# Set paths
CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "📁 Installation paths:"
echo "   Global CLAUDE.md: $CLAUDE_DIR/CLAUDE.md"
echo "   Commands: $COMMANDS_DIR/"
echo ""

# Create directories
echo "📂 Creating directories..."
mkdir -p "$CLAUDE_DIR"
mkdir -p "$COMMANDS_DIR"

# Install global CLAUDE.md
echo "📄 Installing global CLAUDE.md..."
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    echo "⚠️  Global CLAUDE.md already exists."
    read -p "   Overwrite? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp "$SKILL_DIR/../CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
        echo "   ✅ Overwritten"
    else
        echo "   ⏭️  Skipped"
    fi
else
    cp "$SKILL_DIR/../CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    echo "   ✅ Installed"
fi

# Install commands
echo ""
echo "🔧 Installing slash commands..."
COMMANDS=(
    "para-init"
    "para-plan"
    "para-summarize"
    "para-archive"
    "para-status"
    "para-check"
)

for cmd in "${COMMANDS[@]}"; do
    if [ -f "$COMMANDS_DIR/${cmd}.md" ]; then
        echo "   ⚠️  ${cmd}.md exists (skipping)"
    else
        cp "$SKILL_DIR/commands/${cmd}.md" "$COMMANDS_DIR/"
        echo "   ✅ ${cmd}.md"
    fi
done

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✨ Installation Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Start Claude Code in your project:"
echo "   $ cd your-project && claude"
echo ""
echo "2. Initialize PARA structure:"
echo "   /para-init"
echo ""
echo "3. Check available commands:"
echo "   /help"
echo ""
echo "4. Start your first task:"
echo "   /para-plan \"your task description\""
echo ""
echo "🎉 Happy PARA-Programming!"
echo ""
