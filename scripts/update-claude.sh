#!/bin/bash
#
# Update script for Claude Code (legacy, no skill)
#

set -e

# Get script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "Update Claude Code (Legacy) + PARA-Programming"

# Set paths
CLAUDE_DIR="$HOME/.claude"
GLOBAL_CLAUDE_MD="$REPO_ROOT/CLAUDE.md"

# Check if setup exists
if [ ! -e "$CLAUDE_DIR/CLAUDE.md" ]; then
    print_error "Claude Code not set up yet"
    echo ""
    echo "Run setup first:"
    echo "  make setup claude"
    exit 1
fi

# Check if using symlinks (recommended)
if check_symlink "$GLOBAL_CLAUDE_MD" "$CLAUDE_DIR/CLAUDE.md"; then
    print_success "✨ Using symlinks - updates are automatic!"
    echo ""
    print_info "Your setup uses symlinks, which means updates are automatic."
    print_info "Just run: git pull origin main"
    echo ""
    print_info "No action needed. You're already on the latest version!"
    echo ""
    print_info "💡 Tip: Consider upgrading to claude-skill for slash commands:"
    print_info "   make setup claude-skill"
    exit 0
else
    # Using regular files - offer to convert to symlinks
    print_warning "Not using symlinks - updates require manual copying"
    echo ""
    read -p "Convert to symlinks for automatic updates? (y/N): " -n 1 -r
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
        echo ""
        print_info "💡 Tip: Consider upgrading to claude-skill for slash commands:"
        print_info "   make setup claude-skill"
    else
        print_step "Re-copying files..."

        # Copy files
        cp "$GLOBAL_CLAUDE_MD" "$CLAUDE_DIR/CLAUDE.md"
        print_success "Updated CLAUDE.md"

        echo ""
        print_info "Files updated. For automatic updates in the future,"
        print_info "consider converting to symlinks: make update claude"
    fi
fi
