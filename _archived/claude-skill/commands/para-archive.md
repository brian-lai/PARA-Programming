# Command: para-archive

Archive the current context to create a clean slate for the next task.

## What This Does

This command archives completed work and resets the context:

1. Moves `context/context.md` to `context/archives/YYYY-MM-DD-HHMM-context.md`
2. Creates a fresh `context/context.md` (optionally seeded with ongoing context)
3. Preserves complete audit trail of all work
4. Prepares for the next task

## Usage

```
/para-archive
```

### Options

```
/para-archive --fresh          # Create completely empty context
/para-archive --seed           # Carry forward relevant context
```

Default behavior: Create fresh context with reference to completed summaries.

## When to Archive

Archive your context when:

- ✅ Work is complete and summarized
- ✅ All tests are passing
- ✅ Changes are committed to git
- ✅ Ready to start a new, unrelated task

Do NOT archive if:
- ❌ Work is still in progress
- ❌ Continuing the same task in next session
- ❌ Need to reference current context immediately

## What Gets Preserved

Archived contexts contain:
- Active plans at time of archive
- Completed summaries
- Work summary description
- Timestamp of archive

## Implementation

1. Get current timestamp: `YYYY-MM-DD-HHMM`
2. Check if `context/context.md` exists
3. Move to: `context/archives/YYYY-MM-DD-HHMM-context.md`
4. Create new `context/context.md`:

````markdown
# Current Work Summary

Ready for next task.

---
```json
{
  "active_context": [],
  "completed_summaries": [
    "context/summaries/YYYY-MM-DD-*.md"
  ],
  "last_updated": "TIMESTAMP"
}
```
````

5. Display success message:
   - Location of archived context
   - Confirmation of fresh context
   - Ready for new task

## Recovery

If you need to recover an archived context:

```bash
# List archives
ls -lt context/archives/

# Restore specific archive
cp context/archives/2025-11-24-1430-context.md context/context.md
```

## Notes

- Archives create a complete audit trail
- Never delete archives (they're your project memory)
- Use archives to review past decisions
- Archives are searchable: `grep -r "authentication" context/archives/`
