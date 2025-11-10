# Cursor + PARA-Programming Quick Start

**Get started with PARA-Programming in Cursor in under 10 minutes**

---

## Step 1: Install Cursor (2 minutes)

If you haven't already:

1. Download Cursor from [cursor.sh](https://cursor.sh)
2. Install and open Cursor
3. (Optional) Import your VSCode settings: `File → Preferences → Import Settings`

---

## Step 2: Setup Your Project (3 minutes)

In your project directory:

```bash
# Navigate to your project
cd your-project/

# Create PARA directory structure
mkdir -p context/{data,plans,summaries,archives,servers}

# Download and copy .cursorrules
curl -o .cursorrules \
  https://raw.githubusercontent.com/[your-repo]/PARA-Programming/main/cursor/cursorrules

# Download context template
curl -o context/context.md \
  https://raw.githubusercontent.com/[your-repo]/PARA-Programming/main/cursor/templates/context-template.md

# Download CLAUDE.md template
curl -o CLAUDE.md \
  https://raw.githubusercontent.com/[your-repo]/PARA-Programming/main/cursor/templates/claude-template.md

# Edit CLAUDE.md with your project details
cursor CLAUDE.md
```

**Or manually create the files:**

**.cursorrules:**
```
Copy content from: cursor/cursorrules
```

**context/context.md:**
```markdown
# Current Work Summary

Ready to start PARA-Programming with Cursor.

---

```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "2025-11-09T10:00:00Z"
}
```
```

**CLAUDE.md:** (minimal version)
```markdown
# Your Project Name

> **Workflow Methodology:** Follow `.cursorrules` for PARA-Programming

## About
[Brief description of your project]

## Tech Stack
- [Your primary language/framework]
- [Key dependencies]

## Getting Started
```bash
# Your setup commands
npm install
npm run dev
```
```

---

## Step 3: Verify Setup (1 minute)

Open Cursor in your project directory:

```bash
cursor .
```

Open Chat (CMD+L) and test:

```
You: "Are you following PARA-Programming methodology?"

Cursor: "Yes! I'm following the PARA-Programming methodology from .cursorrules.
I'll use the Plan → Review → Execute → Summarize → Archive workflow for all
non-trivial tasks. Would you like to start with something?"
```

If you see this response, you're all set! ✅

---

## Step 4: Your First Task (5 minutes)

Let's add a simple health check endpoint as a learning exercise.

### 4a. Create a Plan (Chat)

Open Chat (CMD+L):

```
You: "Create a plan for adding a health check endpoint"
```

**Expected Response:**
```
Cursor: "I'll create a plan for adding a health check endpoint.

Creating context/plans/health-check.md...

Plan includes:
- Adding GET /health endpoint
- Returning server status and timestamp
- Adding tests for the endpoint

Please review context/plans/health-check.md before I proceed."
```

**Review the plan:**
- Open `context/plans/health-check.md`
- Check that it makes sense for your project
- If good, continue. If not, ask for changes.

### 4b. Approve the Plan

In Chat:

```
You: "Looks good, approved"
```

### 4c. Implementation (Composer)

**Open Composer:** CMD+I

```
You: "Implement the plan in context/plans/health-check.md"
```

**Cursor will:**
1. Create or modify necessary files
2. Show you diffs across all files
3. Wait for your confirmation

**Review the changes**, then click "Accept" or "Apply"

**Cursor continues:**
```
"Implementation complete!
Running tests... ✅ All tests passing

Should I create the summary?"
```

### 4d. Create Summary (Chat)

Back in Chat (CMD+L):

```
You: "Yes, create the summary"
```

**Cursor creates:** `context/summaries/health-check-summary.md`

```
Cursor: "Summary created at context/summaries/health-check-summary.md

The health check endpoint is now live at GET /health and returns:
- status: 'ok'
- timestamp: current time
- version: from package.json

All tests passing ✅"
```

---

## Step 5: Review Your Work (1 minute)

You now have:

```
your-project/
├── .cursorrules ✅
├── context/
│   ├── context.md ✅
│   ├── plans/
│   │   └── health-check.md ✅
│   └── summaries/
│       └── health-check-summary.md ✅
└── CLAUDE.md ✅
```

Open each file and see:
- **Plan** documents what you intended to do
- **Summary** documents what was actually done
- **context.md** tracks the current state

This is your **audit trail** - you can come back weeks later and understand exactly what happened!

---

## Next Steps

### Try More Tasks

Now that you understand the workflow, try:

**Small Task:**
```
"Create a plan for adding logging to the health check endpoint"
```

**Medium Task:**
```
"Create a plan for adding user authentication with JWT"
```

**Large Task:**
```
"Create a plan for refactoring the authentication module"
```

### Learn Cursor Features

#### Use @-Mentions for Context

```
You: "@context/plans/health-check.md
Based on this plan, what other endpoints should we add?"

Cursor: [Reads plan, suggests related endpoints]
```

#### Use Composer for Multi-File Work

When the plan involves 3+ files, use Composer (CMD+I) instead of Chat.

#### Use CMD+K for Quick Edits

Select code, press CMD+K:
```
"Add error handling to this function"
```

### Explore Templates

Check out the templates in `cursor/templates/`:
- `plan-template.md` - Comprehensive plan template
- `summary-template.md` - Comprehensive summary template
- `context-template.md` - Context tracking template
- `claude-template.md` - Full CLAUDE.md template

### Set Up MCP Servers (Advanced)

If you have repetitive preprocessing tasks, create MCP servers in `context/servers/`.

See: [Advanced Usage](README.md#advanced-usage)

---

## Workflow Reference Card

### The 5 Steps

```
1. PLAN (Chat)
   "Create a plan for [task]"
   → context/plans/[task].md

2. REVIEW (You)
   Read the plan
   "Approved" or "Change X to Y"

3. EXECUTE (Composer or CMD+K)
   CMD+I: "Implement context/plans/[task].md"
   → Makes changes across files

4. SUMMARIZE (Chat)
   "Create summary"
   → context/summaries/[task]-summary.md

5. ARCHIVE (When done)
   mv context/context.md context/archives/context-[date].md
```

### When to Use Each Mode

| Mode | Use For | Command |
|------|---------|---------|
| **Chat** | Planning, summaries, discussions | CMD+L |
| **Composer** | Multi-file implementation | CMD+I |
| **CMD+K** | Single-file inline edits | CMD+K |

### Quick Commands

Add these to your workflow:

```
/para-plan [task]        → Create plan
/para-composer          → Open Composer with plan
/para-summarize         → Create summary
/para-archive           → Archive context
```

---

## Common Patterns

### Pattern 1: Feature Addition

```
Chat: "Create a plan for [feature]"
→ Review plan
→ "Approved"
Composer: "Implement context/plans/[feature].md"
→ Review changes → Accept
Chat: "Create summary"
```

### Pattern 2: Bug Fix

```
Chat: "Investigate [bug] and create fix plan"
→ Review plan
→ "Approved"
CMD+K: [Select buggy code] "Fix following context/plans/fix-[bug].md"
→ Review → Accept
Chat: "Create summary"
```

### Pattern 3: Refactoring

```
Chat: "Analyze [component] and create refactoring plan"
→ Review plan
→ "Looks good but do it incrementally"
Composer: "Implement step 1 of context/plans/refactor-[component].md"
→ Review → Accept
Chat: "Tests passing?"
Composer: "Implement step 2..."
[Repeat]
Chat: "Create summary"
```

---

## Troubleshooting

### Cursor isn't following .cursorrules

**Fix:** Restart Cursor after creating `.cursorrules`

### Cursor implements without creating plan

**Fix:** Be explicit: "Following PARA methodology, create a plan FIRST"

### Plans are too generic

**Fix:** Ask for more detail: "Add specific file paths and line numbers to the plan"

### Can't find the plan file

**Fix:** Check `context/plans/` directory. Use Chat to list: "What plans exist?"

### Summary is incomplete

**Fix:** Request specific sections: "Add test results and performance metrics to summary"

---

## Tips for Success

### 1. Always Create Plans for Non-Trivial Work

Even if tempted to skip, create the plan. It saves time by catching issues early.

### 2. Review Before Implementing

The human review step is crucial. Don't rubber-stamp - actually read the plan.

### 3. Use Composer for Implementation

Composer can modify multiple files simultaneously. Use it!

### 4. Create Summaries Immediately

Don't wait - create the summary right after implementation while context is fresh.

### 5. Be Specific with @-Mentions

Instead of `@src`, use `@src/specific-file.ts` for better context.

### 6. Break Down Large Tasks

If a plan has 10+ steps, break it into multiple smaller plans.

### 7. Keep Context Clean

Close unnecessary files. Reference summaries instead of re-loading old code.

---

## Getting Help

- **Read the full guide:** [README.md](README.md)
- **Check templates:** [templates/](templates/)
- **See examples:** [examples/](examples/)
- **Ask questions:** [GitHub Discussions](../../discussions)
- **Report issues:** [GitHub Issues](../../issues)

---

## What's Next?

You now know the basics of PARA-Programming with Cursor!

**Continue learning:**
1. Read the [full Cursor guide](README.md)
2. Explore [advanced MCP usage](README.md#advanced-usage)
3. Check out [real-world examples](examples/)
4. Customize `.cursorrules` for your team
5. Set up MCP servers for preprocessing

**Share with your team:**
1. Commit `.cursorrules` and `CLAUDE.md` to git
2. Share this quickstart with teammates
3. Have everyone follow the same workflow
4. Review each other's plans and summaries

**Happy PARA-Programming! 🚀**

---

**Time to productivity:** ~10 minutes
**Time to mastery:** ~1 week of daily use
**ROI:** Clearer thinking, better documentation, fewer mistakes
