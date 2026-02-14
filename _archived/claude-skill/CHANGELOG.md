# Changelog

All notable changes to the PARA-Programming Claude Code skill will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-24

### Added

- **Slash Commands:**
  - `/para-init` - Initialize PARA structure in projects
  - `/para-plan` - Create structured planning documents
  - `/para-summarize` - Generate summaries from work sessions
  - `/para-archive` - Archive completed contexts
  - `/para-status` - Display current workflow state
  - `/para-check` - Decision helper for workflow application

- **Templates:**
  - Plan template with standard structure
  - Summary template for documenting results
  - Context template for session state
  - Basic and full CLAUDE.md templates for projects

- **Installation:**
  - Automated installation script (install.sh)
  - Automated uninstallation script (uninstall.sh)
  - Manual installation instructions
  - Cross-platform support (macOS, Linux, Windows)

- **Documentation:**
  - Comprehensive README with examples
  - Detailed INSTALL guide
  - Example workflow walkthrough
  - Troubleshooting section

- **Workflow Enforcement:**
  - Updated CLAUDE.md with strict workflow adherence rules
  - Clear decision tree for when to use PARA workflow
  - Examples of appropriate vs. inappropriate workflow usage

### Features

- **Automated Context Management:**
  - Date-prefixed files for chronological ordering
  - JSON-based context tracking
  - Automatic updates to context.md

- **Workflow Guidance:**
  - Intelligent next-action suggestions
  - Status detection (planning, executing, ready to summarize, etc.)
  - Built-in decision support for workflow application

- **Token Efficiency:**
  - MCP tool support for preprocessing
  - Structured templates minimize boilerplate
  - Selective context loading

- **Audit Trail:**
  - Complete history via archives
  - Timestamped plans and summaries
  - Git-integrated change tracking

## [Unreleased]

### Planned

- MCP tool implementations for automation
- GitHub Actions workflow for CI/CD
- Example projects demonstrating PARA methodology
- Video tutorials and screencasts
- Plugin API integration when available
- Additional language-specific templates
- Team collaboration features
- VS Code extension for non-Claude-Code users

---

## Version History

- **1.0.0** - Initial release with core commands and documentation
