# Pret-a-Program Setup Makefile
# Automated setup for different AI coding assistants

.PHONY: help setup setup-all update update-all uninstall clean test claude-skill claude cursor copilot uninstall-claude-skill uninstall-claude uninstall-cursor uninstall-copilot uninstall-all

# Default target - show help
help:
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "  Pret-a-Program Setup"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@echo "Usage:"
	@echo "  make setup <assistant>        Set up Pret for specific assistant"
	@echo "  make setup-all                Set up for all assistants"
	@echo "  make update-<assistant>       Update global methodology for assistant"
	@echo "  make update-all               Update for all (or just: git pull)"
	@echo "  make uninstall <target>       Remove setup for specific assistant"
	@echo "  make test                     Verify installation"
	@echo "  make clean                    Clean up temporary files"
	@echo ""
	@echo "Available Assistants:"
	@echo "  claude-skill    Claude Code with skill (recommended)"
	@echo "  claude          Claude Code without skill (legacy)"
	@echo "  cursor          Cursor IDE"
	@echo "  copilot         GitHub Copilot"
	@echo ""
	@echo "Examples:"
	@echo "  make setup claude-skill          # Initial setup"
	@echo "  make setup-all                   # Setup all assistants"
	@echo "  make update-claude-skill         # Update methodology"
	@echo "  make update-all                  # Or just: git pull"
	@echo "  make uninstall claude-skill      # Remove setup"
	@echo ""
	@echo "💡 With symlinks, updates are automatic: just 'git pull'!"
	@echo ""
	@echo "For manual setup instructions, see:"
	@echo "  - SETUP-GUIDE.md (overview)"
	@echo "  - skills/claude-code/INSTALL.md (Claude Code skill)"
	@echo "  - claude/QUICKSTART.md (Claude Code)"
	@echo "  - cursor/QUICKSTART.md (Cursor)"
	@echo "  - copilot/QUICKSTART.md (GitHub Copilot)"
	@echo ""

# Individual assistant setup targets
setup:
	@if [ -z "$(filter-out setup,$(MAKECMDGOALS))" ]; then \
		echo "❌ Error: Please specify an assistant"; \
		echo ""; \
		echo "Usage: make setup <assistant>"; \
		echo ""; \
		echo "Available: claude-skill, claude, cursor, copilot, gemini"; \
		exit 1; \
	fi

claude-skill:
	@echo "🚀 Setting up Claude Code with Pret-a-Program skill..."
	@bash scripts/setup-claude-skill.sh

claude:
	@echo "🚀 Setting up Claude Code (legacy, no skill)..."
	@bash scripts/setup-claude.sh

cursor:
	@echo "🚀 Setting up Cursor IDE with Pret-a-Program..."
	@bash scripts/setup-cursor.sh

copilot:
	@echo "🚀 Setting up GitHub Copilot with Pret-a-Program..."
	@bash scripts/setup-copilot.sh

gemini:
	@echo "🚀 Setting up Gemini with Pret-a-Program..."
	@bash scripts/setup-gemini.sh

# Setup for all assistants
setup-all:
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "  Setting up Pret-a-Program for ALL assistants"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@$(MAKE) claude-skill
	@echo ""
	@$(MAKE) cursor
	@echo ""
	@$(MAKE) copilot
	@echo ""
	@$(MAKE) gemini
	@echo ""
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "  ✨ All assistants configured!"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Update targets
update-claude-skill:
	@bash scripts/update-claude-skill.sh

update-claude:
	@bash scripts/update-claude.sh

update-cursor:
	@bash scripts/update-cursor.sh

update-copilot:
	@bash scripts/update-copilot.sh

update-gemini:
	@bash scripts/update-gemini.sh

update-all:
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "  Updating Pret-a-Program"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@echo "✨ With symlinks, updates are automatic!"
	@echo ""
	@echo "Just run:"
	@echo "  git pull origin main"
	@echo ""
	@echo "Your symlinked files will automatically point to the latest version."

# Uninstall targets
uninstall:
	@if [ -z "$(filter-out uninstall,$(MAKECMDGOALS))" ]; then \
		echo "❌ Error: Please specify what to uninstall"; \
		echo ""; \
		echo "Usage: make uninstall <target>"; \
		echo ""; \
		echo "Available: claude-skill, claude, cursor, copilot, gemini, all"; \
		exit 1; \
	fi

uninstall-claude-skill:
	@echo "🗑️  Uninstalling Claude Code skill..."
	@bash skills/claude-code/scripts/uninstall.sh

uninstall-claude:
	@echo "🗑️  Uninstalling Claude Code setup..."
	@bash scripts/uninstall-claude.sh

uninstall-cursor:
	@echo "🗑️  Uninstalling Cursor setup..."
	@bash scripts/uninstall-cursor.sh

uninstall-copilot:
	@echo "🗑️  Uninstalling Copilot setup..."
	@bash scripts/uninstall-copilot.sh

uninstall-gemini:
	@echo "🗑️  Uninstalling Gemini setup..."
	@bash scripts/uninstall-gemini.sh

uninstall-all:
	@echo "⚠️  This will remove Pret-a-Program setup for ALL assistants"
	@read -p "Continue? (y/N): " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		$(MAKE) uninstall-claude-skill; \
		$(MAKE) uninstall-cursor; \
		$(MAKE) uninstall-copilot; \
		$(MAKE) uninstall-gemini; \
	else \
		echo "❌ Cancelled"; \
	fi

# Test installation
test:
	@echo "🧪 Testing Pret-a-Program installation..."
	@bash scripts/test-setup.sh

# Clean temporary files
clean:
	@echo "🧹 Cleaning temporary files..."
	@find . -name "*.tmp" -delete
	@find . -name ".DS_Store" -delete
	@echo "✅ Clean complete"

# Aliases for common typos
setup_claude-skill: claude-skill
setup_cursor: cursor
setup_copilot: copilot
setup_gemini: gemini
install: setup

# Help for specific assistants
help-claude-skill:
	@cat skills/claude-code/README.md | head -50

help-cursor:
	@cat cursor/README.md | head -50

help-copilot:
	@cat copilot/README.md | head -50

help-gemini:
	@cat gemini/README.md | head -50
