---
name: yegor-tickets
description: All meaningful project communication lives in the issue tracker. No Slack, DMs, or meetings as the primary channel. Decisions don't exist until written as a ticket comment. Use when making a design decision, changing direction, answering a project question, or proposing a new approach.
version: 0.3.0
last_reviewed: 2026-06-26
---

# Yegor Ticket-as-Conversation

If it isn't in the issue tracker, it didn't happen. Write the comment first; chat is just a courtesy summary of the artifact.

## Triggers
- About to make a design decision
- About to answer a project-specific question
- About to change direction mid-work
- User proposes a new approach informally in chat

## What lives in tickets
- Every question
- Every design decision
- Every blocker
- Every assumption (recorded as a comment)
- Every "won't do because X" (closes the ticket with justification)

## What does NOT live elsewhere as the primary record
- Decisions in Slack/Discord/Telegram: forbidden as primary
- Decisions in meetings: meeting output is N issue comments, otherwise the meeting didn't exist
- Decisions in commit messages: rationale lives in the ticket; the commit references it
- Decisions in your head: especially for solo work — your head is not a database

## Comment hygiene
- Every comment is **addressed** to a specific person via `@`-mention.
- Every comment advocates closing the ticket OR keeping it open until a specific condition.
- "+1" / "agreed" / "thanks" → use reactions, not comments.

## Closing discipline (Five Principles of Bug Tracking)

Two rules govern *when and how* a ticket ends:

- **Keep it one-on-one.** A ticket is a transaction between **one reporter and
  one solver**, not a forum. Others are secondary. Don't let a ticket sprawl into
  a committee thread — if it needs many voices, that's a smell to split or
  escalate, then land the outcome back here.
- **Never close it empty-handed.** Close fast — long-lived tickets waste
  attention — but **never close a ticket without delivering *some* solution**,
  even a temporary or partial one (a workaround, a disable, a "can't reproduce"
  proof test, a follow-up ticket). "Closing with nothing" is forbidden; closing
  with the smallest honest deliverable is the goal.

## Correcting an existing description

A ticket description is an authored artifact. When you find an error in someone else's description — a wrong cross-reference, a stale dependency, an outdated premise — **do not silently rewrite the body.** Redline it instead, so the correction stays additive and auditable like every other decision here:

1. Add a banner at the very top: `> ⚠️ **SEE COMMENTS FOR CORRECTIONS**`.
2. `~~Strike through~~` the wrong/outdated text **in place** — leave it visible, marked as superseded. Never delete it.
3. Post the correction as one or more comments — what was wrong, the right value, and why.

This keeps the original visible (the audit trail), the author's voice intact, and the authoritative fix in the timestamped comment stream — the same "additive, in-the-tracker" discipline as the rest of this skill. The issue's **own owner** doing normal scope/spec edits is unaffected; this targets a *second party* fixing a *factual error*.

## Rules for Claude

**Before answering a design question in chat:**
- Ask: "Should I write this as a comment on issue #N first?"
- Write the comment, then summarize back to the user. The artifact is primary; the chat reply is courtesy.

**When the user changes direction:**
- "Let me write this rationale into the relevant issue first, then we'll continue."

**When the user says "I decided to X":**
- Ask which ticket it lands on. If none, create one or attach as a comment to a related one. Spoken decisions evaporate.

**When reviewing a project:**
- Read the issue tracker first, not the code. The tracker is the project's mind.

## Solo developer ritual
1. **Write the issue before writing the code** — even for 15-minute work.
2. **Comment on the issue when you change your mind:** "Earlier I thought X; now Y because Z."
3. **Close the issue with a one-line outcome:** "Closed by commit abc123 — chose approach Y, see comment above."
4. **End-of-session journal:** comment on the active issue with where you stopped and what's next.

## Pitfalls
- Over-ticketing trivia (typos don't need tickets — threshold is anything that involves a decision or could be questioned later).
- "I'll write it later" — reverse the order: write the comment first, then chat.
- Walls of text in comments — keep each one short and focused (problem → refinement → explanation → solution → close).
- Locking arguments in comment threads — escalate to a synchronous conversation, but the output still lands back in the ticket as a final comment.

## Cross-references
- `yegor-bdd` — tickets are complaints, not chats.
- `yegor-architect` — architect decisions land as ticket comments before any PR opens.
- `yegor-velocity` — if it's not a ticket, it can't be counted.
- `yegor-nohelp` — answers to questions live in docs, but the question itself is a ticket.

## Deep reference

- `research/philosophy_04_tickets_ticket_as_conversation.md`
- `research/philosophy_17_bug_tracking_hygiene.md` (the Five Principles of Bug Tracking, shared with `yegor-bdd`)
