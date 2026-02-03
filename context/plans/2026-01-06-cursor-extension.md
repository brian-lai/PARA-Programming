# Master Plan: PARA-Programming Cursor Extension

**Created:** 2026-01-06
**Type:** Phased Plan (Master)
**Status:** Planning

---

## Overall Objective

Create a native Cursor IDE extension for PARA-Programming that provides an integrated, first-class experience for the methodology. This will complement the existing Claude Code plugin by offering:

- **Native Cursor integration** - Extension API, command palette, status bar
- **Visual workflow support** - Tree view, quick picks, status indicators
- **Automatic file management** - Context directory creation, template scaffolding
- **Git integration** - Automatic branch creation, context commits
- **Enhanced UX** - Better than `.cursorrules` file alone

The extension will make PARA-Programming feel like a built-in Cursor feature rather than an external methodology.

---

## Why Phased Approach?

This project naturally breaks into distinct phases:

1. **Foundation** - Extension setup, manifest, activation
2. **Core Commands** - Command palette integration for PARA workflow
3. **UI Components** - Tree view, status bar, webviews
4. **Polish & Publishing** - Testing, documentation, marketplace submission

Each phase:
- Delivers independently testable functionality
- Can be reviewed and merged separately
- Builds on previous phases
- Has clear success criteria

---

## Phase Breakdown

### Phase 1: Repository & Extension Foundation
**Plan:** `context/plans/2026-01-06-cursor-extension-phase-1.md`
**Estimated Files:** 10-12 files
**Dependencies:** None

**Deliverables:**
- New GitHub repository: `github.com/brian-lai/para-programming-cursor`
- Repository setup (README, LICENSE, .gitignore)
- Extension project scaffolding (package.json, tsconfig, webpack)
- Basic extension activation and registration
- Extension manifest with metadata and capabilities
- Development workflow setup (build, watch, debug)
- Basic "Hello PARA" command to verify extension works
- Initial PARA structure in the repository (context/, templates/)

**Success Criteria:**
- Repository created and initialized
- Extension loads in Cursor development host
- Command palette shows "PARA-Programming" category
- Basic command executes successfully
- Hot reload works during development
- Repository follows PARA methodology itself

### Phase 2: Core PARA Commands
**Plan:** `context/plans/2026-01-06-cursor-extension-phase-2.md`
**Estimated Files:** 10-12 files
**Dependencies:** Phase 1

**Deliverables:**
- `/para-init` command implementation
- `/para-plan` command implementation
- `/para-execute` command implementation
- `/para-summarize` command implementation
- `/para-archive` command implementation
- Context directory management utilities
- Template file generation
- Git branch integration

**Success Criteria:**
- All 5 core commands work end-to-end
- Context directories created correctly
- Templates generated with proper content
- Git branches created automatically
- Commands appear in command palette with descriptions

### Phase 3: UI Components & Enhanced Experience
**Plan:** `context/plans/2026-01-06-cursor-extension-phase-3.md`
**Estimated Files:** 8-10 files
**Dependencies:** Phase 2

**Deliverables:**
- Tree View for context/ directory structure
- Status bar item showing current PARA state
- Quick Pick menus for plan selection
- Webview for plan review/approval
- Notifications and progress indicators
- File watchers for context/ changes
- Syntax highlighting for PARA templates

**Success Criteria:**
- Tree view renders context/ directory with icons
- Status bar shows active plan/branch
- Quick picks work for command selection
- Webview displays plans with formatting
- File changes trigger UI updates

### Phase 4: Polish, Documentation & Publishing
**Plan:** `context/plans/2026-01-06-cursor-extension-phase-4.md`
**Estimated Files:** 6-8 files
**Dependencies:** Phase 3

**Deliverables:**
- Extension README with usage guide
- CHANGELOG and versioning
- Extension icon and branding
- Marketplace listing metadata
- Installation instructions
- Example project/demo
- VS Code Marketplace submission
- Repository documentation updates
- Link from main para-programming repo

**Success Criteria:**
- Professional README with screenshots
- Extension published to marketplace
- Installation works via marketplace search
- Demo project demonstrates features
- Documentation covers all commands
- Main PARA repo links to extension

---

## Technical Architecture

### Extension Components

```
para-programming-extension/
├── src/
│   ├── extension.ts              # Extension entry point
│   ├── commands/                 # Command implementations
│   │   ├── init.ts
│   │   ├── plan.ts
│   │   ├── execute.ts
│   │   ├── summarize.ts
│   │   └── archive.ts
│   ├── ui/                       # UI components
│   │   ├── treeView.ts
│   │   ├── statusBar.ts
│   │   ├── quickPicks.ts
│   │   └── webview/
│   ├── utils/                    # Utilities
│   │   ├── fileSystem.ts
│   │   ├── git.ts
│   │   ├── templates.ts
│   │   └── context.ts
│   └── types/                    # TypeScript types
├── templates/                    # Template files
├── media/                        # Icons and images
├── test/                         # Tests
├── package.json                  # Extension manifest
└── README.md
```

### Key Technologies

- **TypeScript** - Extension language
- **VS Code Extension API** - Cursor extends VS Code
- **Node.js** - Runtime environment
- **webpack** - Bundling
- **simple-git** - Git operations
- **@types/vscode** - Type definitions

### Integration Points

1. **Command Palette** - Register PARA commands
2. **Activity Bar** - Tree view for context/ navigation
3. **Status Bar** - Show current plan/branch
4. **File System** - Watch context/ directory
5. **Git Integration** - Branch creation, commits
6. **Editor** - Open plans/summaries in editor
7. **Notifications** - User feedback and guidance

---

## Cross-Phase Considerations

### Consistency with Claude Code Plugin

The Cursor extension should maintain workflow consistency with the Claude Code plugin:

- Same command names (`para-program:init` → `PARA: Initialize`)
- Same directory structure (`context/plans/`, `context/summaries/`)
- Same template formats
- Same workflow steps (Plan → Review → Execute → Summarize → Archive)
- Compatible with existing PARA projects

### Token Efficiency (Not Directly Applicable)

While Cursor extensions don't consume LLM tokens, the extension should:
- Generate concise, well-structured plans
- Create clear summaries
- Maintain clean context/ directory
- Support MCP integration patterns (for future)

### User Experience Principles

1. **Guided workflow** - Extension guides users through PARA steps
2. **Visual feedback** - Always show current state
3. **Error prevention** - Validate before destructive operations
4. **Discoverability** - Commands easy to find in palette
5. **Flexibility** - Support both keyboard and mouse workflows

### Testing Strategy

Each phase should include:
- **Unit tests** - Test individual functions
- **Integration tests** - Test command workflows
- **Manual testing** - Test in actual Cursor instance
- **Regression tests** - Ensure earlier phases still work

### Documentation Strategy

Each phase should document:
- **User-facing docs** - How to use new features
- **Developer docs** - How extension works internally
- **Changelog** - What changed in this phase

---

## Risk Analysis

### Technical Risks

| Risk | Mitigation | Phase |
|------|-----------|-------|
| VS Code API changes | Use stable API only, version pinning | 1 |
| Git operations fail | Error handling, user notifications | 2 |
| File system permissions | Check permissions, clear error messages | 2 |
| Tree view performance | Lazy loading, caching | 3 |
| Webview security | Content Security Policy, sanitization | 3 |
| Marketplace rejection | Follow all guidelines, test thoroughly | 4 |

### User Experience Risks

| Risk | Mitigation | Phase |
|------|-----------|-------|
| Overwhelming UI | Incremental disclosure, clear defaults | 3 |
| Unclear workflow | Onboarding guide, contextual help | 4 |
| Conflicts with .cursorrules | Clear precedence rules, documentation | 2 |
| Git conflicts | Branch strategy, conflict detection | 2 |

### Project Risks

| Risk | Mitigation | Phase |
|------|-----------|-------|
| Scope creep | Stick to phase plans, defer features | All |
| Compatibility issues | Test with multiple Cursor versions | 4 |
| Incomplete documentation | Doc requirement in each phase | All |

---

## Success Criteria (Overall)

The Cursor extension project is successful when:

✅ **Functional Completeness**
- All 5 core PARA commands work end-to-end
- UI components render correctly
- Git integration works reliably
- File operations are robust

✅ **User Experience**
- Extension feels native to Cursor
- Workflow is intuitive and guided
- Visual feedback is clear
- Error messages are helpful

✅ **Distribution**
- Published to VS Code Marketplace
- Installation works smoothly
- Documentation is comprehensive
- Demo project demonstrates value

✅ **Quality**
- All tests passing
- No critical bugs
- Performance is acceptable
- Code is maintainable

✅ **Adoption**
- Users prefer extension over .cursorrules alone
- Positive feedback from community
- Compatible with existing PARA projects

---

## Post-Launch Considerations

After Phase 4, potential future enhancements:

- **Settings panel** - Configure PARA preferences
- **MCP server integration** - Direct MCP tool execution
- **Plan templates** - Pre-built plan templates for common tasks
- **Multi-workspace support** - Handle monorepos
- **Cloud sync** - Sync context across machines
- **Analytics** - Usage metrics and insights
- **AI assistant** - Integrated plan generation

These are OUT OF SCOPE for initial release but noted for future roadmap.

---

## Timeline & Sequencing

**Phase Order (must be sequential):**

1. Phase 1 (Foundation) - Cannot proceed without working extension
2. Phase 2 (Commands) - Requires Phase 1 activation
3. Phase 3 (UI) - Requires Phase 2 commands to visualize
4. Phase 4 (Publishing) - Requires complete, tested extension

**Review Points:**

- After Phase 1: Verify extension architecture is sound
- After Phase 2: Verify command workflow matches Claude Code plugin
- After Phase 3: Verify UX is intuitive and polished
- After Phase 4: Final review before marketplace submission

**Integration Strategy:**

- Each phase should be on separate git branch
- Merge to main after review
- Tag releases at phase boundaries (v0.1, v0.2, v0.3, v1.0)

---

## References

- **Claude Code Plugin:** `github.com/brian-lai/para-programming-plugin`
- **PARA Methodology:** Main repository `github.com/brian-lai/para-programming`
- **New Extension Repo:** `github.com/brian-lai/para-programming-cursor` (to be created)
- **VS Code Extension API:** https://code.visualstudio.com/api
- **Cursor Documentation:** https://cursor.sh/docs
- **VS Code Publishing:** https://code.visualstudio.com/api/working-with-extensions/publishing-extension

---

## Next Steps

1. Review this master plan
2. Review Phase 1 plan: `context/plans/2026-01-06-cursor-extension-phase-1.md`
3. Approve to begin Phase 1 implementation
4. Execute Phase 1 → Review → Merge → Repeat for subsequent phases

---

**This is a comprehensive, multi-phase project. Each phase builds on the previous one to create a polished, professional Cursor extension for PARA-Programming.** 🚀
