#!/usr/bin/env bash
#
# setup-tier2.sh - Setup script for Tier 2 PARA-Programming tools
#
# Tier 2 tools (Methodology Only):
# - GitHub Copilot
# - Gemini
#
# These tools don't read AGENTS.md natively, so we create symlinks
# from their expected instruction file locations to AGENTS.md.
#
# Usage:
#   ./setup-tier2.sh [--tool=copilot|gemini] [--verbose]
#
# Exit codes:
#   0 - Success
#   1 - Error (failed to create files or symlinks)

set -euo pipefail

# Script directory (for finding template)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_PATH="$PROJECT_ROOT/templates/AGENTS.md"
AGENTS_PATH="$PROJECT_ROOT/AGENTS.md"

# Configuration
VERBOSE=false
TOOL_FILTER=""

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --verbose)
      VERBOSE=true
      ;;
    --tool=*)
      TOOL_FILTER="${arg#*=}"
      ;;
  esac
done

# Logging helpers
log_verbose() {
  if [[ "$VERBOSE" == "true" ]]; then
    echo "[setup-tier2] $*" >&2
  fi
}

log_info() {
  echo "$*"
}

log_error() {
  echo "Error: $*" >&2
}

# Create AGENTS.md if it doesn't exist
ensure_agents_md() {
  log_verbose "Ensuring AGENTS.md exists..."

  if [[ -f "$AGENTS_PATH" ]]; then
    log_verbose "AGENTS.md already exists"
    return 0
  fi

  # Check if template exists
  if [[ ! -f "$TEMPLATE_PATH" ]]; then
    log_error "Template not found: $TEMPLATE_PATH"
    return 1
  fi

  # Create AGENTS.md from template
  log_verbose "Creating AGENTS.md from template"
  if ! cp "$TEMPLATE_PATH" "$AGENTS_PATH"; then
    log_error "Failed to create AGENTS.md"
    return 1
  fi

  chmod 644 "$AGENTS_PATH"
  log_info "  ✓ Created AGENTS.md"
}

# Setup GitHub Copilot (symlink in .github/)
setup_copilot() {
  log_verbose "Setting up GitHub Copilot..."

  local github_dir="$PROJECT_ROOT/.github"
  local target_path="$github_dir/copilot-instructions.md"
  local relative_link="../AGENTS.md"

  # Create .github directory if needed
  if [[ ! -d "$github_dir" ]]; then
    log_verbose "Creating .github directory"
    mkdir -p "$github_dir"
  fi

  # Check if symlink or file already exists
  if [[ -e "$target_path" || -L "$target_path" ]]; then
    log_verbose "copilot-instructions.md already exists"
    log_info "  ⚠️  .github/copilot-instructions.md already exists (skipping)"
    return 0
  fi

  # Create symlink
  log_verbose "Creating symlink: $target_path -> $relative_link"
  if ! ln -s "$relative_link" "$target_path"; then
    log_error "Failed to create copilot-instructions.md symlink"
    return 1
  fi

  log_info "  ✓ Created .github/copilot-instructions.md → ../AGENTS.md (symlink)"
}

# Setup Gemini (symlink in project root)
setup_gemini() {
  log_verbose "Setting up Gemini..."

  local target_path="$PROJECT_ROOT/GEMINI.md"
  local relative_link="AGENTS.md"

  # Check if symlink or file already exists
  if [[ -e "$target_path" || -L "$target_path" ]]; then
    log_verbose "GEMINI.md already exists"
    log_info "  ⚠️  GEMINI.md already exists (skipping)"
    return 0
  fi

  # Create symlink
  log_verbose "Creating symlink: $target_path -> $relative_link"
  if ! ln -s "$relative_link" "$target_path"; then
    log_error "Failed to create GEMINI.md symlink"
    return 1
  fi

  log_info "  ✓ Created GEMINI.md → AGENTS.md (symlink)"
}

# Main setup function
setup_tier2() {
  log_verbose "Starting Tier 2 setup..."
  log_verbose "Template path: $TEMPLATE_PATH"
  log_verbose "AGENTS.md path: $AGENTS_PATH"

  # Ensure AGENTS.md exists first
  if ! ensure_agents_md; then
    return 1
  fi

  # Setup tools based on filter
  local success=true

  if [[ -z "$TOOL_FILTER" || "$TOOL_FILTER" == "copilot" ]]; then
    if ! setup_copilot; then
      success=false
    fi
  fi

  if [[ -z "$TOOL_FILTER" || "$TOOL_FILTER" == "gemini" ]]; then
    if ! setup_gemini; then
      success=false
    fi
  fi

  if [[ "$success" == "true" ]]; then
    return 0
  else
    return 1
  fi
}

# Run main function
setup_tier2
