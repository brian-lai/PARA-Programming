#!/usr/bin/env bash
#
# pret execute - Start execution with branch and tracking
#

cmd_execute() {
    local phase=""
    local branch_name=""
    local no_branch=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --phase=*)
                phase="${1#*=}"
                shift
                ;;
            --branch=*)
                branch_name="${1#*=}"
                shift
                ;;
            --no-branch)
                no_branch=true
                shift
                ;;
            --help|-h)
                echo "Usage: pret execute [options]"
                echo ""
                echo "Start execution: create branch and set up tracking."
                echo ""
                echo "Options:"
                echo "  --phase=N        Execute specific phase (phased plans)"
                echo "  --branch=name    Use custom branch name"
                echo "  --no-branch      Skip branch creation"
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
        print_error "No context/context.md found. Run 'pret init' and 'pret plan' first."
        return 1
    fi

    # Read active plan
    local plan_path
    plan_path=$(read_active_plan)

    if [ -z "$plan_path" ]; then
        print_error "No active plan found in context/context.md"
        echo ""
        echo "  Run 'pret plan <task-name>' first."
        return 1
    fi

    if [ ! -f "$plan_path" ]; then
        print_error "Plan file not found: $plan_path"
        return 1
    fi

    # Extract task name from plan
    local task_name
    task_name=$(extract_task_name "$plan_path")

    # Determine branch name
    if [ -z "$branch_name" ]; then
        if [ -n "$phase" ]; then
            branch_name="pret/${task_name}-phase-${phase}"
        else
            branch_name="pret/${task_name}"
        fi
    fi

    print_header "Starting Execution: ${task_name}"

    # Create branch (unless --no-branch)
    if [ "$no_branch" = false ] && is_git_repo; then
        # Check for uncommitted changes
        if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
            print_warning "You have uncommitted changes."
            echo "  They will be carried to the new branch."
            echo ""
        fi

        # Check if branch exists
        if git rev-parse --verify "$branch_name" &>/dev/null; then
            print_warning "Branch '$branch_name' already exists."
            echo "  Switching to it instead of creating new."
            git checkout "$branch_name"
        else
            git checkout -b "$branch_name"
            print_success "Created branch: $branch_name"
        fi
    elif [ "$no_branch" = true ]; then
        print_info "Skipping branch creation (--no-branch)"
    else
        print_info "Not a git repository; skipping branch creation"
    fi

    # Update context.md with execution tracking
    local timestamp
    timestamp=$(get_timestamp)

    cat > "context/context.md" <<CONTEXT
# Current Work Summary

Executing: ${task_name}

**Branch:** \`${branch_name}\`
**Plan:** ${plan_path}

## To-Do List

_Extract steps from your plan and list them here._

## Progress Notes

Execution started.

---

\`\`\`json
{
  "active_context": [
    "${plan_path}"
  ],
  "completed_summaries": [],
  "execution_branch": "${branch_name}",
  "execution_started": "${timestamp}",
  "last_updated": "${timestamp}"
}
\`\`\`
CONTEXT

    echo ""
    echo "  Plan: $plan_path"
    echo "  Branch: $branch_name"
    echo ""
    echo "  Next steps:"
    echo "    1. Work through your plan step by step"
    echo "    2. Update the To-Do list in context/context.md as you go"
    echo "    3. Commit after each completed step"
    echo "    4. Run: pret summarize   (when done)"
    echo ""
}
