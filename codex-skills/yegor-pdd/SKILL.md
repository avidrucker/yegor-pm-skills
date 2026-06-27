---
name: yegor-pdd
description: Apply Puzzle Driven Development by turning deferred implementation sub-problems into bounded, tracker-linked puzzle comments at the exact code site. Use when Codex is about to write a stub, placeholder, partial implementation, TODO, or "handle later" note; when reviewing existing TODO comments; or when implementation uncovers sub-work that should be tracked instead of kept in chat or memory.
---

# Yegor PDD

## Overview

Use this skill to make deferral explicit. A deferred code sub-problem becomes a `@todo #N:Mm` puzzle comment beside the relevant code, tied to a tracker issue, sized to fit in one bounded work session, and removed only when resolved.

The original Claude Code source remains in `skills/yegor-pdd/`. This Codex port keeps the behavior and drops Claude-specific wording.

## Use PDD When

- You are about to write a stub, placeholder, partial implementation, fake branch, or known-limited version.
- You are about to say "later", "follow-up", "we should", or "not now" about implementation work.
- You see a TODO-style code comment and need to decide whether it is tracked correctly.
- A task decomposes during implementation and one sub-problem should not be solved in the current slice.

Do not use PDD as a dumping ground for vague ideas. If the code site, expected change, or repro is unknown, route to a spike first.

## Puzzle Comment

Use this shape:

```text
@todo #234:30m/DEV Replace this narrow placeholder with the real parser,
 because the current branch only accepts the legacy token format.
```

Required:

- A TODO marker: prefer `@todo`.
- A tracker issue number: `#234`.
- A bounded estimate: `:30m`; keep it at or below 60 minutes.
- A concrete description of the deferred sub-problem.
- Placement at the exact code site that contains the stub or limitation.

Optional:

- A role tag such as `/DEV`, `/DES`, or `/QA` when the project uses role tags.

## Workflow

1. Confirm there is a real parent tracker issue. If not, file or propose one before adding the puzzle.
2. Check whether the deferred work is small enough for one bounded session. If it is larger than 60 minutes, split it before writing the puzzle.
3. Add the puzzle comment next to the stub, placeholder, branch, or incomplete behavior.
4. Keep implementing the current slice. Do not solve the puzzle opportunistically unless it is actually part of the current issue.
5. When resolving a puzzle, remove the puzzle comment, include the issue close keyword according to the project protocol, and verify any PDD scan no longer reports that issue.

## Review Checklist

When reviewing a diff or existing code:

- Flag bare TODOs that lack a tracker issue.
- Flag puzzle comments without estimates or with estimates over 60 minutes.
- Flag puzzles placed away from the actual stub site.
- Flag puzzle descriptions that are vague, speculative, or not independently actionable.
- Confirm blocked puzzles remain visible in code until the blocker clears and the work is resolved.

## Blocked Puzzles

A puzzle is blocked only when it needs an external dependency, decision, upstream fix, or research result. When blocked:

1. Record the blocker on the tracker issue.
2. Leave the puzzle comment in the code.
3. Skip it in priority order until the blocker clears.
4. Resume it at the original priority once unblocked.

Do not remove a puzzle merely because it is blocked.

## Tooling Notes

- The `pdd` CLI is language-agnostic and can scan source comments when installed.
- A typical scan is `pdd --source . --file puzzles.xml`.
- Do not trust an empty scan until you know the relevant files are inside the scan source and outside exclude globs.
- Avoid putting a second literal TODO marker inside a puzzle description; parsers may treat it as a malformed new puzzle.

## Source References

Use the original Claude skill for deeper details until all Codex ports exist: `skills/yegor-pdd/SKILL.md`. For rationale, read `research/philosophy_01_pdd_puzzle_driven_development.md`.
