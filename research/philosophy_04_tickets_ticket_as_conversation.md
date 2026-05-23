# Philosophy 04 — The Ticket is the Conversation (NoMeetings)

> **Why this doc exists:** capture the XDSD rule that no decision exists until it lives in the issue tracker, and translate it into actionable rules Claude can follow.
>
> **Primary sources:**
> - Yegor Bugayenko, *Stop Chatting, Start Coding* (2014-10-07) — https://www.yegor256.com/2014/10/07/stop-chatting-start-coding.html
> - Yegor Bugayenko, *How XDSD Is Different* (2014-04-17) — https://www.yegor256.com/2014/04/17/how-xdsd-is-different.html
> - Yegor Bugayenko, *Five Principles of Bug Tracking* (2014-11-24) — https://www.yegor256.com/2014/11/24/principles-of-bug-tracking.html
> - Talk: *eXtremely Distributed Software Development* (DevTernity 2016), takeaway @ 23:13

---

## The principle (paraphrased)

All meaningful project communication happens inside tickets — typically GitHub Issues. No Slack DMs, no emails, no Zoom calls, no hallway conversations, no "quick syncs." If a decision was made outside a ticket, it didn't happen: there's no traceability, no future reader can reconstruct it, no payment / closure can attach to it.

Yegor's framing (2014): "every hour spent by a team member is traceable to the line of code they produced." The ticket is the unit of traceability.

## Why it works

- **Decisions become artifacts.** Future-you (or future-anyone) can reconstruct *why* a choice was made by reading the ticket. Chat history rots and disappears.
- **Async by default.** Tickets don't require simultaneous presence. Distributed/solo work doesn't fight calendars.
- **Single source of truth.** No more "I think we agreed in Slack last week" disputes.
- **Forces precision.** A spoken question can be vague. A written ticket question must be specific enough to read in isolation.
- **Onboards future-you.** A solo developer returning to a project after months reads the issue tracker and is fully oriented.

## Canonical rules

### What goes in a ticket

- Every question → ticket
- Every design decision → comment on the relevant ticket
- Every blocker → ticket
- Every assumption → comment on the relevant ticket
- Every "won't do because X" → comment with justification, then close

### What does NOT go elsewhere

- Decisions in Slack/Discord/Telegram: forbidden. If a decision starts forming in chat, the next message must be "let's capture this in #issue-N."
- Decisions in meetings: forbidden. If you meet, the meeting output is N issue comments, otherwise the meeting didn't exist.
- Decisions in commit messages: forbidden as the *primary* channel. A commit can reference a ticket but the rationale lives in the ticket.
- Decisions in the developer's head: forbidden. Especially for solo work — your head is not a database.

### Comment hygiene (from *Five Principles of Bug Tracking*)

- Every comment is **addressed** to a specific person via `@`-mention. No undirected musing.
- Every comment either advocates *closing* the ticket or advocates *keeping it open* until a specific condition is met. Comments that do neither are noise.
- "I agree" / "thanks" / "+1" without action recommendation = noise. Use reactions instead.

## Actionable guidelines

### How Claude should use this when helping

- **Before answering a design question in conversation,** ask: "Should I write this as a comment on issue #N first?" If the user agrees, write the comment, then summarize back to them. The artifact is primary; the chat reply is a courtesy summary.
- **When the user proposes a change of direction,** insist on the ticket comment first: "Let me write this rationale into the relevant issue, then we'll continue."
- **When the user says "I decided to X",** ask which ticket it lands on. If none, create one or attach as a comment to a related one. Spoken decisions evaporate.
- **When reviewing a project's state,** read the issue tracker first, not the code. The tracker is the project's mind.
- **When a project lacks tickets,** suggest that even the smallest piece of work be filed before starting. The discipline matters more than the tool.

### For a solo developer

The discipline is *harder* solo because there's no one to enforce it. Rules that help:

1. **Write the issue before writing the code.** Even for 15-minute work.
2. **Comment on the issue when you change your mind.** "Earlier I thought X; now I think Y because Z." That comment is your future-self's lifeline.
3. **Close the issue with a one-line outcome.** "Closed by commit abc123 — chose approach Y, see comment above."
4. **Use the tracker as a journal.** End-of-session, comment on the active issue with where you stopped and what's next.

## Pitfalls

- **Over-ticketing trivia.** "Fix typo" doesn't need a ticket. The threshold is: anything that involves a decision or could be questioned later.
- **The "I'll write it later" lie.** If you say it in chat first and intend to capture it later, you won't. Reverse the order — write the comment first, then summarize in chat.
- **Walls of text.** Each comment should be short and focused (Yegor: ticket lifecycle is "problem → refinement → explanation → solution → close"). Long essays in tickets are anti-pattern.
- **Locking arguments in comments.** A long back-and-forth thread is a smell — escalate to a synchronous conversation, but the *output* still has to land back in the ticket as a final comment.

## Integration with the other philosophies

- + [BDD](./philosophy_02_bdd_bug_driven_development.md): tickets are *complaints*, not chats.
- + [Architect-then-courier](./philosophy_05_architect_then_courier.md): architecture decisions land as ticket comments before any PR opens.
- + [Velocity = closed tickets](./philosophy_06_velocity_closed_tickets.md): if it's not a ticket, it can't be counted.

## One-line summary for Claude

> If it isn't in the issue tracker, it didn't happen. Write the comment first; chat is just a courtesy summary of the artifact.
