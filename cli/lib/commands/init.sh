#!/usr/bin/env bash
#
# pret init - Initialize Pret-a-Program in current project
#

cmd_init() {
    local template_type="basic"

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --template=*)
                template_type="${1#*=}"
                shift
                ;;
            --help|-h)
                echo "Usage: pret init [--template=basic|full]"
                echo ""
                echo "Initialize Pret-a-Program structure in current project."
                echo ""
                echo "Options:"
                echo "  --template=basic   Create minimal AGENTS.md (default)"
                echo "  --template=full    Create comprehensive AGENTS.md"
                return 0
                ;;
            *)
                print_error "Unknown option: $1"
                return 1
                ;;
        esac
    done

    print_header "Initializing Pret-a-Program"

    local templates_dir
    templates_dir=$(resolve_templates_dir 2>/dev/null) || templates_dir=""

    # 1. Create context/ directory structure
    print_info "Creating context/ directory structure..."
    ensure_dir "context/data"
    ensure_dir "context/plans"
    ensure_dir "context/summaries"
    ensure_dir "context/archives"
    ensure_dir "context/servers"

    # 2. Create context/context.md from template
    if [ -f "context/context.md" ]; then
        print_info "Already exists: context/context.md"
    else
        if [ -n "$templates_dir" ] && [ -f "$templates_dir/context.md" ]; then
            local timestamp
            timestamp=$(get_timestamp)
            sed "s|TIMESTAMP|$timestamp|g" "$templates_dir/context.md" > "context/context.md"
        else
            # Inline fallback if template not found
            cat > "context/context.md" <<'CONTEXT'
# Current Work Summary

Ready to start first task.

---

```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "TIMESTAMP"
}
```
CONTEXT
            local timestamp
            timestamp=$(get_timestamp)
            sed -i.bak "s|TIMESTAMP|$timestamp|g" "context/context.md" && rm -f "context/context.md.bak"
        fi
        print_success "Created: context/context.md"
    fi

    # 3. Create AGENTS.md from template (if it doesn't exist)
    if [ -f "AGENTS.md" ]; then
        print_info "Already exists: AGENTS.md"
    elif [ -n "$templates_dir" ] && [ -f "$templates_dir/agents.md" ]; then
        cp "$templates_dir/agents.md" "AGENTS.md"
        print_success "Created: AGENTS.md"
    else
        print_warning "AGENTS.md template not found; skipping"
    fi

    # 4. Print success message
    echo ""
    print_header "Pret-a-Program Initialized"

    echo "  Directory structure:"
    echo ""
    echo "  context/"
    echo "  ├── archives/     # Historical context snapshots"
    echo "  ├── data/         # Input files, payloads, datasets"
    echo "  ├── plans/        # Pre-work planning documents"
    echo "  ├── servers/      # Tool wrappers (MCP, preprocessing)"
    echo "  ├── summaries/    # Post-work reports"
    echo "  └── context.md    # Active session context"
    echo ""

    if [ -f "AGENTS.md" ]; then
        echo "  Files:"
        echo "  - AGENTS.md      # Project methodology"
        echo "  - context/context.md  # Active work tracker"
        echo ""
    fi

    echo "  Pret Workflow: Plan -> Review -> Execute -> Summarize -> Archive"
    echo ""
    echo "  Next steps:"
    echo "    1. Edit AGENTS.md with your project-specific context"
    echo "    2. Run: pret plan <task-name>"
    echo "    3. Run: pret install-skills   (optional: install AI tool integrations)"
    echo ""
}
