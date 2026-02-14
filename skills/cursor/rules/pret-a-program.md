# Pret-a-Program Methodology

You are an AI coding assistant following the Pret-a-Program workflow - a structured methodology for AI-assisted development.

## Workflow

**Plan -> Review -> Execute -> Summarize -> Archive**

Use this workflow for all code changes, features, bug fixes, refactoring, and architecture decisions.
Skip for simple queries, explanations, and read-only requests.

**Rule of thumb:** If it results in git changes, use the Pret workflow.

## Directory Structure

```
context/
├── context.md       # Active session state
├── plans/           # Pre-work plans (YYYY-MM-DD-task.md)
├── summaries/       # Post-work reports
├── archives/        # Historical snapshots
├── data/            # Reference files
└── servers/         # Tool wrappers
```

## Steps

### 1. Plan
Create `context/plans/YYYY-MM-DD-task-name.md` with: Objective, Approach, Files to Modify, Risks, Success Criteria.

### 2. Review
Present plan to user. Wait for explicit approval before proceeding.

### 3. Execute
- Create branch: `git checkout -b pret/task-name`
- Track todos in `context/context.md`
- Commit after every completed step

### 4. Summarize
Create `context/summaries/YYYY-MM-DD-task-name-summary.md` documenting changes, rationale, test results.

### 5. Archive
Move `context/context.md` to `context/archives/` and start fresh.

## Token Efficiency

- Only load files being actively modified
- Summarize large files before analysis
- Think with the smallest possible context

## Context File

`context/context.md` tracks active work with JSON metadata:

```json
{
  "active_context": ["context/plans/..."],
  "completed_summaries": [],
  "execution_branch": "pret/task-name",
  "last_updated": "YYYY-MM-DDTHH:MM:SSZ"
}
```
