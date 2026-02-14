# Command: para-check

Decision helper to determine if PARA workflow should be used for a given request.

## What This Does

This command helps you (and Claude) decide whether to use the full PARA workflow:

1. Analyzes the type of request
2. Applies the decision tree from CLAUDE.md
3. Provides clear guidance: Use PARA or Skip PARA
4. Explains the reasoning

## Usage

```
/para-check "Add user authentication to the API"
/para-check "Where is the auth middleware defined?"
/para-check "Explain how JWT tokens work"
```

## Decision Tree

The command applies this logic:

```
Is this request asking for code/file changes?
├─ YES → Use PARA Workflow
│         (Plan → Review → Execute → Summarize → Archive)
│
└─ NO → Is it asking about this project's code?
    ├─ YES → Direct answer with file references
    │         (Skip PARA, provide immediate response)
    │
    └─ NO → Standard response
              (Skip PARA, answer the question directly)
```

## Output Format

### Example 1: Should Use PARA

```
🔍 PARA Workflow Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Request: "Add user authentication to the API"

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

### Example 2: Should Skip PARA

```
🔍 PARA Workflow Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Request: "Where is the authentication middleware defined?"

❌ SKIP PARA WORKFLOW

Reason:
  This is an informational query about existing code.
  No file modifications are required.

Category: Code Navigation

Recommended Action:
  Provide direct answer with file:line references
```

### Example 3: General Question

```
🔍 PARA Workflow Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Request: "What's the difference between OAuth and JWT?"

❌ SKIP PARA WORKFLOW

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
       return "USE PARA WORKFLOW"
   elif (asks_about_project_code(request)):
       return "SKIP PARA - Direct Answer"
   else:
       return "SKIP PARA - General Response"
   ```

4. Format output with:
   - Clear verdict (Use PARA / Skip PARA)
   - Reasoning explanation
   - Category classification
   - Recommended next actions

## Request Type Patterns

### ✅ Use PARA (Code Changes)
Keywords: add, implement, create, fix, refactor, update, migrate, optimize, build, configure, setup, install, remove, delete, change

### ❌ Skip PARA (Navigation)
Keywords: where is, show me, find, locate, list, what files, which functions

### ❌ Skip PARA (Explanation)
Keywords: explain, how does, what is, why does, describe, tell me about

### ❌ Skip PARA (General)
Questions not referencing project files or requesting modifications

## Notes

- Use this command when uncertain about workflow application
- Helps maintain consistency in applying PARA methodology
- Prevents unnecessary overhead for simple queries
- Ensures complex work follows proper planning process
- Can be used as training tool for understanding PARA decisions
