#!/usr/bin/env bash
#
# pret check - Decision helper: should I use the Pret workflow?
#

cmd_check() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --help|-h)
                echo "Usage: pret check"
                echo ""
                echo "Decision helper: should I use the Pret workflow for this task?"
                return 0
                ;;
            *)
                print_error "Unknown option: $1"
                return 1
                ;;
        esac
    done

    print_header "Should I use the Pret workflow?"

    cat <<'DECISION'
  Will this task result in git changes?
  │
  ├─ YES → Use the Pret workflow
  │        Run: pret plan <task-name>
  │
  │        Examples:
  │        • Code changes (features, bugs, refactors)
  │        • Architecture decisions
  │        • Configuration changes
  │        • Database migrations
  │        • Test implementation
  │        • Complex debugging
  │
  └─ NO  → Just answer directly
           No workflow needed.

           Examples:
           • "What does this function do?"
           • "Show me the auth logic"
           • "Explain how this works"
           • "What version is X?"

  Rule of thumb: If it changes files, use Pret.
                  If it's read-only, skip it.

DECISION
}
