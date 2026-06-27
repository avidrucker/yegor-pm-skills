---
name: yegor-spikes
description: Research/scope spikes for large or fuzzy issues. Run a bounded ≤60min investigation session to discover code sites, current state, open questions, and ROI before writing any @todo puzzle. Use when a GH issue is too vague or too large to add a meaningful @todo — scope it first, puzzle later.
version: 0.1.0
last_reviewed: 2026-05-27
---

# Yegor Spikes — Scope Before You Puzzle

When you can't place a `@todo` because the code site is unknown, the scope is fuzzy, or the problem is too large to fit in ≤60m, run a spike first. A spike is a ≤60m **research and documentation session** whose output is the information needed to write real puzzles.

## Triggers
- A GH issue exists but no one knows which file to put the `@todo` in
- Estimate for the issue is clearly > 60min with no obvious decomposition
- The issue says "investigate", "assess", "figure out", or "research"
- Multiple legacy issues exist with no `@todo` markers yet
- A feature is requested but its implementation approach is unknown

## Spike anatomy

A spike produces a **scope comment** on the GH issue containing:

1. **Current state** — what the code already does today (file:line citations)
2. **Gap** — what it doesn't do that the issue asks for
3. **Key code sites** — the exact files and line numbers affected
4. **Open questions** — anything still ambiguous after investigation
5. **Perceived ROI** — is the work worth doing? Is there a simpler alternative?
6. **Closure recommendation** — one of:
   - "Ready to decompose into N puzzles" (proceed to architect mode)
   - "Defer — low ROI, no concrete trigger"
   - "Close — already resolved by other work"

## Spike rules

- **Hard time limit: 60 minutes.** If you don't have enough information, write what you have and flag remaining questions.
- **Output is documentation, not code.** You may read code, run tests, and consult the oracle — but the deliverable is the scope comment, not implementation.
- **One spike per issue.** Don't open multiple spike tickets for the same issue — extend the scope comment instead.
- **Spike closes only when its recommendation is acted on.** If you recommend decomposition, close after the N child issues are created.

## GH issue format for a scope/spike ticket

```
## Purpose
Spike to scope [original issue #N]. Output: bounded @todo(s) or defer/close decision.

## Current state
[what exists today, with file:line citations]

## Gap
[what the issue asks for that doesn't exist]

## Key code sites
- `path/to/file.js:line` — [why it's relevant]

## Open questions
- [anything still ambiguous]

## Perceived ROI
[High/Medium/Low — justify briefly]

## Recommendation
[ ] Decompose into N puzzles  [ ] Defer  [ ] Close
```

## Rules for Claude

**When a large issue has no `@todo`:**
- Propose a spike instead of placing a speculative `@todo`.
- "This is too large/fuzzy to puzzle directly. Want me to run a 30-minute scope session and document the findings as a GH comment?"

**When running a spike:**
- Read the relevant code, grep for call sites, check existing tests and docs.
- Write findings directly into the GH issue comment (per `yegor-tickets` — all decisions in the tracker).
- End with a concrete recommendation.

**When the spike concludes:**
- If decomposing: enter architect mode, write the design, open N child issues with @todos.
- If deferring: close the spike issue with justification; leave the parent open with a "deferred pending X" comment.
- If closing: close both spike and parent with the "already resolved" explanation.

## Pitfalls
- Don't turn a spike into implementation work. If you catch yourself writing code, stop.
- Don't run a spike for work you already understand. If you know the code site, write the `@todo` directly.
- Don't leave a spike open indefinitely. If the recommendation is "defer", close it.

## Cross-references
- `yegor-pdd` — spikes produce the inputs that `@todo` puzzles need.
- `yegor-architect` — after a spike, architect mode produces the actual design.
- `yegor-microtasks` — spikes are themselves ≤60m micro-tasks.
- `yegor-tickets` — spike findings land as issue comments, not in chat.
