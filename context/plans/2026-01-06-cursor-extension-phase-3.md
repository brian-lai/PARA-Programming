# Phase 3: UI Components & Enhanced Experience

**Master Plan:** `context/plans/2026-01-06-cursor-extension.md`
**Phase:** 3 of 4
**Created:** 2026-01-06
**Status:** Planning
**Dependencies:** Phase 2 (Core commands)

---

## Phase Objective

Transform the command-driven PARA extension into a visually rich, intuitive experience by adding:

1. **Tree View** - Visual navigation of context/ directory
2. **Status Bar** - At-a-glance current state indicator
3. **Quick Picks** - Enhanced command selection menus
4. **Webview** - Plan review interface with formatting
5. **File Watchers** - Auto-refresh on file changes
6. **Notifications** - Contextual user guidance

This phase makes PARA feel native to Cursor, not just a collection of commands.

---

## Detailed Implementation Steps

### Step 1: Tree View for Context Directory

#### File: `src/ui/treeView.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';
import * as fs from 'fs/promises';

export class ParaTreeDataProvider
    implements vscode.TreeDataProvider<ParaTreeItem>
{
    private _onDidChangeTreeData: vscode.EventEmitter<
        ParaTreeItem | undefined | null | void
    > = new vscode.EventEmitter<ParaTreeItem | undefined | null | void>();
    readonly onDidChangeTreeData: vscode.Event<
        ParaTreeItem | undefined | null | void
    > = this._onDidChangeTreeData.event;

    constructor(private workspaceRoot: string) {}

    refresh(): void {
        this._onDidChangeTreeData.fire();
    }

    getTreeItem(element: ParaTreeItem): vscode.TreeItem {
        return element;
    }

    async getChildren(element?: ParaTreeItem): Promise<ParaTreeItem[]> {
        if (!this.workspaceRoot) {
            return [];
        }

        const contextPath = path.join(this.workspaceRoot, 'context');

        // Check if context exists
        try {
            await fs.access(contextPath);
        } catch {
            return [
                new ParaTreeItem(
                    'Initialize PARA',
                    vscode.TreeItemCollapsibleState.None,
                    'init'
                )
            ];
        }

        if (!element) {
            // Root level - show folders
            return [
                new ParaTreeItem(
                    'Plans',
                    vscode.TreeItemCollapsibleState.Collapsed,
                    'folder',
                    path.join(contextPath, 'plans')
                ),
                new ParaTreeItem(
                    'Summaries',
                    vscode.TreeItemCollapsibleState.Collapsed,
                    'folder',
                    path.join(contextPath, 'summaries')
                ),
                new ParaTreeItem(
                    'Data',
                    vscode.TreeItemCollapsibleState.Collapsed,
                    'folder',
                    path.join(contextPath, 'data')
                ),
                new ParaTreeItem(
                    'Archives',
                    vscode.TreeItemCollapsibleState.Collapsed,
                    'folder',
                    path.join(contextPath, 'archives')
                )
            ];
        }

        // Show files in folder
        if (element.contextValue === 'folder' && element.resourceUri) {
            const files = await fs.readdir(element.resourceUri.fsPath);
            return files
                .filter((f) => f.endsWith('.md'))
                .sort()
                .reverse() // Most recent first
                .map(
                    (f) =>
                        new ParaTreeItem(
                            f,
                            vscode.TreeItemCollapsibleState.None,
                            'file',
                            vscode.Uri.file(
                                path.join(element.resourceUri!.fsPath, f)
                            )
                        )
                );
        }

        return [];
    }
}

class ParaTreeItem extends vscode.TreeItem {
    constructor(
        public readonly label: string,
        public readonly collapsibleState: vscode.TreeItemCollapsibleState,
        public readonly contextValue: string,
        public readonly resourceUri?: vscode.Uri
    ) {
        super(label, collapsibleState);

        if (contextValue === 'file' && resourceUri) {
            this.command = {
                command: 'vscode.open',
                title: 'Open File',
                arguments: [resourceUri]
            };
            this.iconPath = new vscode.ThemeIcon('file');
        } else if (contextValue === 'folder') {
            this.iconPath = new vscode.ThemeIcon('folder');
        } else if (contextValue === 'init') {
            this.command = {
                command: 'para.init',
                title: 'Initialize PARA'
            };
            this.iconPath = new vscode.ThemeIcon('rocket');
        }
    }
}

export function registerTreeView(
    context: vscode.ExtensionContext,
    workspaceRoot: string
): void {
    const treeDataProvider = new ParaTreeDataProvider(workspaceRoot);

    const treeView = vscode.window.createTreeView('paraContext', {
        treeDataProvider
    });

    context.subscriptions.push(treeView);

    // Refresh command
    context.subscriptions.push(
        vscode.commands.registerCommand('para.refreshTree', () =>
            treeDataProvider.refresh()
        )
    );

    // Watch for file changes
    const watcher = vscode.workspace.createFileSystemWatcher(
        new vscode.RelativePattern(workspaceRoot, 'context/**/*.md')
    );

    watcher.onDidCreate(() => treeDataProvider.refresh());
    watcher.onDidDelete(() => treeDataProvider.refresh());
    watcher.onDidChange(() => treeDataProvider.refresh());

    context.subscriptions.push(watcher);
}
```

#### Update: `package.json`

```json
{
  "contributes": {
    "views": {
      "explorer": [
        {
          "id": "paraContext",
          "name": "PARA Context"
        }
      ]
    },
    "commands": [
      {
        "command": "para.refreshTree",
        "title": "PARA: Refresh Tree View",
        "icon": "$(refresh)"
      }
    ],
    "menus": {
      "view/title": [
        {
          "command": "para.refreshTree",
          "when": "view == paraContext",
          "group": "navigation"
        }
      ]
    }
  }
}
```

### Step 2: Status Bar Integration

#### File: `src/ui/statusBar.ts`

```typescript
import * as vscode from 'vscode';
import { GitUtils } from '../utils/git';
import { ContextUtils } from '../utils/context';

export class ParaStatusBar {
    private statusBarItem: vscode.StatusBarItem;

    constructor(private workspaceRoot: string) {
        this.statusBarItem = vscode.window.createStatusBarItem(
            vscode.StatusBarAlignment.Left,
            100
        );
        this.statusBarItem.command = 'para.showStatus';
    }

    async update(): Promise<void> {
        const gitUtils = new GitUtils(this.workspaceRoot);

        try {
            const branch = await gitUtils.getCurrentBranch();
            const contextUtils = new ContextUtils(this.workspaceRoot);
            const context = await contextUtils.readContext();

            if (branch.startsWith('para/')) {
                const taskName = branch.replace('para/', '');
                this.statusBarItem.text = `$(git-branch) PARA: ${taskName}`;
                this.statusBarItem.tooltip = `Active PARA task on branch: ${branch}`;
                this.statusBarItem.backgroundColor = new vscode.ThemeColor(
                    'statusBarItem.warningBackground'
                );
            } else if (context.active_context.length > 0) {
                this.statusBarItem.text = `$(book) PARA: ${context.active_context.length} plan(s)`;
                this.statusBarItem.tooltip = 'Active PARA plans (not executing)';
                this.statusBarItem.backgroundColor = undefined;
            } else {
                this.statusBarItem.text = '$(check) PARA: Ready';
                this.statusBarItem.tooltip = 'PARA-Programming ready';
                this.statusBarItem.backgroundColor = undefined;
            }

            this.statusBarItem.show();
        } catch (error) {
            // Not a git repo or PARA not initialized
            this.statusBarItem.hide();
        }
    }

    dispose(): void {
        this.statusBarItem.dispose();
    }
}

export function registerStatusBar(
    context: vscode.ExtensionContext,
    workspaceRoot: string
): ParaStatusBar {
    const statusBar = new ParaStatusBar(workspaceRoot);

    // Update on activation
    statusBar.update();

    // Update when files change
    const watcher = vscode.workspace.createFileSystemWatcher(
        new vscode.RelativePattern(workspaceRoot, 'context/context.md')
    );

    watcher.onDidChange(() => statusBar.update());
    context.subscriptions.push(watcher);

    // Update when git branch changes
    vscode.workspace.onDidChangeTextDocument(() => statusBar.update());

    // Show status command
    context.subscriptions.push(
        vscode.commands.registerCommand('para.showStatus', async () => {
            const contextUtils = new ContextUtils(workspaceRoot);
            const context = await contextUtils.readContext();

            const message = `
**Active Plans:** ${context.active_context.length}
**Completed Summaries:** ${context.completed_summaries.length}
**Last Updated:** ${context.last_updated}
            `.trim();

            vscode.window.showInformationMessage(message);
        })
    );

    context.subscriptions.push(statusBar);

    return statusBar;
}
```

### Step 3: Enhanced Quick Picks

#### File: `src/ui/quickPicks.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';
import { ContextUtils } from '../utils/context';

export async function showPlanQuickPick(
    workspaceRoot: string
): Promise<string | undefined> {
    const contextUtils = new ContextUtils(workspaceRoot);
    const context = await contextUtils.readContext();

    if (context.active_context.length === 0) {
        vscode.window.showWarningMessage('No active plans. Create one first.');
        return undefined;
    }

    interface PlanQuickPickItem extends vscode.QuickPickItem {
        planPath: string;
    }

    const items: PlanQuickPickItem[] = context.active_context.map((p) => ({
        label: `$(file) ${path.basename(p, '.md')}`,
        description: p,
        planPath: p
    }));

    const selected = await vscode.window.showQuickPick(items, {
        placeHolder: 'Select a plan to execute',
        matchOnDescription: true
    });

    return selected?.planPath;
}

export async function showWorkflowQuickPick(): Promise<string | undefined> {
    interface WorkflowQuickPickItem extends vscode.QuickPickItem {
        command: string;
    }

    const items: WorkflowQuickPickItem[] = [
        {
            label: '$(rocket) Initialize PARA',
            description: 'Set up PARA structure in this project',
            command: 'para.init'
        },
        {
            label: '$(book) Create Plan',
            description: 'Start a new task with planning',
            command: 'para.plan'
        },
        {
            label: '$(play) Execute Plan',
            description: 'Start execution (creates branch)',
            command: 'para.execute'
        },
        {
            label: '$(note) Summarize Work',
            description: 'Document what was completed',
            command: 'para.summarize'
        },
        {
            label: '$(archive) Archive Context',
            description: 'Archive and start fresh',
            command: 'para.archive'
        }
    ];

    const selected = await vscode.window.showQuickPick(items, {
        placeHolder: 'Select PARA command',
        matchOnDescription: true
    });

    if (selected) {
        await vscode.commands.executeCommand(selected.command);
    }

    return selected?.command;
}
```

### Step 4: Webview for Plan Review

#### File: `src/ui/webview/planReview.ts`

```typescript
import * as vscode from 'vscode';
import * as path from 'path';
import { FileSystemUtils } from '../../utils/fileSystem';

export async function showPlanReviewWebview(
    context: vscode.ExtensionContext,
    planPath: string
): Promise<void> {
    const panel = vscode.window.createWebviewPanel(
        'paraPlanReview',
        'PARA Plan Review',
        vscode.ViewColumn.Two,
        {
            enableScripts: true
        }
    );

    // Read plan content
    const planContent = await FileSystemUtils.readFile(planPath);

    // Convert markdown to HTML (simple version)
    const htmlContent = markdownToHtml(planContent);

    panel.webview.html = getWebviewContent(htmlContent, path.basename(planPath));

    // Handle messages from webview
    panel.webview.onDidReceiveMessage(
        async (message) => {
            switch (message.command) {
                case 'approve':
                    vscode.window.showInformationMessage('Plan approved! ✅');
                    panel.dispose();
                    await vscode.commands.executeCommand('para.execute');
                    break;
                case 'reject':
                    vscode.window.showWarningMessage(
                        'Plan rejected. Make changes and review again.'
                    );
                    panel.dispose();
                    break;
            }
        },
        undefined,
        context.subscriptions
    );
}

function markdownToHtml(markdown: string): string {
    // Simple markdown conversion (you might want to use a library like marked.js)
    return markdown
        .replace(/^# (.*$)/gim, '<h1>$1</h1>')
        .replace(/^## (.*$)/gim, '<h2>$1</h2>')
        .replace(/^### (.*$)/gim, '<h3>$1</h3>')
        .replace(/\*\*(.*)\*\*/gim, '<strong>$1</strong>')
        .replace(/\*(.*)\*/gim, '<em>$1</em>')
        .replace(/\n/gim, '<br>')
        .replace(/```([\s\S]*?)```/gim, '<pre><code>$1</code></pre>');
}

function getWebviewContent(planHtml: string, planName: string): string {
    return `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plan Review: ${planName}</title>
    <style>
        body {
            font-family: var(--vscode-font-family);
            padding: 20px;
            color: var(--vscode-foreground);
            background-color: var(--vscode-editor-background);
        }
        h1, h2, h3 {
            color: var(--vscode-textLink-foreground);
        }
        pre {
            background-color: var(--vscode-textCodeBlock-background);
            padding: 10px;
            border-radius: 4px;
            overflow-x: auto;
        }
        .actions {
            position: fixed;
            bottom: 20px;
            right: 20px;
            display: flex;
            gap: 10px;
        }
        button {
            padding: 10px 20px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .approve {
            background-color: var(--vscode-button-background);
            color: var(--vscode-button-foreground);
        }
        .approve:hover {
            background-color: var(--vscode-button-hoverBackground);
        }
        .reject {
            background-color: var(--vscode-button-secondaryBackground);
            color: var(--vscode-button-secondaryForeground);
        }
        .reject:hover {
            background-color: var(--vscode-button-secondaryHoverBackground);
        }
    </style>
</head>
<body>
    <div id="content">
        ${planHtml}
    </div>

    <div class="actions">
        <button class="reject" onclick="reject()">Reject</button>
        <button class="approve" onclick="approve()">Approve & Execute</button>
    </div>

    <script>
        const vscode = acquireVsCodeApi();

        function approve() {
            vscode.postMessage({ command: 'approve' });
        }

        function reject() {
            vscode.postMessage({ command: 'reject' });
        }
    </script>
</body>
</html>`;
}
```

### Step 5: File Watchers & Notifications

#### File: `src/ui/notifications.ts`

```typescript
import * as vscode from 'vscode';

export class ParaNotifications {
    static showInitializationSuccess(): void {
        vscode.window
            .showInformationMessage(
                'PARA structure initialized! 🚀',
                'Create Plan',
                'Dismiss'
            )
            .then((selection) => {
                if (selection === 'Create Plan') {
                    vscode.commands.executeCommand('para.plan');
                }
            });
    }

    static showPlanCreated(planName: string): void {
        vscode.window
            .showInformationMessage(
                `Plan created: ${planName}`,
                'Review Plan',
                'Execute Now',
                'Dismiss'
            )
            .then((selection) => {
                if (selection === 'Review Plan') {
                    // Open in webview (implemented in Step 4)
                } else if (selection === 'Execute Now') {
                    vscode.commands.executeCommand('para.execute');
                }
            });
    }

    static showExecutionStarted(branchName: string): void {
        vscode.window.showInformationMessage(
            `Execution started on branch: ${branchName} 🚀`,
            'Dismiss'
        );
    }

    static showSummaryCreated(summaryName: string): void {
        vscode.window
            .showInformationMessage(
                `Summary created: ${summaryName}`,
                'Archive Context',
                'Dismiss'
            )
            .then((selection) => {
                if (selection === 'Archive Context') {
                    vscode.commands.executeCommand('para.archive');
                }
            });
    }

    static showContextArchived(): void {
        vscode.window
            .showInformationMessage(
                'Context archived! Ready for next task. ✅',
                'Create New Plan',
                'Dismiss'
            )
            .then((selection) => {
                if (selection === 'Create New Plan') {
                    vscode.commands.executeCommand('para.plan');
                }
            });
    }

    static showWorkflowGuidance(): void {
        vscode.window
            .showInformationMessage(
                'PARA workflow: Plan → Review → Execute → Summarize → Archive',
                'Show Commands',
                'Dismiss'
            )
            .then((selection) => {
                if (selection === 'Show Commands') {
                    vscode.commands.executeCommand('workbench.action.showCommands');
                }
            });
    }
}
```

### Step 6: Integrate UI Components into Extension

#### File: `src/extension.ts` (updated)

```typescript
import * as vscode from 'vscode';
import { initCommand } from './commands/init';
import { planCommand } from './commands/plan';
import { executeCommand } from './commands/execute';
import { summarizeCommand } from './commands/summarize';
import { archiveCommand } from './commands/archive';
import { registerTreeView } from './ui/treeView';
import { registerStatusBar } from './ui/statusBar';
import { showWorkflowQuickPick } from './ui/quickPicks';
import { FileSystemUtils } from './utils/fileSystem';

export function activate(context: vscode.ExtensionContext) {
    console.log('PARA-Programming extension is now active');

    const workspaceRoot = FileSystemUtils.getWorkspaceRoot();

    if (!workspaceRoot) {
        vscode.window.showWarningMessage(
            'PARA-Programming requires a workspace folder'
        );
        return;
    }

    // Register commands
    const commands = [
        vscode.commands.registerCommand('para.init', initCommand),
        vscode.commands.registerCommand('para.plan', planCommand),
        vscode.commands.registerCommand('para.execute', executeCommand),
        vscode.commands.registerCommand('para.summarize', summarizeCommand),
        vscode.commands.registerCommand('para.archive', archiveCommand),
        vscode.commands.registerCommand('para.showWorkflow', showWorkflowQuickPick)
    ];

    commands.forEach((cmd) => context.subscriptions.push(cmd));

    // Register UI components
    registerTreeView(context, workspaceRoot);
    registerStatusBar(context, workspaceRoot);
}

export function deactivate() {}
```

---

## Testing Strategy

### Manual Testing Checklist

1. **Tree View**
   - [ ] Shows in Explorer sidebar
   - [ ] Displays Plans, Summaries, Data, Archives folders
   - [ ] Expands folders to show files
   - [ ] Files sorted by date (most recent first)
   - [ ] Clicking file opens in editor
   - [ ] Refresh button works
   - [ ] Auto-refreshes on file changes

2. **Status Bar**
   - [ ] Shows "PARA: Ready" when idle
   - [ ] Shows "PARA: task-name" when on para/ branch
   - [ ] Shows plan count when plans exist
   - [ ] Clicking status bar shows details
   - [ ] Updates when branch changes
   - [ ] Updates when context.md changes

3. **Quick Picks**
   - [ ] Plan quick pick shows all active plans
   - [ ] Workflow quick pick shows all commands
   - [ ] Icons display correctly
   - [ ] Descriptions are helpful
   - [ ] Selecting item executes command

4. **Webview**
   - [ ] Opens in new column
   - [ ] Markdown renders correctly
   - [ ] Approve button starts execution
   - [ ] Reject button closes webview
   - [ ] Styling matches VS Code theme

5. **Notifications**
   - [ ] Initialization shows next steps
   - [ ] Plan creation offers review/execute
   - [ ] Execution confirms branch creation
   - [ ] Summary creation offers archiving
   - [ ] Archive offers new plan creation

---

## Success Criteria

Phase 3 is complete when:

✅ **Tree View**
- [ ] PARA Context tree view in Explorer
- [ ] Folders and files display correctly
- [ ] Click to open files works
- [ ] Auto-refresh on file changes
- [ ] Refresh button in toolbar

✅ **Status Bar**
- [ ] Status bar item shows current state
- [ ] Updates dynamically
- [ ] Clicking shows details
- [ ] Color coding for states

✅ **Quick Picks**
- [ ] Plan selection quick pick
- [ ] Workflow quick pick
- [ ] Icons and descriptions
- [ ] Command execution

✅ **Webview**
- [ ] Plan review webview
- [ ] Markdown rendering
- [ ] Approve/reject actions
- [ ] Theme-aware styling

✅ **Notifications**
- [ ] Contextual notifications
- [ ] Action buttons
- [ ] Workflow guidance

✅ **Integration**
- [ ] All UI components work together
- [ ] Extension feels native
- [ ] No performance issues
- [ ] Consistent visual style

---

## Files Created/Modified

| File | Purpose | Lines |
|------|---------|-------|
| `src/ui/treeView.ts` | Tree view for context/ | ~150 |
| `src/ui/statusBar.ts` | Status bar integration | ~100 |
| `src/ui/quickPicks.ts` | Enhanced quick picks | ~80 |
| `src/ui/webview/planReview.ts` | Plan review webview | ~130 |
| `src/ui/notifications.ts` | User notifications | ~70 |
| `src/extension.ts` | Updated with UI registration | ~20 |
| `package.json` | Updated contributes | ~30 |

**Total:** ~580 lines across 7 files

---

## Risks & Mitigation

| Risk | Mitigation |
|------|-----------|
| Tree view performance with many files | Lazy loading, pagination |
| Webview security issues | Content Security Policy |
| Status bar update frequency | Debouncing, smart triggers |
| Theme compatibility | Use VS Code theme variables |

---

## Next Phase

After Phase 3 is complete and reviewed:

👉 **Phase 4:** Polish, Documentation & Publishing
- Professional README with screenshots
- Extension icon and branding
- Marketplace listing
- Installation instructions
- Example project/demo

**Plan:** `context/plans/2026-01-06-cursor-extension-phase-4.md`

---

**Phase 3 makes PARA visual and intuitive. Users will love the native Cursor experience!** 🎨
