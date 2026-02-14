# Phased Plan Example: Complete Walkthrough

This document demonstrates a complete phased plan workflow from start to finish.

---

## Scenario

**Task:** Implement user authentication system with JWT tokens, including database schema, API layer, and frontend.

**Why phased?**
- Spans multiple architectural layers (database → API → frontend)
- Database migrations must run before API implementation
- API must be complete before frontend can be built
- Each phase can be code reviewed and merged independently
- Incremental value delivery and reduced deployment risk

---

## Phase 1: Plan Creation

### Command

```bash
/para-plan implement-user-authentication
```

### Claude Analysis

Claude analyzes the task:
1. Explores the codebase to understand current architecture
2. Identifies affected files (15+ files across DB, API, frontend layers)
3. Recognizes architectural boundaries
4. Determines this should be a phased plan

### Claude Prompt

```
This looks like substantial work that spans multiple architectural layers.
I recommend creating a phased plan with 3 phases:

Phase 1: Database Schema & Migrations
Phase 2: API Layer (Auth Service, Middleware, Endpoints)
Phase 3: Frontend Integration (Login UI, Auth Context, Protected Routes)

This approach allows:
- Each phase to be reviewed and merged independently
- Database migrations to run before code changes
- Incremental testing and deployment
- Easier code review (smaller, focused PRs)

Should I create a phased plan with these 3 phases?
```

### User Response

```
Yes
```

### Files Created

```
context/plans/2025-12-18-implement-user-authentication.md               (Master)
context/plans/2025-12-18-implement-user-authentication-phase-1.md       (Database)
context/plans/2025-12-18-implement-user-authentication-phase-2.md       (API)
context/plans/2025-12-18-implement-user-authentication-phase-3.md       (Frontend)
```

### Master Plan Contents

```markdown
# Master Plan: Implement User Authentication

**Date:** 2025-12-18
**Status:** In Review
**Type:** Phased Plan

## Overview

### Objective

Implement a complete user authentication system using JWT tokens, including
database schema, API endpoints, middleware, and frontend login UI.

### Why Phased?

This work spans three architectural layers with clear dependencies:
- Database schema must exist before API can use it
- API must be functional before frontend can integrate
- Each phase can be independently tested and deployed
- Smaller, focused PRs for easier code review

## Phase Breakdown

### Phase 1: Database Schema & Migrations

**Objective:** Create user authentication tables and JWT refresh token storage

**Key Deliverables:**
- `users` table with auth fields
- `refresh_tokens` table for JWT rotation
- Database migrations
- Seed data for testing

**Dependencies:** None (foundational phase)

**Plan:** `context/plans/2025-12-18-implement-user-authentication-phase-1.md`

---

### Phase 2: API Layer

**Objective:** Implement authentication service, JWT middleware, and endpoints

**Key Deliverables:**
- Auth service with login/logout/refresh logic
- JWT token generation and validation
- Auth middleware for protected routes
- API endpoints: POST /auth/login, POST /auth/logout, POST /auth/refresh
- Unit and integration tests

**Dependencies:** Phase 1 must be complete and merged

**Plan:** `context/plans/2025-12-18-implement-user-authentication-phase-2.md`

---

### Phase 3: Frontend Integration

**Objective:** Build login UI and integrate with auth API

**Key Deliverables:**
- Login page with form validation
- Auth context provider for React
- Protected route wrapper component
- Token storage and auto-refresh logic
- Logout functionality

**Dependencies:** Phase 2 must be complete and merged

**Plan:** `context/plans/2025-12-18-implement-user-authentication-phase-3.md`

---

## Integration Strategy

### How Phases Connect

1. Phase 1 provides database tables
2. Phase 2 reads/writes to those tables via API
3. Phase 3 calls Phase 2's API endpoints

### Testing Strategy

- **Phase-Level Testing:**
  - Phase 1: Run migrations, verify schema
  - Phase 2: Unit tests for service, integration tests for endpoints
  - Phase 3: Component tests, E2E tests for login flow

- **Integration Testing:**
  - After Phase 2: Test API with real database
  - After Phase 3: Test full auth flow (frontend → API → DB)

### Deployment Strategy

- Phase 1: Deploy migration, run in production
- Phase 2: Deploy API (but no frontend using it yet)
- Phase 3: Deploy frontend (complete feature available to users)

## Cross-Phase Considerations

### Shared Risks

- **Password Security:** Use bcrypt with appropriate salt rounds (handled in Phase 2)
- **JWT Secret Management:** Ensure secrets are in environment variables, not code
- **Token Expiration:** Coordinate access token (15min) and refresh token (7 days) lifetimes
- **CORS Configuration:** Must be set up for frontend to call API

### Success Criteria

- [ ] Users can register and log in via frontend
- [ ] JWT tokens are properly generated and validated
- [ ] Protected routes only accessible when authenticated
- [ ] Tokens auto-refresh before expiration
- [ ] Logout properly invalidates tokens
- [ ] All tests passing (unit, integration, E2E)
- [ ] No sensitive data logged or exposed
```

---

## Phase 2: Review

### User Action

User reviews all 4 plan files (master + 3 phases) and approves the approach.

---

## Phase 3: Execute Phase 1

### Command

```bash
/para-execute --phase=1
```

### What Happens

1. Claude reads `context/context.md` and detects phased plan
2. Reads phase 1 plan: `2025-12-18-implement-user-authentication-phase-1.md`
3. Checks out `main` and pulls latest: `git checkout main && git pull`
4. Creates branch: `git checkout -b para/implement-user-authentication-phase-1`
5. Extracts implementation steps from phase 1 plan
6. Updates `context/context.md`:

```markdown
# Current Work Summary

Executing: Implement User Authentication - Phase 1: Database Schema & Migrations

**Branch:** `para/implement-user-authentication-phase-1`
**Master Plan:** context/plans/2025-12-18-implement-user-authentication.md
**Phase Plan:** context/plans/2025-12-18-implement-user-authentication-phase-1.md

## To-Do List

- [ ] Create users table migration
- [ ] Create refresh_tokens table migration
- [ ] Add indexes for performance
- [ ] Create seed data for testing
- [ ] Test migrations up and down

## Progress Notes

_Update this section as you complete items._

---

```json
{
  "active_context": [
    "context/plans/2025-12-18-implement-user-authentication.md",
    "context/plans/2025-12-18-implement-user-authentication-phase-1.md"
  ],
  "completed_summaries": [],
  "execution_branch": "para/implement-user-authentication-phase-1",
  "execution_started": "2025-12-18T10:00:00Z",
  "phased_execution": {
    "master_plan": "context/plans/2025-12-18-implement-user-authentication.md",
    "phases": [
      {
        "phase": 1,
        "plan": "context/plans/2025-12-18-implement-user-authentication-phase-1.md",
        "status": "in_progress"
      },
      {
        "phase": 2,
        "plan": "context/plans/2025-12-18-implement-user-authentication-phase-2.md",
        "status": "pending"
      },
      {
        "phase": 3,
        "plan": "context/plans/2025-12-18-implement-user-authentication-phase-3.md",
        "status": "pending"
      }
    ],
    "current_phase": 1
  },
  "last_updated": "2025-12-18T10:00:00Z"
}
```
```

7. Commits context: `git commit -m "chore: Initialize execution context for implement-user-authentication-phase-1"`

### Implementation Work

Claude (or user) works through the to-dos:

1. Creates migration file: `migrations/001_create_users_table.sql`
2. Commits: `git commit -m "feat: Add users table migration"`
3. Creates migration file: `migrations/002_create_refresh_tokens_table.sql`
4. Commits: `git commit -m "feat: Add refresh_tokens table migration"`
5. Updates context.md to mark items complete
6. Runs and tests migrations
7. Commits: `git commit -m "test: Verify migrations work correctly"`

---

## Phase 4: Summarize Phase 1

### Command

```bash
/para-summarize --phase=1
```

### What Happens

1. Claude analyzes git diff on branch `para/implement-user-authentication-phase-1`
2. Reads phase 1 plan and success criteria
3. Creates summary: `context/summaries/2025-12-18-implement-user-authentication-phase-1-summary.md`
4. Updates `context/context.md`:
   - Adds summary to `completed_summaries`
   - Changes phase 1 status to "completed"
   - Sets `current_phase` to `null`

### Summary Contents

```markdown
# Summary: Implement User Authentication - Phase 1

**Date:** 2025-12-18
**Status:** ✅ Completed
**Branch:** para/implement-user-authentication-phase-1
**Plan:** context/plans/2025-12-18-implement-user-authentication-phase-1.md

## Phase Objective

Create user authentication tables and JWT refresh token storage.

## Changes Made

### Files Created

- `migrations/001_create_users_table.sql` - User authentication table
- `migrations/002_create_refresh_tokens_table.sql` - JWT refresh token storage
- `seeds/test_users.sql` - Test user data

### Database Schema

**users table:**
- id (UUID, primary key)
- email (VARCHAR, unique)
- password_hash (VARCHAR)
- created_at (TIMESTAMP)
- updated_at (TIMESTAMP)

**refresh_tokens table:**
- id (UUID, primary key)
- user_id (UUID, foreign key → users.id)
- token (VARCHAR, unique)
- expires_at (TIMESTAMP)
- created_at (TIMESTAMP)

### Indexes Added

- users.email (unique)
- refresh_tokens.token (unique)
- refresh_tokens.user_id (for foreign key lookups)

## Success Criteria Validation

- [x] Users table created with proper fields
- [x] Refresh tokens table created
- [x] Migrations can run up and down cleanly
- [x] Indexes created for performance
- [x] Test data seeds work correctly

## Key Learnings

- Used UUID for primary keys for security and distribution
- Added expires_at index on refresh_tokens for efficient cleanup queries
- Migration rollback tested successfully

## Next Steps

1. Push branch and create PR
2. Get code review
3. Merge to main
4. Run migration in staging/production
5. Begin Phase 2: API Layer
```

---

## Phase 5: Merge Phase 1

### User Actions

```bash
git push origin para/implement-user-authentication-phase-1
gh pr create --title "feat: User auth - Phase 1 (Database Schema)" \
  --body "Part of #123. Adds database tables for user authentication."
```

1. PR is reviewed
2. Tests pass in CI
3. PR is merged to main
4. Migration runs in production

---

## Phase 6: Execute Phase 2

### Command

```bash
/para-execute --phase=2
```

### What Happens

1. Claude checks that phase 1 is "completed" ✅
2. Checks out main: `git checkout main && git pull` (gets phase 1 changes)
3. Creates new branch: `git checkout -b para/implement-user-authentication-phase-2`
4. Reads phase 2 plan
5. Updates `context/context.md` for phase 2 execution
6. Sets phase 2 status to "in_progress"

### Implementation continues...

User/Claude implements API layer, commits incrementally, summarizes phase 2, creates PR, merges.

---

## Phase 7: Execute Phase 3

Same process for frontend integration.

---

## Phase 8: Final Archive

After all phases are complete and merged:

```bash
/para-archive
```

This:
1. Moves `context/context.md` to `context/archives/2025-12-18-context.md`
2. Clears `phased_execution` from context
3. Marks entire master plan as complete

---

## Benefits Demonstrated

### For Code Review
- Phase 1 PR: 2 files (migrations) - easy to review
- Phase 2 PR: 6 files (service, middleware, endpoints, tests) - focused review
- Phase 3 PR: 5 files (components, context, routes) - frontend-only review

Instead of one 13+ file PR that's hard to review.

### For Deployment
- Phase 1: Deploy migration with no risk (no code changes)
- Phase 2: Deploy API, can test in production before frontend uses it
- Phase 3: Deploy frontend, feature goes live

### For Testing
- Each phase independently tested
- Integration testing between phases
- Reduced risk of breaking changes

### For Collaboration
- Different developers can work on different phases
- Clear handoff points between phases
- Each phase provides clear value

---

## Summary

Phased plans enable:
- ✅ Manageable code reviews
- ✅ Incremental delivery
- ✅ Reduced deployment risk
- ✅ Clear progress tracking
- ✅ Independent testing
- ✅ Better collaboration
