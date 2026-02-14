#!/bin/bash
# Deprecated: Use `pret install-skills` instead. See README.md for details.
#
# Setup script for Claude Code (legacy, without skill)
# Use setup-claude-skill.sh for the recommended setup with commands
#

set -e

# Get script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "Claude Code (Legacy) Setup"

# Check requirements
check_requirements || exit 1

# Detect OS
OS=$(detect_os)
print_info "Detected OS: $OS"

# Set paths
CLAUDE_DIR="$HOME/.claude"
GLOBAL_CLAUDE_MD="$REPO_ROOT/CLAUDE.md"

echo ""
print_step "Step 1: Creating .claude directory"
create_dir "$CLAUDE_DIR"

echo ""
print_step "Step 2: Creating symlink to global CLAUDE.md"
create_symlink "$GLOBAL_CLAUDE_MD" "$CLAUDE_DIR/CLAUDE.md" "Global CLAUDE.md"

echo ""
print_step "Step 3: Verifying installation"
verify_symlink "$CLAUDE_DIR/CLAUDE.md" "Global CLAUDE.md"

# Print completion
print_completion "Claude Code (legacy)"

echo "Note: This is the legacy setup without slash commands."
echo "For a better experience, consider:"
echo "  make setup claude-skill"
echo ""

print_update_instructions

echo "Documentation:"
echo "  Claude README: $REPO_ROOT/claude/README.md"
echo "  Quickstart:    $REPO_ROOT/claude/QUICKSTART.md"
echo ""

print_success "Setup complete! Start Claude Code and begin using Pret methodology"
