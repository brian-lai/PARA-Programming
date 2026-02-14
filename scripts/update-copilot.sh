#!/bin/bash
# Deprecated: Use `pret install-skills` instead. See README.md for details.
#
# Update script for GitHub Copilot with Pret-a-Program
#

set -e

# Get script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "Update GitHub Copilot + Pret-a-Program"

# Set paths
COPILOT_SOURCE="$REPO_ROOT/copilot/copilot-instructions.md"
COPILOT_TARGET="$HOME/.github/copilot-instructions.md"

# Check if setup exists
if [ ! -e "$COPILOT_TARGET" ]; then
    print_error "GitHub Copilot not set up yet"
    echo ""
    echo "Run setup first:"
    echo "  make setup copilot"
    exit 1
fi

# Check if using symlinks (recommended)
if check_symlink "$COPILOT_SOURCE" "$COPILOT_TARGET"; then
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
        if [ -f "$COPILOT_TARGET" ]; then
            mv "$COPILOT_TARGET" "$COPILOT_TARGET.backup"
            print_info "Backed up existing file"
        fi

        # Create symlink
        create_symlink "$COPILOT_SOURCE" "$COPILOT_TARGET" "Copilot instructions"

        print_success "✨ Converted to symlinks!"
        echo ""
        print_info "Future updates are now automatic with 'git pull'!"
    else
        print_step "Re-copying files..."

        # Copy files
        cp "$COPILOT_SOURCE" "$COPILOT_TARGET"
        print_success "Updated copilot-instructions.md"

        echo ""
        print_info "Files updated. For automatic updates in the future,"
        print_info "consider converting to symlinks: make update copilot"
    fi
fi
