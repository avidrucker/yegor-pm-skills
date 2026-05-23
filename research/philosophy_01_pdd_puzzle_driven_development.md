# Philosophy 01 — Puzzle Driven Development (PDD)

> **Why this doc exists:** distill Yegor's PDD into clear, actionable rules that Claude can apply when helping manage a software project. Convert "vague mental notes" into tracked work automatically.
>
> **Primary sources:**
> - Yegor Bugayenko, *Puzzle Driven Development* (2010-03-04) — https://www.yegor256.com/2010/03/04/pdd.html
> - Yegor Bugayenko, *PDD in Action* (2017-04-05) — https://www.yegor256.com/2017/04/05/pdd-in-action.html
> - `yegor256/pdd` CLI README — https://github.com/yegor256/pdd
> - `yegor256/0pdd` bot README — https://github.com/yegor256/0pdd

---

## The principle (paraphrased)

A "puzzle" is a structured comment placed in source code at the exact spot where the code hits a stub or an unresolved assumption. Each puzzle is a deferred sub-problem that the codebase itself remembers — it doesn't live in your head, in Slack, or in a backlog grooming session. A scanner converts puzzles into trackable items (XML, GitHub issues, etc.) and closes them automatically when the comment is deleted.

Yegor's framing: the developer who *creates* the puzzle is doing decomposition work. They are delegating an unresolved piece to a future actor (themselves, another developer, an AI). The deliverable they hand back is "minimal code solving the high-level problem within time constraints, plus puzzles for everything they had to defer."

## Why it works

- **Eliminates context loss.** When you re-open a file three weeks later, the puzzle comments are right there at the relevant lines — no need to grep TODOs, parse stale notes, or guess intent.
- **Forces decomposition.** Writing a puzzle requires naming the deferred problem and estimating it. That naming itself is design work.
- **Closes the loop automatically.** Resolving the puzzle = deleting the comment. No bookkeeping drift between code and tracker.
- **Survives team changes.** The knowledge of "what's still open" is in the artifact (code), not in a person.

## Canonical puzzle syntax

```
@todo #234:30m/DEV Description of the deferred sub-problem,
 written at the exact stub site, referencing parent ticket #234.
```

Fields:

| Field | Meaning | Required |
|---|---|---|
| keyword | One of `@todo`, `TODO`, `TODO:` | Yes |
| `#234` | Parent ticket ID this puzzle decomposes from | Yes |
| `:30m` | Estimate in minutes (typically ≤60) | Optional but recommended |
| `/DEV` | Role tag (DEV, DES, QA, etc.) | Optional |
| description | Plain-text explanation of what to do | Yes |

## Actionable guidelines

These are rules Claude should apply when helping manage a project that uses PDD.

### When to *create* a puzzle

1. **At the stub site.** If you write a function that just returns a hard-coded value, returns `null`, throws "not implemented", or hides edge cases — add a puzzle on the line above. Never write a puzzle in a different file *about* this code.
2. **When you defer an "and also".** If implementing X surfaces "we should also handle Y" — that's a puzzle on the relevant line, not a side note in the PR description.
3. **When you make a judgment call you're not sure about.** Add a puzzle explaining the assumption. Future readers (including future-you) need to know it was a deliberate guess.
4. **Always reference a parent ticket.** If no ticket exists yet, create one before adding the puzzle. The parent ticket is the "why"; the puzzle is the "where + what".

### When *not* to create a puzzle

1. Don't use puzzles as bookmarks ("I want to refactor this later"). That's a separate issue, not a puzzle.
2. Don't write puzzles in commit messages, PR descriptions, or chat — those are not scanned and will be lost.
3. Don't create puzzles bigger than ~1 hour. If a puzzle is large, decompose it into multiple smaller puzzles or escalate to a new parent ticket.

### Tooling rules

1. **Use the `pdd` CLI locally** (`gem install pdd`). It is MIT-licensed, free, open-source, language-agnostic, and actively maintained.
2. **Do not rely on the `0pdd.com` hosted service** — its latest release (Feb 2024) is tagged "web-service is broken." Either self-host the bot, or pipe `pdd --file puzzles.xml` into a tiny script that calls `gh issue create`.
3. **Run `pdd` in a pre-push hook** so unresolved puzzles are visible before they ship to main.
4. **Closure is implicit.** Deleting the comment closes the issue. Do not separately close the GitHub issue — let the tooling do it.

### How Claude should use this when helping

- When proposing a stub function, **always also propose the `@todo` comment** that documents what's missing.
- When the user says "let me come back to this later" — translate that into a concrete puzzle and offer to write it.
- When reviewing code, flag any orphan `TODO` comment without a ticket reference and offer to convert it.
- When estimating work, count unresolved puzzles in the relevant files. They are real work.

## Pitfalls

- **Puzzle inflation.** Teams (or single devs) sometimes pile up hundreds of puzzles. Cap your unresolved-puzzle count per file; if exceeded, that file needs a redesign, not more puzzles.
- **Stale puzzles.** A puzzle that's been open for >30 days is a smell. Either resolve, escalate to a real ticket, or delete with justification in the parent ticket.
- **Puzzles as venting.** "@todo this whole thing is garbage" is not a puzzle. A puzzle names a concrete deferred sub-problem.

## One-line summary for Claude

> Defer nothing in your head — every deferred sub-problem becomes a `@todo #N:Mm` comment at the exact code site, automatically tracked, automatically closed.
