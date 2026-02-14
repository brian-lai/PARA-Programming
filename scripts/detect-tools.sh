#!/usr/bin/env bash
#
# detect-tools.sh - Auto-detect installed AI coding tools
#
# This script identifies which AI coding tools are installed on the system
# and categorizes them by their setup requirements:
#
# - PLUGIN: Tools that use native plugins (Claude Code)
# - FILE_BASED_TIER1: Tools with full Pret support (Cursor, Continue.dev)
# - FILE_BASED_TIER2: Tools with methodology-only support (Copilot, Gemini)
#
# Output format (one line per category):
#   PLUGIN:claude
#   FILE_BASED_TIER1:cursor,continue
#   FILE_BASED_TIER2:copilot,gemini
#
# Usage:
#   ./detect-tools.sh
#   ./detect-tools.sh --verbose  # Show detection details

set -euo pipefail

# Configuration
VERBOSE=false
if [[ "${1:-}" == "--verbose" ]]; then
  VERBOSE=true
fi

# Arrays to hold detected tools
PLUGIN_TOOLS=()
TIER1_TOOLS=()
TIER2_TOOLS=()

# Logging helper
log_verbose() {
  if [[ "$VERBOSE" == "true" ]]; then
    echo "[detect] $*" >&2
  fi
}

# Detection functions

detect_claude_code() {
  log_verbose "Checking for Claude Code..."

  # Check for Claude Code global config
  if [[ -f "$HOME/.claude/CLAUDE.md" ]]; then
    log_verbose "  ✓ Found: ~/.claude/CLAUDE.md"
    PLUGIN_TOOLS+=("claude")
    return 0
  fi

  # Check for Claude Code environment variable
  if [[ -n "${CLAUDE_CODE_VERSION:-}" ]]; then
    log_verbose "  ✓ Found: \$CLAUDE_CODE_VERSION env var"
    PLUGIN_TOOLS+=("claude")
    return 0
  fi

  log_verbose "  ✗ Not detected"
  return 1
}

detect_cursor() {
  log_verbose "Checking for Cursor..."

  # Check for .cursor directory (project-level)
  if [[ -d ".cursor" ]]; then
    log_verbose "  ✓ Found: .cursor/ directory"
    TIER1_TOOLS+=("cursor")
    return 0
  fi

  # Check if cursor command is available
  if command -v cursor &> /dev/null; then
    log_verbose "  ✓ Found: cursor command"
    TIER1_TOOLS+=("cursor")
    return 0
  fi

  # Check for Cursor app on macOS
  if [[ -d "/Applications/Cursor.app" ]]; then
    log_verbose "  ✓ Found: /Applications/Cursor.app"
    TIER1_TOOLS+=("cursor")
    return 0
  fi

  log_verbose "  ✗ Not detected"
  return 1
}

detect_continue() {
  log_verbose "Checking for Continue.dev..."

  # Check for .continue directory (project-level)
  if [[ -d ".continue" ]]; then
    log_verbose "  ✓ Found: .continue/ directory"
    TIER1_TOOLS+=("continue")
    return 0
  fi

  # Check for .continuerc.json (project-level config)
  if [[ -f ".continuerc.json" ]]; then
    log_verbose "  ✓ Found: .continuerc.json"
    TIER1_TOOLS+=("continue")
    return 0
  fi

  # Check for Continue config in home directory
  if [[ -d "$HOME/.continue" ]]; then
    log_verbose "  ✓ Found: ~/.continue/ directory"
    TIER1_TOOLS+=("continue")
    return 0
  fi

  log_verbose "  ✗ Not detected"
  return 1
}

detect_copilot() {
  log_verbose "Checking for GitHub Copilot..."

  # Check for .github/copilot-instructions.md (existing setup)
  if [[ -f ".github/copilot-instructions.md" ]]; then
    log_verbose "  ✓ Found: .github/copilot-instructions.md"
    TIER2_TOOLS+=("copilot")
    return 0
  fi

  # Check if gh CLI with copilot extension is available
  if command -v gh &> /dev/null; then
    if gh copilot --version &> /dev/null 2>&1; then
      log_verbose "  ✓ Found: gh copilot command"
      TIER2_TOOLS+=("copilot")
      return 0
    fi
  fi

  # Check for VS Code with Copilot extension (harder to detect reliably)
  # We check for common VS Code extensions directories
  local vscode_extensions=(
    "$HOME/.vscode/extensions"
    "$HOME/.vscode-insiders/extensions"
    "$HOME/Library/Application Support/Code/User/extensions"
  )

  for ext_dir in "${vscode_extensions[@]}"; do
    if [[ -d "$ext_dir" ]]; then
      if ls "$ext_dir"/github.copilot-* &> /dev/null 2>&1; then
        log_verbose "  ✓ Found: VS Code Copilot extension in $ext_dir"
        TIER2_TOOLS+=("copilot")
        return 0
      fi
    fi
  done

  log_verbose "  ✗ Not detected"
  return 1
}

detect_gemini() {
  log_verbose "Checking for Gemini..."

  # Check for existing GEMINI.md file (project-level)
  if [[ -f "GEMINI.md" ]]; then
    log_verbose "  ✓ Found: GEMINI.md"
    TIER2_TOOLS+=("gemini")
    return 0
  fi

  # Check for Google Cloud CLI with AI plugin (experimental)
  if command -v gcloud &> /dev/null; then
    # This is speculative - actual detection method may vary
    if gcloud ai --help &> /dev/null 2>&1; then
      log_verbose "  ✓ Found: gcloud ai command"
      TIER2_TOOLS+=("gemini")
      return 0
    fi
  fi

  log_verbose "  ✗ Not detected"
  return 1
}

# Main detection logic
main() {
  log_verbose "Starting AI coding tool detection..."
  log_verbose ""

  # Run all detection functions
  detect_claude_code || true
  detect_cursor || true
  detect_continue || true
  detect_copilot || true
  detect_gemini || true

  log_verbose ""
  log_verbose "Detection complete!"
  log_verbose ""

  # Output results in parseable format
  if [[ ${#PLUGIN_TOOLS[@]} -gt 0 ]]; then
    echo "PLUGIN:$(IFS=,; echo "${PLUGIN_TOOLS[*]}")"
  fi

  if [[ ${#TIER1_TOOLS[@]} -gt 0 ]]; then
    echo "FILE_BASED_TIER1:$(IFS=,; echo "${TIER1_TOOLS[*]}")"
  fi

  if [[ ${#TIER2_TOOLS[@]} -gt 0 ]]; then
    echo "FILE_BASED_TIER2:$(IFS=,; echo "${TIER2_TOOLS[*]}")"
  fi

  # If nothing detected, exit with status 1
  local total_detected=$((${#PLUGIN_TOOLS[@]} + ${#TIER1_TOOLS[@]} + ${#TIER2_TOOLS[@]}))
  if [[ $total_detected -eq 0 ]]; then
    log_verbose "No AI coding tools detected."
    exit 1
  fi
}

# Run main function
main "$@"
