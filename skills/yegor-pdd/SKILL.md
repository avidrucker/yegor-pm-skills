---
name: yegor-pdd
description: Apply Puzzle Driven Development. Convert deferred sub-problems into structured @todo puzzle comments at the code site. Use when writing stubs, reviewing TODO comments, or deferring sub-problems during implementation. Each puzzle references a parent ticket and has an estimate in minutes.
version: 0.3.0
last_reviewed: 2026-05-28
---

# Yegor Puzzle Driven Development

Defer nothing in your head. Every deferred sub-problem becomes a `@todo #N:Mm` comment at the exact code site — automatically tracked, automatically closed when the comment is removed.

## Triggers
- About to write a stub, placeholder, or partial implementation
- See a TODO comment in code
- About to say "I'll handle this later"
- Decomposing a task and discovering sub-problems

## Canonical puzzle syntax

```
@todo #234:30m/DEV Description of the deferred sub-problem,
 written at the exact stub site, referencing parent ticket #234.
```

Fields:
- Keyword: `@todo`, `TODO`, or `TODO:` (one is required)
- `#234`: parent ticket ID (required — if no ticket exists, create one first)
- `:30m`: estimate in minutes (recommended; must be ≤60)
- `/DEV`: role tag (optional — DEV, DES, QA, etc.)
- Description: plain text on the same comment block

## Rules for Claude

**When proposing code that includes a stub:**
- Always also propose the `@todo` puzzle at the stub line.
- Never write a puzzle in a different file from the stub.
- Always reference a parent ticket. If none exists, propose creating one first.

**When reviewing code:**
- Flag any orphan TODO without a ticket reference.
- Offer to convert orphan TODOs to `@todo #N:Mm/ROLE` puzzles.
- Verify stubs have associated puzzles.

**When deferring:**
- "I'll come back to this" → write the puzzle first, then move on.
- Estimate must be ≤60 minutes. If longer, decompose into multiple puzzles.

## Tooling

- CLI: `gem install pdd` — MIT licensed, free, open-source, language-agnostic, actively maintained (yegor256/pdd, latest release Feb 2026).
- Scan: `pdd --source . --file puzzles.xml`
- Recommended: run `pdd` in a pre-push hook to surface unresolved puzzles before they ship.
- Do NOT rely on the `0pdd.com` hosted bot — its latest release is marked "web-service is broken" (Feb 2024).
- For local issue sync, pipe `pdd` XML into a small script that calls `gh issue create`.
- Mind the scan's coverage: a puzzle is only tracked if its file falls within pdd's source set and outside its `--exclude` globs. Puzzles in excluded paths (e.g. `*.md`, `docs/**`) are silently ignored — the pre-push hook can print "0 puzzle(s) tracked" while many exist. Before trusting the count, confirm the puzzle's path is actually scanned; otherwise the parent GH issue is the only real backstop.

## Blocked puzzles

A puzzle is **blocked** when it cannot be resolved without an external dependency (oracle research, upstream fix, decision from another party).

**How to handle:**
1. Add a comment to the GH issue: "Blocked on X — skipping per Yegor-PM priority order."
2. Leave the `@todo` in the code untouched (removing it would lose the obligation).
3. In the priority queue, skip blocked puzzles and move to the next highest-severity unblocked one.
4. When the blocker clears, re-enter the puzzle at its original priority.

**Never** remove a `@todo` just because it's blocked. It remains in the code as a visible obligation until it's actually resolved.

## Puzzle lifecycle (close checklist)

When a puzzle is resolved:
1. Remove the `@todo` comment from the code site.
2. Commit with `Closes #N` in the message body.
3. Close the GH issue with a resolution comment: what was done, commit reference, any follow-up @todos created.
4. Verify `pdd --source . --file puzzles.xml` no longer lists the issue number.

## Pitfalls
- Don't pile puzzles like bookmarks. Each one names a concrete deferred sub-problem.
- Don't write puzzles bigger than 60min. Decompose first.
- Don't let puzzles age past 30 days. Resolve, escalate to a real ticket, or delete with justification in the parent ticket.
- Never put a bare `@todo`, `TODO`, or `TODO:` token inside a puzzle's *description text*. The parser reads the second marker as the start of a new (malformed) puzzle and aborts the whole scan with "puzzle can't be parsed". Write "puzzles"/"todos" without the marker syntax (e.g. "decompose into build puzzles", not "build @todos"). This also applies when a puzzle describes follow-up puzzles it will spawn.

## Cross-references
- `yegor-microtasks` — sized puzzles fit the ≤60-min rule.
- `yegor-tickets` — every puzzle references a parent ticket.
- `yegor-architect` — couriers drop puzzles instead of redesigning mid-implementation.
- `yegor-spikes` — when the code site or scope is unknown, run a spike first to produce the information a puzzle needs.

## Deep reference

`research/philosophy_01_pdd_puzzle_driven_development.md`
