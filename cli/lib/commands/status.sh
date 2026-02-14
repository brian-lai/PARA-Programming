#!/usr/bin/env bash
#
# pret status - Show current workflow state
#

cmd_status() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --help|-h)
                echo "Usage: pret status"
                echo ""
                echo "Show current Pret-a-Program workflow state."
                return 0
                ;;
            *)
                print_error "Unknown option: $1"
                return 1
                ;;
        esac
    done

    if [ ! -f "context/context.md" ]; then
        print_info "No active context."
        echo ""
        echo "  Run 'pret init' to get started."
        return 0
    fi

    print_header "Pret-a-Program Status"

    # Read key fields from context.md
    local active_plan
    active_plan=$(read_active_plan)

    local branch
    branch=$(read_context_json "execution_branch")

    local started
    started=$(read_context_json "execution_started")

    local updated
    updated=$(read_context_json "last_updated")

    # Display status
    if [ -n "$active_plan" ]; then
        echo "  Plan:    $active_plan"
    else
        echo "  Plan:    (none)"
    fi

    if [ -n "$branch" ]; then
        echo "  Branch:  $branch"
    fi

    if [ -n "$started" ]; then
        echo "  Started: $started"
    fi

    if [ -n "$updated" ]; then
        echo "  Updated: $updated"
    fi

    echo ""

    # Count to-do progress
    if [ -f "context/context.md" ]; then
        local total_todos=0
        total_todos=$(grep -c '^- \[' context/context.md 2>/dev/null) || total_todos=0
        local done_todos=0
        done_todos=$(grep -c '^- \[x\]' context/context.md 2>/dev/null) || done_todos=0

        if [ "$total_todos" -gt 0 ]; then
            echo "  Progress: ${done_todos}/${total_todos} tasks complete"
            echo ""

            # Show incomplete items
            local incomplete
            incomplete=$(grep '^- \[ \]' context/context.md 2>/dev/null || true)
            if [ -n "$incomplete" ]; then
                echo "  Remaining:"
                echo "$incomplete" | while IFS= read -r line; do
                    echo "    $line"
                done
                echo ""
            fi
        fi
    fi

    # Show current git branch if in repo
    if is_git_repo; then
        local current_branch
        current_branch=$(git branch --show-current 2>/dev/null)
        if [ -n "$current_branch" ]; then
            echo "  Git branch: $current_branch"
            if [ -n "$branch" ] && [ "$current_branch" != "$branch" ]; then
                print_warning "Expected branch: $branch"
            fi
        fi
    fi

    echo ""
}
