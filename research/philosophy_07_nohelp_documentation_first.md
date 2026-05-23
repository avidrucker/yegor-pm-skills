# Philosophy 07 — NoHelp / Documentation-First Knowledge Sharing

> **Why this doc exists:** distill XDSD's "NoHelp" principle — knowledge transfer happens through documentation, not through tapping experts — and give actionable rules a solo developer (and Claude) can follow.
>
> **Primary sources:**
> - Yegor Bugayenko, *How XDSD Is Different* (2014-04-17) — https://www.yegor256.com/2014/04/17/how-xdsd-is-different.html
> - Yegor Bugayenko, *Stop Chatting, Start Coding* (2014-10-07) — https://www.yegor256.com/2014/10/07/stop-chatting-start-coding.html
> - Talk: *eXtremely Distributed Software Development* (DevTernity 2016), takeaway @ 08:41 — "XDSD promotes knowledge sharing through documentation and discourages reliance on experts."

---

## The principle (paraphrased)

In XDSD, asking experts for unstructured help is discouraged. If you have a question, it becomes a ticket (per [Ticket-as-conversation](./philosophy_04_tickets_ticket_as_conversation.md)). If knowledge needs to spread, it lands in documentation, not in someone's head or in chat history.

Yegor's framing in *Stop Chatting, Start Coding* (2014): nobody is paid for anything except tasks explicitly assigned to them. Casual help — answering Slack DMs, hopping on a quick call to explain a system — falls outside the work model. Therefore knowledge sharing must take a *durable* form (docs, ticket answers integrated into source) rather than a *volatile* one (chat, calls).

The deeper insight: organizations that rely on experts as walking knowledge bases create bottlenecks, single points of failure, and information asymmetry. Documentation-first eliminates all three.

## Why it works

- **Compounds over time.** A documented answer is read by every future questioner; a verbal answer is consumed once.
- **Survives turnover.** Experts leave. Documentation stays.
- **Forces clarity.** Writing forces precision. Casual explanations tolerate vagueness.
- **Searchable.** Future-you greps the docs; future-you can't grep the expert's memory.
- **Removes interruption tax.** Every "got a sec?" interrupts the expert's deep work. The expert's most productive time is destroyed by serving as a knowledge tap.
- **Equalizes access.** New contributors don't need to know *who* to ask. They read.

## Canonical rules

### When you have a question

1. **Check the project docs first** (`README`, `NOTES.md`, `docs/`, ADRs).
2. **If not there, search the issue tracker** — the answer may live in a closed ticket.
3. **If not there, open a ticket** with the question (treat it as a complaint about missing documentation: "X is undocumented").
4. **The answer to that ticket lands in two places:** the ticket itself (for traceability) AND the appropriate doc (for future reuse).
5. **Close the ticket only after the doc is updated**, not just because the asker is satisfied.

### When you discover something non-obvious

This is the documentation flywheel:

- Hit a non-obvious behavior? Write it down *immediately*, even if just one line, in `NOTES.md`.
- Spent more than 10 minutes debugging something? Write the answer down before fixing the next thing.
- Searched Google twice for the same thing across sessions? Write it down.

### What "documentation" means here

It does NOT mean: heavyweight Confluence pages, exhaustive API docs, glossy onboarding guides.

It DOES mean: durable, searchable, version-controlled text that future readers can find. Concretely:

- `NOTES.md` in the project root for free-form discoveries.
- `docs/decisions/` (or `docs/adr/`) for "we chose X because Y" records.
- README sections for setup, conventions, and gotchas.
- Inline source comments only for the WHY of non-obvious code (per Yegor's broader writing — code itself documents the WHAT).
- Closed issue tickets with substantive resolution comments (these are searchable docs).

## Actionable guidelines

### How Claude should use this when helping

- **Before answering "how does X work in this codebase" from inferred memory**, check if it's documented. If not, suggest writing the answer to a doc as part of the response.
- **When the user asks a question that was answered in a previous session**, the answer should already be in a doc. If it isn't, propose adding it: "I'll capture this in `NOTES.md` so it's there next time."
- **When implementing something non-obvious**, write the WHY into a doc or an inline comment with a why-link, not just into the chat reply.
- **When debugging together**, the *result* of the debug session is a doc entry, not just a fixed bug. "We discovered X — let me add that to NOTES."
- **When the user is about to ask Claude (or anyone) the same question for the second time**, gently surface: "We answered this on [date]. Want to write it down so we don't repeat?"

### For a solo developer

Solo work is where NoHelp is most counterintuitive — you don't have experts to avoid relying on, so why bother? Two reasons:

1. **Future-you is a different person.** In three months, you will not remember why you chose approach Y over X. Your documentation is for them.
2. **Claude is your "expert."** You DO have an expert to avoid relying on — me. If every session starts with "remind me how the auth flow works", you're tapping me as a knowledge base instead of building one. Even if I can rebuild context from the code each time, *you* lose continuity. Documentation is for your own throughput, not just mine.

Tactical rules:

- **Every project has a `NOTES.md` at root.** Even tiny projects. Even prototypes.
- **End-of-session ritual: one new line in NOTES.** Whatever you learned that day, capture it. Even "tried X, it doesn't work because Y" is valuable.
- **Promotion ritual:** when a NOTES entry has been referenced more than once, promote it to a structured location (README, ADR, etc.).
- **Don't let me be the knowledge base.** If you find yourself asking Claude the same architectural question across sessions, that's a signal — write the answer down.

## Pitfalls

- **Doc rot.** Documentation that lies is worse than no documentation. Date your entries; review and prune quarterly. If a NOTES entry is wrong, fix it or delete it.
- **Premature formalization.** Don't build a wiki + ADR template + tagging system before writing a single note. Start with one `NOTES.md`. Promote later.
- **Writing for an audience that doesn't exist.** Don't write polished public docs for a private project. Write for future-you. Casual is fine if it's searchable and dated.
- **Hiding docs.** Documentation in places no one looks (a separate wiki, a Notion workspace, a Google Drive folder) is invisible. Keep docs in the repo whenever possible.
- **Treating it as overhead.** It IS overhead — but it's overhead with compounding returns. Skipping it feels fast in the moment and is slow over months.

## Integration with the other philosophies

- + [Ticket-as-conversation](./philosophy_04_tickets_ticket_as_conversation.md): questions become tickets, answers land in docs.
- + [BDD](./philosophy_02_bdd_bug_driven_development.md): "X is undocumented" is a valid complaint and a real ticket.
- + [PDD](./philosophy_01_pdd_puzzle_driven_development.md): a puzzle can defer documentation: `@todo #N:15m/DEV Document why we chose Y over X here.`

## One-line summary for Claude

> Don't be the knowledge base for the user — push every reusable answer into the repo's docs. If a question would be asked twice, it belongs in `NOTES.md`.
