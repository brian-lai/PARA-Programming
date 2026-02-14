# Phase {PHASE_NUMBER}: {PHASE_NAME}

**Parent Plan:** `context/plans/{DATE}-{TASK_NAME}.md`
**Date:** {DATE}
**Status:** Pending
**Dependencies:** {DEPENDENCIES}

---

## Phase Objective

[Clear, specific statement of what this phase accomplishes. Should be independently valuable and testable.]

---

## Scope

### In Scope

[What IS included in this phase]

- [Item 1]
- [Item 2]
- [Item 3]

### Out of Scope

[What is NOT included - will be handled in later phases]

- [Item 1]
- [Item 2]

---

## Approach

### High-Level Strategy

[Brief overview of the approach for this phase]

### Detailed Implementation Steps

1. **[Step 1 Name]**
   - [Sub-task A]
   - [Sub-task B]
   - [Sub-task C]

2. **[Step 2 Name]**
   - [Sub-task A]
   - [Sub-task B]

3. **[Step 3 Name]**
   - [Sub-task A]
   - [Sub-task B]

[Add more steps as needed]

---

## Files to be Modified

### New Files

- `[path/to/new/file.ts]` - [Purpose]
- `[path/to/new/file.test.ts]` - [Purpose]

### Modified Files

- `[path/to/existing/file.ts]` - [What changes and why]
- `[path/to/config.json]` - [What changes and why]

### Total Estimated Files

[Approximate number of files affected - helps validate phase size]

---

## Dependencies

### Prerequisites

[What must be complete before starting this phase]

- [Prerequisite 1]
- [Prerequisite 2]

### Enables Future Phases

[What this phase provides for later phases]

- [Item 1]
- [Item 2]

---

## Phase-Specific Risks

[Risks unique to this phase]

- **Risk 1:** [Description]
  - *Mitigation:* [How to handle]

- **Risk 2:** [Description]
  - *Mitigation:* [How to handle]

---

## Testing Strategy

### Unit Tests

[What unit tests need to be written]

- [Test category 1]
- [Test category 2]

### Integration Tests

[What integration tests need to be written for this phase]

- [Test scenario 1]
- [Test scenario 2]

### Manual Testing

[Manual testing steps to verify this phase]

1. [Step 1]
2. [Step 2]
3. [Step 3]

---

## Success Criteria

This phase is complete when:

- [ ] All implementation steps completed
- [ ] All new files created and properly structured
- [ ] All modified files updated correctly
- [ ] Unit tests written and passing
- [ ] Integration tests written and passing
- [ ] Manual testing completed successfully
- [ ] Code follows project conventions
- [ ] Documentation updated (if needed)
- [ ] No breaking changes to existing functionality
- [ ] Ready for code review

---

## Data Sources

[Files, APIs, or data needed for this phase specifically]

- [Source 1]: [Purpose]
- [Source 2]: [Purpose]

---

## MCP Tools

[Preprocessing or execution tools needed for this phase]

- `context/servers/{tool}.ts` - [Purpose]

---

## Review Checklist

Before executing this phase:

- [ ] Prerequisites met (previous phases complete if applicable)
- [ ] Approach is clear and detailed
- [ ] All files to be modified are identified
- [ ] Testing strategy is comprehensive
- [ ] Success criteria are measurable
- [ ] Risks are identified with mitigations
- [ ] Scope is appropriate (not too large)

After executing this phase:

- [ ] All success criteria met
- [ ] Tests passing
- [ ] Code reviewed
- [ ] Ready to merge

---

## Notes

[Any additional context, references, or considerations for this phase]

---

**Next Step:** Once reviewed and approved, run `/para-execute --phase={PHASE_NUMBER}` to begin implementation.
