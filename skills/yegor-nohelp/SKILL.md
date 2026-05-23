---
name: yegor-nohelp
description: Knowledge sharing happens through documentation, not by tapping experts. Questions become tickets; answers land in docs (NOTES.md minimum). When you'd search or ask twice, write it down. Use when answering project-specific questions, debugging, or discovering non-obvious behavior.
version: 0.1.0
last_reviewed: 2026-05-23
---

# Yegor NoHelp / Documentation-First

Don't be the knowledge base for the user — push every reusable answer into the repo's docs. If a question would be asked twice, it belongs in `NOTES.md`.

## Triggers
- User asks a project-specific question
- Debugging together
- Discovering non-obvious behavior
- About to answer "how does X work in this codebase" from inferred memory

## The knowledge flow

1. **Check the project docs first** (`README`, `NOTES.md`, `docs/`, ADRs).
2. **If not there, search the issue tracker** — the answer may live in a closed ticket.
3. **If not there, open a ticket** with the question (treat it as a complaint: "X is undocumented").
4. **The answer lands in TWO places:** the ticket itself (for traceability) AND the appropriate doc (for future reuse).
5. **Close the ticket only after the doc is updated** — not just because the asker is satisfied.

## When to write things down

- Non-obvious behavior discovered → `NOTES.md` immediately, even one line.
- Spent more than 10 minutes debugging → write the answer before fixing the next thing.
- Searched for the same thing twice across sessions → write it down.
- Made a design decision → ADR in `docs/decisions/`.

## What counts as documentation

YES:
- `NOTES.md` in the project root for free-form discoveries.
- `docs/decisions/` or `docs/adr/` for "we chose X because Y" records.
- README sections for setup, conventions, and gotchas.
- Inline comments only for the WHY of non-obvious code (code itself documents the WHAT).
- Closed issue tickets with substantive resolution comments.

NOT enough:
- Slack/chat history (rots, disappears).
- Personal Notion/Drive (separate from the repo, invisible).
- Verbal explanations.
- Your head.

## Rules for Claude

**Before answering "how does X work in this codebase" from memory:**
- Check if it's documented. If not, suggest writing the answer to a doc as part of the response.

**When the user asks a question that was answered previously:**
- The answer should already be in a doc. If it isn't, propose adding it.
- "Let me capture this in `NOTES.md` so it's there next time."

**When implementing something non-obvious:**
- Write the WHY into a doc or an inline comment, not just into the chat reply.

**When debugging together:**
- The result is a doc entry, not just a fixed bug. "We discovered X — adding that to `NOTES.md`."

**When the user is about to ask the same question for the second time:**
- Surface: "We answered this on [date]. Want to write it down so we don't repeat?"

## Solo developer angle

You DO have an "expert" to avoid relying on — Claude. If every session starts with "remind me how the auth flow works," you're tapping me as a knowledge base instead of building one. Your continuity suffers, not just mine.

Rituals:
1. **Every project has a `NOTES.md` at root** — even tiny projects, even prototypes.
2. **End-of-session ritual:** one new line in `NOTES.md`. Whatever you learned that day.
3. **Promotion ritual:** when a NOTES entry has been referenced more than once, promote it to a structured location (README, ADR, etc.).
4. **Don't let Claude be the knowledge base.** If you find yourself asking the same architectural question across sessions, write it down.

## Pitfalls
- Doc rot. Documentation that lies is worse than none. Date entries; review and prune quarterly. If a NOTES entry is wrong, fix it or delete it.
- Premature formalization. Don't build a wiki + ADR template + tagging system before writing a single note. Start with one `NOTES.md`. Promote later.
- Writing for an audience that doesn't exist. Don't polish public docs for a private project. Casual is fine if searchable and dated.
- Hiding docs in places no one looks (a separate wiki, Notion, Drive folder). Keep docs in the repo whenever possible.
- Treating it as overhead. It IS overhead — but with compounding returns. Skipping it feels fast in the moment, is slow over months.

## Cross-references
- `yegor-tickets` — questions become tickets; answers land in docs.
- `yegor-bdd` — "X is undocumented" is a valid complaint and a real ticket.
- `yegor-pdd` — a puzzle can defer documentation: `@todo #N:15m/DEV Document why we chose Y over X here.`

## Deep reference

`research/philosophy_07_nohelp_documentation_first.md`
