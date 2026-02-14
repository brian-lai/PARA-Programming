# Command: pret-plan

Create a new planning document for the current task, with support for multi-phase plans.

## What This Does

This command helps you create a structured plan before executing work:

1. Prompts for task description
2. Analyzes scope to determine if phased approach is beneficial
3. Generates either:
   - **Simple plan**: Single plan file for straightforward tasks
   - **Phased plan**: Master plan with sub-plans for complex, multi-component work
4. Populates plan(s) with standard sections using appropriate template
5. Updates `context/context.md` to reference the new plan(s)
6. Requests human review before proceeding

## Usage

```
/pret-plan [task-description]
```

### Examples

```
/pret-plan add-user-authentication
/pret-plan fix-memory-leak
/pret-plan refactor-api-layer
```

If no task description is provided, Claude will ask for it.

## When to Use Phased Plans

Claude should create a **phased plan** when ANY of these conditions apply:

### Architectural Boundaries
- Work spans multiple system layers (database → API → frontend)
- Changes affect multiple services or microservices
- Work requires infrastructure changes before application code
- Migration work (e.g., database schema) must precede feature work

### Size & Complexity
- Task would take more than 5-10 files to complete
- Multiple major components need to be built
- Work can be broken into independently testable/deployable units
- Each phase could be code reviewed and merged separately

### Dependencies
- Later work depends on earlier foundation
- Database migrations must run before code changes
- API contracts must be established before client implementation
- Configuration/setup required before feature implementation

### Review Benefits
- Breaking work into phases makes code review more manageable
- Each phase delivers incremental value
- Phases can be reviewed by different team members
- Risk is reduced by deploying in stages

## Plan Structure Types

### Simple Plan (Single File)

For straightforward tasks, a single plan file is created:

```
context/plans/YYYY-MM-DD-task-name.md
```

Standard sections:
- **Objective** - Clear statement of what needs to be done
- **Approach** - Step-by-step methodology
- **Risks** - Potential issues and edge cases
- **Data Sources** - Required files, APIs, or external data
- **MCP Tools** - Preprocessing tools to be used
- **Success Criteria** - Measurable outcomes

### Phased Plan (Master + Sub-plans)

For complex work, a master plan coordinates sub-plans:

```
context/plans/YYYY-MM-DD-task-name.md          (Master plan)
context/plans/YYYY-MM-DD-task-name-phase-1.md  (Phase 1 details)
context/plans/YYYY-MM-DD-task-name-phase-2.md  (Phase 2 details)
context/plans/YYYY-MM-DD-task-name-phase-3.md  (Phase 3 details)
```

**Master plan** includes:
- Overall objective
- Phase breakdown with dependencies
- Cross-phase risks
- Integration strategy
- Success criteria for complete body of work

**Each sub-plan** includes:
- Phase-specific objective
- Detailed implementation steps
- Phase-specific risks
- Files to be modified
- Success criteria (must be independently verifiable)
- Review checklist

## Workflow Integration

### Simple Plan Flow

After creating a simple plan:

1. **Review** - Human validates the approach
2. **Execute** - `/pret-execute` implements the plan
3. **Summarize** - `/pret-summarize` captures results
4. **Archive** - `/pret-archive` moves context to archives

### Phased Plan Flow

After creating a phased plan:

1. **Review** - Human validates the overall approach and all phases
2. **Execute Phase 1** - `/pret-execute --phase=1` implements first phase
3. **Summarize Phase 1** - `/pret-summarize --phase=1` captures results
4. **Merge Phase 1** - Create PR, get review, merge to main
5. **Execute Phase 2** - Repeat for subsequent phases
6. **Final Archive** - After all phases complete, archive the master plan

Each phase is:
- Independently reviewable
- Independently mergeable
- Can be deployed separately (if desired)
- Builds on previous phases

## Implementation

### Detection Logic

When `/pret-plan` is invoked, Claude should:

1. Analyze the task description and explore relevant codebase areas
2. Determine if the work should be phased based on:
   - Number of files affected (>5-10 suggests phasing)
   - Architectural boundaries crossed
   - Natural dependency order
   - Merge/review strategy benefits

3. If phased approach is beneficial:
   - Ask user: "This looks like substantial work. Should I create a phased plan with [X] phases for easier review and incremental merging?"
   - Wait for confirmation
   - If confirmed, create master + sub-plans

### Simple Plan Creation

1. Get current date in `YYYY-MM-DD` format
2. Sanitize task description for filename (lowercase, hyphens)
3. Create plan file: `context/plans/YYYY-MM-DD-{task-name}.md`
4. Populate with template from `templates/plan-template.md`
5. Update `context/context.md`:
   - Add plan to `active_context` array
   - Update `last_updated` timestamp
6. Display plan location and request review

### Phased Plan Creation

1. Get current date in `YYYY-MM-DD` format
2. Sanitize task description for filename (lowercase, hyphens)
3. Create master plan: `context/plans/YYYY-MM-DD-{task-name}.md`
   - Populate with template from `templates/phased-plan-master-template.md`
4. Create sub-plans for each phase:
   - `context/plans/YYYY-MM-DD-{task-name}-phase-1.md`
   - `context/plans/YYYY-MM-DD-{task-name}-phase-2.md`
   - etc.
   - Populate with template from `templates/phased-plan-sub-template.md`
5. Update `context/context.md`:
   - Add master plan to `active_context` array
   - Add all sub-plans to `active_context` array
   - Add `phased_execution` metadata:
     ```json
     {
       "phased_execution": {
         "master_plan": "context/plans/YYYY-MM-DD-{task-name}.md",
         "phases": [
           {
             "phase": 1,
             "plan": "context/plans/YYYY-MM-DD-{task-name}-phase-1.md",
             "status": "pending"
           },
           {
             "phase": 2,
             "plan": "context/plans/YYYY-MM-DD-{task-name}-phase-2.md",
             "status": "pending"
           }
         ],
         "current_phase": null
       }
     }
     ```
6. Display all plan locations and request review

## Examples

### Example: Simple Plan

```
User: /pret-plan add-logging-middleware

Claude analyzes:
- Will touch 2-3 files
- Single architectural layer
- No dependencies
- Straightforward implementation

Creates: context/plans/2025-12-18-add-logging-middleware.md
```

### Example: Phased Plan

```
User: /pret-plan implement-user-authentication

Claude analyzes:
- Will touch 10+ files across multiple layers
- Requires database migrations
- Has clear architectural boundaries
- Benefits from incremental review

Claude asks: "This looks like substantial work. Should I create a phased plan
with 3 phases for easier review and incremental merging?"

User: Yes

Creates:
- context/plans/2025-12-18-implement-user-authentication.md (master)
- context/plans/2025-12-18-implement-user-authentication-phase-1.md (DB migration)
- context/plans/2025-12-18-implement-user-authentication-phase-2.md (API layer)
- context/plans/2025-12-18-implement-user-authentication-phase-3.md (Frontend)
```

## Phasing Strategy Examples

### Example 1: Full-Stack Feature

**Task:** Add payment processing

**Phases:**
1. **Phase 1: Database Schema** - Add payment tables, indexes, migrations
2. **Phase 2: Payment Service** - Core payment logic, external API integration
3. **Phase 3: API Endpoints** - REST endpoints for payment operations
4. **Phase 4: Frontend UI** - Payment forms, confirmation screens

**Why phased?** Each layer builds on the previous, can be reviewed independently, and can be deployed incrementally.

### Example 2: Refactoring

**Task:** Refactor authentication system

**Phases:**
1. **Phase 1: Add New System** - Implement new auth alongside old (feature flag)
2. **Phase 2: Migrate Existing** - Move existing users to new system
3. **Phase 3: Remove Old System** - Delete deprecated code

**Why phased?** Allows testing in production, provides rollback capability, reduces risk.

### Example 3: Data Migration

**Task:** Change user ID format from integer to UUID

**Phases:**
1. **Phase 1: Dual-Write** - Add UUID column, write both ID formats
2. **Phase 2: Backfill** - Migrate existing records to UUIDs
3. **Phase 3: Read Switch** - Update app to read from UUID column
4. **Phase 4: Cleanup** - Remove old integer ID column

**Why phased?** Zero-downtime migration, each phase is reversible, safe production deployment.

## Notes

- Always use date prefix for chronological ordering
- Master plans should be concise (1-2 pages)
- Sub-plans should be detailed (implementation-ready)
- Each phase must be independently verifiable and mergeable
- Phased plans are preferred for work affecting >5-10 files
- All project work MUST start with a plan (per Pret workflow)
- When in doubt, ask the user if they prefer phased approach
