#!/bin/bash
#
# Setup script for GitHub Copilot with PARA-Programming
#

set -e

# Get script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "GitHub Copilot + PARA-Programming Setup"

# Check requirements
check_requirements || exit 1

# Detect OS
OS=$(detect_os)
print_info "Detected OS: $OS"

# Set paths
COPILOT_INSTRUCTIONS_SOURCE="$REPO_ROOT/copilot/copilot-instructions.md"
COPILOT_INSTRUCTIONS_TARGET="$HOME/.github/copilot-instructions.md"
GITHUB_DIR="$HOME/.github"

echo ""
print_step "Step 1: Creating .github directory"
create_dir "$GITHUB_DIR"

echo ""
print_step "Step 2: Creating symlink to copilot-instructions.md"
create_symlink "$COPILOT_INSTRUCTIONS_SOURCE" "$COPILOT_INSTRUCTIONS_TARGET" "Copilot instructions"

echo ""
print_step "Step 3: Verifying installation"
verify_symlink "$COPILOT_INSTRUCTIONS_TARGET" "Copilot instructions"

# Print completion
print_completion "GitHub Copilot"

echo "Using PARA with Copilot:"
echo "1. Open your project in VS Code (or supported IDE)"
echo "2. Open Copilot Chat (Cmd/Ctrl+I or Copilot icon)"
echo "3. Ask: 'Initialize PARA structure for this project'"
echo "4. Copilot will follow the PARA methodology automatically"
echo ""

print_update_instructions

echo "Documentation:"
echo "  Copilot README:     $REPO_ROOT/copilot/README.md"
echo "  Copilot Quickstart: $REPO_ROOT/copilot/QUICKSTART.md"
echo ""
echo "Note: Copilot's PARA support depends on its current context window."
echo "You may need to remind it about PARA methodology in longer sessions."
echo ""

print_success "Setup complete! Open VS Code and start using PARA methodology"
