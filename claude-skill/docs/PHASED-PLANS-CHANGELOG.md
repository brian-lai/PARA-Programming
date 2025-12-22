# Phased Plans Feature: Changelog

**Date:** 2025-12-18
**Status:** ✅ Complete

---

## Summary

Added comprehensive support for phased plans to the PARA-Programming workflow. Complex work that spans multiple architectural layers or affects many files can now be broken into independently reviewable and mergeable phases.

---

## Changes Made

### 1. Commands Updated

#### `/para-plan` (`claude-skill/commands/para-plan.md`)

**New Capabilities:**
- Detects when work should be phased based on scope analysis
- Asks user for confirmation before creating phased plan
- Creates master plan + multiple sub-plans (one per phase)
- Updates `context/context.md` with `phased_execution` metadata

**Decision Criteria for Phasing:**
- Architectural boundaries (database → API → frontend)
- Size & complexity (>5-10 files)
- Dependencies (migrations before code)
- Review benefits (easier PR reviews)

#### `/para-execute` (`claude-skill/commands/para-execute.md`)

**New Capabilities:**
- Accepts `--phase=N` option for phased plans
- Creates phase-specific branches: `para/task-name-phase-N`
- Ensures phases execute in order (validates previous phases complete)
- Starts each phase from `main` branch (assumes previous phases merged)
- Updates phase status: `pending` → `in_progress` → `completed`

#### `/para-summarize` (`claude-skill/commands/para-summarize.md`)

**New Capabilities:**
- Accepts `--phase=N` option for phased plans
- Creates phase-specific summaries
- Validates phase-specific success criteria
- Updates phase status to `completed`
- Tracks completed phases in `phased_execution` metadata

### 2. Templates Created

#### Master Plan Template (`claude-skill/templates/phased-plan-master-template.md`)

**Sections:**
- Overview & objective
- Why phased approach?
- Phase breakdown with dependencies
- Integration strategy
- Cross-phase considerations
- Overall success criteria
- Execution plan & branch strategy
- Review checklist

#### Sub-Plan Template (`claude-skill/templates/phased-plan-sub-template.md`)

**Sections:**
- Phase objective
- Scope (in/out of scope)
- Detailed implementation steps
- Files to be modified
- Dependencies & prerequisites
- Phase-specific risks
- Testing strategy
- Success criteria (independently verifiable)
- Review checklist

### 3. Documentation Created

#### Quick Reference Guide (`claude-skill/docs/phased-plans-quick-reference.md`)

**Contents:**
- When to use phased plans (decision criteria)
- Command comparison (simple vs phased)
- File structure comparison
- context.md JSON structure
- Phase status flow
- Common phasing patterns (5 patterns documented)
- Tips & best practices
- Troubleshooting guide
- Decision tree

#### Complete Example (`claude-skill/docs/phased-plan-example.md`)

**Contents:**
- Full walkthrough of user authentication implementation
- 3 phases: Database → API → Frontend
- Shows all commands and outputs
- Demonstrates benefits of phased approach
- Includes example plan contents
- Shows context.md updates at each step

#### Changelog (`claude-skill/docs/PHASED-PLANS-CHANGELOG.md`)

This document.

### 4. README Updated

**Changes:**
- Added mention of phased plans in workflow section
- Linked to phased plans documentation
- Explained when phased approach is beneficial

---

## Files Created

```
claude-skill/
├── templates/
│   ├── phased-plan-master-template.md    [NEW] Master plan template
│   └── phased-plan-sub-template.md       [NEW] Sub-plan template
└── docs/
    ├── phased-plans-quick-reference.md   [NEW] Quick reference guide
    ├── phased-plan-example.md            [NEW] Complete example
    └── PHASED-PLANS-CHANGELOG.md         [NEW] This file
```

---

## Files Modified

```
claude-skill/
└── commands/
    ├── para-plan.md         [MODIFIED] Added phased plan support
    ├── para-execute.md      [MODIFIED] Added --phase option
    └── para-summarize.md    [MODIFIED] Added --phase option

README.md                    [MODIFIED] Added phased plans mention
```

---

## context.md Schema Changes

### New Field: `phased_execution`

For phased plans, `context/context.md` now includes:

```json
{
  "phased_execution": {
    "master_plan": "context/plans/YYYY-MM-DD-task-name.md",
    "phases": [
      {
        "phase": 1,
        "plan": "context/plans/YYYY-MM-DD-task-name-phase-1.md",
        "status": "completed" | "in_progress" | "pending"
      }
    ],
    "current_phase": number | null
  }
}
```

**Status Flow:** `pending` → `in_progress` → `completed`

---

## Common Phasing Patterns

### 1. Layer-Based (Full-Stack Feature)

```
Phase 1: Database Schema
Phase 2: API/Backend
Phase 3: Frontend
```

**Use case:** User auth, payments, notifications

### 2. Strangler Pattern (Refactoring)

```
Phase 1: Add New System (alongside old)
Phase 2: Migrate Existing Usage
Phase 3: Remove Old System
```

**Use case:** Auth refactor, DB migration, API versioning

### 3. Zero-Downtime Migration

```
Phase 1: Dual-Write (new + old)
Phase 2: Backfill Existing Data
Phase 3: Read Switch (use new)
Phase 4: Cleanup (remove old)
```

**Use case:** Change ID format, rename columns, restructure data

### 4. Infrastructure + Feature

```
Phase 1: Infrastructure Setup
Phase 2: Core Feature
Phase 3: Integration & Testing
```

**Use case:** Add Redis, message queue, search

### 5. Service Decomposition

```
Phase 1: Extract Service Code
Phase 2: Deploy as Separate Service
Phase 3: Update Clients
Phase 4: Remove from Monolith
```

**Use case:** Microservices migration

---

## Benefits

### For Code Review
- Smaller, focused PRs (2-8 files each vs 15+ files)
- Each phase independently reviewable
- Different reviewers for different phases
- Faster review cycles

### For Deployment
- Incremental deployment reduces risk
- Each phase independently testable
- Can deploy phases separately or together
- Easier rollback if issues found

### For Development
- Clear progress tracking
- Natural breaking points
- Parallel development possible (different devs on different phases)
- Reduced merge conflicts

### For Testing
- Each phase independently testable
- Integration testing between phases
- Clear test boundaries
- Easier to isolate failures

---

## Implementation Notes

### Phase Execution Requirements

1. **Order enforcement:** Phase N cannot start until Phase N-1 is completed
2. **Branch strategy:** Each phase gets its own branch from `main`
3. **Merge requirement:** Previous phases must be merged before starting next
4. **Status tracking:** Clear status transitions prevent confusion

### Detection Logic

When `/para-plan` is invoked, Claude:
1. Analyzes task description
2. Explores relevant codebase areas
3. Estimates files affected
4. Identifies architectural boundaries
5. Determines if phasing would benefit the work
6. **Asks user for confirmation** before creating phased plan

This ensures phasing is used appropriately, not forced on simple tasks.

### Context Management

- **Simple plans:** Single plan in `active_context`
- **Phased plans:** Master plan + current phase plan in `active_context`
- **Summaries:** One summary per phase + optional final summary
- **Archives:** Archive after all phases complete

---

## Examples of When to Use

### ✅ Use Phased Plans

- "Implement user authentication system" (DB + API + Frontend)
- "Add payment processing with Stripe" (Config + Service + API + UI)
- "Refactor authentication to OAuth2" (Add new + Migrate + Remove old)
- "Migrate user IDs from int to UUID" (Dual-write + Backfill + Switch + Clean)
- "Add search with Elasticsearch" (Setup ES + Indexer + API + UI)

### ❌ Don't Use Phased Plans

- "Add logging middleware" (1-3 files, single layer)
- "Fix bug in validation" (1-2 files, focused change)
- "Update button text" (1 file, trivial change)
- "Add unit tests for service" (Tests only, straightforward)
- "Refactor single function" (Small scope, no dependencies)

---

## Future Enhancements (Not Implemented)

Potential future improvements:
- Automatic phase dependency graph visualization
- Phase completion percentage tracking
- Support for parallel phases (when no dependencies)
- Phase rollback capabilities
- Integration with project management tools
- Automated PR creation per phase

---

## Testing Recommendations

When testing phased plans:

1. **Test phase detection:** Ensure Claude correctly identifies when to phase
2. **Test phase execution:** Verify each phase executes independently
3. **Test status transitions:** Confirm status changes happen correctly
4. **Test merge requirements:** Ensure phases cannot skip order
5. **Test context updates:** Verify `phased_execution` metadata is accurate
6. **Test branch naming:** Confirm branch names follow convention
7. **Test summaries:** Ensure phase summaries capture phase-specific details

---

## Migration Notes

### Existing Projects

No breaking changes. Existing simple plans continue to work as before.

### New Projects

Can use either simple or phased plans based on task complexity.

### Converting Simple to Phased

If a simple plan is found to be too large during execution:
1. Complete the simple plan
2. Create a new phased plan for follow-up work
3. Or: Stop execution, create phased plan, restart

(Future enhancement: support mid-execution conversion)

---

## Documentation Links

- [Quick Reference Guide](./phased-plans-quick-reference.md)
- [Complete Example](./phased-plan-example.md)
- [/para-plan Command](../commands/para-plan.md)
- [/para-execute Command](../commands/para-execute.md)
- [/para-summarize Command](../commands/para-summarize.md)

---

## Questions & Troubleshooting

**Q: Should this task be phased?**
A: If it affects >5-10 files, crosses architectural boundaries, or benefits from incremental review, probably yes. When in doubt, ask the user!

**Q: How many phases?**
A: Aim for 2-5 phases, each phase covering 2-8 files and half-day to 2 days of work.

**Q: Can phases run in parallel?**
A: Currently no. Phases execute sequentially. Future enhancement possible for independent phases.

**Q: What if a phase is too large?**
A: Split it into sub-phases (1a, 1b) or rebalance work across adjacent phases.

**Q: Can I skip phases?**
A: No. Phases must execute in order to maintain dependencies.

**Q: How do I convert a simple plan to phased mid-execution?**
A: Complete the current work, then create a new phased plan for follow-up. (Future: support mid-execution conversion)

---

**Status:** ✅ Feature complete and documented
