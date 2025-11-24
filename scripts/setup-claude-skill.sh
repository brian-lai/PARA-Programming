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

# Check if already set up
if check_symlink "$GLOBAL_CLAUDE_MD" "$CLAUDE_DIR/CLAUDE.md"; then
    command_count=$(ls -1 "$COMMANDS_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
    if [ "$command_count" -eq 8 ]; then
        print_success "✨ Already set up correctly!"
        print_info "Global CLAUDE.md: ✓"
        print_info "PARA commands: ✓ (8/8)"
        echo ""
        print_info "To reinstall, first run: make uninstall claude-skill"
        exit 0
    fi
fi

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
    copy_directory "$SKILL_DIR/commands" "$COMMANDS_DIR" "*.md" "PARA commands"
else
    print_error "Commands directory not found"
    exit 1
fi

echo ""
print_step "Step 4: Installing SessionStart hook"
HOOKS_DIR="$CLAUDE_DIR/hooks"
create_dir "$HOOKS_DIR"

# Copy hook script
if [ -f "$SKILL_DIR/hooks/para-session-start.sh" ]; then
    cp "$SKILL_DIR/hooks/para-session-start.sh" "$HOOKS_DIR/"
    chmod +x "$HOOKS_DIR/para-session-start.sh"
    print_success "Installed SessionStart hook"
else
    print_warning "Hook script not found, skipping"
fi

# Configure settings.json
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
if [ -f "$SETTINGS_FILE" ]; then
    # Settings file exists - check if hooks already configured
    if grep -q '"SessionStart"' "$SETTINGS_FILE" 2>/dev/null; then
        print_info "SessionStart hook already configured in settings.json"
    else
        # Merge hook configuration using jq if available
        if command -v jq &> /dev/null; then
            print_info "Adding SessionStart hook to existing settings.json"
            # Backup existing file
            cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
            # Merge hook configuration
            jq '. + {"hooks": {"SessionStart": [{"hooks": [{"type": "command", "command": "bash ~/.claude/hooks/para-session-start.sh"}]}]}}' \
                "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
            print_success "Added SessionStart hook to settings.json"
            print_info "Backup saved to settings.json.backup"
        else
            # jq not available, warn user
            print_warning "jq not found - cannot automatically merge settings"
            print_info "Please manually add SessionStart hook to $SETTINGS_FILE:"
            echo ""
            echo '  "hooks": {'
            echo '    "SessionStart": [{'
            echo '      "hooks": [{'
            echo '        "type": "command",'
            echo '        "command": "bash ~/.claude/hooks/para-session-start.sh"'
            echo '      }]'
            echo '    }]'
            echo '  }'
            echo ""
        fi
    fi
else
    # Create new settings.json with hook configuration
    cat > "$SETTINGS_FILE" <<'SETTINGS_EOF'
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/para-session-start.sh"
          }
        ]
      }
    ]
  }
}
SETTINGS_EOF
    print_success "Created settings.json with SessionStart hook"
fi

echo ""
print_step "Step 5: Verifying installation"
verify_symlink "$CLAUDE_DIR/CLAUDE.md" "Global CLAUDE.md"

# Count installed commands
command_count=$(ls -1 "$COMMANDS_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
if [ "$command_count" -eq 8 ]; then
    print_success "All 8 PARA commands installed"
else
    print_warning "Expected 8 commands, found $command_count"
fi

# Print completion
print_completion "Claude Code (with skill)"

echo "Available Commands:"
echo "  /para-init           - Initialize PARA structure"
echo "  /para-plan           - Create a plan"
echo "  /para-summarize      - Generate summary"
echo "  /para-archive        - Archive context"
echo "  /para-status         - Show status"
echo "  /para-check          - Decision helper"
echo "  /para-help           - Complete guide"
echo "  /init-para-claude    - Initialize project CLAUDE.md"
echo ""
echo "SessionStart Hook:"
echo "  ✓ Installed - Shows status on Claude Code startup"
echo ""

print_update_instructions

echo "Documentation:"
echo "  Skill README: $SKILL_DIR/README.md"
echo "  Installation: $SKILL_DIR/INSTALL.md"
echo "  Quickstart:   $REPO_ROOT/claude/QUICKSTART.md"
echo ""

print_success "Setup complete! Start Claude Code and try: /para-init"
