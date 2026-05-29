---
name: yegor-bdd
description: Apply Bug Driven Development. Frame every piece of work as a complaint with shape "have X / should have Y / repro". No feature requests, no suggestions, no questions. The complaint is best expressed as a failing/disabled test that proves the bug. Use when filing, reviewing, or closing issues. Only the reporter closes a ticket.
version: 0.2.0
last_reviewed: 2026-05-28
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

## Test-as-proof (the complaint as code)

The strongest form of a complaint is a **test that fails on the current code**. It is precise, unambiguous, and doubles as the regression guard once fixed.

- **Report a bug as a failing or disabled test**, not (only) prose. A `@Disabled`/`it.skip` test annotated with the issue number is a machine-checkable complaint anyone can run.
- **No code PR without a proving test.** A fix's PR must include a test that *fails against the old code* and passes against the new. A test that would have passed before the change proves nothing (see `yegor-unit-tests` → the Liar).
- **Code and tests in separate PRs.** First PR: add/enable the test (which fails or is disabled). Second PR: change the code to make it pass and remove the `disabled` marker, without touching the test. This proves the requirement wasn't bent to fit the implementation.
- **Solo flow:** as reporter, write the failing/disabled test. As solver, make it green in a separate change. As reporter, verify it's genuinely the test that drove the fix before closing.

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
- `yegor-unit-tests` — the proving test must be a real test (able to fail), not a Liar.
- `yegor-review` — a runtime-only bug found in review becomes a disabled-test complaint.

## Deep reference

`research/philosophy_02_bdd_bug_driven_development.md`
