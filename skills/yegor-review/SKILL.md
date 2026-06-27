---
name: yegor-review
description: Code-review discipline from Yegor Bugayenko. The reviewer's job is to REJECT, not to bless — burden of proof is on the reviewer. Apply the Four NOs (no fear, no compromise, no bullshit, no offense), find the 3 most critical problems, never run the code (a runtime-only bug is a missing test, file it), and auto-reject any PR that changes production code but ships no test. Use when reviewing a PR/diff, giving or receiving review feedback, or deciding how to respond to a review.
version: 0.2.0
last_reviewed: 2026-06-26
---

# Yegor Code Review

A reviewer's job is to **reject bad code**, not to confirm good code. The burden of proof is on the reviewer: it's your job to prove the code is bad, not the author's job to prove it's good.

## Triggers
- About to review a PR or a diff
- Writing or replying to review comments
- A review is stuck in a back-and-forth disagreement
- Deciding whether to run/QA a branch as part of review
- Receiving review feedback and deciding how to respond

## The Four NOs

1. **No Fear.** Loyalty is to the project and its sponsor, not to the author's feelings or the release date. Don't stay silent to avoid friction or to hide that you don't fully understand the code. Rejecting bad code is the job.
2. **No Compromise.** Never split the difference — a half-accepted bad solution is the worst outcome. Only three legitimate exits from a disagreement: (a) the author convinces you and you *fully* reverse, (b) you stand firm ("I will never accept this"), or (c) the architect rules. Never meet halfway.
3. **No Bullshit.** Back every criticism with evidence — a link, an article, a benchmark, an example. "I've done this 15 years" is not an argument. If you can't prove it's bad, reconsider whether it actually is.
4. **No Offense.** Attack the code (style, design, structure), never the person. Stay professional even when the work is plainly poor.

## Core rules

- **Reject by default.** Approach each change asking "what's wrong here," not "looks fine." An LGTM with zero findings on a non-trivial change usually means you didn't review.
- **Find the 3 most critical problems.** Explain each, and ensure each is either fixed or correctly argued away. Don't bury signal under 40 nits.
- **Don't run the code.** The reviewer is a *visual inspector* in the pipeline, alongside the linter and the test suite — not a manual QA stage. Running branches locally is slow and doesn't scale.
- **A runtime-only bug is a missing test.** If a defect can only be found by executing the code, the real bug is in the test suite. File the missing test as a separate ticket; don't hand-QA every PR.
- **Style belongs to the linter.** Humans review design, naming, and structure — not whitespace. If a style point isn't automated, that's a tooling ticket.
- **A PR without a test is a waste — reject it.** A change that touches production code but adds or changes **zero tests** fails review on sight, regardless of how good the code looks. Tests protect the employer's *investment* in working code — untested code is the first to break on the next refactor, so contributing it without a test quietly wastes the very value it adds. This is a binary, diff-checkable gate: prod files changed, test files untouched → reject. (The one honest exception is a change that is *only* tests, docs, or config.)

## Comment hygiene

Every review comment is `problem + evidence + suggested fix`. "I don't like this" is noise. "This allocates on every call — see <link>; cache it like X" is a review. Use reactions, not comments, for "+1/agreed/thanks".

## Two layers of review

- **Per-PR peer review** catches functional and local-quality issues within the team's frame.
- **Independent review** (an outsider with no investment in the code) catches the architectural blind spots the team can't see — objectivity has a half-life; a reviewer re-used on the same codebase becomes engaged and starts hiding problems. Buy a fresh outside review periodically; start early; track how each concern resolves.

## For solo / AI-augmented work
- An agent review (e.g. `/code-review`) is the closest thing to Yegor's "objective outsider" — it has no loyalty to the code. Use it for the independent layer.
- The pipeline (hooks + CI strong enough to *reject* mistakes) is the non-human safety net; keep the human/agent focused on design.

## Pitfalls
- **Blessing instead of rejecting.** Defaulting to approval defeats the purpose.
- **Nit-flooding.** 40 style comments hide the 3 that matter.
- **Manual QA creep.** Running the branch instead of strengthening tests doesn't scale and produces findings that are hard to express as comments.
- **Compromise.** "Let's just half-do it" degrades quality — resolve, stand firm, or escalate.
- **Blessing a testless PR.** Approving a production change because "the code looks right" when it ships no test — the binary gate exists precisely to catch this.

## Cross-references
- `yegor-architect` — the architect is the tie-breaker when a review deadlocks (Four NOs #2c).
- `yegor-unit-tests` — what "the test suite should have caught it" means in practice.
- `yegor-bdd` — a runtime-only bug becomes a complaint (a failing/disabled test) in the tracker.
- `yegor-tickets` — review decisions live in the PR/issue, not in chat.

## Deep reference
`research/philosophy_08_review_serious_code_reviewer.md`
