# Command: para-status

Display the current state of PARA context and workflow progress.

## What This Does

This command shows you where you are in the PARA workflow:

1. Reads and parses `context/context.md`
2. Displays current work summary
3. Lists active plans and their status
4. Shows completed summaries
5. Indicates next recommended action

## Usage

```
/para-status
```

### Options

```
/para-status --verbose         # Include file contents preview
/para-status --files           # List all context files
```

## Output Format

```
📊 PARA Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 Current Work:
   Implementing user authentication system

📋 Active Plans:
   ✓ context/plans/2025-11-24-user-auth.md (created 2h ago)

✅ Completed Summaries:
   → context/summaries/2025-11-23-api-setup-summary.md

⏰ Last Updated: 2025-11-24T14:30:00Z

🎯 Next Action:
   Continue executing the plan, or run /para-summarize when complete
```

## Workflow State Detection

The command detects your current workflow state:

- **Planning** - Active plan exists, no recent changes
- **Executing** - Active plan + git changes detected
- **Ready to Summarize** - Active plan + completed changes
- **Ready to Archive** - Summary completed, no active plans
- **Idle** - No active context, ready for new task

## Implementation

1. Check if `context/context.md` exists
2. Parse the JSON block to extract:
   - `active_context` array
   - `completed_summaries` array
   - `last_updated` timestamp
3. Read the human-readable summary section
4. Check git status for uncommitted changes
5. Determine workflow state
6. Format and display output
7. Suggest next action based on state

## Next Action Suggestions

Based on state, suggest:

- **No context** → Run `/para-init` to set up PARA structure
- **Idle** → Run `/para-plan` to start new task
- **Planning** → Review plan and begin execution
- **Executing** → Continue work or run `/para-summarize` if done
- **Summarized** → Run `/para-archive` to clean up
- **Changes uncommitted** → Commit changes before archiving

## Notes

- Use this to quickly orient yourself when returning to a project
- Helpful for understanding context before running other commands
- Integrates with git to show uncommitted work
- Provides intelligent suggestions for next steps
