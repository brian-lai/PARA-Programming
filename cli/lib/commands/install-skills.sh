#!/usr/bin/env bash
#
# pret install-skills - Install AI tool skills
#

cmd_install_skills() {
    local install_claude=false
    local install_cursor=false
    local install_codex=false
    local install_all=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --claude)
                install_claude=true
                shift
                ;;
            --cursor)
                install_cursor=true
                shift
                ;;
            --codex)
                install_codex=true
                shift
                ;;
            --all)
                install_all=true
                shift
                ;;
            --help|-h)
                echo "Usage: pret install-skills [--claude] [--cursor] [--codex] [--all]"
                echo ""
                echo "Install Pret-a-Program skills for AI coding tools."
                echo ""
                echo "Options:"
                echo "  --claude    Install Claude Code skill (~/.claude/skills/)"
                echo "  --cursor    Install Cursor rules (.cursor/rules/ in PWD)"
                echo "  --codex     Install Codex AGENTS.md (AGENTS.md in PWD)"
                echo "  --all       Install for all detected tools"
                echo ""
                echo "With no flags, detects installed tools and prompts."
                return 0
                ;;
            *)
                print_error "Unknown option: $1"
                return 1
                ;;
        esac
    done

    # Resolve skills source directory
    local skills_dir
    skills_dir=$(resolve_skills_dir 2>/dev/null) || skills_dir=""

    if [ -z "$skills_dir" ]; then
        print_error "Skills directory not found."
        echo "  Expected at: $PRET_SHARE/skills"
        return 1
    fi

    # If --all, enable all
    if [ "$install_all" = true ]; then
        install_claude=true
        install_cursor=true
        install_codex=true
    fi

    # If no flags, detect and prompt
    if [ "$install_claude" = false ] && [ "$install_cursor" = false ] && [ "$install_codex" = false ]; then
        print_header "Pret-a-Program Skill Installer"

        echo "  Detected tools:"
        local detected=0

        if command -v claude &>/dev/null; then
            echo "    [x] Claude Code"
            detected=$((detected + 1))
        else
            echo "    [ ] Claude Code (not found)"
        fi

        if command -v cursor &>/dev/null || [ -d ".cursor" ]; then
            echo "    [x] Cursor"
            detected=$((detected + 1))
        else
            echo "    [ ] Cursor (not found)"
        fi

        if command -v codex &>/dev/null; then
            echo "    [x] Codex CLI"
            detected=$((detected + 1))
        else
            echo "    [ ] Codex CLI (not found)"
        fi

        echo ""

        if [ "$detected" -eq 0 ]; then
            print_warning "No AI tools detected in PATH."
            echo "  You can still install manually with --claude, --cursor, or --codex."
            return 0
        fi

        echo "  Install for all detected tools? (y/N): "
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            if command -v claude &>/dev/null; then install_claude=true; fi
            if command -v cursor &>/dev/null || [ -d ".cursor" ]; then install_cursor=true; fi
            if command -v codex &>/dev/null; then install_codex=true; fi
        else
            echo "  Use --claude, --cursor, or --codex to install individually."
            return 0
        fi
    fi

    print_header "Installing Skills"

    # Install Claude Code skill
    if [ "$install_claude" = true ]; then
        install_claude_skill "$skills_dir"
    fi

    # Install Cursor rules
    if [ "$install_cursor" = true ]; then
        install_cursor_skill "$skills_dir"
    fi

    # Install Codex AGENTS.md
    if [ "$install_codex" = true ]; then
        install_codex_skill "$skills_dir"
    fi

    echo ""
    print_success "Done!"
    echo ""
}

install_claude_skill() {
    local skills_dir="$1"
    local source_dir="$skills_dir/claude-code"
    local target_dir="$HOME/.claude/skills/pret-a-program"

    if [ ! -d "$source_dir" ]; then
        print_error "Claude Code skill not found at: $source_dir"
        return 1
    fi

    print_info "Installing Claude Code skill..."

    # Back up existing
    if [ -d "$target_dir" ]; then
        print_warning "Existing skill found. Backing up to ${target_dir}.bak"
        rm -rf "${target_dir}.bak"
        mv "$target_dir" "${target_dir}.bak"
    fi

    # Create target directory and copy
    mkdir -p "$(dirname "$target_dir")"
    cp -r "$source_dir" "$target_dir"

    print_success "Installed Claude Code skill: $target_dir"
    echo "    Commands available: /pret-init, /pret-plan, /pret-execute, etc."
}

install_cursor_skill() {
    local skills_dir="$1"
    local source_file="$skills_dir/cursor/rules/pret-a-program.md"
    local target_dir=".cursor/rules"
    local target_file="$target_dir/pret-a-program.md"

    if [ ! -f "$source_file" ]; then
        print_error "Cursor rules file not found at: $source_file"
        return 1
    fi

    print_info "Installing Cursor rules..."

    mkdir -p "$target_dir"

    if [ -f "$target_file" ]; then
        print_info "Cursor rule already exists: $target_file"
        echo "    Updating..."
    fi

    cp "$source_file" "$target_file"
    print_success "Installed Cursor rule: $target_file"
}

install_codex_skill() {
    local skills_dir="$1"
    local source_file="$skills_dir/codex/AGENTS.md"
    local target_file="AGENTS.md"

    if [ ! -f "$source_file" ]; then
        print_error "Codex AGENTS.md not found at: $source_file"
        return 1
    fi

    print_info "Installing Codex AGENTS.md..."

    if [ -f "$target_file" ]; then
        print_info "AGENTS.md already exists in project root. Skipping."
        echo "    To force update, remove AGENTS.md and re-run."
        return 0
    fi

    cp "$source_file" "$target_file"
    print_success "Installed AGENTS.md for Codex CLI"
}
