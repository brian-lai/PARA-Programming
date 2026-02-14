#!/usr/bin/env bash
#
# pret plan - Create a new plan document
#

cmd_plan() {
    local task_name=""

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --help|-h)
                echo "Usage: pret plan <task-name>"
                echo ""
                echo "Create a new planning document for a task."
                echo ""
                echo "Arguments:"
                echo "  task-name    Short name for the task (e.g., add-auth, fix-memory-leak)"
                echo ""
                echo "Examples:"
                echo "  pret plan add-authentication"
                echo "  pret plan fix-memory-leak"
                echo "  pret plan refactor-api-layer"
                return 0
                ;;
            -*)
                print_error "Unknown option: $1"
                return 1
                ;;
            *)
                task_name="$1"
                shift
                ;;
        esac
    done

    if [ -z "$task_name" ]; then
        print_error "Missing task name"
        echo ""
        echo "  Usage: pret plan <task-name>"
        echo "  Example: pret plan add-authentication"
        return 1
    fi

    # Sanitize task name (lowercase, hyphens only)
    task_name=$(echo "$task_name" | tr '[:upper:]' '[:lower:]' | tr ' _' '-' | tr -cd 'a-z0-9-')

    local today
    today=$(get_date)
    local plan_file="context/plans/${today}-${task_name}.md"

    # Check prerequisites
    if [ ! -d "context/plans" ]; then
        print_error "context/plans/ directory not found. Run 'pret init' first."
        return 1
    fi

    if [ -f "$plan_file" ]; then
        print_warning "Plan already exists: $plan_file"
        echo ""
        echo "  To create a new version, choose a different task name."
        return 1
    fi

    # Create plan from template or inline
    local templates_dir
    templates_dir=$(resolve_templates_dir 2>/dev/null) || templates_dir=""

    if [ -n "$templates_dir" ] && [ -f "$templates_dir/plan.md" ]; then
        sed "s|\[Task Name\]|${task_name}|g" "$templates_dir/plan.md" > "$plan_file"
    else
        # Inline plan template
        cat > "$plan_file" <<PLAN
# Plan: ${task_name}

## Objective

[Clear, specific goal in 1-2 sentences]

## Approach

1. [Step with specifics]
2. [Step with specifics]
3. [Continue...]

## Files to Modify

- \`path/to/file.ext\` - [What changes and why]

## Files to Create

- \`path/to/new/file.ext\` - [Purpose]

## Risks & Edge Cases

- [Risk and mitigation]

## Success Criteria

- [ ] [Testable criterion]
- [ ] [Testable criterion]
PLAN
    fi

    # Update context.md
    if [ -f "context/context.md" ]; then
        local timestamp
        timestamp=$(get_timestamp)
        # Update active_context to include new plan
        # Simple approach: rewrite the file with plan reference
        cat > "context/context.md" <<CONTEXT
# Current Work Summary

Planning: ${task_name}

**Plan:** ${plan_file}

## To-Do List

_To be filled after plan review._

## Progress Notes

Plan created. Awaiting review.

---

\`\`\`json
{
  "active_context": [
    "${plan_file}"
  ],
  "completed_summaries": [],
  "last_updated": "${timestamp}"
}
\`\`\`
CONTEXT
    fi

    print_success "Plan created: $plan_file"
    echo ""
    echo "  Next steps:"
    echo "    1. Edit the plan with your approach"
    echo "    2. Review with your team"
    echo "    3. Run: pret execute"
    echo ""
}
