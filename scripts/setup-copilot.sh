#!/bin/bash
# Deprecated: Use `pret install-skills` instead. See README.md for details.
#
# Setup script for GitHub Copilot with Pret-a-Program
#

set -e

# Get script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "GitHub Copilot + Pret-a-Program Setup"

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

echo "Using Pret with Copilot:"
echo "1. Open your project in VS Code (or supported IDE)"
echo "2. Open Copilot Chat (Cmd/Ctrl+I or Copilot icon)"
echo "3. Ask: 'Initialize Pret structure for this project'"
echo "4. Copilot will follow the Pret methodology automatically"
echo ""

print_update_instructions

echo "Documentation:"
echo "  Copilot README:     $REPO_ROOT/copilot/README.md"
echo "  Copilot Quickstart: $REPO_ROOT/copilot/QUICKSTART.md"
echo ""
echo "Note: Copilot's Pret support depends on its current context window."
echo "You may need to remind it about Pret methodology in longer sessions."
echo ""

print_success "Setup complete! Open VS Code and start using Pret methodology"
