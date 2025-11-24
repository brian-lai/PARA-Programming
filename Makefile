# PARA-Programming Setup Makefile
# Automated setup for different AI coding assistants

.PHONY: help setup setup-all uninstall clean test

# Default target - show help
help:
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "  PARA-Programming Setup"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@echo "Usage:"
	@echo "  make setup <assistant>   Set up PARA for specific assistant"
	@echo "  make setup-all           Set up for all assistants"
	@echo "  make uninstall <target>  Remove setup for specific assistant"
	@echo "  make test                Verify installation"
	@echo "  make clean               Clean up temporary files"
	@echo ""
	@echo "Available Assistants:"
	@echo "  claude-skill    Claude Code with skill (recommended)"
	@echo "  claude          Claude Code without skill (legacy)"
	@echo "  cursor          Cursor IDE"
	@echo "  copilot         GitHub Copilot"
	@echo ""
	@echo "Examples:"
	@echo "  make setup claude-skill"
	@echo "  make setup cursor"
	@echo "  make setup-all"
	@echo "  make uninstall claude-skill"
	@echo ""
	@echo "For manual setup instructions, see:"
	@echo "  - SETUP-GUIDE.md (overview)"
	@echo "  - claude-skill/INSTALL.md (Claude Code skill)"
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
		echo "Available: claude-skill, claude, cursor, copilot"; \
		exit 1; \
	fi

claude-skill:
	@echo "🚀 Setting up Claude Code with PARA-Programming skill..."
	@bash scripts/setup-claude-skill.sh

claude:
	@echo "🚀 Setting up Claude Code (legacy, no skill)..."
	@bash scripts/setup-claude.sh

cursor:
	@echo "🚀 Setting up Cursor IDE with PARA-Programming..."
	@bash scripts/setup-cursor.sh

copilot:
	@echo "🚀 Setting up GitHub Copilot with PARA-Programming..."
	@bash scripts/setup-copilot.sh

# Setup for all assistants
setup-all:
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "  Setting up PARA-Programming for ALL assistants"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@$(MAKE) claude-skill
	@echo ""
	@$(MAKE) cursor
	@echo ""
	@$(MAKE) copilot
	@echo ""
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo "  ✨ All assistants configured!"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Uninstall targets
uninstall:
	@if [ -z "$(filter-out uninstall,$(MAKECMDGOALS))" ]; then \
		echo "❌ Error: Please specify what to uninstall"; \
		echo ""; \
		echo "Usage: make uninstall <target>"; \
		echo ""; \
		echo "Available: claude-skill, claude, cursor, copilot, all"; \
		exit 1; \
	fi

uninstall-claude-skill:
	@echo "🗑️  Uninstalling Claude Code skill..."
	@bash claude-skill/scripts/uninstall.sh

uninstall-claude:
	@echo "🗑️  Uninstalling Claude Code setup..."
	@bash scripts/uninstall-claude.sh

uninstall-cursor:
	@echo "🗑️  Uninstalling Cursor setup..."
	@bash scripts/uninstall-cursor.sh

uninstall-copilot:
	@echo "🗑️  Uninstalling Copilot setup..."
	@bash scripts/uninstall-copilot.sh

uninstall-all:
	@echo "⚠️  This will remove PARA-Programming setup for ALL assistants"
	@read -p "Continue? (y/N): " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		$(MAKE) uninstall-claude-skill; \
		$(MAKE) uninstall-cursor; \
		$(MAKE) uninstall-copilot; \
	else \
		echo "❌ Cancelled"; \
	fi

# Test installation
test:
	@echo "🧪 Testing PARA-Programming installation..."
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
install: setup

# Help for specific assistants
help-claude-skill:
	@cat claude-skill/README.md | head -50

help-cursor:
	@cat cursor/README.md | head -50

help-copilot:
	@cat copilot/README.md | head -50
