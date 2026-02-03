#!/usr/bin/env bash
#
# setup-tier1.sh - Setup script for Tier 1 PARA-Programming tools
#
# Tier 1 tools (Full PARA Support):
# - Cursor
# - Continue.dev
#
# These tools read AGENTS.md natively, so no symlinks are needed.
# This script simply creates AGENTS.md from the master template.
#
# Usage:
#   ./setup-tier1.sh [--verbose]
#
# Exit codes:
#   0 - Success
#   1 - Error (AGENTS.md already exists or copy failed)

set -euo pipefail

# Script directory (for finding template)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_PATH="$PROJECT_ROOT/templates/AGENTS.md"
TARGET_PATH="$PROJECT_ROOT/AGENTS.md"

# Configuration
VERBOSE=false
if [[ "${1:-}" == "--verbose" ]]; then
  VERBOSE=true
fi

# Logging helper
log_verbose() {
  if [[ "$VERBOSE" == "true" ]]; then
    echo "[setup-tier1] $*" >&2
  fi
}

log_info() {
  echo "$*"
}

log_error() {
  echo "Error: $*" >&2
}

# Main setup function
setup_tier1() {
  log_verbose "Starting Tier 1 setup..."
  log_verbose "Template path: $TEMPLATE_PATH"
  log_verbose "Target path: $TARGET_PATH"

  # Check if template exists
  if [[ ! -f "$TEMPLATE_PATH" ]]; then
    log_error "Template not found: $TEMPLATE_PATH"
    log_error "Please ensure para-programming is properly installed."
    return 1
  fi

  # Check if AGENTS.md already exists
  if [[ -f "$TARGET_PATH" ]]; then
    log_verbose "AGENTS.md already exists at $TARGET_PATH"
    log_info "  ⚠️  AGENTS.md already exists (skipping)"
    return 0
  fi

  # Create AGENTS.md from template
  log_verbose "Copying template to $TARGET_PATH"
  if ! cp "$TEMPLATE_PATH" "$TARGET_PATH"; then
    log_error "Failed to create AGENTS.md"
    return 1
  fi

  # Set permissions (644 = rw-r--r--)
  chmod 644 "$TARGET_PATH"
  log_verbose "Set permissions: 644"

  log_info "  ✓ Created AGENTS.md"
  return 0
}

# Run main function
setup_tier1
