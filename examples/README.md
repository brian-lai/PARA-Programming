# Examples

Templates and examples for PARA-Programming workflow.

## Directory Structure

```
examples/
├── plans/                      # Planning document templates
│   ├── plan-template.md        # Minimal plan template
│   └── example-add-authentication.md  # Real-world example
│
├── summaries/                  # Summary document templates
│   ├── summary-template.md     # Minimal summary template
│   └── example-authentication-summary.md  # Real-world example
│
└── workflows/                  # Workflow templates
    └── context-template.md     # context.md template
```

## Using These Templates

### Plans

1. Copy `plans/plan-template.md` to `context/plans/YYYY-MM-DD-your-task.md`
2. Fill in each section
3. Get approval before proceeding

### Summaries

1. Copy `summaries/summary-template.md` to `context/summaries/YYYY-MM-DD-your-task-summary.md`
2. Document changes after implementation
3. Include test results and learnings

### Context Tracking

1. Copy `workflows/context-template.md` to `context/context.md`
2. Update as you work through tasks
3. Archive when task is complete

## Tips

- **Keep plans concise** - Focus on approach and risks, not boilerplate
- **Be specific in summaries** - Include file:line references
- **Update context.md frequently** - It's your working memory
- **Use date prefixes** - `YYYY-MM-DD-task-name.md` for chronological sorting
