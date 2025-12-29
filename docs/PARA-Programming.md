# Building a Second Brain with Agentic AI

### A Framework for Human–AI Collaboration, Cognitive Scaling & Efficient Data Access

---

## Why This Matters

Claude Code and similar Agentic tools are more than an AI coding assistant, they’re a thinking partner.

To use it effectively, we need systems that persist insight, decision‑making and progress across sessions.

Inspired by Tiago Forte’s *Building a Second Brain*, this workflow unites AI and the human engineer into a shared cognitive system—a *joint Second Brain*.

This system ensures:

- We never lose context between sessions.
- Our reasoning is **visible, auditable and reusable**.
- Claude’s contributions compound over time.
- We optimize token usage and efficiency, especially when handling large data/tools via MCP.

---

## Core Philosophy: The Shared Second Brain

> “Your mind is for having ideas, not holding them.” — Tiago Forte
>

A structured `context/` directory externalizes thinking into files—not fleeting prompts—giving both human and Claude a persistent working memory that evolves with each project.

**The goal:**

Build a system that remembers what we know, tracks what we’re doing, and records why we made decisions.

---

## The PARA Framework

### PARA Mapping

| PARA Concept | Implementation |
| --- | --- |
| **Projects** | `context/plans/` holds project‑specific plans and specs |
| **Areas** | `context/context.md` tracks ongoing work for each session |
| **Resources** | `context/data/` stores datasets, inputs, API payloads |
| **Archives** | `context/archives/` preserves completed sessions |

### (Optional) MCP Integration

In addition to PARA, we add a directory for MCP tool access:

| MCP Strategy | Implementation |
| --- | --- |
| **Tool Wrappers Directory** | `context/servers/` (or `context/mcp_servers/`) holds code wrappers for MCP servers |
| **Lazy Loading of Tool Definitions** | Claude reads only the wrappers needed for current task (reduces token overhead) |
| **Pre‑processing of Data** | Large datasets are fetched via MCP code, filtered/transformed, then only the result sent to model (minimises context size) |
| **Privacy & State** | Sensitive data remains outside model context unless necessary, improving privacy and efficiency |

---

## The `context/` Directory Structure

Each project should have a `context/` directory that Claude can **read from and write to**. This is our shared brain.

```
project-root/
├── context/
│   ├── context.md
│   ├── data/
│   ├── plans/
│   ├── summaries/
│   ├── archives/
│   └── servers/             ← MCP tool wrappers directory
└── Claude.md

```

### Folder Purposes

| Directory | Purpose |
| --- | --- |
| `context/data/` | Store supporting data, input files, API payloads |
| `context/plans/` | Project plans, specs and reasoning documents |
| `context/summaries/` | Completed work summaries and decisions |
| `context/archives/` | Archived context/history for audit trail |
| `context/servers/` | Code wrapper files for MCP servers (tool definitions, APIs) |

---

## The Master File: `context/context.md`

This file serves as Claude’s **working memory** for the current session.

It includes:

1. A human‑readable summary of what’s being worked on.
2. A JSON section tracking active context, tool wrappers loaded, datasets used, etc.

Example:

```
# Current Work Summary
Working on splitting BFF and Data Provider logic with MCP tool integration.

---
```json
{
  "active_context": [
    "context/plans/split-bff-data-provider.md",
    "context/data/openapi_schema.json",
    "context/servers/google-drive/getDocument.ts"
  ],
  "completed_summaries": [
    "context/summaries/advisor-service-architecture.md"
  ],
  "last_updated": "2025‑11‑08T12:42:00Z"
}

```

```
When a task completes, archive:
```bash
mv context/context.md context/archives/context‑$(date +%F‑%H%M).md
```
```

---

## The Cognitive Workflow Loop

```
(Plan) → (Review) → (Execute) → (Summarize) → (Archive)
↑                           ↓
Human Review                 Context Refresh

```

### Pair‑Programming Philosophy

At the core of this workflow is working with the AI as a pairing partner.

Roles may flip when logic is complex or sensitive. The key: maintain shared understanding through plans, tool wrappers and summaries.

### Step‑by‑step

### 1. **Plan**

Claude drafts a plan in `context/plans/`, declaring: objective, background, approach, risks, review checklist, data/tool sources (including `servers/`).

*See also the **Plan Authoring Guide** (Confluence) for the full plan template, data/source manifests, token budgets, and MCP usage gates.*

### 2. **Review**

Pause and ask the human:

> “Please review context/plans/<task>.md. Does it align with your intent—including the MCP tool wrappers in context/servers/?”
> 

### 3. **Execute**

Claude writes or uses existing wrapper code in `context/servers/` to call MCP tools, preprocess data externally, then uses the model only with filtered results. This dramatically reduces token consumption.

(E.g., load only necessary tools from `servers/`, filter large result sets before returning to model.)

### 4. **Summarize**

Claude writes a summary in `context/summaries/`:

- What changed
- Why it changed
- Which MCP tools/data wrappers were used
- Key learnings + next steps

### 5. **Archive**

Move `context/context.md` → `context/archives/`, then create a new, fresh `context/context.md` seeded with persistent context (if any). Keeps brain focused, lean and fresh.

### Progressive Summarization with MCP

Each step creates reusable artifacts (plans, summaries, tool wrappers) that become part of the shared brain.

Because we load only what’s needed, and preprocess in code, token usage is far lower.

### Session Hygiene & MCP Best Practices

1. Archive old context files after each task.
2. Keep `context/servers/` up to date with wrappers; load only what’s needed.
3. Summaries include which wrappers/tools were used (provenance).
4. Use the “load‑on‑demand” principle for MCP: never dump full tool definitions unless required.
5. Monitor token usage and strive for lean model context.

---

## Token & Cognitive Efficiency Strategies

| Strategy | Description |
| --- | --- |
| **Fewer, richer prompts** | Use structured plans and tool wrappers to reduce guesswork and prompt loops |
| **Context linking, not repetition** | Use `context/servers/`, `context/data/`, `context/plans/` rather than restating large data inline |
| **Active summarization** | Fill `context/summaries/` to seed future sessions |
| **Cache critical state** | Store token metadata, tool usages in `context/context.md` |
| **Load‑on‑demand tools** | Use wrappers in `servers/`, load only relevant definitions and skip full tool list |
| **Preprocess large results** | Use MCP tool wrapper code to filter large datasets before the model sees them |
| **Human checkpoints** | Review steps to avoid wasted tokens on misaligned work |

---

## Why This Approach Works

### Backed by Cognitive and Empirical Evidence

PARA‑Programming is effective because it mirrors how both **humans and LLMs process information most efficiently**— through **focused working memory** and **externalized long‑term memory**.

### 1. Cognitive Parallel

Humans use short‑term memory to process active tasks and rely on external systems (notes, documents, tools) for recall. PARA‑Programming formalizes the same behavior for Claude:

- The **prompt window** is analogous to human working memory.
- The **context directory** acts as long‑term memory.
- The `context.md` **file** serves as the prefrontal cortex — deciding what to bring into focus.

By keeping only the most relevant context active, Claude performs more accurate reasoning while minimizing noise and token costs.

### 2. Supported by Anthropic Research

[Anthropic’s research on **Model Context Protocol](https://www.anthropic.com/engineering/code-execution-with-mcp) (MCP)** confirms this design principle:

- LLMs perform best when **context is minimal and purposeful** rather than exhaustive.
- **Externalized computation** (via tools or code execution) allows the model to focus on reasoning instead of data handling.
- In Anthropic’s internal benchmarks, using persistent code and data abstractions reduced token usage by up to **98.7%** while improving accuracy and determinism.

These findings validate the Second Brain model: persistent memory and selective recall lead to lower cost, higher precision, and scalable reasoning.

### 3. Engineering Payoff

- **Efficiency**: Less redundant prompting and smaller active context.
- **Reproducibility**: Every reasoning step stored in human‑readable files.
- **Scalability**: Multi‑agent and multi‑engineer work remains consistent across sessions.
- **Auditability**: Clear trace of what Claude knew, when, and why.

In short, PARA‑Programming applies the same evidence‑based design principles that Anthropic uses internally to make Claude efficient — turning context management into an engineering discipline.

---

## The Outcome

With this system:

- Every engineering session produces durable knowledge.
- Every decision is documented and recoverable.
- Token usage and rework decrease.
- Claude becomes a **deterministic, collaborative engineer** with minimal wasted context.
- Access to large data, tools and systems is efficient and secure thanks to MCP wrappers.

---

## Summary

- Setup `context/servers/` for MCP tool wrappers.
- Use the plan → review → execute → summarize → archive loop.
- Leverage MCP strategy for loading only necessary tools and filtering data.
- Link everything to `context/data/`, `context/plans/`, `context/summaries/`.
- Archive completed context files to preserve audit trail.
- Continuously monitor token usage and accuracy.

---

## Closing Thought

Worth mentioning again:

> “Your mind is for having ideas, not holding them.” — Tiago Forte
> 

PARA‑Programming applies this principle to Claude; we externalize memory into structure, freeing ourselves to focus purely on reasoning and creativity.