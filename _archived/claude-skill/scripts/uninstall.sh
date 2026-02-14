#!/bin/bash
#
# PARA-Programming Skill Uninstallation Script
# Removes slash commands (preserves global CLAUDE.md by default)
#

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  PARA-Programming Skill Uninstaller"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Set paths
CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"

echo "⚠️  This will remove PARA slash commands."
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Uninstall cancelled"
    exit 0
fi

# Remove commands
echo ""
echo "🗑️  Removing slash commands..."
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
        rm "$COMMANDS_DIR/${cmd}.md"
        echo "   ✅ Removed ${cmd}.md"
    else
        echo "   ⏭️  ${cmd}.md (not found)"
    fi
done

# Ask about global CLAUDE.md
echo ""
echo "📄 Global CLAUDE.md contains your workflow methodology."
read -p "Remove global CLAUDE.md too? (y/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
        rm "$CLAUDE_DIR/CLAUDE.md"
        echo "   ✅ Removed CLAUDE.md"
    else
        echo "   ⏭️  CLAUDE.md (not found)"
    fi
else
    echo "   ⏭️  Keeping CLAUDE.md"
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✨ Uninstall Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "To reinstall:"
echo "  $ ./scripts/install.sh"
echo ""
