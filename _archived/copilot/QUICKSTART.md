# GitHub Copilot + PARA-Programming Quick Start

**Get started with PARA-Programming in GitHub Copilot in under 10 minutes**

---

## Step 1: Prerequisites (1 minute)

Ensure you have:
- ✅ GitHub Copilot subscription
- ✅ VSCode or JetBrains IDE installed
- ✅ Copilot extensions installed and active

**VSCode:**
- GitHub Copilot extension
- GitHub Copilot Chat extension

**JetBrains:**
- GitHub Copilot plugin

---

## Step 2: Setup Project Structure (3 minutes)

In your project directory:

```bash
# Navigate to project
cd your-project/

# Create PARA structure
mkdir -p context/{data,plans,summaries,archives,servers}
mkdir -p .github

# Download Copilot instructions
curl -o .github/copilot-instructions.md \
  https://raw.githubusercontent.com/brian-lai/PARA-Programming/main/copilot/copilot-instructions.md

# Initialize context
cat > context/context.md << 'EOF'
# Current Work Summary

Ready to start PARA-Programming with GitHub Copilot.

---

```json
{
  "active_context": [],
  "completed_summaries": [],
  "last_updated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
```
EOF

# Create project context (minimal)
cat > CLAUDE.md << 'EOF'
# Your Project Name

> **Workflow Methodology:** Follow `.github/copilot-instructions.md`

## About
[Brief project description]

## Tech Stack
- [Your stack]

## Getting Started
```bash
[Setup commands]
```
EOF
```

**Or create manually:**

```
your-project/
├── .github/
│   └── copilot-instructions.md  ← Copy from this repo
├── context/
│   ├── context.md               ← Initialize with template
│   ├── data/                    ← Empty for now
│   ├── plans/                   ← Empty for now
│   ├── summaries/               ← Empty for now
│   └── archives/                ← Empty for now
└── CLAUDE.md                    ← Project context
```

---

## Step 3: Verify Setup (1 minute)

**Open VSCode/JetBrains in your project:**

```bash
code .  # VSCode
# or open in JetBrains
```

**Open Copilot Chat:**
- VSCode: Click Copilot icon in sidebar (or Ctrl+Shift+I / Cmd+Shift+I)
- JetBrains: Tools → GitHub Copilot → Open Chat

**Test:**

```
You: "Are you following PARA-Programming methodology?"

Copilot: "Yes! I'm following PARA-Programming from .github/copilot-instructions.md.
I'll create plans before implementing, wait for approval, and work file-by-file.
Ready to start?"
```

If you see this, you're ready! ✅

---

## Step 4: Your First Task (5 minutes)

Let's add a health check endpoint to learn the workflow.

### 4a. Create Plan (Copilot Chat)

In Copilot Chat:

```
You: "Create a plan for adding a health check endpoint at GET /health"
```

**Expected Response:**

```
Copilot: "I'll create a plan for the health check endpoint.

Creating context/plans/health-check.md...

Plan includes:
1. Create health check route
2. Return server status and timestamp
3. Add tests

Files to modify: 1-2
Files to create: 2

Please review context/plans/health-check.md before I proceed."
```

**Review the plan:**
- Open `context/plans/health-check.md` in VSCode
- Check it makes sense
- If good, continue. If not, ask for changes.

### 4b. Approve the Plan

In Copilot Chat:

```
You: "Looks good, approved"
```

### 4c. Implementation (File-by-File)

**Copilot will guide you:**

```
Copilot: "Starting implementation.

File 1: src/routes/health.ts

Please open or create this file. I'll provide inline suggestions
for the health check route implementation."
```

**In VSCode:**

1. **Split screen:**
   - Left pane: `context/plans/health-check.md` (keep visible)
   - Right pane: `src/routes/health.ts` (create if needed)

2. **Start typing:**
   ```typescript
   import express from 'express';
   // Copilot suggests...
   ```

3. **Accept suggestions with Tab**
   - Copilot suggests implementation
   - Review before accepting
   - Modify if needed

4. **Complete the file**

**Back in Chat:**

```
You: "Done with health.ts. What's next?"

Copilot: "Great! Now let's test this file before moving on.
Run: npm test src/routes/health.test.ts

Next file: tests/health.test.ts"
```

### 4d. Continue Through Files

```
You: "Tests pass. Next file?"

Copilot: "File 2: tests/health.test.ts
Open this file and I'll guide you through test implementation..."

[Implement tests with Copilot's help]

You: "Tests complete and passing"

Copilot: "Excellent! All files complete ✅
All tests passing ✅

Should I create the summary?"
```

### 4e. Create Summary

```
You: "Yes, create the summary"

Copilot: "Creating context/summaries/health-check-summary.md...

Summary includes:
- Files created: health.ts, health.test.ts
- Test results: All passing
- Health endpoint returns status and timestamp

Summary complete at context/summaries/health-check-summary.md"
```

---

## Step 5: Review Your Work (1 minute)

You now have:

```
your-project/
├── .github/
│   └── copilot-instructions.md ✅
├── context/
│   ├── context.md ✅
│   ├── plans/
│   │   └── health-check.md ✅
│   └── summaries/
│       └── health-check-summary.md ✅
├── src/routes/
│   └── health.ts ✅
├── tests/
│   └── health.test.ts ✅
└── CLAUDE.md ✅
```

**Open each file and see:**
- **Plan** = What you intended to do
- **Implementation** = Code with Copilot's help
- **Summary** = What was actually done

This is your **audit trail**! 🎉

---

## Understanding the Workflow

### The 5 Steps

```
1. PLAN (Chat)
   You: "Create a plan for X"
   Copilot: Creates context/plans/x.md

2. REVIEW (You)
   Read the plan
   You: "Approved" or "Change Y"

3. EXECUTE (File-by-File)
   Copilot: "Open file 1"
   You: Open file, type code
   Copilot: Provides inline suggestions
   Repeat for each file

4. SUMMARIZE (Chat)
   You: "Create summary"
   Copilot: Creates context/summaries/x.md

5. ARCHIVE (Later)
   mv context/context.md context/archives/
```

### Key Differences from Cursor

**GitHub Copilot:**
- ✅ Works in VSCode & JetBrains
- ✅ Inline suggestions are excellent
- ⚠️ No multi-file editor (work one at a time)
- ⚠️ More human orchestration needed

**You lead, Copilot assists!**

---

## Next Steps

### Try More Tasks

**Small Task:**
```
You: "Create a plan to add request logging"
```

**Medium Task:**
```
You: "Create a plan for user authentication with JWT"
```

**Large Task:**
```
You: "Create a plan to refactor the user service"
```

### Learn Copilot Features

#### Use @workspace for Understanding

```
You: "@workspace Where is authentication currently handled?"
Copilot: [Analyzes entire codebase, explains]

You: "@workspace Create an architecture summary in context/data/"
Copilot: [Creates summary document]
```

#### Split Screen is Your Friend

Always keep plan visible:
- Left: Plan file
- Right: Implementation file
- Copilot sees both = better suggestions

#### Guide with Comments

```typescript
// Following plan step 3: Add JWT validation
// Should check expiration and signature
function validateToken() {
  // Copilot suggests implementation
```

### Use the Templates

Copy templates for consistent formatting:

```bash
cp copilot/templates/plan-template.md context/plans/my-task.md
# Edit with your task details

# Copilot can also fill templates:
You: "Fill out the plan template for adding OAuth"
```

---

## Troubleshooting

### "Copilot doesn't see .github/copilot-instructions.md"

**Fix:**
1. Verify file exists: `ls .github/copilot-instructions.md`
2. Restart VSCode
3. Be explicit: "Following PARA methodology, create a plan..."

### "Copilot starts coding before I approve plan"

**Fix:**
```
You: "Create a plan ONLY. Wait for my approval."
```

### "Lost track of which file I'm on"

**Fix:**
```
You: "What file are we working on? What's the status?"
Copilot: "Working on file 3 of 5: AuthService.ts
Completed: User.ts, auth.ts
Remaining: AuthService.ts, tests, docs"
```

### "Suggestions don't match the plan"

**Fix:**
1. Keep plan open in split view (Copilot sees it)
2. Add comment referencing plan:
   ```typescript
   // Implementing step 2 from context/plans/auth.md
   ```

---

## Workflow Reference Card

### When to Use Chat vs Inline

| Task | Use |
|------|-----|
| Create plan | **Chat** |
| Ask questions | **Chat** |
| Create summary | **Chat** |
| Check status | **Chat** |
| Write code | **Inline suggestions** |
| Implement from plan | **Inline suggestions** |

### Common Chat Commands

```bash
# Planning
"Create a plan for [task]"
"@workspace Analyze [component] and create plan"

# Status
"What's next in the plan?"
"Status check?"
"What files are done?"

# Implementation
"I've finished [file]. What's next?"
"Done with [file]. Should I test?"

# Summary
"Create summary"
"Document the [feature] changes"

# Understanding
"@workspace Where is [feature] implemented?"
"Explain the current [system]"
```

### Tips for Success

1. **Always split screen** - Plan + implementation file
2. **Work file-by-file** - Don't try to edit multiple files at once
3. **Test between files** - Catch issues early
4. **Use Chat to navigate** - "What's next?" "Status?"
5. **Be explicit** - Tell Copilot what context you're in
6. **Review before accepting** - Don't blindly Tab through suggestions

---

## Example Session

Here's a complete session workflow:

```
# 1. Start
You: "Create a plan for adding rate limiting"

# 2. Copilot creates plan
Copilot: "Created context/plans/rate-limiting.md"

# 3. You review
You: [Reads plan] "Approved"

# 4. Implementation starts
Copilot: "File 1 of 4: src/middleware/rateLimit.ts
Open this file..."

You: [Opens file in split with plan visible]
You: [Starts typing]
Copilot: [Provides inline suggestions]
You: [Accepts, completes file]

# 5. Test checkpoint
You: "Done with rateLimit.ts"
Copilot: "Test before next file?"
You: "Tests pass ✅"

# 6. Continue
Copilot: "File 2: src/routes/api.ts..."
[Repeat process]

# 7. Complete
You: "All files done"
Copilot: "All tests passing ✅ Create summary?"
You: "Yes"

# 8. Summary created
Copilot: "Summary at context/summaries/rate-limiting-summary.md"

# 9. Done!
You: "Great work!"
```

**Time:** ~20-30 minutes for a feature like this.

---

## What's Next?

### Keep Learning

1. **Read full guide:** [README.md](README.md)
2. **Check templates:** [templates/](templates/)
3. **See examples:** [examples/](examples/) (coming soon)
4. **Explore patterns:** Try different types of tasks

### Share with Team

```bash
# Commit PARA structure
git add .github/copilot-instructions.md context/ CLAUDE.md
git commit -m "Add PARA-Programming for GitHub Copilot"
git push

# Now whole team uses same methodology!
```

### Customize

- Edit `.github/copilot-instructions.md` for your team
- Add project-specific patterns to `context/data/patterns/`
- Create team conventions in CLAUDE.md

---

## Get Help

- **Full documentation:** [README.md](README.md)
- **GitHub Copilot docs:** [docs.github.com/copilot](https://docs.github.com/en/copilot)
- **Ask questions:** [GitHub Discussions](../../discussions)
- **Report issues:** [GitHub Issues](../../issues)

---

**Ready to build better software with GitHub Copilot + PARA-Programming! 🚀**

---

**Quick Stats:**
- Setup time: ~5 minutes
- First task: ~5 minutes
- Time to productivity: ~10 minutes
- Time to mastery: ~1 week of daily use

**Benefits:**
- ✅ Clear planning before coding
- ✅ Complete audit trail
- ✅ Fewer bugs (test between files)
- ✅ Better documentation
- ✅ Team consistency
