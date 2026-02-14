#!/bin/bash
# Deprecated: Use `pret install-skills` instead. See README.md for details.
#
# Update script for Claude Code with Pret-a-Program skill
# Checks if using symlinks and provides update guidance
#

set -e

# Get script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "Update Claude Code + Pret-a-Program Skill"

# Set paths
CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
GLOBAL_CLAUDE_MD="$REPO_ROOT/CLAUDE.md"
SKILL_DIR="$REPO_ROOT/skills/claude-code"

# Check if setup exists
if [ ! -e "$CLAUDE_DIR/CLAUDE.md" ]; then
    print_error "Claude Code not set up yet"
    echo ""
    echo "Run setup first:"
    echo "  make setup claude-skill"
    exit 1
fi

# Check if commands directory exists
if [ ! -d "$COMMANDS_DIR" ]; then
    print_error "Commands directory not found: $COMMANDS_DIR"
    echo ""
    echo "Run setup first:"
    echo "  make setup claude-skill"
    exit 1
fi

# Check if using symlinks (recommended)
if check_symlink "$GLOBAL_CLAUDE_MD" "$CLAUDE_DIR/CLAUDE.md"; then
    print_success "✨ Global CLAUDE.md is symlinked (auto-updates)"
    echo ""

    # Commands need to be re-copied
    print_step "Updating slash commands..."
    echo ""

    # Backup existing commands
    if [ -d "$COMMANDS_DIR" ] && [ "$(ls -A $COMMANDS_DIR/*.md 2>/dev/null)" ]; then
        backup_dir="$COMMANDS_DIR/backup-$(date +%Y%m%d-%H%M%S)"
        mkdir -p "$backup_dir"
        mv "$COMMANDS_DIR"/*.md "$backup_dir/" 2>/dev/null || true
        print_info "Backed up existing commands to: $backup_dir"
    fi

    # Copy updated commands
    copy_directory "$SKILL_DIR/commands" "$COMMANDS_DIR" "*.md" "Pret commands"

    # Count installed commands
    command_count=$(ls -1 "$COMMANDS_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
    expected_count=$(ls -1 "$SKILL_DIR/commands"/*.md 2>/dev/null | wc -l | tr -d ' ')

    if [ "$command_count" -eq "$expected_count" ]; then
        print_success "All $command_count Pret commands updated"
    else
        print_warning "Expected $expected_count commands, found $command_count"
    fi

    # Update hooks if they exist
    echo ""
    print_step "Checking SessionStart hook..."
    HOOKS_DIR="$CLAUDE_DIR/hooks"
    if [ -f "$SKILL_DIR/hooks/para-session-start.sh" ]; then
        if [ ! -d "$HOOKS_DIR" ]; then
            mkdir -p "$HOOKS_DIR"
        fi
        cp "$SKILL_DIR/hooks/para-session-start.sh" "$HOOKS_DIR/"
        chmod +x "$HOOKS_DIR/para-session-start.sh"
        print_success "Updated SessionStart hook"
    fi

    echo ""
    print_success "✨ Update complete!"
    print_info "Global methodology (CLAUDE.md) auto-updates with 'git pull'"
    print_info "Slash commands updated to latest version"
    print_info "SessionStart hook updated"
    exit 0
else
    # Using regular files - offer to convert to symlinks
    print_warning "Not using symlinks - updates require manual copying"
    echo ""
    echo "You have two options:"
    echo ""
    echo "1. Convert to symlinks (recommended):"
    echo "   - Future updates will be automatic"
    echo "   - Just run 'git pull' to stay current"
    echo ""
    echo "2. Re-copy files manually:"
    echo "   - Replaces files with latest version"
    echo "   - Requires manual update each time"
    echo ""
    read -p "Convert to symlinks? (y/N): " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_step "Converting to symlinks..."

        # Backup existing file
        if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
            mv "$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.backup"
            print_info "Backed up existing file to CLAUDE.md.backup"
        fi

        # Create symlink
        create_symlink "$GLOBAL_CLAUDE_MD" "$CLAUDE_DIR/CLAUDE.md" "Global CLAUDE.md"

        print_success "✨ Converted to symlinks!"
        echo ""
        print_info "Future updates are now automatic with 'git pull'!"
    else
        print_step "Re-copying files..."
        echo ""

        # Copy global methodology
        cp "$GLOBAL_CLAUDE_MD" "$CLAUDE_DIR/CLAUDE.md"
        print_success "Updated CLAUDE.md"

        # Backup existing commands
        if [ -d "$COMMANDS_DIR" ] && [ "$(ls -A $COMMANDS_DIR/*.md 2>/dev/null)" ]; then
            backup_dir="$COMMANDS_DIR/backup-$(date +%Y%m%d-%H%M%S)"
            mkdir -p "$backup_dir"
            mv "$COMMANDS_DIR"/*.md "$backup_dir/" 2>/dev/null || true
            print_info "Backed up existing commands to: $backup_dir"
        fi

        # Copy updated commands
        copy_directory "$SKILL_DIR/commands" "$COMMANDS_DIR" "*.md" "Pret commands"

        # Count installed commands
        command_count=$(ls -1 "$COMMANDS_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
        expected_count=$(ls -1 "$SKILL_DIR/commands"/*.md 2>/dev/null | wc -l | tr -d ' ')

        if [ "$command_count" -eq "$expected_count" ]; then
            print_success "All $command_count Pret commands updated"
        else
            print_warning "Expected $expected_count commands, found $command_count"
        fi

        # Update hooks if they exist
        echo ""
        print_step "Checking SessionStart hook..."
        HOOKS_DIR="$CLAUDE_DIR/hooks"
        if [ -f "$SKILL_DIR/hooks/para-session-start.sh" ]; then
            if [ ! -d "$HOOKS_DIR" ]; then
                mkdir -p "$HOOKS_DIR"
            fi
            cp "$SKILL_DIR/hooks/para-session-start.sh" "$HOOKS_DIR/"
            chmod +x "$HOOKS_DIR/para-session-start.sh"
            print_success "Updated SessionStart hook"
        fi

        echo ""
        print_success "✨ Update complete!"
        print_info "Files updated. For automatic updates in the future,"
        print_info "consider converting to symlinks: make update-claude-skill"
    fi
fi
