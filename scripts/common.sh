#!/bin/bash
#
# Common functions for PARA-Programming setup scripts
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_header() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  $1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_step() {
    echo -e "${BLUE}▶ $1${NC}"
}

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Linux*)     echo "Linux";;
        Darwin*)    echo "Mac";;
        CYGWIN*|MINGW*|MSYS*) echo "Windows";;
        *)          echo "Unknown";;
    esac
}

# Get repository root
get_repo_root() {
    git rev-parse --show-toplevel 2>/dev/null || pwd
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Create directory safely
create_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        if [ $? -eq 0 ]; then
            print_success "Created directory: $dir"
            return 0
        else
            print_error "Failed to create directory: $dir"
            return 1
        fi
    else
        print_info "Directory already exists: $dir"
        return 0
    fi
}

# Check if symlink is correctly set up
check_symlink() {
    local source="$1"
    local target="$2"

    # Expand source to absolute path
    source="$(cd "$(dirname "$source")" 2>/dev/null && pwd)/$(basename "$source")"

    # Check if target exists and is a symlink pointing to source
    if [ -L "$target" ]; then
        local current_target=$(readlink "$target")
        if [ "$current_target" = "$source" ]; then
            return 0  # Correctly set up
        fi
    fi
    return 1  # Not set up or incorrect
}

# Create symlink safely
create_symlink() {
    local source="$1"
    local target="$2"
    local description="${3:-symlink}"

    # Expand paths to absolute
    source="$(cd "$(dirname "$source")" && pwd)/$(basename "$source")"

    # Check if target already exists
    if [ -L "$target" ]; then
        local current_target=$(readlink "$target")
        if [ "$current_target" = "$source" ]; then
            print_info "$description already correctly symlinked"
            return 0
        else
            print_warning "$description symlink exists but points to: $current_target"
            read -p "Replace with correct symlink? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$target"
            else
                print_info "Skipped $description"
                return 0
            fi
        fi
    elif [ -e "$target" ]; then
        print_warning "$description exists as regular file"
        read -p "Replace with symlink? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm "$target"
        else
            print_info "Skipped $description"
            return 0
        fi
    fi

    # Create symlink
    ln -s "$source" "$target"
    if [ $? -eq 0 ]; then
        print_success "Created $description"
        return 0
    else
        print_error "Failed to create $description"
        return 1
    fi
}

# Copy file safely
copy_file() {
    local source="$1"
    local target="$2"
    local description="${3:-file}"

    if [ ! -f "$source" ]; then
        print_error "Source file not found: $source"
        return 1
    fi

    if [ -f "$target" ]; then
        print_warning "$description already exists"
        read -p "Overwrite? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Skipped $description"
            return 0
        fi
    fi

    cp "$source" "$target"
    if [ $? -eq 0 ]; then
        print_success "Copied $description"
        return 0
    else
        print_error "Failed to copy $description"
        return 1
    fi
}

# Copy directory contents
copy_directory() {
    local source="$1"
    local target="$2"
    local pattern="${3:-*}"
    local description="${4:-files}"

    if [ ! -d "$source" ]; then
        print_error "Source directory not found: $source"
        return 1
    fi

    local file_count=0
    for file in "$source"/$pattern; do
        if [ -f "$file" ]; then
            cp "$file" "$target/"
            ((file_count++))
        fi
    done

    if [ $file_count -gt 0 ]; then
        print_success "Copied $file_count $description"
        return 0
    else
        print_warning "No files matched pattern: $pattern"
        return 1
    fi
}

# Verify symlink
verify_symlink() {
    local target="$1"
    local description="${2:-symlink}"

    if [ -L "$target" ]; then
        local link_target=$(readlink "$target")
        if [ -e "$target" ]; then
            print_success "$description verified → $link_target"
            return 0
        else
            print_error "$description broken → $link_target"
            return 1
        fi
    else
        print_error "$description not found or not a symlink"
        return 1
    fi
}

# Verify file
verify_file() {
    local file="$1"
    local description="${2:-file}"

    if [ -f "$file" ]; then
        print_success "$description verified"
        return 0
    else
        print_error "$description not found"
        return 1
    fi
}

# Print completion message
print_completion() {
    local assistant="$1"

    print_header "✨ Installation Complete!"
    echo ""
    echo "PARA-Programming is now set up for $assistant"
    echo ""
    echo "Next Steps:"
    echo "1. Open your project in $assistant"
    echo "2. Initialize PARA structure (see assistant-specific guide)"
    echo "3. Start building with PARA methodology!"
    echo ""
    echo "Documentation:"
    echo "  Setup Guide: SETUP-GUIDE.md"
    echo "  Main README: README.md"
    echo ""
}

# Print update instructions
print_update_instructions() {
    local repo_root=$(get_repo_root)

    echo ""
    echo "💡 To get updates:"
    echo "   cd $repo_root"
    echo "   git pull origin main"
    echo ""
    echo "   Symlinked files will update automatically!"
    echo ""
}

# Check for required tools
check_requirements() {
    local missing=()

    if ! command_exists git; then
        missing+=("git")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        print_error "Missing required tools: ${missing[*]}"
        echo ""
        echo "Please install the missing tools and try again."
        return 1
    fi

    return 0
}

# Export functions for use in other scripts
export -f print_header
export -f print_success
export -f print_error
export -f print_warning
export -f print_info
export -f print_step
export -f detect_os
export -f get_repo_root
export -f command_exists
export -f create_dir
export -f create_symlink
export -f copy_file
export -f copy_directory
export -f verify_symlink
export -f verify_file
export -f print_completion
export -f print_update_instructions
export -f check_requirements
