#!/bin/bash
#
# Setup script for Cursor IDE with PARA-Programming
#

set -e

# Get script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "Cursor IDE + PARA-Programming Setup"

# Check requirements
check_requirements || exit 1

# Detect OS
OS=$(detect_os)
print_info "Detected OS: $OS"

# Set paths based on OS
case "$OS" in
    Mac)
        CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"
        ;;
    Linux)
        CURSOR_DIR="$HOME/.config/Cursor/User"
        ;;
    Windows)
        CURSOR_DIR="$APPDATA/Cursor/User"
        ;;
    *)
        print_error "Unsupported OS: $OS"
        exit 1
        ;;
esac

CURSOR_RULES_SOURCE="$REPO_ROOT/cursor/cursorrules"
CURSOR_RULES_TARGET="$HOME/.cursorrules"

echo ""
print_step "Step 1: Checking Cursor installation"
if [ ! -d "$CURSOR_DIR" ]; then
    print_warning "Cursor config directory not found: $CURSOR_DIR"
    echo ""
    echo "Please ensure Cursor is installed and has been run at least once."
    echo "If you're certain Cursor is installed, the config directory may be elsewhere."
    echo ""
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    print_success "Cursor installation found"
fi

echo ""
print_step "Step 2: Creating symlink to .cursorrules"
create_symlink "$CURSOR_RULES_SOURCE" "$CURSOR_RULES_TARGET" "Cursor rules"

echo ""
print_step "Step 3: Verifying installation"
verify_symlink "$CURSOR_RULES_TARGET" "Cursor rules"

# Print completion
print_completion "Cursor IDE"

echo "Using PARA with Cursor:"
echo "1. Open your project in Cursor"
echo "2. Open Cursor Composer (Cmd/Ctrl+I)"
echo "3. Ask: 'Initialize PARA structure for this project'"
echo "4. Cursor will follow the PARA methodology automatically"
echo ""

print_update_instructions

echo "Documentation:"
echo "  Cursor README:     $REPO_ROOT/cursor/README.md"
echo "  Cursor Quickstart: $REPO_ROOT/cursor/QUICKSTART.md"
echo ""

print_success "Setup complete! Open Cursor and start using PARA methodology"
