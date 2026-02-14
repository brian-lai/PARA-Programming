# Command: pret-summarize

Generate a summary document from the current work session. Supports both simple and phased plans.

## What This Does

This command creates a structured summary after completing work:

1. Analyzes git changes (files modified, added, deleted)
2. Reviews the active plan (or phase) from `context/context.md`
3. Generates a summary with proper date prefix: `context/summaries/YYYY-MM-DD-task-name-summary.md` or `context/summaries/YYYY-MM-DD-task-name-phase-N-summary.md`
4. Documents what changed, why, and key learnings
5. Updates `context/context.md` to mark work (or phase) as complete

## Usage

### Simple Plans

```
/pret-summarize
```

The command will automatically:
- Detect the current active plan
- Analyze git diff for changes
- Generate a comprehensive summary

### Phased Plans

```
/pret-summarize --phase=1         # Summarize specific phase
/pret-summarize                   # Will prompt for which phase to summarize
```

For phased plans:
- Each phase gets its own summary file
- Phase status changes from "in_progress" → "completed"
- Summary includes phase-specific success criteria validation
- After all phases complete, a final summary can be generated

## Summary Template Structure

The generated summary includes:

- **Date & Status** - When completed, success/failure status
- **Changes Made** - Files modified/created with line references
- **Rationale** - Why these changes were made
- **MCP Tools Used** - Which preprocessing tools were utilized
- **Key Learnings** - Insights, follow-up tasks, gotchas
- **Test Results** - Pass/fail status, coverage metrics

## Workflow Integration

After summarizing:

1. Summary added to `context/summaries/`
2. `context/context.md` updated to reference the summary
3. Plan moved from `active_context` to `completed_summaries`
4. Ready for `/pret-archive` to clean up

## Implementation

1. Get current date in `YYYY-MM-DD` format
2. Read `context/context.md` to find active plan
3. Run `git diff` to see changes
4. Run `git status` to see staged/unstaged files
5. Extract task name from active plan filename
6. Create summary file: `context/summaries/YYYY-MM-DD-{task-name}-summary.md`
7. Populate with template from `templates/summary-template.md`
8. Fill in:
   - Changed files with line numbers
   - Rationale from plan
   - Test results if available
   - Key learnings
9. Update `context/context.md`:
   - Move plan from `active_context` to `completed_summaries`
   - Update `last_updated` timestamp
10. Display summary location

## Notes

- Summaries should be concise but complete
- Include file:line references for easy navigation
- Document both what changed and why
- Capture learnings for future reference
- All project work MUST end with a summary (per Pret workflow)
