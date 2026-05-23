# Philosophy 02 — Bug Driven Development (BDD)

> **Why this doc exists:** distill Yegor's BDD into actionable rules. Reframe every piece of work as a *complaint* so the ticket forces precision and demands a code patch, not a discussion.
>
> **Primary sources:**
> - Yegor Bugayenko, *Stop Asking and Suggesting — Just Complain* (2025-05-25) — https://www.yegor256.com/2025/05/25/bug-driven-development.html
> - Yegor Bugayenko, *Five Principles of Bug Tracking* (2014-11-24) — https://www.yegor256.com/2014/11/24/principles-of-bug-tracking.html
> - Yegor Bugayenko, *Let the Bug Reporter Have the Last Word* (2025-04-24) — https://www.yegor256.com/2025/04/24/dont-close-their-tickets.html

---

## The principle (paraphrased)

Every piece of work — bug, feature, refactor, doc update, build fix — is filed as a *complaint* about the current state of the system. There are no feature requests, no "wouldn't it be nice", no exploratory questions. There are only bugs.

Yegor's framing (2025): the aggressive nature of a complaint forces the submitter to justify why the current state is *wrong*, and forces the resolver to produce a *code patch* rather than an explanation. Both sides have to be concrete.

This is a direct continuation of the XDSD principle "communication via tickets, not meetings" — but sharpened. Now the ticket itself has a required *shape*.

## Why it works

- **Kills vague tickets.** A "request" can be wishy-washy. A complaint must name what's broken. Tickets that can't articulate a complaint are noise and should be rejected.
- **Forces deliverable form.** "Could we discuss X?" produces conversations. "X returns wrong output when Y" produces a patch.
- **Aligns with user-pain framing.** The reporter is essentially playing the user role: "this is wrong from my perspective." This dovetails neatly with UX practice.
- **Reduces ticket entropy.** One format → easier triage, easier search, easier metrics.

## Canonical complaint shape

Every ticket must have:

1. **A title that names what is broken** — not what the reporter wants.
2. **The "have" line** — what the current state is.
3. **The "should-have" line** — what it should be instead.
4. **Repro steps (when applicable)** — exact path from clean state to the broken behavior.

Example titles (good):

- "Settings dialog is unreachable from the editor toolbar"
- "Date parser drops timezone when input has fractional seconds"
- "README does not explain how to install on Windows"

Example titles (bad — rewrite before working):

- "Add settings menu" → rewrite: "Settings are inaccessible from the main UI"
- "Improve date parsing" → rewrite: "Date parser fails on ISO inputs with milliseconds"
- "Write Windows install docs" → rewrite: "Windows installation is undocumented"

## Actionable guidelines

### Five rules of bug tracking (Yegor, 2014)

1. **Keep it one-on-one.** Each ticket has exactly two primary roles: the reporter (defends the problem's validity) and the solver (defends the solution's quality). Others may comment but bear no responsibility.
2. **Close it.** Long-running tickets are a tracking nightmare. Prefer a partial fix + close over a perfect fix + lingering open ticket.
3. **Don't close it (without delivering something).** Even a doc note explaining "won't fix because X" counts as a deliverable. Empty closure wastes the investment.
4. **Avoid noise.** Comments must be addressed to a specific person (via @-mention) and must advocate either closing or keeping open. Generic opinions are forbidden.
5. **Report reproducibly.** "Have X, should have Y, here's how to repro" is the universal format.

### Closure rule (Yegor, 2025)

- **Only the reporter closes the ticket.** The solver finishes the work and asks the reporter to verify. The reporter closes when satisfied.
- Exceptions: obvious duplicates, questions answered directly, intentional "won't fix" decisions can be closed by anyone with justification.
- Rationale: closing without the reporter's blessing is disrespectful, kills future reporting, and leads to duplicate tickets.

### How Claude should use this when helping

- **Before working a ticket, check its shape.** If it's not a complaint, propose a rewrite. If the user agrees, update the title/body first.
- **When the user describes new work in chat,** translate it into a complaint *out loud* before opening anything: "Sounds like the complaint is: X currently does Y, but should do Z. Confirm?"
- **When closing,** check who reported. If the reporter is a human and Claude is the solver, do not auto-close — leave it ready-for-review and mention the reporter.
- **For solo developers:** the reporter and solver are the same person, but the *roles* still apply. Switch hats deliberately. Write the complaint as reporter; deliver as solver; verify as reporter again at closure.

## Pitfalls

- **Faux complaints.** "It's bad that we don't have feature X" is just a request in disguise. A real complaint must name a concrete current behavior that is wrong, not the absence of something hypothetical.
- **Stacked complaints.** Don't pack five unrelated complaints into one ticket. One ticket = one complaint.
- **Adversarial tone.** "Complaint" is structural, not emotional. Keep the language neutral and specific.
- **Over-application.** Pure exploratory research / brainstorming may not fit BDD. For those, use a separate "spike" channel and convert outputs to complaints afterward.

## One-line summary for Claude

> Every piece of work is a complaint with shape "have X / should have Y / repro" — no requests, no suggestions, no questions. Reporter closes.
