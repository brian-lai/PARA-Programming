# Phase 2: Core PARA Commands

**Master Plan:** `context/plans/2026-01-06-cursor-extension.md`
**Phase:** 2 of 4
**Created:** 2026-01-06
**Status:** Planning
**Dependencies:** Phase 1 (Extension foundation)

---

## Phase Objective

Implement the five core PARA-Programming commands that form the workflow backbone:

1. **PARA: Initialize** - Set up PARA structure in a project
2. **PARA: Plan** - Create a new plan document
3. **PARA: Execute** - Start execution (branch + context)
4. **PARA: Summarize** - Generate summary from work completed
5. **PARA: Archive** - Archive context and prepare for next task

Each command should match the functionality of the Claude Code plugin while leveraging Cursor's native capabilities (file system API, git integration, editor control).

---

## Detailed Implementation Steps

### Step 1: Utility Modules

Before implementing commands, create reusable utility modules:

#### File: `src/utils/fileSystem.ts`

```typescript
import * as vscode from 'vscode';
import * as fs from 'fs/promises';
import * as path from 'path';

export class FileSystemUtils {
    static async createDirectory(dirPath: string): Promise<void> {
        try {
            await fs.mkdir(dirPath, { recursive: true });
        } catch (error) {
            throw new Error(`Failed to create directory ${dirPath}: ${error}`);
        }
    }

    static async fileExists(filePath: string): Promise<boolean> {
        try {
            await fs.access(filePath);
            return true;
        } catch {
            return false;
        }
    }

    static async readFile(filePath: string): Promise<string> {
        return await fs.readFile(filePath, 'utf-8');
    }

    static async writeFile(filePath: string, content: string): Promise<void> {
        await fs.writeFile(filePath, content, 'utf-8');
    }

    static getWorkspaceRoot(): string | undefined {
        return vscode.workspace.workspaceFolders?.[0]?.uri.fsPath;
    }
}
```

#### File: `src/utils/git.ts`

```typescript
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

export class GitUtils {
    constructor(private workingDir: string) {}

    async createBranch(branchName: string): Promise<void> {
        try {
            // Check if branch already exists
            const { stdout } = await execAsync(
                `git rev-parse --verify ${branchName}`,
                { cwd: this.workingDir }
            );
            throw new Error(`Branch ${branchName} already exists`);
        } catch {
            // Branch doesn't exist, create it
            await execAsync(`git checkout -b ${branchName}`, {
                cwd: this.workingDir
            });
        }
    }

    async getCurrentBranch(): Promise<string> {
        const { stdout } = await execAsync('git branch --show-current', {
            cwd: this.workingDir
        });
        return stdout.trim();
    }

    async commit(message: string): Promise<void> {
        await execAsync('git add .', { cwd: this.workingDir });
        await execAsync(`git commit -m "${message}"`, {
            cwd: this.workingDir
        });
    }

    async getStatus(): Promise<string> {
        const { stdout } = await execAsync('git status --short', {
            cwd: this.workingDir
        });
        return stdout;
    }

    async getDiff(fromRef: string = 'main'): Promise<string> {
        const { stdout } = await execAsync(`git diff ${fromRef}...HEAD`, {
            cwd: this.workingDir
        });
        return stdout;
    }

    async isGitRepo(): Promise<boolean> {
        try {
            await execAsync('git rev-parse --git-dir', {
                cwd: this.workingDir
            });
            return true;
        } catch {
            return false;
        }
    }
}
```

#### File: `src/utils/templates.ts`

```typescript
import * as fs from 'fs/promises';
import * as path from 'path';

export class TemplateUtils {
    static async getPlanTemplate(): Promise<string> {
        return `# [Task Name]

**Created:** ${new Date().toISOString().split('T')[0]}

---

## Objective

[Clear statement of what needs to be accomplished]

---

## Approach

### Step 1: [First Step]

[Detailed description]

### Step 2: [Second Step]

[Detailed description]

### Step 3: [Third Step]

[Detailed description]

---

## Risks

- **[Risk 1]:** [Description and mitigation]
- **[Risk 2]:** [Description and mitigation]

---

## Data Sources

- [File paths, APIs, or external data needed]

---

## Success Criteria

- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]
- [ ] [Measurable outcome 3]

---

## Review Checklist

- [ ] All steps clearly defined
- [ ] Risks identified and mitigated
- [ ] Success criteria are measurable
- [ ] Ready to proceed
`;
    }

    static async getSummaryTemplate(taskName: string): Promise<string> {
        return `# Summary: ${taskName}

**Completed:** ${new Date().toISOString().split('T')[0]}

---

## What Was Done

[High-level description of what was accomplished]

---

## Changes Made

### Files Created
- \`path/to/file1.ts\` - [Purpose]
- \`path/to/file2.ts\` - [Purpose]

### Files Modified
- \`path/to/file3.ts\` - [What changed]
- \`path/to/file4.ts\` - [What changed]

---

## Technical Decisions

**[Decision 1]:** [Rationale]

**[Decision 2]:** [Rationale]

---

## Testing

- [Test approach]
- [Test results]

---

## Known Issues

- [Any issues or limitations]

---

## Next Steps

- [Suggested follow-up work]
`;
    }

    static async getContextTemplate(): Promise<string> {
        return `# Current Work Summary

Ready to start PARA-Programming.

---

\`\`\`json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "${new Date().toISOString()}"
}
\`\`\`
`;
    }

    static async getClaudeTemplate(projectName: string): Promise<string> {
        return `# ${projectName}

> **Workflow Methodology:** Follow PARA-Programming methodology.

## About

[Project description]

## Tech Stack

- [Technology 1]
- [Technology 2]

## Architecture

[High-level architecture description]

## Getting Started

\`\`\`bash
[Setup commands]
\`\`\`
`;
    }
}
```

#### File: `src/utils/context.ts`

```typescript
import * as path from 'path';
import { FileSystemUtils } from './fileSystem';

interface ContextData {
    active_context: string[];
    completed_summaries: string[];
    last_updated: string;
}

export class ContextUtils {
    constructor(private workspaceRoot: string) {}

    async readContext(): Promise<ContextData> {
        const contextPath = path.join(
            this.workspaceRoot,
            'context',
            'context.md'
        );

        if (!(await FileSystemUtils.fileExists(contextPath))) {
            return {
                active_context: [],
                completed_summaries: [],
                last_updated: new Date().toISOString()
            };
        }

        const content = await FileSystemUtils.readFile(contextPath);
        const jsonMatch = content.match(/```json\n([\s\S]*?)\n```/);

        if (jsonMatch) {
            return JSON.parse(jsonMatch[1]);
        }

        return {
            active_context: [],
            completed_summaries: [],
            last_updated: new Date().toISOString()
        };
    }

    async updateContext(data: Partial<ContextData>): Promise<void> {
        const current = await this.readContext();
        const updated = { ...current, ...data, last_updated: new Date().toISOString() };

        const contextPath = path.join(
            this.workspaceRoot,
            'context',
            'context.md'
        );

        const content = `# Current Work Summary

[Update this with current status]

---

\`\`\`json
${JSON.stringify(updated, null, 2)}
\`\`\`
`;

        await FileSystemUtils.writeFile(contextPath, content);
    }

    async addActivePlan(planPath: string): Promise<void> {
        const context = await this.readContext();
        if (!context.active_context.includes(planPath)) {
            context.active_context.push(planPath);
            await this.updateContext(context);
        }
    }

    async addCompletedSummary(summaryPath: string): Promise<void> {
        const context = await this.readContext();
        if (!context.completed_summaries.includes(summaryPath)) {
            context.completed_summaries.push(summaryPath);
            await this.updateContext(context);
        }
    }
}
```

### Step 2: Command Implementations

#### File: `src/commands/init.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';
import { FileSystemUtils } from '../utils/fileSystem';
import { TemplateUtils } from '../utils/templates';

export async function initCommand() {
    const workspaceRoot = FileSystemUtils.getWorkspaceRoot();

    if (!workspaceRoot) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    // Check if already initialized
    const contextPath = path.join(workspaceRoot, 'context');
    if (await FileSystemUtils.fileExists(contextPath)) {
        const overwrite = await vscode.window.showWarningMessage(
            'PARA structure already exists. Overwrite?',
            'Yes',
            'No'
        );
        if (overwrite !== 'Yes') {
            return;
        }
    }

    try {
        // Create directory structure
        await FileSystemUtils.createDirectory(path.join(contextPath, 'data'));
        await FileSystemUtils.createDirectory(path.join(contextPath, 'plans'));
        await FileSystemUtils.createDirectory(
            path.join(contextPath, 'summaries')
        );
        await FileSystemUtils.createDirectory(
            path.join(contextPath, 'archives')
        );
        await FileSystemUtils.createDirectory(
            path.join(contextPath, 'servers')
        );

        // Create context.md
        const contextTemplate = await TemplateUtils.getContextTemplate();
        await FileSystemUtils.writeFile(
            path.join(contextPath, 'context.md'),
            contextTemplate
        );

        // Create CLAUDE.md if it doesn't exist
        const claudePath = path.join(workspaceRoot, 'CLAUDE.md');
        if (!(await FileSystemUtils.fileExists(claudePath))) {
            const projectName = path.basename(workspaceRoot);
            const claudeTemplate = await TemplateUtils.getClaudeTemplate(
                projectName
            );
            await FileSystemUtils.writeFile(claudePath, claudeTemplate);
        }

        vscode.window.showInformationMessage(
            'PARA structure initialized successfully! 🚀'
        );
    } catch (error) {
        vscode.window.showErrorMessage(
            `Failed to initialize PARA structure: ${error}`
        );
    }
}
```

#### File: `src/commands/plan.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';
import { FileSystemUtils } from '../utils/fileSystem';
import { TemplateUtils } from '../utils/templates';
import { ContextUtils } from '../utils/context';

export async function planCommand() {
    const workspaceRoot = FileSystemUtils.getWorkspaceRoot();

    if (!workspaceRoot) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    // Check if PARA initialized
    const contextPath = path.join(workspaceRoot, 'context');
    if (!(await FileSystemUtils.fileExists(contextPath))) {
        const init = await vscode.window.showWarningMessage(
            'PARA not initialized. Initialize now?',
            'Yes',
            'No'
        );
        if (init === 'Yes') {
            await vscode.commands.executeCommand('para.init');
        }
        return;
    }

    // Prompt for task name
    const taskName = await vscode.window.showInputBox({
        prompt: 'Enter task name (e.g., "add-user-authentication")',
        placeHolder: 'task-name'
    });

    if (!taskName) {
        return;
    }

    // Generate filename
    const date = new Date().toISOString().split('T')[0];
    const sanitized = taskName.toLowerCase().replace(/\s+/g, '-');
    const filename = `${date}-${sanitized}.md`;
    const planPath = path.join(contextPath, 'plans', filename);

    // Create plan from template
    const template = await TemplateUtils.getPlanTemplate();
    const content = template.replace('[Task Name]', taskName);
    await FileSystemUtils.writeFile(planPath, content);

    // Update context
    const contextUtils = new ContextUtils(workspaceRoot);
    await contextUtils.addActivePlan(`context/plans/${filename}`);

    // Open plan in editor
    const doc = await vscode.workspace.openTextDocument(planPath);
    await vscode.window.showTextDocument(doc);

    vscode.window.showInformationMessage(
        `Plan created: context/plans/${filename}`
    );
}
```

#### File: `src/commands/execute.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';
import { FileSystemUtils } from '../utils/fileSystem';
import { GitUtils } from '../utils/git';
import { ContextUtils } from '../utils/context';

export async function executeCommand() {
    const workspaceRoot = FileSystemUtils.getWorkspaceRoot();

    if (!workspaceRoot) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const gitUtils = new GitUtils(workspaceRoot);

    // Check if git repo
    if (!(await gitUtils.isGitRepo())) {
        vscode.window.showErrorMessage(
            'Not a git repository. Initialize git first.'
        );
        return;
    }

    // Get active plans
    const contextUtils = new ContextUtils(workspaceRoot);
    const context = await contextUtils.readContext();

    if (context.active_context.length === 0) {
        vscode.window.showWarningMessage('No active plans. Create a plan first.');
        return;
    }

    // Select plan (if multiple)
    let planPath: string;
    if (context.active_context.length === 1) {
        planPath = context.active_context[0];
    } else {
        const selection = await vscode.window.showQuickPick(
            context.active_context,
            { placeHolder: 'Select plan to execute' }
        );
        if (!selection) {
            return;
        }
        planPath = selection;
    }

    // Extract task name from plan path
    const filename = path.basename(planPath, '.md');
    const taskName = filename.replace(/^\d{4}-\d{2}-\d{2}-/, '');

    // Create git branch
    const branchName = `para/${taskName}`;

    try {
        await gitUtils.createBranch(branchName);

        // Update context.md with execution info
        const contextPath = path.join(workspaceRoot, 'context', 'context.md');
        const content = `# Current Work Summary

Executing: ${taskName}

**Branch:** \`${branchName}\`
**Plan:** \`${planPath}\`

## To-Do List

- [ ] Review plan
- [ ] Implement changes
- [ ] Run tests
- [ ] Create summary

## Progress Notes

[Add notes as you work]

---

\`\`\`json
${JSON.stringify(context, null, 2)}
\`\`\`
`;

        await FileSystemUtils.writeFile(contextPath, content);

        // Commit context initialization
        await gitUtils.commit(
            `chore: Initialize execution context for ${taskName}

🤖 Generated with PARA-Programming
`
        );

        vscode.window.showInformationMessage(
            `Execution started on branch: ${branchName} 🚀`
        );
    } catch (error) {
        vscode.window.showErrorMessage(`Failed to start execution: ${error}`);
    }
}
```

#### File: `src/commands/summarize.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';
import { FileSystemUtils } from '../utils/fileSystem';
import { GitUtils } from '../utils/git';
import { TemplateUtils } from '../utils/templates';
import { ContextUtils } from '../utils/context';

export async function summarizeCommand() {
    const workspaceRoot = FileSystemUtils.getWorkspaceRoot();

    if (!workspaceRoot) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const gitUtils = new GitUtils(workspaceRoot);

    // Get current branch
    const currentBranch = await gitUtils.getCurrentBranch();

    if (!currentBranch.startsWith('para/')) {
        vscode.window.showWarningMessage(
            'Not on a PARA branch. Summarize anyway?',
            'Yes',
            'No'
        ).then(async (choice) => {
            if (choice !== 'Yes') {
                return;
            }
        });
    }

    // Extract task name from branch
    const taskName = currentBranch.replace('para/', '');

    // Generate summary filename
    const date = new Date().toISOString().split('T')[0];
    const filename = `${date}-${taskName}-summary.md`;
    const summaryPath = path.join(
        workspaceRoot,
        'context',
        'summaries',
        filename
    );

    // Get git diff for context
    const diff = await gitUtils.getDiff();

    // Create summary from template
    let template = await TemplateUtils.getSummaryTemplate(taskName);

    // Add git diff info if available
    if (diff) {
        template += `\n---\n\n## Git Diff\n\n\`\`\`diff\n${diff.slice(
            0,
            5000
        )}\n\`\`\`\n`;
    }

    await FileSystemUtils.writeFile(summaryPath, template);

    // Update context
    const contextUtils = new ContextUtils(workspaceRoot);
    await contextUtils.addCompletedSummary(`context/summaries/${filename}`);

    // Open summary for editing
    const doc = await vscode.workspace.openTextDocument(summaryPath);
    await vscode.window.showTextDocument(doc);

    vscode.window.showInformationMessage(
        `Summary created: context/summaries/${filename}`
    );
}
```

#### File: `src/commands/archive.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';
import { FileSystemUtils } from '../utils/fileSystem';
import { TemplateUtils } from '../utils/templates';

export async function archiveCommand() {
    const workspaceRoot = FileSystemUtils.getWorkspaceRoot();

    if (!workspaceRoot) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const confirm = await vscode.window.showWarningMessage(
        'Archive current context and start fresh?',
        'Yes',
        'No'
    );

    if (confirm !== 'Yes') {
        return;
    }

    try {
        // Read current context
        const contextPath = path.join(workspaceRoot, 'context', 'context.md');
        const currentContext = await FileSystemUtils.readFile(contextPath);

        // Generate archive filename
        const timestamp = new Date()
            .toISOString()
            .replace(/[:.]/g, '-')
            .slice(0, -5);
        const archivePath = path.join(
            workspaceRoot,
            'context',
            'archives',
            `${timestamp}-context.md`
        );

        // Move to archives
        await FileSystemUtils.writeFile(archivePath, currentContext);

        // Reset context
        const newContext = await TemplateUtils.getContextTemplate();
        await FileSystemUtils.writeFile(contextPath, newContext);

        vscode.window.showInformationMessage(
            `Context archived: context/archives/${path.basename(archivePath)} ✅`
        );
    } catch (error) {
        vscode.window.showErrorMessage(`Failed to archive context: ${error}`);
    }
}
```

### Step 3: Register Commands in Extension

#### File: `src/extension.ts` (updated)

```typescript
import * as vscode from 'vscode';
import { initCommand } from './commands/init';
import { planCommand } from './commands/plan';
import { executeCommand } from './commands/execute';
import { summarizeCommand } from './commands/summarize';
import { archiveCommand } from './commands/archive';

export function activate(context: vscode.ExtensionContext) {
    console.log('PARA-Programming extension is now active');

    // Register all commands
    const commands = [
        vscode.commands.registerCommand('para.init', initCommand),
        vscode.commands.registerCommand('para.plan', planCommand),
        vscode.commands.registerCommand('para.execute', executeCommand),
        vscode.commands.registerCommand('para.summarize', summarizeCommand),
        vscode.commands.registerCommand('para.archive', archiveCommand)
    ];

    commands.forEach((cmd) => context.subscriptions.push(cmd));
}

export function deactivate() {}
```

### Step 4: Update Extension Manifest

#### File: `package.json` (contributes section)

```json
{
  "contributes": {
    "commands": [
      {
        "command": "para.init",
        "title": "PARA: Initialize"
      },
      {
        "command": "para.plan",
        "title": "PARA: Create Plan"
      },
      {
        "command": "para.execute",
        "title": "PARA: Execute Plan"
      },
      {
        "command": "para.summarize",
        "title": "PARA: Summarize Work"
      },
      {
        "command": "para.archive",
        "title": "PARA: Archive Context"
      }
    ]
  }
}
```

---

## Testing Strategy

### Unit Tests (Optional for Phase 2, Required for Phase 4)

Create tests for utility modules:

- `test/utils/fileSystem.test.ts`
- `test/utils/git.test.ts`
- `test/utils/templates.test.ts`
- `test/utils/context.test.ts`

### Manual Testing Checklist

1. **PARA: Initialize**
   - [ ] Creates context/ directories
   - [ ] Creates context.md with valid JSON
   - [ ] Creates CLAUDE.md if missing
   - [ ] Doesn't overwrite without confirmation
   - [ ] Shows success message

2. **PARA: Create Plan**
   - [ ] Prompts for task name
   - [ ] Generates correct filename (YYYY-MM-DD-task-name.md)
   - [ ] Creates plan from template
   - [ ] Updates context.md with plan reference
   - [ ] Opens plan in editor

3. **PARA: Execute Plan**
   - [ ] Checks if git repository exists
   - [ ] Shows quick pick if multiple plans
   - [ ] Creates correct branch name (para/task-name)
   - [ ] Updates context.md with execution info
   - [ ] Creates initial commit

4. **PARA: Summarize Work**
   - [ ] Detects current branch
   - [ ] Generates correct summary filename
   - [ ] Includes git diff in summary
   - [ ] Updates context.md with summary reference
   - [ ] Opens summary in editor

5. **PARA: Archive Context**
   - [ ] Shows confirmation dialog
   - [ ] Creates archive with timestamp
   - [ ] Resets context.md
   - [ ] Shows success message

---

## Success Criteria

Phase 2 is complete when:

✅ **Utility Modules**
- [ ] FileSystemUtils fully implemented and working
- [ ] GitUtils fully implemented and working
- [ ] TemplateUtils generates all templates correctly
- [ ] ContextUtils reads/writes context.md properly

✅ **Commands Implemented**
- [ ] PARA: Initialize creates directory structure
- [ ] PARA: Create Plan generates plan files
- [ ] PARA: Execute Plan creates branches and updates context
- [ ] PARA: Summarize Work creates summaries with diffs
- [ ] PARA: Archive Context archives and resets

✅ **Command Registration**
- [ ] All commands appear in command palette
- [ ] Commands have correct titles
- [ ] Commands execute without errors
- [ ] Extension activates properly

✅ **Integration**
- [ ] Commands work end-to-end (init → plan → execute → summarize → archive)
- [ ] Git integration works reliably
- [ ] File system operations are robust
- [ ] Error handling is comprehensive

✅ **User Experience**
- [ ] Clear success/error messages
- [ ] Prompts are intuitive
- [ ] Files open in editor when appropriate
- [ ] Workflow matches Claude Code plugin

---

## Files Created/Modified

| File | Purpose | Lines |
|------|---------|-------|
| `src/utils/fileSystem.ts` | File system operations | ~50 |
| `src/utils/git.ts` | Git operations | ~80 |
| `src/utils/templates.ts` | Template generation | ~120 |
| `src/utils/context.ts` | Context management | ~70 |
| `src/commands/init.ts` | Initialize command | ~60 |
| `src/commands/plan.ts` | Plan command | ~60 |
| `src/commands/execute.ts` | Execute command | ~90 |
| `src/commands/summarize.ts` | Summarize command | ~70 |
| `src/commands/archive.ts` | Archive command | ~50 |
| `src/extension.ts` | Updated entry point | ~30 |
| `package.json` | Updated manifest | ~10 |

**Total:** ~690 lines across 11 files

---

## Risks & Mitigation

| Risk | Mitigation |
|------|-----------|
| Git command failures | Comprehensive error handling, user notifications |
| File system permissions | Check permissions, clear error messages |
| Invalid JSON in context.md | JSON validation, fallback to defaults |
| Command execution order | Clear workflow guidance in UI |

---

## Next Phase

After Phase 2 is complete and reviewed:

👉 **Phase 3:** UI Components & Enhanced Experience
- Tree view for context/ directory
- Status bar item showing current state
- Quick picks for selection
- Webview for plan review
- File watchers and notifications

**Plan:** `context/plans/2026-01-06-cursor-extension-phase-3.md`

---

**Phase 2 delivers the core PARA workflow. Users can now complete full tasks using command palette!** ⚡
