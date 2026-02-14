#!/usr/bin/env bash
#
# Common functions for pret CLI
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Print functions
print_header() {
    echo ""
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}  $1${NC}"
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}  $1${NC}"
}

print_error() {
    echo -e "${RED}  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}  $1${NC}"
}

print_info() {
    echo -e "${BLUE}  $1${NC}"
}

# Get current date in YYYY-MM-DD format
get_date() {
    date +%F
}

# Get ISO timestamp
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

# Resolve templates directory
# Checks PRET_SHARE first (Homebrew install), then falls back to relative path
resolve_templates_dir() {
    local templates_dir="$PRET_LIBEXEC/templates"
    if [ -d "$templates_dir" ]; then
        echo "$templates_dir"
        return 0
    fi

    # Fallback: check share directory (Homebrew layout)
    templates_dir="$PRET_SHARE/templates"
    if [ -d "$templates_dir" ]; then
        echo "$templates_dir"
        return 0
    fi

    print_error "Templates directory not found"
    return 1
}

# Resolve skills directory
resolve_skills_dir() {
    local skills_dir="$PRET_SHARE/skills"
    if [ -d "$skills_dir" ]; then
        echo "$skills_dir"
        return 0
    fi

    # Fallback: check relative to script
    skills_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/skills"
    if [ -d "$skills_dir" ]; then
        echo "$skills_dir"
        return 0
    fi

    print_error "Skills directory not found"
    return 1
}

# Create directory if it doesn't exist
ensure_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        return 0
    fi
    return 0
}

# Create file from template if it doesn't already exist
# Usage: create_from_template <template_file> <target_file> [placeholder] [replacement]
create_from_template() {
    local template="$1"
    local target="$2"
    local placeholder="${3:-}"
    local replacement="${4:-}"

    if [ -f "$target" ]; then
        print_info "Already exists: $target"
        return 0
    fi

    if [ ! -f "$template" ]; then
        print_error "Template not found: $template"
        return 1
    fi

    if [ -n "$placeholder" ] && [ -n "$replacement" ]; then
        sed "s|$placeholder|$replacement|g" "$template" > "$target"
    else
        cp "$template" "$target"
    fi

    print_success "Created: $target"
    return 0
}

# Check if we're in a git repository
is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
}

# Get the project root (git root or PWD)
get_project_root() {
    if is_git_repo; then
        git rev-parse --show-toplevel
    else
        pwd
    fi
}

# Check if context directory exists
has_context() {
    [ -d "context" ] && [ -f "context/context.md" ]
}

# Read a value from the JSON block in context.md
# Usage: read_context_json <key>
# Note: Simple grep-based parsing, no jq dependency
read_context_json() {
    local key="$1"
    if [ -f "context/context.md" ]; then
        grep -o "\"$key\": *\"[^\"]*\"" context/context.md | head -1 | sed 's/.*: *"\(.*\)"/\1/'
    fi
}

# Read the active plan path from context.md
read_active_plan() {
    if [ -f "context/context.md" ]; then
        grep -o '"context/plans/[^"]*"' context/context.md | head -1 | tr -d '"'
    fi
}

# Extract task name from a plan filename
# e.g., "context/plans/2026-02-12-my-feature.md" -> "my-feature"
extract_task_name() {
    local plan_path="$1"
    local filename
    filename=$(basename "$plan_path" .md)
    # Remove date prefix (YYYY-MM-DD-)
    echo "$filename" | sed 's/^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}-//'
}
