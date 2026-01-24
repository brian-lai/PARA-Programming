# PARA-Programming for Cursor

**The complete guide to using PARA-Programming methodology with Cursor IDE**

Cursor is one of the best IDEs for PARA-Programming due to its powerful multi-file editing (Composer), MCP support, and intelligent codebase understanding. This guide shows you how to leverage Cursor's unique features while maintaining the PARA methodology.

---

## 📋 Table of Contents

- [Why Cursor for PARA-Programming?](#why-cursor-for-para-programming)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Cursor-Specific Features](#cursor-specific-features)
- [Workflow Modes](#workflow-modes)
- [Best Practices](#best-practices)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)
- [Advanced Usage](#advanced-usage)

---

## Why Cursor for PARA-Programming?

Cursor earns a **⭐⭐⭐⭐⭐ Excellent** rating for PARA compatibility:

### Advantages

✅ **Composer Mode** - Multi-file edits make implementation phase seamless
✅ **MCP Support** - Native support for preprocessing tools
✅ **Codebase Indexing** - Understands entire project context
✅ **Smart Context** - @-mentions for precise context loading
✅ **CMD+K Inline** - Quick edits without leaving your file
✅ **Chat History** - Persistent conversation across sessions
✅ **Rules System** - `.cursorrules` automatically applied to all interactions

### Perfect For

- **Multi-file refactoring** - Composer can modify 10+ files at once
- **Complex features** - Plan → Composer implementation → Summary
- **MCP integration** - Full preprocessing pipeline support
- **Team workflows** - Commit `.cursorrules` for consistency

---

## Quick Start

### 5-Minute Setup

```bash
# 1. Navigate to your project
cd your-project/

# 2. Create PARA structure
mkdir -p context/{data,plans,summaries,archives,servers}

# 3. Copy Cursor rules
curl -o .cursorrules \
  https://raw.githubusercontent.com/brian-lai/PARA-Programming/main/cursor/cursorrules

# 4. Initialize context
cat > context/context.md << 'EOF'
# Current Work Summary

Ready to start PARA-Programming with Cursor.

---

```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
```
EOF

# 5. Create project context
cat > CLAUDE.md << 'EOF'
# [Your Project Name]

> **Workflow Methodology:** Follow `.cursorrules` for PARA-Programming

## About
[Your project description]

## Tech Stack
- [Your technologies]

## Architecture
[High-level architecture]

## Getting Started
```bash
[Setup commands]
```
EOF
```

### First Task Test

Open Cursor and try:

```
You: "Create a plan for adding a dark mode toggle"

Cursor: "I'll create a plan following PARA methodology.
Creating context/plans/dark-mode.md..."

[Cursor creates detailed plan]

Cursor: "I've created the plan at context/plans/dark-mode.md.
Please review before I proceed."

You: "Approved"

Cursor: "Opening Composer to implement across multiple files..."
```

If this works, you're ready! 🎉

---

## Installation

### Step 1: Install Cursor IDE

Download from [cursor.sh](https://cursor.sh)

### Step 2: Clone or Download This Repository

```bash
git clone https://github.com/brian-lai/PARA-Programming.git
cd PARA-Programming
```

### Step 3: Copy Cursor Rules to Your Project

```bash
# Copy the cursorrules file
cp cursor/cursorrules /path/to/your-project/.cursorrules

# Or create a symlink for automatic updates
ln -s $(pwd)/cursor/cursorrules /path/to/your-project/.cursorrules
```

### Step 4: Initialize PARA Structure

In your project directory:

```bash
# Create directories
mkdir -p context/{data,plans,summaries,archives,servers}

# Copy templates
cp cursor/templates/context-template.md context/context.md
cp cursor/templates/claude-template.md CLAUDE.md

# Edit CLAUDE.md with your project details
cursor CLAUDE.md
```

### Step 5: Verify Installation

Open Cursor in your project and test:

```
You: "Are you following PARA-Programming methodology?"

Cursor: "Yes! I'm following the PARA-Programming methodology from .cursorrules.
I'll use the Plan → Review → Execute → Summarize → Archive workflow for all
non-trivial tasks. Would you like to start with a planning task?"
```

---

## Cursor-Specific Features

### 1. Composer Mode (CMD+I)

**Best for:** Multi-file implementations, complex refactoring, feature additions

**How PARA works with Composer:**

```
1. Create plan in context/plans/ (using Chat)
2. Get human approval
3. Use Composer with plan reference:
   "Implement the plan in context/plans/dark-mode.md"
4. Composer edits multiple files simultaneously
5. Create summary after Composer completes
```

**Example:**

```
You: [Opens Composer - CMD+I]
"Following context/plans/dark-mode.md, implement dark mode across the app"

Cursor: "I'll implement the dark mode plan using Composer. This will modify:
- src/contexts/ThemeContext.tsx (create)
- src/App.tsx (modify)
- src/components/Navbar.tsx (modify)
- src/styles/globals.css (modify)

Working across all files now..."

[Composer shows diff across all files]

Cursor: "Implementation complete! All files updated.
Should I create the summary now?"
```

### 2. CMD+K Mode

**Best for:** Single-file edits, quick refactoring, inline improvements

**How PARA works with CMD+K:**

```
1. Skip planning for trivial edits
2. For complex file changes, reference plan:
   [Select code, CMD+K]
   "Following context/plans/refactor-auth.md, refactor this method"
3. CMD+K applies change inline
```

**Example:**

```
You: [Selects method, presses CMD+K]
"Refactor this to use the new theme system from context/plans/dark-mode.md"

Cursor: "I'll refactor this to use useTheme hook and CSS variables.

Changes:
- Add useTheme import
- Replace hardcoded colors with CSS variables
- Apply theme className

[Shows inline diff]

Apply changes?"
```

### 3. Chat Mode

**Best for:** Planning, discussions, understanding code, creating summaries

**How PARA works with Chat:**

```
1. Use Chat for Plan creation
2. Use Chat for code exploration
3. Use Chat for Summary generation
4. Keep Chat history as implicit context
```

**Example:**

```
You: "Create a plan for implementing real-time notifications"

Cursor: "I'll create a detailed plan for real-time notifications.

[Creates context/plans/realtime-notifications.md]

Plan includes:
- WebSocket server setup
- Frontend notification system
- Database schema for notifications
- User preferences

Review the full plan at context/plans/realtime-notifications.md"
```

### 4. @-Mentions for Context

**Precise context loading:**

```
@context/plans/dark-mode.md - Reference specific plan
@src/App.tsx - Load specific file
@context/data/api-summary.md - Load data summary
@context/summaries/ - Reference past work
```

**Example:**

```
You: "Using @context/plans/dark-mode.md and @src/App.tsx,
implement step 1 of the plan"

Cursor: "I see the plan calls for creating ThemeProvider wrapper in App.tsx.
I'll modify @src/App.tsx to add the wrapper..."
```

### 5. Codebase Indexing

Cursor indexes your entire codebase, but **still practice token efficiency:**

**Good Usage:**
```
You: "Find all components that use hardcoded colors"
Cursor: [Uses index to find, creates summary in context/data/]
```

**Wasteful Usage:**
```
You: "@src Looking at everything, maybe add dark mode?"
Cursor: [Loads massive context unnecessarily]
```

**PARA Approach:**
```
You: "Search for hardcoded colors and summarize findings in
context/data/hardcoded-colors.md"
Cursor: [Creates compact summary]

You: "Now create a plan to fix these using context/data/hardcoded-colors.md"
Cursor: [Uses summary, not full codebase]
```

---

## Workflow Modes

### Mode 1: Chat + Composer (Recommended)

**Best for:** Complex features, multi-file changes

**Flow:**

```
┌─────────────┐
│    Chat     │ Create plan
│             │ Discuss approach
└──────┬──────┘
       │
       v
┌──────────────┐
│    Human     │ Review and approve
│   Review     │
└──────┬───────┘
       │
       v
┌──────────────┐
│  Composer    │ Implement across
│   (CMD+I)    │ multiple files
└──────┬───────┘
       │
       v
┌──────────────┐
│    Chat      │ Create summary
│              │ Document changes
└──────────────┘
```

**Example:**

```bash
# Step 1: Planning in Chat
You: "Create a plan for user authentication"
Cursor: [Creates context/plans/user-auth.md]

# Step 2: Review
You: "Approved"

# Step 3: Implementation in Composer
You: [CMD+I] "Implement context/plans/user-auth.md"
Cursor: [Modifies 8 files simultaneously]

# Step 4: Summary in Chat
You: "Create summary"
Cursor: [Creates context/summaries/user-auth-summary.md]
```

### Mode 2: Chat-Only

**Best for:** Planning, exploration, understanding

**Flow:**

```
Chat → Plan → Review → Manual Code → Summary
```

**Example:**

```
You: "Help me understand the authentication flow"
Cursor: [Analyzes code, creates summary in context/data/]

You: "Now create a plan to add OAuth"
Cursor: [Creates plan based on understanding]

You: [Manually codes or uses Composer]

You: "Create summary of my OAuth changes"
Cursor: [Documents what was done]
```

### Mode 3: CMD+K Quick Edits

**Best for:** Focused refactoring, single-file improvements

**Flow:**

```
[Select code] → CMD+K → Inline prompt → Apply
```

**When to use:**
- Refactoring a single method
- Updating imports
- Fixing a specific bug
- Adding tests to one file

**Skip PARA workflow** for:
- Trivial changes (< 10 lines)
- Obvious fixes
- Formatting

**Use PARA workflow** for:
- Complex refactoring (even in one file)
- Logic changes
- Anything with edge cases

---

## Best Practices

### 1. Always Create Plans First

Even though Composer is powerful, **resist the urge to skip planning:**

❌ **Bad:**
```
You: [CMD+I] "Add dark mode to the app"
Cursor: [Immediately starts editing files]
```

✅ **Good:**
```
You: "Create a plan for adding dark mode"
Cursor: [Creates plan in context/plans/]
You: "Approved"
You: [CMD+I] "Implement context/plans/dark-mode.md"
```

**Why?** Plans catch edge cases before you write code.

### 2. Use @-Mentions Strategically

❌ **Wasteful:**
```
You: "@src @lib @components Let's add authentication"
[Loads 100+ files]
```

✅ **Efficient:**
```
You: "Summarize the current auth system in context/data/auth-summary.md"
Cursor: [Creates 2-page summary]
You: "@context/data/auth-summary.md Create a plan to add OAuth"
[Uses summary, not full codebase]
```

### 3. Leverage Composer for Implementation Only

**Composer is for execution, not planning:**

✅ **Correct Flow:**
```
1. Chat: Create plan
2. Human: Review plan
3. Composer: Execute plan
4. Chat: Create summary
```

❌ **Incorrect Flow:**
```
1. Composer: [CMD+I] "Add auth and make it good"
   [No plan, no review, no summary]
```

### 4. Create Summaries Immediately

Don't batch summaries! Create them right after Composer completes:

```
[Composer finishes]

You: "Create summary of what you just did"
Cursor: [Creates context/summaries/[task]-summary.md]
```

**Why?** Context is fresh, details are accurate.

### 5. Use MCP Servers for Preprocessing

If you have large data or complex analysis:

```bash
# Create MCP server
# context/servers/analyzeComponents.js

export async function analyzeComponents(pattern) {
  const files = glob(pattern);
  const summary = {
    count: files.length,
    byType: groupByType(files),
    complexity: files.map(f => analyzeComplexity(f))
  };
  return summary; // Returns ~1k tokens instead of 50k
}
```

**Then use it:**
```
You: "Use MCP analyzeComponents to understand our component architecture,
then create a refactoring plan"

Cursor: [Uses MCP, gets summary, creates plan based on summary]
```

### 6. Keep Context Clean

Close files and clear context regularly:

```
You: "We're done with authentication. Archive context/context.md
and start fresh for the next feature"

Cursor: [Moves context.md to archives/, creates new context.md]
```

### 7. Reference Past Summaries

Don't re-analyze old work:

```
You: "@context/summaries/user-auth-summary.md
Now create a plan to add password reset"

Cursor: [Reads summary, understands prior work, creates plan]
```

---

## Examples

### Example 1: Full Feature Implementation

**Task:** Add real-time collaboration to a text editor

**Step 1: Planning (Chat)**

```
You: "Create a plan for adding real-time collaboration using WebSockets"

Cursor: "I'll create a comprehensive plan for real-time collaboration.

Creating context/plans/realtime-collab.md...

Plan includes:
1. WebSocket server setup (Socket.io)
2. Operational Transform (OT) for conflict resolution
3. User presence indicators
4. Cursor position sharing
5. Conflict resolution strategy

Files to create: 6
Files to modify: 4
Risks: Network latency, conflict resolution complexity

Full plan at context/plans/realtime-collab.md. Please review."

You: [Reads plan]

You: "Looks good, but let's use Y.js instead of custom OT"

Cursor: "Good call! Y.js is more battle-tested. Updating plan..."

[Updates plan]

Cursor: "Plan updated. Ready to proceed?"

You: "Yes"
```

**Step 2: Implementation (Composer)**

```
You: [CMD+I - Opens Composer]

"Implement the plan in context/plans/realtime-collab.md.
Work across all necessary files."

Cursor: "I'll implement real-time collaboration with Y.js.

Working across these files:
✓ src/server/websocket.ts (create)
✓ src/hooks/useYjs.ts (create)
✓ src/components/Editor.tsx (modify)
✓ src/components/UserCursors.tsx (create)
✓ src/lib/yjs-config.ts (create)
✓ package.json (modify)

[Shows diffs across all files]

Step 1: Setting up WebSocket server... ✓
Step 2: Integrating Y.js provider... ✓
Step 3: Adding user presence... ✓
Step 4: Implementing cursor sharing... ✓
Step 5: Adding connection status indicator... ✓

All steps complete! Running tests..."

[Tests run]

Cursor: "✅ 34/34 tests passing
✅ TypeScript: No errors
✅ ESLint: Clean

Implementation complete! Should I create the summary?"

You: "Yes"
```

**Step 3: Summary (Chat)**

```
Cursor: "Creating summary at context/summaries/realtime-collab-summary.md...

Summary created! Key points:

**Changes:**
- Added Y.js-based real-time collaboration
- WebSocket server with Socket.io
- User presence and cursor position sharing
- Connection status UI

**Tech decisions:**
- Y.js instead of custom OT (better conflict resolution)
- Socket.io for WebSocket (easier reconnection handling)
- Separate hook for Y.js logic (better testing)

**Test coverage:** 34 tests, 96% coverage
**Performance:** <50ms latency for updates

Full summary at context/summaries/realtime-collab-summary.md"
```

### Example 2: Bug Fix with Investigation

**Task:** Memory leak in WebSocket connections

**Step 1: Investigation (Chat)**

```
You: "Investigate the memory leak in WebSocket connections.
Create a summary of findings in context/data/"

Cursor: "I'll analyze the WebSocket code for memory leaks.

[Analyzes codebase]

Found several issues:
1. Event listeners not cleaned up in useEffect
2. Interval for heartbeat not cleared
3. Y.js provider not destroyed on unmount

Creating detailed analysis at context/data/memory-leak-analysis.md..."

[Creates analysis document]

Cursor: "Analysis complete. Found 3 leak sources.
Shall I create a plan to fix them?"

You: "Yes"
```

**Step 2: Planning (Chat)**

```
Cursor: "Creating fix plan at context/plans/fix-memory-leaks.md...

Plan:
1. Add cleanup in useWebSocket.ts
2. Clear heartbeat interval
3. Destroy Y.js provider properly
4. Add memory leak tests

Testing strategy:
- Run for 1 hour with heap snapshots
- Verify memory stays stable

Plan ready for review."

You: "Approved"
```

**Step 3: Fix (Composer + CMD+K)**

```
You: [CMD+K on useWebSocket.ts]
"Fix the memory leak using context/plans/fix-memory-leaks.md"

Cursor: "Adding cleanup to useEffect return:

return () => {
  ws.removeEventListener('message', handleMessage);
  ws.removeEventListener('error', handleError);
  clearInterval(heartbeatInterval);
  yjsProvider.destroy();
  ws.close();
};

Applied! This fixes all 3 leak sources."

[Applies fix]

Cursor: "Fix applied. Running tests..."

You: "Add memory leak test"

Cursor: [CMD+I]
"Creating memory leak test in tests/websocket.test.ts..."

[Creates test that monitors heap]

Cursor: "Test created. Running... ✅ Memory stable after 1000 connect/disconnect cycles"
```

**Step 4: Summary (Chat)**

```
You: "Create summary"

Cursor: "Creating context/summaries/fix-memory-leaks-summary.md...

**Root Cause:** Event listeners and intervals not cleaned up

**Fix Applied:**
- Added proper cleanup in useEffect
- Clear all intervals and destroy providers
- Added memory leak regression test

**Verification:**
- Ran 1-hour stability test
- Memory usage stable at 45MB (was growing to 500MB+)
- 1000 connection cycles: No leaks detected

Summary complete!"
```

### Example 3: Large Refactoring

**Task:** Split monolithic UserService into multiple services

**Step 1: Analysis (Chat with MCP)**

```
You: "Analyze UserService.ts and suggest how to split it"

Cursor: "UserService.ts is 847 lines. I'll analyze its responsibilities...

[If you have MCP server]
Using MCP analyzeComplexity...

Found 5 distinct responsibilities:
1. Authentication (login, logout, token management) - 234 lines
2. User CRUD (create, update, delete) - 156 lines
3. Profile management (avatar, settings) - 178 lines
4. Permissions/roles (authorize, checkRole) - 143 lines
5. Session management (track, expire) - 136 lines

Creating detailed analysis in context/data/userservice-analysis.md..."

You: "Create a refactoring plan to split into 5 services"
```

**Step 2: Plan (Chat)**

```
Cursor: "Creating context/plans/refactor-userservice.md...

Plan:
1. Extract AuthService (lines 45-278)
2. Extract UserRepository (lines 279-434)
3. Extract ProfileService (lines 435-612)
4. Extract PermissionService (lines 613-755)
5. Extract SessionService (lines 756-891)
6. Update UserService to orchestrate these services
7. Update all imports across codebase
8. Update tests

Risks:
- Breaking existing code (46 files import UserService)
- Test coverage during migration
- Circular dependencies

Strategy:
- One service at a time
- Run tests after each extraction
- Use dependency injection

Full plan ready for review."

You: "Approved, but let's do it step by step with tests between each"

Cursor: "Good approach! I'll do one extraction per Composer session."
```

**Step 3: Incremental Refactoring (Multiple Composer sessions)**

**Session 1: Extract AuthService**

```
You: [CMD+I]
"Following context/plans/refactor-userservice.md Step 1:
Extract AuthService from UserService"

Cursor: "Extracting authentication logic into src/services/AuthService.ts...

Changes:
✓ Created AuthService.ts
✓ Moved auth methods from UserService
✓ Updated UserService to use AuthService
✓ Updated 12 imports that used auth methods

Running tests... ✅ 89/89 tests passing

Step 1 complete! Ready for Step 2?"
```

**Session 2-5: Continue with other services** (similar pattern)

**Final Session: Integration**

```
You: [CMD+I]
"Step 6: Refactor UserService to orchestrate all extracted services"

Cursor: "Refactoring UserService to orchestration layer...

New UserService (147 lines, was 847):
- Injects all 5 services
- Provides high-level operations
- Handles cross-service coordination

Final test run... ✅ 127/127 tests passing
Coverage: 94% (maintained)

Refactoring complete!"
```

**Step 4: Summary (Chat)**

```
You: "Create comprehensive summary"

Cursor: "Creating context/summaries/refactor-userservice-summary.md...

**Before:**
- UserService: 847 lines, complexity 45
- Single file handling 5 responsibilities
- Difficult to test and maintain

**After:**
- 5 focused services (avg 140 lines each)
- UserService orchestrator (147 lines)
- Average complexity: 8
- Better separation of concerns

**Migration:**
- Done incrementally over 6 steps
- Tests passed after each step
- Zero breaking changes (all 46 dependent files updated)

**Performance:**
- No performance regression
- Actually 15% faster (better caching in split services)

**Files Changed:**
- 5 new service files
- 1 refactored UserService
- 46 files with updated imports
- 38 test files updated

Summary complete!"
```

---

## Troubleshooting

### Issue: Cursor doesn't follow `.cursorrules`

**Symptoms:** Cursor implements without creating plan

**Solutions:**

1. **Verify `.cursorrules` location:**
   ```bash
   ls -la .cursorrules
   # Should be in project root
   ```

2. **Restart Cursor after adding `.cursorrules`**

3. **Be explicit in prompts:**
   ```
   "Following PARA methodology from .cursorrules, create a plan first"
   ```

4. **Check if rules are loaded:**
   ```
   You: "What methodology are you following?"
   Cursor: "I'm following PARA-Programming from .cursorrules..."
   ```

### Issue: Composer edits too many files

**Symptoms:** Composer modifies unrelated files

**Solutions:**

1. **Be specific in Composer prompt:**
   ```
   "Implement context/plans/dark-mode.md
   ONLY modify files listed in the plan:
   - src/contexts/ThemeContext.tsx
   - src/App.tsx
   - src/components/Navbar.tsx"
   ```

2. **Use @-mentions to limit scope:**
   ```
   "@src/contexts @src/App.tsx @src/components/Navbar.tsx
   Implement dark mode in these files only"
   ```

3. **Review Composer preview before applying:**
   - Cursor shows diffs before applying
   - Reject unwanted changes

### Issue: Context window exceeded

**Symptoms:** "Context too large" error

**Solutions:**

1. **Create summaries first:**
   ```
   You: "Summarize all auth code in context/data/auth-summary.md"
   Cursor: [Creates compact summary]
   You: "@context/data/auth-summary.md Create plan to add OAuth"
   ```

2. **Close unnecessary files:**
   ```
   You: "Close all files except the ones in the current plan"
   ```

3. **Use specific @-mentions instead of @src:**
   ```
   ❌ @src "Add auth"
   ✅ @src/services/AuthService.ts "Add OAuth method"
   ```

4. **Break down large tasks:**
   ```
   Instead of: "Refactor entire app"
   Do: "Step 1: Refactor auth. Step 2: Refactor user management..."
   ```

### Issue: Plans are too generic

**Symptoms:** Plan doesn't have enough detail

**Solutions:**

1. **Request specific plan sections:**
   ```
   You: "Create a plan including:
   - Exact files to modify with line numbers
   - Edge cases to handle
   - Testing strategy
   - Rollback plan"
   ```

2. **Use MCP for analysis first:**
   ```
   You: "Analyze the auth system complexity first,
   then create detailed refactoring plan"
   ```

3. **Iterate on the plan:**
   ```
   You: "The plan needs more detail on error handling.
   Update context/plans/add-auth.md with error scenarios"
   ```

### Issue: Summaries are incomplete

**Symptoms:** Summary missing important details

**Solutions:**

1. **Use summary template:**
   ```
   You: "Create summary using the template in cursor/templates/summary-template.md"
   ```

2. **Request specific sections:**
   ```
   You: "Create summary including:
   - All files changed with line references
   - Why each decision was made
   - Test results
   - Performance impact"
   ```

3. **Create summary immediately:**
   - Don't wait - do it right after implementation
   - Context is fresh, details are accurate

### Issue: CMD+K makes unrelated changes

**Symptoms:** CMD+K modifies more than selected code

**Solutions:**

1. **Select exactly what you want changed:**
   - Highlight the specific method/block
   - Be precise with selection

2. **Be explicit in CMD+K prompt:**
   ```
   "Only refactor the selected method.
   Do not modify anything outside the selection."
   ```

3. **Review before applying:**
   - CMD+K shows diff
   - Reject if it changes too much

---

## Advanced Usage

### 1. MCP Server Integration

Cursor has excellent MCP support. Create preprocessing tools:

**Setup MCP Server:**

```javascript
// context/servers/analyzeCode.js
import { MCPServer } from '@cursor/mcp-sdk';

export const server = new MCPServer({
  name: 'code-analyzer',
  version: '1.0.0'
});

server.addTool('analyze-complexity', async ({ pattern }) => {
  const files = await glob(pattern);
  const analysis = files.map(f => ({
    file: f,
    lines: countLines(f),
    complexity: calculateComplexity(f),
    dependencies: findDependencies(f)
  }));

  return {
    summary: {
      totalFiles: files.length,
      avgComplexity: average(analysis.map(a => a.complexity)),
      highComplexity: analysis.filter(a => a.complexity > 10)
    },
    files: analysis
  };
});
```

**Use in Cursor:**

```
You: "Use MCP analyze-complexity on src/**/*.ts
and create a refactoring plan for high-complexity files"

Cursor: "Running MCP analysis...

Found 23 files with complexity > 10:
- src/services/UserService.ts: 45
- src/utils/DataProcessor.ts: 23
- src/controllers/ApiController.ts: 18
...

Creating refactoring plan based on these findings..."
```

### 2. Custom Slash Commands

Add to `.cursorrules`:

```markdown
## Custom Commands

When the user types:
- `/para-plan [task]` - Create a plan for the task
- `/para-implement` - Open Composer with current plan
- `/para-summarize` - Create summary of recent changes
- `/para-archive` - Archive current context and start fresh
```

**Usage:**

```
You: "/para-plan Add OAuth authentication"
Cursor: [Creates plan in context/plans/]

You: "/para-implement"
Cursor: [Opens Composer with plan loaded]

You: "/para-summarize"
Cursor: [Creates summary]
```

### 3. Multi-Developer Workflows

**Scenario:** Team of 3 developers, all using Cursor with PARA

**Setup:**

```bash
# Commit PARA structure to git
git add .cursorrules context/ CLAUDE.md
git commit -m "Add PARA-Programming structure"
git push

# Each developer clones and gets:
# - Same .cursorrules
# - Shared context/ directory
# - Consistent workflow
```

**Workflow:**

```
Developer A:
- Creates plan in context/plans/feature-x.md
- Commits plan: git add context/plans/feature-x.md
- Implements with Composer
- Creates summary: context/summaries/feature-x-summary.md
- Commits all: git add . && git commit -m "Add feature X"

Developer B:
- git pull
- Reads @context/summaries/feature-x-summary.md
- Builds on top with new plan
- Follows same workflow

Developer C:
- Reviews historical context/archives/
- Understands all past decisions
- Consistent methodology across team
```

### 4. Large Codebase Strategy

For codebases > 100k lines:

**1. Create Architectural Map:**

```
You: "Create an architectural summary of the entire codebase
in context/data/architecture-map.md

Include:
- Top-level structure
- Key modules and responsibilities
- Data flow
- External dependencies"

Cursor: [Analyzes codebase, creates compact map]
```

**2. Reference Map in Plans:**

```
You: "@context/data/architecture-map.md
Create a plan to add payment processing"

Cursor: [Uses map to understand where payment logic fits]
```

**3. Module-Specific Summaries:**

```
context/data/
├── architecture-map.md       # Overall structure
├── auth-module-summary.md    # Auth module deep-dive
├── payment-module-summary.md # Payment module deep-dive
└── api-summary.md            # API architecture
```

**4. Load Only What's Needed:**

```
You: "@context/data/auth-module-summary.md
Create a plan to add 2FA to auth"

[Loads 2k token summary instead of 50k lines of auth code]
```

### 5. Continuous Documentation

Keep documentation up-to-date automatically:

**Add to `.cursorrules`:**

```markdown
## Documentation Updates

When creating summaries, also update:
- context/data/current-architecture.md if architecture changed
- CLAUDE.md if conventions changed
- context/data/tech-decisions.md with major technical decisions
```

**Example:**

```
[After implementing new caching layer]

Cursor: "Creating summary...

Also updating:
- context/data/current-architecture.md: Added caching layer section
- context/data/tech-decisions.md: Documented Redis choice over Memcached

All documentation updated!"
```

---

## Next Steps

1. **Install Cursor** - Download from [cursor.sh](https://cursor.sh)
2. **Copy `.cursorrules`** - [Get the file](cursorrules)
3. **Initialize PARA structure** - Use templates
4. **Try a simple task** - Create your first plan
5. **Use Composer** - Experience multi-file magic
6. **Create MCP servers** - Add preprocessing (optional)
7. **Share with team** - Commit `.cursorrules` to git

---

## Resources

- [Cursor Rules File](cursorrules) - Copy this to `.cursorrules`
- [Templates](templates/) - Plan and summary templates
- [Examples](examples/) - Real-world usage examples
- [Main PARA Documentation](../README.md) - Full methodology
- [Cursor Documentation](https://cursor.sh/docs) - Official Cursor docs

---

## Get Help

- [GitHub Discussions](../../discussions) - Ask questions
- [GitHub Issues](../../issues) - Report problems
- [Cursor Discord](https://discord.gg/cursor) - Cursor community

---

**Ready to supercharge your development with Cursor + PARA? Start with the [Quick Start](#quick-start)!** 🚀
