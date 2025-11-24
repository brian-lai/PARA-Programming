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

# Install global CLAUDE.md (using symlink)
echo "📄 Installing global CLAUDE.md..."
if [ -L "$CLAUDE_DIR/CLAUDE.md" ]; then
    echo "⚠️  Global CLAUDE.md symlink already exists."
    CURRENT_TARGET=$(readlink "$CLAUDE_DIR/CLAUDE.md")
    echo "   Current target: $CURRENT_TARGET"
    read -p "   Replace with new symlink? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm "$CLAUDE_DIR/CLAUDE.md"
        ln -s "$SKILL_DIR/../CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
        echo "   ✅ Symlink updated"
    else
        echo "   ⏭️  Skipped"
    fi
elif [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    echo "⚠️  Global CLAUDE.md file exists (not a symlink)."
    echo "   This will be replaced with a symlink to get automatic updates."
    read -p "   Replace with symlink? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm "$CLAUDE_DIR/CLAUDE.md"
        ln -s "$SKILL_DIR/../CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
        echo "   ✅ Symlink created"
    else
        echo "   ⏭️  Skipped"
    fi
else
    ln -s "$SKILL_DIR/../CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    echo "   ✅ Symlink created"
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
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✨ Installation Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ Global CLAUDE.md is symlinked to:"
echo "   $SKILL_DIR/../CLAUDE.md"
echo ""
echo "💡 To get methodology updates:"
echo "   cd $(dirname "$SKILL_DIR")"
echo "   git pull origin main"
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
