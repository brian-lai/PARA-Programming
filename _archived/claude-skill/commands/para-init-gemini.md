# Initialize Project GEMINI.md

Create a new `GEMINI.md` file in the project root that references the global workflow guide at `~/.gemini/GEMINI.md`.

## Instructions

1. **First, gather project information by asking the user:**
   - Project name
   - Brief project description (what it does)
   - Tech stack (language, framework, database, key libraries)

2. **Then create a new GEMINI.md file** in the project root using the template below.

3. **Ensure the file includes:**
   - Clear reference to the global workflow guide: `~/.gemini/GEMINI.md`
   - Project-specific context only (not workflow methodology)
   - Placeholders filled in with the information gathered from the user

## Template

```markdown
# [Project Name]

> **CRITICAL: Workflow Methodology Reference**
>
> All workflow practices are defined in `~/.gemini/GEMINI.md`
> This document contains project-specific context only.

---

## About
[Brief description of what this project does and why it exists]

## Tech Stack
- **Language/Runtime:** [e.g., TypeScript/Node.js, Python, Go]
- **Framework:** [e.g., Express, FastAPI, Next.js]
- **Database:** [e.g., PostgreSQL, MongoDB, SQLite]
- **Key Libraries:** [List 3-5 most important dependencies]

---

**Last Updated:** [YYYY-MM-DD]
```

## After Creating the File

1. **Confirm** the file was created successfully at the project root
2. **Remind the user** that workflow methodology lives in `~/.gemini/GEMINI.md`
3. **Suggest** they review and customize the placeholders
4. **Note** that the GEMINI.md should be committed to version control
