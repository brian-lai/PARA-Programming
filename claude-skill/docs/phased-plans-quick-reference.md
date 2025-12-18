# Phased Plans: Quick Reference

## When to Use Phased Plans

Create a phased plan when ANY of these apply:

✅ **Architectural Boundaries**
- Work spans database → API → frontend
- Multiple services/microservices affected
- Infrastructure changes before application code
- Migration work precedes feature work

✅ **Size & Complexity**
- More than 5-10 files affected
- Multiple major components to build
- Can break into independently testable units
- Each phase could be code reviewed separately

✅ **Dependencies**
- Later work depends on earlier foundation
- Database migrations before code changes
- API contracts before client implementation
- Configuration/setup before features

✅ **Review Benefits**
- Phases make code review manageable
- Each phase delivers incremental value
- Different team members can review phases
- Risk reduced by deploying in stages

---

## Command Comparison

### Simple Plan

| Step | Command | Output |
|------|---------|--------|
| Plan | `/para-plan task-name` | `context/plans/YYYY-MM-DD-task-name.md` |
| Execute | `/para-execute` | Branch: `para/task-name` |
| Summarize | `/para-summarize` | `context/summaries/YYYY-MM-DD-task-name-summary.md` |
| Archive | `/para-archive` | Moves context to archives |

### Phased Plan

| Step | Command | Output |
|------|---------|--------|
| Plan | `/para-plan task-name` | Master + N phase plans |
| Review | (Manual) | Review all phases |
| Execute Phase 1 | `/para-execute --phase=1` | Branch: `para/task-name-phase-1` |
| Summarize Phase 1 | `/para-summarize --phase=1` | Phase 1 summary |
| Merge Phase 1 | `gh pr create` + merge | Phase 1 in main |
| Execute Phase 2 | `/para-execute --phase=2` | Branch: `para/task-name-phase-2` |
| ... | (Repeat for each phase) | ... |
| Archive | `/para-archive` | After all phases complete |

---

## File Structure

### Simple Plan

```
context/
├── plans/
│   └── YYYY-MM-DD-task-name.md
└── summaries/
    └── YYYY-MM-DD-task-name-summary.md
```

### Phased Plan

```
context/
├── plans/
│   ├── YYYY-MM-DD-task-name.md              ← Master plan
│   ├── YYYY-MM-DD-task-name-phase-1.md      ← Phase 1 details
│   ├── YYYY-MM-DD-task-name-phase-2.md      ← Phase 2 details
│   └── YYYY-MM-DD-task-name-phase-3.md      ← Phase 3 details
└── summaries/
    ├── YYYY-MM-DD-task-name-phase-1-summary.md
    ├── YYYY-MM-DD-task-name-phase-2-summary.md
    └── YYYY-MM-DD-task-name-phase-3-summary.md
```

---

## context.md JSON Structure

### Simple Plan

```json
{
  "active_context": [
    "context/plans/YYYY-MM-DD-task-name.md"
  ],
  "completed_summaries": [],
  "execution_branch": "para/task-name",
  "execution_started": "timestamp",
  "last_updated": "timestamp"
}
```

### Phased Plan

```json
{
  "active_context": [
    "context/plans/YYYY-MM-DD-task-name.md",
    "context/plans/YYYY-MM-DD-task-name-phase-1.md"
  ],
  "completed_summaries": [
    "context/summaries/YYYY-MM-DD-task-name-phase-1-summary.md"
  ],
  "execution_branch": "para/task-name-phase-2",
  "execution_started": "timestamp",
  "phased_execution": {
    "master_plan": "context/plans/YYYY-MM-DD-task-name.md",
    "phases": [
      {
        "phase": 1,
        "plan": "context/plans/YYYY-MM-DD-task-name-phase-1.md",
        "status": "completed"
      },
      {
        "phase": 2,
        "plan": "context/plans/YYYY-MM-DD-task-name-phase-2.md",
        "status": "in_progress"
      },
      {
        "phase": 3,
        "plan": "context/plans/YYYY-MM-DD-task-name-phase-3.md",
        "status": "pending"
      }
    ],
    "current_phase": 2
  },
  "last_updated": "timestamp"
}
```

---

## Phase Status Flow

```
pending → in_progress → completed
```

- **pending**: Phase planned but not started
- **in_progress**: Phase currently being executed
- **completed**: Phase summarized and merged

---

## Common Phasing Patterns

### 1. Full-Stack Feature (Layer-Based)

```
Phase 1: Database Schema
Phase 2: API/Backend
Phase 3: Frontend
```

**Example:** User authentication, payment processing, notifications

### 2. Refactoring (Strangler Pattern)

```
Phase 1: Add New System (alongside old)
Phase 2: Migrate Existing Usage
Phase 3: Remove Old System
```

**Example:** Auth system refactor, database migration, API versioning

### 3. Data Migration (Zero-Downtime)

```
Phase 1: Dual-Write (new + old)
Phase 2: Backfill Existing Data
Phase 3: Read Switch (use new)
Phase 4: Cleanup (remove old)
```

**Example:** Change ID format, rename columns, restructure data

### 4. Feature with Infrastructure

```
Phase 1: Infrastructure Setup
Phase 2: Core Feature
Phase 3: Integration & Testing
```

**Example:** Add Redis caching, set up message queue, add search

### 5. Service Decomposition

```
Phase 1: Extract Service Code
Phase 2: Deploy as Separate Service
Phase 3: Update Clients
Phase 4: Remove from Monolith
```

**Example:** Microservices migration

---

## Tips & Best Practices

### Planning

- ✅ Each phase should deliver **independent value**
- ✅ Keep phases **similar in size** (2-8 files each)
- ✅ Make dependencies **explicit** in master plan
- ✅ Define **success criteria** per phase
- ❌ Don't make phases too granular (overhead)
- ❌ Don't make phases too large (defeats purpose)

### Execution

- ✅ Always start from `main` for each phase
- ✅ Ensure previous phases are **merged** first
- ✅ Test each phase **independently**
- ✅ Commit **incrementally** within phases
- ❌ Don't skip phase order
- ❌ Don't combine phases into one PR

### Review

- ✅ Review master plan + all phases **upfront**
- ✅ Adjust phase boundaries if needed **before executing**
- ✅ Each phase PR should be **independently reviewable**
- ✅ Include **context** in PR description (link to master plan)

### Merging

- ✅ Merge phases **in order** (1 → 2 → 3)
- ✅ Wait for **full review** before merging
- ✅ Run **tests** in CI before merging
- ✅ Deploy/verify phase before starting next

---

## Troubleshooting

### "Should this be phased?"

Ask yourself:
- More than 5-10 files affected? → **Probably yes**
- Multiple architectural layers? → **Probably yes**
- Can phases be independently reviewed? → **Yes, go phased**
- Simple, focused change? → **Probably no**

When in doubt, **ask the user**!

### "How many phases?"

Aim for:
- **2-5 phases** typically
- Each phase: **2-8 files**
- Each phase: **half-day to 2 days** of work
- Avoid: **Too many tiny phases** (overhead)
- Avoid: **Too few giant phases** (defeats purpose)

### "Phase dependencies unclear?"

- Draw a **dependency graph** in master plan
- Make **prerequisites explicit** in each phase plan
- Verify **previous phases completed** before executing
- Document **what each phase provides** for next phase

### "Phase too large?"

- **Split it further**: Create sub-phases (1a, 1b)
- Or: **Rebalance**: Move some work to adjacent phases
- Or: **Simplify scope**: Defer some work to follow-up

---

## Example: Quick Decision Tree

```
Task: "Add search functionality with Elasticsearch"

Is it >5-10 files? YES (ES setup, indexer, API, frontend)
  ↓
Multiple layers? YES (infra, backend, frontend)
  ↓
Has dependencies? YES (ES must exist before indexing)
  ↓
Benefits from incremental review? YES
  ↓
→ USE PHASED PLAN

Phases:
1. Elasticsearch setup + configuration
2. Indexing service + API endpoints
3. Frontend search UI
```

```
Task: "Fix typo in button text"

Is it >5-10 files? NO (1 file)
  ↓
Multiple layers? NO (just frontend)
  ↓
→ USE SIMPLE PLAN
```

---

## See Also

- [Complete Phased Plan Example](./phased-plan-example.md)
- [/para-plan Command Reference](../commands/para-plan.md)
- [/para-execute Command Reference](../commands/para-execute.md)
- [/para-summarize Command Reference](../commands/para-summarize.md)
