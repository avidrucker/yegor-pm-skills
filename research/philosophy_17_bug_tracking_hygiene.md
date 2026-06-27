# Philosophy 17 — Bug-Tracking Hygiene: Good Titles & the Five Principles

> **Why this doc exists:** capture Yegor's rules for disciplined issue hygiene —
> a bug title must be a complaint, not a question; and the Five Principles of Bug
> Tracking — and translate them for a solo developer working with AI agents,
> where an agent is the ideal enforcer of cheap, near-deterministic title and
> comment lints at filing time. This cluster enhances `yegor-bdd` (the title
> lint) and `yegor-tickets` (the Five Principles closing/comment discipline,
> already shipped in tickets 0.3.0).
>
> **Primary sources:**
> - Yegor Bugayenko, *Good Title, Good Bug Report* (2025-05-31) — https://www.yegor256.com/2025/05/31/good-bug-title.html
> - Yegor Bugayenko, *Five Principles of Bug Tracking* (2014-11-24) — https://www.yegor256.com/2014/11/24/principles-of-bug-tracking.html

---

## Part 1 — A bug title is a complaint, not a question

A good title names the **gap between expectation and reality** in one declarative
line. A title that asks a question ("Why do I get a CSV instead of a PNG?"),
states a bare topic ("Date parsing"), or wishes for a feature ("Add dark mode")
hides what is actually broken. The fix is a near-deterministic lint applied at
filing time, with an auto-proposed rewrite:

- **Reject interrogatives.** A `?`, or an opening *why/how/what/when/where/can/
  does/is*, marks a question, not a complaint. Rewrite to assert the breakage:
  "Why is the export empty?" → "CSV export produces an empty file for filtered
  views."
- **Reject topic/wish titles.** A bare noun phrase or a wish names a subject, not
  a defect. Require a **breakage signal** — *broken / fails / wrong / missing /
  crashes / instead / should / undocumented* — so the title asserts something is
  wrong.
- **Keep it specific and declarative.** Name the concrete current behavior:
  "Login is buggy" → "Login rejects valid emails containing a `+`."

This is the title-level expression of BDD's complaint shape (philosophy_02): the
title is the one-line "have X / should have Y." Because it's cheap and
mechanical, an AI agent can flag a weak title and offer the rewrite in the same
breath, before the ticket is filed.

## Part 2 — The Five Principles of Bug Tracking

Disciplined ticket hygiene for async/remote (and solo+agent) work:

1. **One-on-one.** A ticket is a transaction between **one reporter and one
   solver**, not a forum. Extra voices are secondary; if a ticket needs a
   committee, that's a smell to split or escalate, then land the outcome back in
   the ticket. *(shipped in `yegor-tickets` 0.3.0)*
2. **Close it fast.** Long-lived tickets waste attention. Drive each to closure
   quickly rather than letting it linger.
3. **Never close empty-handed.** A ticket can't be closed without delivering
   *some* change — a fix, a workaround, a disable, a "can't reproduce" proof
   test, or a follow-up ticket. "Closing with nothing" is forbidden; closing with
   the smallest honest deliverable is the goal. *(shipped in `yegor-tickets`
   0.3.0)*
4. **Every comment @-addresses a person.** No un-addressed noise; each comment is
   directed at someone. *(already in `yegor-bdd` + `yegor-tickets` comment
   hygiene)*
5. **A report is have-X / should-have-Y / repro.** The body states the gap
   concretely. *(already the BDD complaint shape, philosophy_02)*

Principles 4 and 5 were already encoded by the comment-hygiene and complaint-shape
rules; 1–3 are the closing discipline now in `yegor-tickets`. This doc is their
shared deep reference.

## Why it works

- **A declarative title is searchable and triagable.** "PNG download returns a
  CSV" tells a reader the defect at a glance; "Why is it broken?" tells them
  nothing. Titles are the index of the tracker.
- **One-on-one keeps accountability sharp.** Two parties, one owner of the
  outcome — no diffusion of responsibility into a thread.
- **Closing fast + never-empty keeps the tracker honest.** It can neither rot
  with stale open tickets nor be gamed by closing things with no deliverable.
- **The lints are mechanical.** `?` in a title, a missing @-mention, a close with
  no linked change — all checkable, all ideal for an agent to enforce.

## Canonical rules

- **Title = declarative complaint** — no interrogatives, require a breakage
  signal, name the concrete behavior; auto-rewrite weak titles.
- **One-on-one** — one reporter, one solver per ticket.
- **Close fast, never empty-handed** — always deliver some solution.
- **Every comment @-addresses someone** and advocates close-or-keep-open.
- **The body is have/should/repro.**

## Translating for solo + AI work

- **The agent lints at filing time.** Before a ticket is created, the agent
  checks the title and offers the complaint-form rewrite — and refuses to file a
  topic/question title as-is.
- **Switch hats deliberately.** Solo, "one reporter, one solver" means writing as
  reporter, delivering as solver, and closing as reporter (philosophy_02) — the
  one-on-one is you in two roles, not a free-for-all.
- **No empty closes.** When the agent wants to close a ticket, it must point at
  the delivered change (a commit, a workaround, a follow-up ticket) — never close
  with nothing.

## Pitfalls

- **Interrogative/topic titles** that hide the defect.
- **Committee tickets** sprawling past one reporter and one solver.
- **Stale open tickets** left to rot instead of closing fast.
- **Empty closes** — closing with no delivered change.
- **Un-addressed comments** — noise with no @-mention and no close/keep stance.

## Integration with the other philosophies

- + [BDD](./philosophy_02_bdd_bug_driven_development.md): the title lint is the
  one-line form of the complaint shape; principle 5 *is* have/should/repro.
- + [Tickets](./philosophy_04_tickets_ticket_as_conversation.md): principles 1–4
  are the comment/closing discipline; this is their deep reference.
- + [Velocity](./philosophy_06_velocity_closed_tickets.md): "close fast" feeds
  the close-rate; "never empty-handed" keeps each close a real deliverable.
- + [Stuck](./philosophy_10_stuck_cut_corners.md): a ticket that can't be closed
  honestly is revealed and re-scoped, not closed empty.

## One-line summary for Claude

> A bug title is a one-line complaint (no questions, no topics — name the
> breakage), and a ticket is one reporter + one solver, closed fast but never
> empty-handed, every comment @-addressed. Lint and rewrite weak titles at filing
> time — that's an agent's job.
