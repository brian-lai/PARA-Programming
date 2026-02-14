# Phase 1: Repository & Extension Foundation

**Master Plan:** `context/plans/2026-01-06-cursor-extension.md`
**Phase:** 1 of 4
**Created:** 2026-01-06
**Status:** Planning

---

## Phase Objective

Establish the foundational infrastructure for the PARA-Programming Cursor extension. This includes:

1. Creating a new GitHub repository with proper structure
2. Setting up VS Code extension project scaffolding
3. Configuring TypeScript, webpack, and development workflow
4. Implementing basic extension activation
5. Creating a simple "Hello PARA" command to verify the extension loads
6. Applying PARA methodology to the extension repository itself

By the end of this phase, we'll have a working (though minimal) extension that can be loaded in Cursor's development host and execute a basic command.

---

## Detailed Implementation Steps

### Step 1: Create New GitHub Repository

**Repository Name:** `para-programming-cursor`
**Location:** `github.com/brian-lai/para-programming-cursor`

**Actions:**
1. Create repository on GitHub:
   - Public repository
   - MIT License
   - Add README.md (basic placeholder)
   - Add .gitignore (Node.js template)

2. Clone locally:
   ```bash
   cd ~/dev
   git clone git@github.com:brian-lai/para-programming-cursor.git
   cd para-programming-cursor
   ```

3. Initialize repository structure:
   ```bash
   # Create directory structure
   mkdir -p src/{commands,ui,utils,types}
   mkdir -p templates
   mkdir -p media
   mkdir -p test
   mkdir -p .vscode

   # Create PARA context structure (repository follows its own methodology!)
   mkdir -p context/{data,plans,summaries,archives}
   ```

### Step 2: Extension Project Scaffolding

**Files to Create:**

1. **package.json** - Extension manifest and npm configuration
   ```json
   {
     "name": "para-programming-cursor",
     "displayName": "PARA-Programming",
     "description": "Structured AI-assisted development with PARA methodology",
     "version": "0.1.0",
     "engines": {
       "vscode": "^1.85.0"
     },
     "categories": [
       "Other"
     ],
     "activationEvents": [
       "onCommand:para.init",
       "onStartupFinished"
     ],
     "main": "./dist/extension.js",
     "contributes": {
       "commands": [
         {
           "command": "para.hello",
           "title": "PARA: Hello World"
         }
       ]
     },
     "scripts": {
       "vscode:prepublish": "npm run package",
       "compile": "webpack",
       "watch": "webpack --watch",
       "package": "webpack --mode production --devtool hidden-source-map",
       "test": "node ./out/test/runTest.js"
     },
     "devDependencies": {
       "@types/vscode": "^1.85.0",
       "@types/node": "^20.x",
       "typescript": "^5.3.0",
       "webpack": "^5.89.0",
       "webpack-cli": "^5.1.4",
       "ts-loader": "^9.5.1"
     }
   }
   ```

2. **tsconfig.json** - TypeScript configuration
   ```json
   {
     "compilerOptions": {
       "module": "commonjs",
       "target": "ES2020",
       "outDir": "out",
       "lib": ["ES2020"],
       "sourceMap": true,
       "rootDir": "src",
       "strict": true,
       "esModuleInterop": true,
       "skipLibCheck": true,
       "forceConsistentCasingInFileNames": true,
       "resolveJsonModule": true
     },
     "exclude": ["node_modules", ".vscode-test"]
   }
   ```

3. **webpack.config.js** - Webpack bundling configuration
   ```javascript
   const path = require('path');

   module.exports = {
     target: 'node',
     mode: 'none',
     entry: './src/extension.ts',
     output: {
       path: path.resolve(__dirname, 'dist'),
       filename: 'extension.js',
       libraryTarget: 'commonjs2'
     },
     externals: {
       vscode: 'commonjs vscode'
     },
     resolve: {
       extensions: ['.ts', '.js']
     },
     module: {
       rules: [
         {
           test: /\.ts$/,
           exclude: /node_modules/,
           use: ['ts-loader']
         }
       ]
     },
     devtool: 'nosources-source-map'
   };
   ```

4. **.vscodeignore** - Files to exclude from extension package
   ```
   .vscode/**
   .vscode-test/**
   src/**
   .gitignore
   webpack.config.js
   tsconfig.json
   context/**
   *.md
   ```

5. **.gitignore** - Git ignore file
   ```
   node_modules
   out
   dist
   *.vsix
   .vscode-test
   ```

### Step 3: Extension Entry Point

**File:** `src/extension.ts`

```typescript
import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
    console.log('PARA-Programming extension is now active');

    // Register the hello command
    let disposable = vscode.commands.registerCommand('para.hello', () => {
        vscode.window.showInformationMessage('Hello from PARA-Programming! 🚀');
    });

    context.subscriptions.push(disposable);
}

export function deactivate() {}
```

### Step 4: Development Workflow Setup

**Files to Create:**

1. **.vscode/launch.json** - Debug configuration
   ```json
   {
     "version": "0.2.0",
     "configurations": [
       {
         "name": "Run Extension",
         "type": "extensionHost",
         "request": "launch",
         "args": [
           "--extensionDevelopmentPath=${workspaceFolder}"
         ],
         "outFiles": [
           "${workspaceFolder}/dist/**/*.js"
         ],
         "preLaunchTask": "${defaultBuildTask}"
       }
     ]
   }
   ```

2. **.vscode/tasks.json** - Build tasks
   ```json
   {
     "version": "2.0.0",
     "tasks": [
       {
         "type": "npm",
         "script": "watch",
         "problemMatcher": "$tsc-watch",
         "isBackground": true,
         "presentation": {
           "reveal": "never"
         },
         "group": {
           "kind": "build",
           "isDefault": true
         }
       }
     ]
   }
   ```

3. **.vscode/settings.json** - Workspace settings
   ```json
   {
     "typescript.tsdk": "node_modules/typescript/lib",
     "editor.formatOnSave": true
   }
   ```

### Step 5: Initial Documentation

**File:** `README.md`

```markdown
# PARA-Programming for Cursor

**Native Cursor IDE extension for the PARA-Programming methodology**

## Status

🚧 **In Development** - Phase 1: Foundation

## What is PARA-Programming?

PARA-Programming is a structured methodology for AI-assisted software development that combines:
- **Plan → Review → Execute → Summarize → Archive** workflow
- Persistent context management via `context/` directories
- Token-efficient AI collaboration
- Git-integrated development flow

This extension brings first-class PARA support to Cursor IDE.

## Development Setup

```bash
# Clone and install
git clone git@github.com:brian-lai/para-programming-cursor.git
cd para-programming-cursor
npm install

# Build and run
npm run watch  # Terminal 1
Press F5       # Start debugging
```

## Project Status

- ✅ Phase 1: Foundation (In Progress)
- ⏳ Phase 2: Core Commands
- ⏳ Phase 3: UI Components
- ⏳ Phase 4: Publishing

## License

MIT License - see LICENSE file for details.

## Links

- **Main PARA Repo:** https://github.com/brian-lai/para-programming
- **Claude Code Plugin:** https://github.com/brian-lai/para-programming-plugin
```

**File:** `LICENSE`

```
MIT License

Copyright (c) 2026 PARA-Programming Community

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### Step 6: Apply PARA to the Repository Itself

**File:** `context/context.md`

```markdown
# Current Work Summary

**Phase 1:** Repository & Extension Foundation

## To-Do List

- [ ] Repository created on GitHub
- [ ] Local clone and directory structure
- [ ] package.json and extension manifest
- [ ] TypeScript and webpack configuration
- [ ] Extension entry point (extension.ts)
- [ ] Hello World command implementation
- [ ] Development workflow (.vscode/ configs)
- [ ] Initial documentation (README, LICENSE)
- [ ] First build and test in Cursor dev host
- [ ] Phase 1 summary

## Progress Notes

Extension repository initialized following PARA methodology.

---

\`\`\`json
{
  "active_context": [
    "context/plans/2026-01-06-phase-1-foundation.md"
  ],
  "completed_summaries": [],
  "last_updated": "2026-01-06T00:00:00Z",
  "phased_execution": {
    "master_plan": "../para-programming/context/plans/2026-01-06-cursor-extension.md",
    "current_phase": 1
  }
}
\`\`\`
```

**File:** `CLAUDE.md` (project-specific instructions)

```markdown
# PARA-Programming Cursor Extension

> **Workflow Methodology:** This repository follows the PARA-Programming methodology it implements.

## About

Native Cursor IDE extension for PARA-Programming. Provides command palette integration, tree view, status bar, and workflow automation for the PARA methodology.

## Tech Stack

- **TypeScript** - Extension language
- **VS Code Extension API** - Core API (Cursor extends VS Code)
- **webpack** - Bundling
- **Node.js** - Runtime

## Architecture

```
src/
├── extension.ts       # Entry point, activation
├── commands/          # Command implementations
├── ui/                # Tree view, status bar, webviews
├── utils/             # File system, git, templates
└── types/             # TypeScript types
```

## Development

```bash
npm install
npm run watch  # Terminal 1
Press F5       # Start debugging (Terminal 2)
```

## Phase Strategy

This project uses **phased plans** (defined in main para-programming repo):

- Phase 1: Foundation ← **Current**
- Phase 2: Core Commands
- Phase 3: UI Components
- Phase 4: Publishing

Each phase is independently reviewable and mergeable.
```

### Step 7: Initialize npm and Build

**Commands:**
```bash
cd ~/dev/para-programming-cursor
npm install
npm run compile
```

**Verify:**
- `node_modules/` directory created
- `dist/extension.js` created
- No TypeScript errors

### Step 8: Test in Cursor Development Host

**Steps:**
1. Open `para-programming-cursor` in Cursor
2. Press F5 to start extension development host
3. New Cursor window opens with extension loaded
4. Open Command Palette (Cmd+Shift+P)
5. Search for "PARA: Hello World"
6. Execute command
7. Verify "Hello from PARA-Programming! 🚀" notification appears

### Step 9: Initial Commit

**Commands:**
```bash
git add .
git commit -m "chore: Phase 1 foundation - extension scaffolding

- Initialize extension project structure
- Configure TypeScript, webpack, and build system
- Implement basic extension activation
- Add hello world command for verification
- Set up development workflow
- Apply PARA methodology to repository itself

Phase 1 of 4 complete. Extension loads and executes basic command.

🤖 Generated with Claude Code
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

git push origin main
```

---

## Files to Create/Modify

| File | Purpose | Lines |
|------|---------|-------|
| `package.json` | Extension manifest, npm config | ~60 |
| `tsconfig.json` | TypeScript configuration | ~20 |
| `webpack.config.js` | Webpack bundler config | ~30 |
| `.vscodeignore` | Package exclusions | ~10 |
| `.gitignore` | Git exclusions | ~10 |
| `src/extension.ts` | Extension entry point | ~20 |
| `.vscode/launch.json` | Debug configuration | ~20 |
| `.vscode/tasks.json` | Build tasks | ~20 |
| `.vscode/settings.json` | Workspace settings | ~5 |
| `README.md` | Repository documentation | ~50 |
| `LICENSE` | MIT license | ~20 |
| `context/context.md` | PARA context (meta!) | ~30 |
| `CLAUDE.md` | Project instructions | ~40 |

**Total:** ~335 lines across 13 files

---

## Risks & Mitigation

### Technical Risks

| Risk | Impact | Mitigation |
|------|--------|-----------|
| VS Code API compatibility | High | Use stable API version (^1.85.0) |
| Webpack bundling issues | Medium | Follow official extension examples |
| TypeScript configuration | Low | Use standard extension tsconfig |

### Development Risks

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Development host not loading | High | Verify launch.json and tasks.json |
| Hot reload not working | Medium | Use watch mode, restart if needed |
| Extension not activating | High | Check activation events in package.json |

---

## Success Criteria

Phase 1 is complete when:

✅ **Repository Setup**
- [ ] GitHub repository created at `github.com/brian-lai/para-programming-cursor`
- [ ] Repository cloned locally
- [ ] Directory structure initialized
- [ ] PARA context/ structure created

✅ **Extension Scaffolding**
- [ ] package.json with valid extension manifest
- [ ] TypeScript and webpack configured
- [ ] Extension entry point created
- [ ] Build system working (`npm run compile` succeeds)

✅ **Development Workflow**
- [ ] .vscode/ configuration files created
- [ ] `npm run watch` starts successfully
- [ ] F5 launches extension development host
- [ ] New Cursor window opens with extension loaded

✅ **Verification**
- [ ] "PARA: Hello World" command appears in command palette
- [ ] Command executes without errors
- [ ] Notification appears with correct message
- [ ] Console shows "PARA-Programming extension is now active"

✅ **Documentation**
- [ ] README.md describes project and setup
- [ ] LICENSE file present (MIT)
- [ ] CLAUDE.md provides project context
- [ ] context/context.md tracks phase progress

✅ **Repository Quality**
- [ ] All files committed to git
- [ ] Pushed to GitHub
- [ ] Repository follows PARA methodology itself
- [ ] Clean build (no errors or warnings)

---

## Testing Checklist

### Build Tests
- [ ] `npm install` completes without errors
- [ ] `npm run compile` builds dist/extension.js
- [ ] `npm run watch` starts and watches for changes
- [ ] TypeScript compilation has no errors
- [ ] Webpack bundling succeeds

### Extension Tests
- [ ] Extension development host launches (F5)
- [ ] Extension activates (check console)
- [ ] Command palette shows PARA commands
- [ ] "PARA: Hello World" executes successfully
- [ ] Notification displays correct message

### Hot Reload Tests
- [ ] Make change to extension.ts
- [ ] Save file (watch mode rebuilds)
- [ ] Reload extension (Cmd+R in dev host)
- [ ] Changes reflected without full restart

---

## Dependencies

**npm packages to install:**

```json
{
  "devDependencies": {
    "@types/vscode": "^1.85.0",
    "@types/node": "^20.x",
    "typescript": "^5.3.0",
    "webpack": "^5.89.0",
    "webpack-cli": "^5.1.4",
    "ts-loader": "^9.5.1"
  }
}
```

All are dev dependencies (extension itself has no runtime dependencies in Phase 1).

---

## Review Checklist

Before proceeding to Phase 2:

- [ ] All files created and committed
- [ ] Extension loads in development host
- [ ] Hello World command works
- [ ] Build system is reliable
- [ ] Documentation is clear
- [ ] Repository follows PARA methodology
- [ ] No outstanding TODOs or FIXMEs
- [ ] Code is clean and well-structured

---

## Next Phase

After Phase 1 is complete and reviewed:

👉 **Phase 2:** Core PARA Commands
- Implement `/para-init` command
- Implement `/para-plan` command
- Implement `/para-execute` command
- Implement `/para-summarize` command
- Implement `/para-archive` command
- Add git integration
- Add template generation

**Plan:** `context/plans/2026-01-06-cursor-extension-phase-2.md`

---

**Phase 1 establishes the foundation. Phases 2-4 build the full PARA experience on this solid base.** 🏗️
