#!/usr/bin/env bash
#
# pret archive - Archive current context
#

cmd_archive() {
    local seed=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --fresh)
                seed=false
                shift
                ;;
            --seed)
                seed=true
                shift
                ;;
            --help|-h)
                echo "Usage: pret archive [--fresh|--seed]"
                echo ""
                echo "Archive current context and reset for next task."
                echo ""
                echo "Options:"
                echo "  --fresh    Create completely empty context (default)"
                echo "  --seed     Carry forward completed summaries list"
                return 0
                ;;
            *)
                print_error "Unknown option: $1"
                return 1
                ;;
        esac
    done

    if [ ! -f "context/context.md" ]; then
        print_error "No context/context.md to archive."
        return 1
    fi

    if [ ! -d "context/archives" ]; then
        mkdir -p "context/archives"
    fi

    # Generate archive filename with date and time
    local today
    today=$(get_date)
    local time_suffix
    time_suffix=$(date +%H%M)
    local archive_file="context/archives/${today}-${time_suffix}-context.md"

    # Move current context to archive
    cp "context/context.md" "$archive_file"
    print_success "Archived: $archive_file"

    # Create fresh context.md
    local timestamp
    timestamp=$(get_timestamp)

    if [ "$seed" = true ]; then
        # Carry forward completed_summaries from old context
        local summaries
        summaries=$(grep -o '"context/summaries/[^"]*"' "$archive_file" 2>/dev/null | tr '\n' ', ' | sed 's/,$//')
        summaries="${summaries:-}"

        cat > "context/context.md" <<CONTEXT
# Current Work Summary

Ready to start next task.

## Progress Notes

Archived previous context: ${archive_file}

---

\`\`\`json
{
  "active_context": [],
  "completed_summaries": [${summaries}],
  "last_updated": "${timestamp}"
}
\`\`\`
CONTEXT
    else
        cat > "context/context.md" <<CONTEXT
# Current Work Summary

Ready to start next task.

---

\`\`\`json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "${timestamp}"
}
\`\`\`
CONTEXT
    fi

    print_success "Context reset: context/context.md"
    echo ""
    echo "  Archived: $archive_file"
    echo "  Ready for next task."
    echo ""
    echo "  Next: pret plan <task-name>"
    echo ""
}
