# Master Plan: [Task Name]

**Date:** YYYY-MM-DD
**Status:** In Review
**Type:** Phased Plan

---

## Overview

### Objective

[Clear statement of the overall goal]

### Why Phased?

[Brief explanation of why this work is broken into phases]

---

## Phase Breakdown

### Phase 1: [Phase Name]

**Objective:** [What this phase accomplishes]
**Key Deliverables:**
- [Deliverable 1]
- [Deliverable 2]

**Dependencies:** None (foundational phase)
**Plan:** `context/plans/YYYY-MM-DD-[task]-phase-1.md`

---

### Phase 2: [Phase Name]

**Objective:** [What this phase accomplishes]
**Key Deliverables:**
- [Deliverable 1]
- [Deliverable 2]

**Dependencies:** Phase 1 must be complete and merged
**Plan:** `context/plans/YYYY-MM-DD-[task]-phase-2.md`

---

### Phase 3: [Phase Name]

**Objective:** [What this phase accomplishes]
**Key Deliverables:**
- [Deliverable 1]
- [Deliverable 2]

**Dependencies:** Phase 2 must be complete and merged
**Plan:** `context/plans/YYYY-MM-DD-[task]-phase-3.md`

---

## Integration Strategy

### How Phases Connect

[Explain how the phases build on each other]

### Testing Strategy

- **Phase-Level:** [How each phase is tested independently]
- **Integration:** [How phases are tested together]

---

## Cross-Phase Risks

- **Risk 1:** [Description and mitigation]
- **Risk 2:** [Description and mitigation]

## Overall Success Criteria

- [ ] [Overall criterion 1]
- [ ] [Overall criterion 2]
- [ ] All phase-specific criteria met
- [ ] Integration testing passes

---

## Execution Plan

1. Review all phases
2. Execute Phase 1 → `pret execute --phase=1`
3. PR, review, merge Phase 1
4. Execute Phase 2 → `pret execute --phase=2`
5. Continue for remaining phases
6. Final verification
7. Archive → `pret archive`

### Branch Strategy

- Phase 1: `pret/[task]-phase-1`
- Phase 2: `pret/[task]-phase-2`
- Phase 3: `pret/[task]-phase-3`

Each branch starts from `main` (with previous phases merged).

---

**Next Step:** Review this master plan and all sub-plans before execution.
