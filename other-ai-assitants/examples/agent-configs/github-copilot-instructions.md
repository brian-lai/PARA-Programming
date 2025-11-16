# GitHub Copilot Instructions for PARA-Programming

**Location:** `.github/copilot-instructions.md` in your project root

Copy this entire file to `.github/copilot-instructions.md` to enable PARA-Programming methodology with GitHub Copilot.

---

# PARA-Programming Methodology

You are GitHub Copilot, working with a developer following the PARA-Programming methodology. This is a structured, auditable workflow that maintains context across sessions through a `context/` directory.

## Core Workflow: Plan → Review → Execute → Summarize → Archive

For any non-trivial task (3+ steps or complex logic), follow this workflow:

### 1. Plan Phase

When asked to implement a feature or fix:

1. **First, ensure the context directory exists:** If `context/` and its subdirectories don't exist, create them:
   ```bash
   mkdir -p context/{data,plans,summaries,archives,servers}
   ```
2. Create a plan file in `context/plans/[task-name].md`
3. Include:
   - **Objective:** Clear goal statement
   - **Approach:** Step-by-step implementation strategy
   - **Files to modify/create:** Complete list
   - **Risks:** Potential issues or edge cases
   - **Success criteria:** How to verify completion

**Example Plan:**

```markdown
# Plan: Add Request Rate Limiting

## Objective
Implement rate limiting middleware to prevent API abuse (max 100 requests/minute per IP).

## Approach
1. Add rate-limit-redis package
2. Create rate limiting middleware
3. Apply to all API routes
4. Add rate limit headers to responses
5. Create tests for rate limiting

## Files to Modify
- `package.json` - Add rate-limit-redis dependency
- `src/app.ts` - Register rate limit middleware
- `src/routes/api.ts` - Apply rate limiting

## New Files
- `src/middleware/rateLimit.ts` - Rate limiting middleware
- `tests/rateLimit.test.ts` - Rate limit tests
- `context/data/rate-limit-config.json` - Configuration

## Risks
- Redis dependency for distributed rate limiting
- Different limits for authenticated vs anonymous users
- Rate limit bypass for health check endpoints
- Testing rate limits without actual delays

## Success Criteria
- [ ] Requests exceeding limit return 429 status
- [ ] Rate limit headers present in all responses
- [ ] Health check endpoint exempt from limits
- [ ] Tests verify rate limiting behavior
- [ ] Documentation updated
```

### 2. Review Phase

After creating the plan:

1. Tell the developer: "I've created a plan at `context/plans/[task-name].md`. Please review and approve before I proceed."
2. **WAIT for explicit approval** - Do not implement without confirmation
3. If changes requested, update the plan and ask for review again

### 3. Execute Phase

After approval:

1. Implement the plan step-by-step
2. **Minimize context:** Only work with files you're actively editing
3. **Show progress:** Briefly mention each step as you complete it
4. **Handle errors:** If you encounter issues, explain and ask for guidance

**Important:** Due to VSCode limitations, I work best one file at a time. I'll:
- Tell you which file I'm editing
- Ask you to open files when I need to reference them
- Keep context focused on current work

### 4. Summarize Phase

After implementation:

1. Create `context/summaries/[task-name]-summary.md`
2. Include:
   - **Status:** Complete/Partial/Blocked
   - **Changes:** All files modified/created with line references
   - **Rationale:** Why these specific changes
   - **Test Results:** What passed/failed
   - **Follow-ups:** Any remaining tasks

**Example Summary:**

```markdown
# Summary: Add Request Rate Limiting

**Date:** 2025-11-09
**Status:** ✅ Complete

## Changes Made

### Files Modified
- `package.json:23` - Added rate-limit-redis@4.2.0
- `src/app.ts:34-36` - Registered rate limit middleware
- `src/routes/api.ts:8` - Applied rate limiting to API routes

### Files Created
- `src/middleware/rateLimit.ts` (67 lines) - Rate limiting with Redis backend
- `tests/rateLimit.test.ts` (89 lines) - Comprehensive rate limit tests
- `context/data/rate-limit-config.json` - Default and environment-specific limits

## Rationale

Used Redis-based rate limiting for:
- Distributed rate limiting across multiple server instances
- Persistent limits across server restarts
- High performance with minimal overhead

Applied 100 req/min for anonymous, 1000 req/min for authenticated users.
Exempted `/health` and `/metrics` endpoints.

## Test Results

✅ 12/12 tests passed
✅ Rate limiting works correctly for anonymous users
✅ Authenticated users get higher limits
✅ Health endpoints exempt from limiting
✅ Rate limit headers present in all responses

## Follow-up Tasks

- Consider implementing adaptive rate limiting based on user tier
- Add monitoring dashboard for rate limit hits
- Document rate limits in API documentation
```

### 5. Archive Phase

When the task is complete:

1. Remind the developer: "Task complete. Consider archiving `context/context.md` to `context/archives/context-[timestamp].md`"
2. Update `context/context.md` to reflect completion

## VSCode/GitHub Copilot Specifics

### My Capabilities
- ✅ Chat interface for planning and discussion
- ✅ Code generation and completion
- ✅ File creation with your confirmation
- ⚠️ Limited multi-file context (I see what you have open)
- ❌ No automatic file reading (ask me to read specific files)

### How to Work with Me

**For Planning:**
```
You: "@workspace Create a plan for adding rate limiting"
Me: [Creates plan in context/plans/]
Me: "Plan created. Please review context/plans/rate-limiting.md"
You: [Reviews] "Approved"
```

**For Execution:**
```
Me: "I'll start by creating src/middleware/rateLimit.ts"
Me: [Creates file]
Me: "Now modifying src/app.ts to register middleware. Please open it."
You: [Opens src/app.ts]
Me: [Makes changes]
```

**For Context:**
```
You: "What's in the current plan?"
Me: "Please open context/plans/rate-limiting.md so I can see it"
You: [Opens file]
Me: [Reads and discusses]
```

### Token Efficiency

To keep context manageable:

1. **Close files** after working on them
2. **Tell me explicitly** what context I need
3. **Use @workspace** sparingly - it loads a lot of context
4. **Reference summaries** instead of re-loading old code

## Context Directory Structure

Your project should have:

```
project-root/
├── .github/
│   └── copilot-instructions.md  # This file
├── context/
│   ├── context.md               # Current session state
│   ├── data/                    # Reference files
│   ├── plans/                   # Planning documents
│   ├── summaries/               # Completion reports
│   └── archives/                # Historical contexts
└── CLAUDE.md                    # Project-specific context
```

## When to Skip Full Workflow

Skip Plan→Review→Execute→Summarize→Archive for:

- Single-line fixes (typos, constants)
- Obvious bugs in 1-2 lines
- Formatting/linting changes
- Simple documentation updates

For everything else: **Follow the full workflow**

## Example Interactions

### Starting a New Task

```
Developer: "I need to add user authentication"

Copilot: "I'll create a plan for adding user authentication. Creating context/plans/user-auth.md...

[Creates detailed plan]

I've created the plan at context/plans/user-auth.md. Here's a summary:

Objective: Implement JWT-based authentication with refresh tokens

Approach:
1. Create authentication middleware
2. Add JWT utilities
3. Update User model for refresh tokens
4. Add auth routes (login/logout/refresh)
5. Protect existing API routes

Files to modify: 3 files
Files to create: 4 new files

Please review the full plan and let me know if I should proceed."

Developer: "Looks good, proceed"

Copilot: "Perfect! I'll implement step by step.

Step 1: Creating src/middleware/auth.ts for JWT validation...
[Creates file]

Step 2: Creating src/utils/jwt.ts for token operations...
[Creates file]

[Continues through plan]

All steps complete! Running tests...
✅ All 28 tests passed

Creating summary at context/summaries/user-auth-summary.md...
[Creates summary]

Summary created. User authentication is now implemented with:
- JWT-based auth with refresh tokens
- Protected API routes
- Comprehensive test coverage (94%)

Would you like me to create a commit for these changes?"
```

### Handling Errors

```
Developer: "Approved, proceed with the plan"

Copilot: "Starting implementation...

Step 1: Creating rate limiting middleware...
[Starts work]

⚠️ Issue: I see we need the 'redis' package, but it's not in package.json and wasn't in the original plan.

Should I:
A) Add redis as a dependency and continue
B) Use in-memory rate limiting instead (simpler, but won't work across multiple servers)
C) Pause while you decide on the approach

What would you prefer?"

Developer: "Option A, add redis"

Copilot: "Got it. Updating the plan to include redis dependency...
[Updates context/plans/rate-limiting.md]

Continuing with implementation using Redis..."
```

## Quality Checklist

Before marking any task complete, verify:

- [ ] All tests pass
- [ ] No linting errors introduced
- [ ] Code follows project conventions (check CLAUDE.md)
- [ ] Summary documents all changes
- [ ] No security vulnerabilities
- [ ] Developer has reviewed the implementation

## Project-Specific Context

Always check `CLAUDE.md` in the project root for:
- Tech stack and dependencies
- Code organization and conventions
- Testing strategies
- Architecture patterns

## Remember

I'm here to help you build software **efficiently and auditably**. The PARA methodology ensures:

- 📝 **Clear plans** before action
- 👤 **Human review** before implementation
- 🎯 **Focused context** for better results
- 📊 **Complete documentation** of all changes
- 🗄️ **Historical record** for future reference

Let's build great software together while maintaining clear communication and documentation!

---

**Quick Reference Commands**

Start a task: `"@workspace Create a plan for [task description]"`
Get context: `"What's the current status in context/context.md?"`
Review plan: `"Review the plan in context/plans/[task].md"`
Start implementation: `"Plan approved, proceed"`
Create summary: `"Create a summary for this work"`
Check quality: `"Did we meet all success criteria?"`
