---
name: yegor-bdd
description: Apply Bug Driven Development. Frame every piece of work as a complaint with shape "have X / should have Y / repro". No feature requests, no suggestions, no questions. Use when filing, reviewing, or closing issues. Only the reporter closes a ticket.
version: 0.1.0
last_reviewed: 2026-05-23
---

# Yegor Bug Driven Development

Every piece of work is a complaint with shape "have X / should have Y / repro." No requests, no suggestions, no questions. Reporter closes.

## Triggers
- About to file a new issue
- Reviewing the shape of an existing issue
- About to close an issue
- User describes new work informally in chat

## The complaint shape
1. **Title** names what is broken, not what is wanted.
2. **Have**: current state.
3. **Should have**: desired state.
4. **Repro**: steps from a clean state to the broken behavior (when applicable).

## Title rewrites

| Vague request | Complaint |
|---|---|
| "Add settings menu" | "Settings are inaccessible from the main UI" |
| "Improve date parsing" | "Date parser fails on ISO inputs with milliseconds" |
| "Write Windows install docs" | "Windows installation is undocumented" |

## Rules for Claude

**Before working on a ticket:**
- Check its shape. If it isn't a complaint, propose a rewrite. Update title/body before coding.
- Out loud: "Sounds like the complaint is: X currently does Y, but should do Z. Confirm?"

**Comment hygiene:**
- Every comment is `@`-mentioned to a specific person.
- Every comment either advocates closing the ticket or keeping it open until a specific condition.
- "+1", "agreed", "thanks" → use reactions, not comments.

**Closure:**
- Only the reporter closes. The solver finishes, asks the reporter to verify, the reporter closes.
- Exceptions: obvious duplicates, direct-answer questions, intentional "won't fix" decisions with a documented reason.
- For solo work: switch hats deliberately. Write the complaint as reporter; deliver as solver; verify as reporter at closure.

## Pitfalls
- Faux complaints: "It's bad that we don't have feature X" is a request in disguise. A real complaint names a concrete current behavior that is wrong, not the absence of something hypothetical.
- Stacked complaints: one ticket = one complaint. Don't pack multiple unrelated complaints together.
- Adversarial tone: "complaint" is structural, not emotional. Language stays neutral and specific.
- Over-application: pure exploratory research / spikes may not fit. Use a separate channel and convert outputs to complaints afterward.

## Cross-references
- `yegor-tickets` — complaints live in the issue tracker, not in chat.
- `yegor-velocity` — closure (by reporter) is the unit that counts.
- `yegor-microtasks` — each complaint must be ≤60min to resolve.

## Deep reference

`research/philosophy_02_bdd_bug_driven_development.md`
