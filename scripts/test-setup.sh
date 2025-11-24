#!/bin/bash
#
# Test script to verify PARA-Programming installation
#

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
source "$SCRIPT_DIR/common.sh"

print_header "Testing PARA-Programming Installation"

# Test results
PASSED=0
FAILED=0

# Test function
test_component() {
    local description="$1"
    local test_command="$2"

    echo -n "Testing $description... "
    if eval "$test_command" >/dev/null 2>&1; then
        print_success "$description"
        ((PASSED++))
        return 0
    else
        print_error "$description"
        ((FAILED++))
        return 1
    fi
}

echo ""
print_step "Testing Claude Code Setup"

# Test Claude Code
test_component "Global CLAUDE.md symlink" "[ -L ~/.claude/CLAUDE.md ]"
test_component "Global CLAUDE.md readable" "[ -r ~/.claude/CLAUDE.md ]"

if [ -d ~/.claude/commands ]; then
    command_count=$(ls -1 ~/.claude/commands/para-*.md 2>/dev/null | wc -l | tr -d ' ')
    if [ "$command_count" -eq 6 ]; then
        print_success "All 6 PARA commands found"
        ((PASSED++))
    elif [ "$command_count" -gt 0 ]; then
        print_warning "Found $command_count PARA commands (expected 6)"
        ((FAILED++))
    else
        print_info "No PARA commands installed (legacy setup)"
    fi
else
    print_info "Commands directory not found (legacy setup)"
fi

echo ""
print_step "Testing Cursor Setup"

test_component "Cursor rules symlink" "[ -L ~/.cursorrules ]"
test_component "Cursor rules readable" "[ -r ~/.cursorrules ]"

echo ""
print_step "Testing Copilot Setup"

test_component "Copilot instructions symlink" "[ -L ~/.github/copilot-instructions.md ]"
test_component "Copilot instructions readable" "[ -r ~/.github/copilot-instructions.md ]"

# Summary
echo ""
print_header "Test Results"

echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    print_success "All tests passed! ✨"
    exit 0
else
    print_warning "Some tests failed. Check the output above."
    echo ""
    echo "To fix issues, try running setup again:"
    echo "  make setup claude-skill"
    echo "  make setup cursor"
    echo "  make setup copilot"
    exit 1
fi
