#!/bin/bash
#
# Update script for Cursor IDE with PARA-Programming
#

set -e

# Get script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "Update Cursor IDE + PARA-Programming"

# Set paths
CURSORRULES_SOURCE="$REPO_ROOT/cursor/.cursorrules"
CURSORRULES_TARGET="$HOME/.cursorrules"

# Check if setup exists
if [ ! -e "$CURSORRULES_TARGET" ]; then
    print_error "Cursor not set up yet"
    echo ""
    echo "Run setup first:"
    echo "  make setup cursor"
    exit 1
fi

# Check if using symlinks (recommended)
if check_symlink "$CURSORRULES_SOURCE" "$CURSORRULES_TARGET"; then
    print_success "✨ Using symlinks - updates are automatic!"
    echo ""
    print_info "Your setup uses symlinks, which means updates are automatic."
    print_info "Just run: git pull origin main"
    echo ""
    print_info "No action needed. You're already on the latest version!"
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
        if [ -f "$CURSORRULES_TARGET" ]; then
            mv "$CURSORRULES_TARGET" "$CURSORRULES_TARGET.backup"
            print_info "Backed up existing file to .cursorrules.backup"
        fi

        # Create symlink
        create_symlink "$CURSORRULES_SOURCE" "$CURSORRULES_TARGET" "Cursor rules"

        print_success "✨ Converted to symlinks!"
        echo ""
        print_info "Future updates are now automatic with 'git pull'!"
    else
        print_step "Re-copying files..."

        # Copy files
        cp "$CURSORRULES_SOURCE" "$CURSORRULES_TARGET"
        print_success "Updated .cursorrules"

        echo ""
        print_info "Files updated. For automatic updates in the future,"
        print_info "consider converting to symlinks: make update cursor"
    fi
fi
