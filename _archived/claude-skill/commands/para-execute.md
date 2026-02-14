# Command: para-execute

Execute the active plan by creating a branch and tracking to-dos. Supports both simple and phased plans.

## What This Does

This command implements the **Execute** phase of the PARA workflow:

1. Reads the active plan from `context/context.md`
2. Detects if it's a simple or phased plan
3. For phased plans, executes a specific phase (or prompts for which phase)
4. Creates a new git branch named `para/{task-name}` or `para/{task-name}-phase-N`
5. Extracts implementation steps from the plan as to-dos
6. Updates `context/context.md` with a trackable to-do list
7. Commits the context update as the first commit on the branch
8. Guides incremental commits as each to-do is completed

## Usage

### Simple Plans

```
/para-execute
```

The command automatically:
- Detects the active plan from context
- Creates an appropriately named branch
- Sets up to-do tracking

### Phased Plans

```
/para-execute --phase=1               # Execute specific phase
/para-execute --phase=2               # Execute next phase
/para-execute                         # Will prompt for which phase to execute
```

For phased plans:
- Each phase creates a separate branch: `para/{task-name}-phase-N`
- Each branch starts from `main` (assuming previous phases are merged)
- Phase execution updates `phased_execution.current_phase` in context
- Phase status changes from "pending" → "in_progress" → "completed"

### Options

```
/para-execute --branch=custom-name    # Use custom branch name (simple plans only)
/para-execute --no-branch             # Skip branch creation (continue on current branch)
/para-execute --phase=N               # Execute specific phase (phased plans only)
```

## Workflow Integration

### Simple Plan Workflow

This command bridges planning and summarizing:

1. **Plan** - `/para-plan` creates the plan (done before this)
2. **Review** - Human validates the approach (done before this)
3. **Execute** - `/para-execute` sets up execution tracking ← YOU ARE HERE
4. **Summarize** - `/para-summarize` captures results (after work is done)
5. **Archive** - `/para-archive` cleans up (after summarizing)

### Phased Plan Workflow

For each phase:

1. **Plan** - `/para-plan` creates master + sub-plans (done before this)
2. **Review** - Human validates all phases (done before this)
3. **Execute Phase N** - `/para-execute --phase=N` sets up phase tracking ← YOU ARE HERE
4. **Implement** - Work through phase to-dos, commit incrementally
5. **Summarize Phase N** - `/para-summarize --phase=N` captures phase results
6. **PR & Merge** - Create PR, get review, merge to main
7. **Repeat** - Move to next phase
8. **Archive** - `/para-archive` cleans up after all phases complete

## Implementation

### Step 1: Validate Prerequisites

1. Check if `context/context.md` exists
2. Parse the JSON block to find `active_context` array
3. Determine if this is a simple or phased plan:
   - If `phased_execution` exists in JSON → phased plan
   - Otherwise → simple plan
4. For simple plans:
   - Verify exactly one active plan exists (if multiple, ask user which one)
   - If no active plan, error with: "No active plan found. Run `/para-plan` first."
5. For phased plans:
   - If `--phase=N` option provided, validate phase N exists
   - If no `--phase` option, prompt user: "Which phase should we execute? (1-N)"
   - Verify phase N is "pending" or "in_progress" (not "completed")
   - If previous phases exist, verify they are "completed"

### Step 2: Check Git State

1. Run `git status` to check for uncommitted changes
2. If dirty state, warn user:
   ```
   ⚠️ You have uncommitted changes. Options:
   - Commit or stash changes first
   - Continue anyway (changes will be included in new branch)
   ```
3. Check if target branch already exists:
   - If exists, ask: "Branch `para/{task-name}` exists. Continue on it or create new?"

### Step 3: Read the Plan

#### For Simple Plans

1. Extract task name from plan filename (e.g., `2025-12-15-add-user-auth.md` → `add-user-auth`)
2. Read the plan file
3. Extract implementation steps from either:
   - "Implementation Steps" section (preferred)
   - "Approach" section (fallback)
   - If neither has actionable items, prompt user for to-dos

#### For Phased Plans

1. Extract task name from phase plan filename (e.g., `2025-12-15-add-auth-phase-1.md` → `add-auth`)
2. Read the phase-specific plan file
3. Extract implementation steps from "Detailed Implementation Steps" section
4. If no steps found, prompt user for to-dos

### Step 4: Create Branch

#### For Simple Plans

1. Generate branch name: `para/{task-name}`
2. Run: `git checkout -b para/{task-name}`
3. If branch creation fails, report error

#### For Phased Plans

1. Ensure we're on `main` branch first: `git checkout main && git pull`
2. Generate branch name: `para/{task-name}-phase-{N}`
3. Run: `git checkout -b para/{task-name}-phase-{N}`
4. If branch creation fails, report error

### Step 5: Update context.md

#### For Simple Plans

Replace `context/context.md` with execution tracking format:

```markdown
# Current Work Summary

Executing: {Task Name from plan}

**Branch:** `para/{task-name}`
**Plan:** context/plans/{plan-filename}

## To-Do List

- [ ] {Step 1 from plan}
- [ ] {Step 2 from plan}
- [ ] {Step 3 from plan}
...

## Progress Notes

_Update this section as you complete items._

---

```json
{
  "active_context": [
    "context/plans/{plan-filename}"
  ],
  "completed_summaries": [],
  "execution_branch": "para/{task-name}",
  "execution_started": "{ISO timestamp}",
  "last_updated": "{ISO timestamp}"
}
```
```

#### For Phased Plans

Replace `context/context.md` with phase execution tracking format:

```markdown
# Current Work Summary

Executing: {Task Name} - Phase {N}: {Phase Name}

**Branch:** `para/{task-name}-phase-{N}`
**Master Plan:** context/plans/{master-plan-filename}
**Phase Plan:** context/plans/{phase-plan-filename}

## To-Do List

- [ ] {Step 1 from phase plan}
- [ ] {Step 2 from phase plan}
- [ ] {Step 3 from phase plan}
...

## Progress Notes

_Update this section as you complete items._

---

```json
{
  "active_context": [
    "context/plans/{master-plan-filename}",
    "context/plans/{phase-plan-filename}"
  ],
  "completed_summaries": [],
  "execution_branch": "para/{task-name}-phase-{N}",
  "execution_started": "{ISO timestamp}",
  "phased_execution": {
    "master_plan": "context/plans/{master-plan-filename}",
    "phases": [
      {
        "phase": 1,
        "plan": "context/plans/{phase-1-plan}",
        "status": "completed"
      },
      {
        "phase": N,
        "plan": "context/plans/{phase-N-plan}",
        "status": "in_progress"
      }
    ],
    "current_phase": N
  },
  "last_updated": "{ISO timestamp}"
}
```
```

### Step 6: Initial Commit

1. Stage context changes: `git add context/context.md`
2. Commit with message: `chore: Initialize execution context for {task-name}`

### Step 7: Display Status

Output execution status:

```
## ✅ Execution Started

**Branch:** `para/{task-name}`
**Plan:** context/plans/{plan-filename}

### To-Do List

- [ ] {Step 1}
- [ ] {Step 2}
- [ ] {Step 3}
...

---

### Next Steps

1. Work through the to-do list above
2. As you complete each item:
   - Mark it `[x]` in `context/context.md`
   - Commit with: `git commit -m "feat: {description of what was done}"`
3. When all items are complete, run `/para-summarize`

💡 **Tip:** Commit frequently! Each to-do item should be one or more commits.
```

## Commit Message Guidelines

When executing, follow these commit patterns:

| To-Do Type | Commit Prefix | Example |
|------------|---------------|---------|
| New feature | `feat:` | `feat: Add JWT token generation` |
| Bug fix | `fix:` | `fix: Resolve auth middleware error` |
| Refactor | `refactor:` | `refactor: Extract validation logic` |
| Tests | `test:` | `test: Add auth middleware tests` |
| Docs | `docs:` | `docs: Update API documentation` |
| Config | `chore:` | `chore: Configure environment variables` |

## To-Do Tracking

As you work, update `context/context.md`:

**Before:**
```markdown
- [ ] Set up authentication middleware
- [ ] Implement JWT tokens
```

**After completing first item:**
```markdown
- [x] Set up authentication middleware ✓ (commit: abc1234)
- [ ] Implement JWT tokens
```

Optionally add commit hash reference for traceability.

## Edge Cases

### No Implementation Steps in Plan

If the plan lacks clear implementation steps:

```
⚠️ No implementation steps found in plan.

The plan's "Implementation Steps" and "Approach" sections don't contain
actionable items. Please either:

1. Update the plan with specific steps
2. Provide to-dos now:

What are the main tasks for this work? (one per line)
```

### Multiple Active Plans

If multiple plans are in `active_context`:

```
⚠️ Multiple active plans found:

1. context/plans/2025-12-15-add-auth.md
2. context/plans/2025-12-15-fix-bug.md

Which plan should we execute? (enter number)
```

### Branch Already Exists

```
⚠️ Branch `para/add-auth` already exists.

Options:
1. Continue on existing branch (recommended if resuming work)
2. Create new branch with suffix: `para/add-auth-2`
3. Cancel

Choice:
```

## Notes

- Always creates a branch to isolate work (unless `--no-branch` specified)
- Branch naming follows `para/{task-name}` convention for easy identification
- To-dos are extracted automatically but can be manually adjusted
- Commit frequently - each to-do should result in one or more commits
- The execution tracking in `context/context.md` provides resume capability
- Run `/para-status` anytime to see current progress
