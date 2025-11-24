# Example PARA-Programming Workflow

This example walks through a complete PARA workflow for adding user authentication to a web API.

---

## Starting Point

You have a web API project that needs authentication added. You're using Claude Code with the PARA-Programming skill installed.

---

## Step 1: Check Current Status

```
/para-status
```

**Output:**
```
📊 PARA Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 Current Work:
   No active context

🎯 Next Action:
   Run /para-init to set up PARA structure (if not done)
   Or run /para-plan to start a new task
```

---

## Step 2: Verify Workflow Needed

```
/para-check "Add JWT-based user authentication to the API"
```

**Output:**
```
🔍 PARA Workflow Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Request: "Add JWT-based user authentication to the API"

✅ USE PARA WORKFLOW

Reason:
  This request requires code changes and file modifications.

Category: Code Implementation

Recommended Actions:
  1. Run /para-plan to create implementation plan
  2. Get human review of the plan
  3. Execute the implementation
  4. Run /para-summarize when complete
  5. Run /para-archive to clean up
```

---

## Step 3: Create a Plan

```
/para-plan add-jwt-authentication
```

**Claude creates:** `context/plans/2025-11-24-add-jwt-authentication.md`

**Plan contents:**
```markdown
# Plan: Add JWT Authentication

**Date:** 2025-11-24
**Status:** In Review

## Objective

Implement JWT-based authentication for the API with login, token refresh, and protected routes.

## Approach

1. Install JWT library (jsonwebtoken)
2. Create authentication middleware
3. Implement login endpoint
4. Add refresh token endpoint
5. Protect existing routes with auth middleware
6. Add tests for auth flow

## Risks & Edge Cases

- **Token expiration:** Need to handle expired tokens gracefully
- **Refresh token storage:** Store securely, implement rotation
- **Rate limiting:** Prevent brute force on login endpoint

## Data Sources

- Existing user model: src/models/User.ts
- Express app configuration: src/app.ts

## MCP Tools

- context/servers/crypto/generateSecret.ts (for JWT secret)

## Success Criteria

- [ ] Login endpoint returns valid JWT
- [ ] Protected routes reject invalid tokens
- [ ] Refresh token flow works
- [ ] All tests passing (existing + new auth tests)
- [ ] Documentation updated

## Review Checklist

- [ ] Approach aligns with REST best practices?
- [ ] Security considerations addressed?
- [ ] Testing strategy is comprehensive?
```

**Claude says:**
> "I've created a plan at `context/plans/2025-11-24-add-jwt-authentication.md`. Please review it and let me know if it looks good before I proceed with implementation."

---

## Step 4: Human Review

**You review the plan and respond:**
> "Looks good! One change: use httpOnly cookies for tokens instead of headers. Proceed."

**Claude updates the plan and confirms:**
> "Updated the plan to use httpOnly cookies for token storage. Beginning implementation now."

---

## Step 5: Execution

Claude implements step-by-step:

1. **Installs dependencies:**
   ```bash
   npm install jsonwebtoken cookie-parser
   npm install --save-dev @types/jsonwebtoken @types/cookie-parser
   ```

2. **Creates auth middleware:** `src/middleware/auth.ts`

3. **Implements login endpoint:** `src/routes/auth.ts`

4. **Adds refresh endpoint:** Updates `src/routes/auth.ts`

5. **Protects routes:** Updates `src/app.ts`

6. **Adds tests:** `src/routes/auth.test.ts`

7. **Updates documentation:** `README.md`

---

## Step 6: Generate Summary

After implementation is complete:

```
/para-summarize
```

**Claude analyzes git changes and creates:** `context/summaries/2025-11-24-add-jwt-authentication-summary.md`

**Summary contents:**
```markdown
# Summary: Add JWT Authentication

**Date:** 2025-11-24
**Duration:** 45 minutes
**Status:** ✅ Complete

## Changes Made

### Files Modified

- `src/app.ts:12-15` – Added cookie-parser middleware
- `src/app.ts:45-48` – Protected routes with auth middleware
- `package.json:15-17` – Added jwt and cookie-parser dependencies
- `README.md:89-134` – Added authentication documentation

### Files Created

- `src/middleware/auth.ts` – JWT authentication middleware
- `src/routes/auth.ts` – Login and refresh endpoints
- `src/routes/auth.test.ts` – Authentication test suite
- `src/utils/jwt.ts` – JWT signing and verification utilities

## Rationale

Implemented JWT authentication with httpOnly cookies (instead of header-based tokens) for improved security against XSS attacks. Used short-lived access tokens (15min) with refresh tokens (7 days) to balance security and UX.

## MCP Tools Used

- `context/servers/crypto/generateSecret.ts` – Generated secure JWT secret

## Key Learnings

- httpOnly cookies prevent client-side JavaScript access to tokens
- Need to add CORS configuration for cookie-based auth (follow-up)
- Consider rate limiting on auth endpoints (follow-up)

## Follow-Up Tasks

- [ ] Add rate limiting to login endpoint
- [ ] Configure CORS for production
- [ ] Add password reset flow
- [ ] Implement email verification

## Test Results

- ✅ 32/32 tests passing
- ✅ Code coverage: 91%
- ✅ All existing tests still passing

## Documentation Updated

- [x] README updated with auth endpoints
- [x] API docs include authentication headers
- [x] Environment variables documented
```

---

## Step 7: Check Status

```
/para-status
```

**Output:**
```
📊 PARA Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 Current Work:
   Completed JWT authentication implementation

📋 Active Plans:
   (none)

✅ Completed Summaries:
   → context/summaries/2025-11-24-add-jwt-authentication-summary.md

⏰ Last Updated: 2025-11-24T15:45:00Z

🎯 Next Action:
   Run /para-archive to clean up and prepare for next task
```

---

## Step 8: Archive and Clean Up

```
/para-archive
```

**Claude archives context:**

```
✅ Context archived to: context/archives/2025-11-24-1545-context.md
✅ Fresh context created
🎉 Ready for next task!
```

---

## Step 9: Start Next Task (Optional)

```
/para-plan add-rate-limiting
```

**And the cycle continues...**

---

## Key Takeaways

1. **Every code change starts with a plan** - `/para-plan`
2. **Always get human review** - Before execution
3. **Document everything** - `/para-summarize` captures learnings
4. **Clean up when done** - `/para-archive` maintains clean context
5. **Stay oriented** - `/para-status` shows where you are

This workflow ensures:
- ✅ Structured approach to complex tasks
- ✅ Complete audit trail of decisions
- ✅ Learnings captured for future reference
- ✅ Consistent methodology across projects
