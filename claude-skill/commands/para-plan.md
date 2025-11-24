# Command: para-plan

Create a new planning document for the current task.

## What This Does

This command helps you create a structured plan before executing work:

1. Prompts for task description
2. Generates a plan file with proper date prefix: `context/plans/YYYY-MM-DD-task-name.md`
3. Populates the plan with standard sections using the template
4. Updates `context/context.md` to reference the new plan
5. Requests human review before proceeding

## Usage

```
/para-plan [task-description]
```

### Examples

```
/para-plan add-user-authentication
/para-plan fix-memory-leak
/para-plan refactor-api-layer
```

If no task description is provided, Claude will ask for it.

## Plan Template Structure

The generated plan includes:

- **Objective** - Clear statement of what needs to be done
- **Approach** - Step-by-step methodology
- **Risks** - Potential issues and edge cases
- **Data Sources** - Required files, APIs, or external data
- **MCP Tools** - Preprocessing tools to be used
- **Success Criteria** - Measurable outcomes

## Workflow Integration

After creating a plan:

1. **Review** - Human validates the approach
2. **Execute** - Claude implements following the plan
3. **Summarize** - Results captured in `context/summaries/`
4. **Archive** - Context moved to `context/archives/`

## Implementation

1. Get current date in `YYYY-MM-DD` format
2. Sanitize task description for filename (lowercase, hyphens)
3. Create plan file: `context/plans/YYYY-MM-DD-{task-name}.md`
4. Populate with template from `templates/plan-template.md`
5. Update `context/context.md`:
   - Add plan to `active_context` array
   - Update `last_updated` timestamp
6. Display plan location and request review

## Notes

- Always use date prefix for chronological ordering
- Plans should be concise (1-2 pages max)
- Focus on approach and risks, not implementation details
- All project work MUST start with a plan (per PARA workflow)
