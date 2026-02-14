# Command: pret-check

Decision helper to determine if Pret workflow should be used for a given request.

## What This Does

This command helps you (and Claude) decide whether to use the full Pret workflow:

1. Analyzes the type of request
2. Applies the decision tree from CLAUDE.md
3. Provides clear guidance: Use Pret or Skip Pret
4. Explains the reasoning

## Usage

```
/pret-check "Add user authentication to the API"
/pret-check "Where is the auth middleware defined?"
/pret-check "Explain how JWT tokens work"
```

## Decision Tree

The command applies this logic:

```
Is this request asking for code/file changes?
├─ YES → Use Pret Workflow
│         (Plan → Review → Execute → Summarize → Archive)
│
└─ NO → Is it asking about this project's code?
    ├─ YES → Direct answer with file references
    │         (Skip Pret, provide immediate response)
    │
    └─ NO → Standard response
              (Skip Pret, answer the question directly)
```

## Output Format

### Example 1: Should Use Pret

```
🔍 Pret Workflow Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Request: "Add user authentication to the API"

✅ USE Pret WORKFLOW

Reason:
  This request requires code changes and file modifications.

Category: Code Implementation

Recommended Actions:
  1. Run /pret-plan to create implementation plan
  2. Get human review of the plan
  3. Execute the implementation
  4. Run /pret-summarize when complete
  5. Run /pret-archive to clean up
```

### Example 2: Should Skip Pret

```
🔍 Pret Workflow Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Request: "Where is the authentication middleware defined?"

❌ SKIP Pret WORKFLOW

Reason:
  This is an informational query about existing code.
  No file modifications are required.

Category: Code Navigation

Recommended Action:
  Provide direct answer with file:line references
```

### Example 3: General Question

```
🔍 Pret Workflow Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Request: "What's the difference between OAuth and JWT?"

❌ SKIP Pret WORKFLOW

Reason:
  This is a general knowledge question unrelated to
  project-specific code changes.

Category: General Knowledge

Recommended Action:
  Provide standard informational response
```

## Implementation

1. Parse the request text
2. Classify the request type:
   - **Code Changes** - Implementing, fixing, refactoring
   - **Architecture** - Design decisions, library additions
   - **Configuration** - Build/deploy config changes
   - **Navigation** - Finding code, reading files
   - **Explanation** - Understanding existing code
   - **General** - Questions unrelated to project

3. Apply decision logic:
   ```
   if (requires_file_changes(request)):
       return "USE Pret WORKFLOW"
   elif (asks_about_project_code(request)):
       return "SKIP Pret - Direct Answer"
   else:
       return "SKIP Pret - General Response"
   ```

4. Format output with:
   - Clear verdict (Use Pret / Skip Pret)
   - Reasoning explanation
   - Category classification
   - Recommended next actions

## Request Type Patterns

### ✅ Use Pret (Code Changes)
Keywords: add, implement, create, fix, refactor, update, migrate, optimize, build, configure, setup, install, remove, delete, change

### ❌ Skip Pret (Navigation)
Keywords: where is, show me, find, locate, list, what files, which functions

### ❌ Skip Pret (Explanation)
Keywords: explain, how does, what is, why does, describe, tell me about

### ❌ Skip Pret (General)
Questions not referencing project files or requesting modifications

## Notes

- Use this command when uncertain about workflow application
- Helps maintain consistency in applying Pret methodology
- Prevents unnecessary overhead for simple queries
- Ensures complex work follows proper planning process
- Can be used as training tool for understanding Pret decisions
