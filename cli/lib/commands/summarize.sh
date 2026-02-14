#!/usr/bin/env bash
#
# pret summarize - Generate post-work summary
#

cmd_summarize() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --help|-h)
                echo "Usage: pret summarize"
                echo ""
                echo "Create a summary document for the current task."
                return 0
                ;;
            *)
                print_error "Unknown option: $1"
                return 1
                ;;
        esac
    done

    # Check prerequisites
    if [ ! -f "context/context.md" ]; then
        print_error "No context/context.md found. Nothing to summarize."
        return 1
    fi

    # Read active plan
    local plan_path
    plan_path=$(read_active_plan)

    if [ -z "$plan_path" ]; then
        print_error "No active plan found in context/context.md"
        return 1
    fi

    # Extract task name
    local task_name
    task_name=$(extract_task_name "$plan_path")

    local today
    today=$(get_date)
    local summary_file="context/summaries/${today}-${task_name}-summary.md"

    if [ ! -d "context/summaries" ]; then
        mkdir -p "context/summaries"
    fi

    if [ -f "$summary_file" ]; then
        print_warning "Summary already exists: $summary_file"
        echo "  Edit it directly to update."
        return 0
    fi

    # Create summary from template or inline
    local templates_dir
    templates_dir=$(resolve_templates_dir 2>/dev/null) || templates_dir=""

    if [ -n "$templates_dir" ] && [ -f "$templates_dir/summary.md" ]; then
        sed "s|\[Task Name\]|${task_name}|g" "$templates_dir/summary.md" > "$summary_file"
    else
        cat > "$summary_file" <<SUMMARY
# Summary: ${task_name}

**Date:** ${today}
**Status:** Complete | Partial | Blocked

## Changes Made

### Files Modified
- \`path/file.ext\` - [Description]

### Files Created
- \`path/new.ext\` - [Purpose]

## Rationale

[Why these changes were made]

## Deviations from Plan

[What changed from the original plan and why]

## Test Results

[Pass/fail status, coverage]

## Key Learnings

[Important insights, gotchas]

## Follow-up Tasks

[Remaining work, if any]
SUMMARY
    fi

    # Update context.md to reference summary
    if [ -f "context/context.md" ]; then
        # Add summary reference - simple approach: note it in progress
        local timestamp
        timestamp=$(get_timestamp)
        # Append a note rather than rewrite the whole file
        echo "" >> "context/context.md"
        echo "Summary created: ${summary_file} at ${timestamp}" >> "context/context.md"
    fi

    print_success "Summary created: $summary_file"
    echo ""
    echo "  Next steps:"
    echo "    1. Fill in the summary with your results"
    echo "    2. Commit the summary"
    echo "    3. Run: pret archive   (to reset for next task)"
    echo ""
}
