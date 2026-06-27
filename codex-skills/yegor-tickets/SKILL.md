---
name: yegor-tickets
description: Apply ticket-as-conversation discipline by making the issue tracker the primary record for project decisions, assumptions, blockers, status changes, and direction changes. Use when Codex is about to answer a project-specific question, make or record a design decision, change direction mid-work, propose a new approach, close work with rationale, or summarize state that should not live only in chat.
---

# Yegor Tickets

## Overview

Use this skill to keep project state in the tracker. If a decision, blocker, rationale, or status update matters later, write it as an issue comment first; the chat reply is only a courtesy summary.

The original Claude Code source remains in `skills/yegor-tickets/`. This Codex port keeps the behavior and removes Claude-specific wording.

## Comment First

Before answering or acting, ask where the durable record belongs:

- Active task issue for implementation status, blockers, scope changes, and close notes.
- Design or architecture issue for decisions and tradeoffs.
- Bug or complaint issue for repros, evidence, and reporter-facing outcomes.
- A new issue when there is no suitable existing record and the work crosses the project's ticket threshold.

Then write the tracker comment before giving the chat summary, unless the user explicitly asks only for a private draft or the project rules forbid writing.

## What Belongs In Tickets

- Questions and answers that affect project work.
- Design decisions and direction changes.
- Assumptions that future work depends on.
- Blockers and unblock conditions.
- "Won't do" decisions with the reason.
- End-of-session handoffs for active work.
- Close outcomes: what landed, what did not, and where follow-up lives.

Do not rely on chat, meetings, commit messages, or memory as the primary record. Commits can reference the decision, but the rationale belongs in the issue.

## Comment Hygiene

- Address the responsible person or role when the project uses mentions.
- Keep each comment focused: problem, refinement, explanation, solution, or close.
- Prefer reactions over low-information comments such as "+1", "agreed", or "thanks".
- Make the comment either move the ticket toward closure or state the exact condition that keeps it open.
- For contentious threads, move the argument out of band if needed, then put the final outcome back in the ticket.

## Closing Discipline

When closing a ticket:

1. Keep the ticket one-on-one where possible: one reporter, one solver, one transaction.
2. Never close empty-handed. Deliver some honest outcome: a fix, proof, workaround, explicit non-repro, follow-up issue, or documented decision.
3. Include the commit or artifact reference when one exists.
4. Name any follow-up work created instead of hiding it in prose.

## Correct Existing Descriptions

Do not silently rewrite someone else's ticket body to fix factual errors. Preserve auditability:

1. Add a visible top banner pointing readers to corrections in comments.
2. Strike through wrong text in place rather than deleting it.
3. Post a comment with what was wrong, the correct value, and why.

The ticket owner can still make normal scope/spec edits to their own issue; this rule is for second-party corrections.

## Solo Developer Ritual

- Write the issue before writing code for meaningful work.
- Comment when changing your mind: "Earlier I thought X; now Y because Z."
- Close with a one-line outcome tied to the artifact.
- End a session with the active issue saying where work stopped and what comes next.

## Pitfalls

- Over-ticketing trivia: not every typo needs a ticket.
- Promising to write the comment later; reverse the order.
- Long unfocused comments that bury the decision.
- Treating commit messages as design records.
- Letting spoken or chat-only decisions evaporate.

## Source References

Use the original Claude skill for deeper details until all Codex ports exist: `skills/yegor-tickets/SKILL.md`. For rationale, read `research/philosophy_04_tickets_ticket_as_conversation.md` and `research/philosophy_17_bug_tracking_hygiene.md`.
