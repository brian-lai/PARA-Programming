# Command: para-init

Initialize PARA-Programming structure in the current project.

## What This Does

This command sets up the complete PARA-Programming directory structure and files:

1. Creates `context/` directory with subdirectories:
   - `context/data/` - Input files, payloads, datasets
   - `context/plans/` - Pre-work planning documents
   - `context/summaries/` - Post-work reports
   - `context/archives/` - Historical context snapshots
   - `context/servers/` - MCP tool wrappers

2. Creates `context/context.md` with initial structure

3. Creates project `CLAUDE.md` (if it doesn't exist) with reference to global methodology

4. Displays next steps for getting started

## Usage

```
/para-init
```

### Options

```
/para-init --template=basic    # Create minimal CLAUDE.md
/para-init --template=full     # Create comprehensive CLAUDE.md
```

## After Running

You'll have a complete PARA-Programming setup ready for your first task. Start by:

1. Editing `CLAUDE.md` with your project-specific context
2. Running `/para-plan` to create your first plan
3. Following the PARA workflow: Plan → Review → Execute → Summarize → Archive

## Implementation

Create the following directory structure:

```bash
mkdir -p context/{data,plans,summaries,archives,servers}
```

Create `context/context.md`:

````markdown
# Current Work Summary

Ready to start first task.

---
```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "TIMESTAMP"
}
```
````

If `CLAUDE.md` doesn't exist, create it from template based on `--template` option (default: basic).

Display success message with next steps.
