#!/bin/bash
#
# Setup script for Claude Code with PARA-Programming skill
# This is the recommended setup method
#

set -e

# Get script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "Claude Code + PARA-Programming Skill Setup"

# Check requirements
check_requirements || exit 1

# Detect OS
OS=$(detect_os)
print_info "Detected OS: $OS"

# Set paths
CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
GLOBAL_CLAUDE_MD="$REPO_ROOT/CLAUDE.md"
SKILL_DIR="$REPO_ROOT/claude-skill"

echo ""
print_step "Step 1: Creating directories"
create_dir "$CLAUDE_DIR"
create_dir "$COMMANDS_DIR"

echo ""
print_step "Step 2: Creating symlink to global CLAUDE.md"
create_symlink "$GLOBAL_CLAUDE_MD" "$CLAUDE_DIR/CLAUDE.md" "Global CLAUDE.md"

echo ""
print_step "Step 3: Installing slash commands"
if [ -d "$COMMANDS_DIR" ]; then
    copy_directory "$SKILL_DIR/commands" "$COMMANDS_DIR" "para-*.md" "PARA commands"
else
    print_error "Commands directory not found"
    exit 1
fi

echo ""
print_step "Step 4: Verifying installation"
verify_symlink "$CLAUDE_DIR/CLAUDE.md" "Global CLAUDE.md"

# Count installed commands
command_count=$(ls -1 "$COMMANDS_DIR"/para-*.md 2>/dev/null | wc -l | tr -d ' ')
if [ "$command_count" -eq 6 ]; then
    print_success "All 6 PARA commands installed"
else
    print_warning "Expected 6 commands, found $command_count"
fi

# Print completion
print_completion "Claude Code (with skill)"

echo "Available Commands:"
echo "  /para-init       - Initialize PARA structure"
echo "  /para-plan       - Create a plan"
echo "  /para-summarize  - Generate summary"
echo "  /para-archive    - Archive context"
echo "  /para-status     - Show status"
echo "  /para-check      - Decision helper"
echo ""

print_update_instructions

echo "Documentation:"
echo "  Skill README: $SKILL_DIR/README.md"
echo "  Installation: $SKILL_DIR/INSTALL.md"
echo "  Quickstart:   $REPO_ROOT/claude/QUICKSTART.md"
echo ""

print_success "Setup complete! Start Claude Code and try: /para-init"
