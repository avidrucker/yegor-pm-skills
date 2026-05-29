# Philosophy 08 — Serious Code Review

> **Why this doc exists:** distill Yegor's code-review doctrine into actionable rules. The reviewer exists to *reject* bad code, carrying the burden of proof, while staying objective and impersonal.
>
> **Primary sources:**
> - Yegor Bugayenko, *Four NOs of a Serious Code Reviewer* (2015-02-09) — https://www.yegor256.com/2015/02/09/serious-code-reviewer.html
> - Yegor Bugayenko, *Does Code Review Involve Testing?* (2019-12-03) — https://www.yegor256.com/2019/12/03/testing-in-code-review.html
> - Yegor Bugayenko, *You Do Need Independent Technical Reviews!* (2014-12-18) — https://www.yegor256.com/2014/12/18/independent-technical-reviews.html
> - Yegor Bugayenko, *Software Project Review Checklist* (2019-04-02) — https://www.yegor256.com/2019/04/02/software-project-review-checklist.html

---

## The principle (paraphrased)

A code review is an adversarial quality gate, not a courtesy. The reviewer's
job is to *find what is wrong and reject it* — and the burden of proof runs
toward the reviewer: it is your job to prove the code is bad, not the author's
job to prove it is good. Loyalty belongs to the project and its sponsor, not to
the author's feelings or the release schedule.

## The Four NOs

1. **No Fear.** Fear of offending the author, of delaying the release, or of
   exposing your own knowledge gaps all corrupt the review. The sponsor pays
   for high-quality software, not workplace harmony. Reject bad code even when
   it's uncomfortable.
2. **No Compromise.** Compromise — both sides accepting something suboptimal to
   end the argument — is the worst outcome. There are only three legitimate
   exits: (a) you are genuinely persuaded and fully reverse your position, (b)
   you stand firm ("I will never accept this, period"), or (c) the software
   architect makes the final call. Never meet halfway.
3. **No Bullshit.** Support every criticism with evidence — a link, an article,
   a benchmark, a book, an example. Appeals to authority ("15 years of Java")
   don't count. If you can't produce convincing proof, reconsider whether
   you're the one who's wrong.
4. **No Offense.** Stay professional regardless of how poor the work or how
   difficult the author. Criticize the code — style, design, structure —
   systematically, never the person.

## Scope: the three most critical problems

A good reviewer finds the problematic lines, explains the problem, and proposes
a solution — focusing on the *three most critical* problems and driving each to
resolution (fixed, or correctly argued away). Drowning a review in dozens of
nits buries the findings that matter. Style nits belong to the linter; the
human reviews design and structure.

## Reviewers don't run the code

The reviewer is a stage in the automated merge pipeline — a visual inspector
alongside the linter and the test suite — not a manual QA step. Checking out
the branch and running it locally is slow, doesn't scale, and produces findings
that are hard to express as review comments. The sharp corollary: **if a bug
can only be found by executing the code, the bug is in the test suite, not in
the review process.** The correct response is to file the missing test as a
separate ticket and strengthen the pipeline, not to hand-QA every PR.

## Two layers: peer review vs. independent review

- **Daily peer review** catches functional bugs and local quality issues within
  the team's existing frame of reference.
- **Independent review** — an outsider, unfamiliar with the team, paid to give
  an objective opinion — catches the architectural blind spots the team can't
  see precisely *because* it is invested in its own code. Objectivity has a
  half-life: re-hire the same reviewer repeatedly and they become psychologically
  engaged with the codebase and start hiding problems instead of exposing them.
  Start independent reviews early, pay well, and systematically track how each
  concern is resolved.

The two are complementary, not substitutes.

## The project review checklist (what an independent reviewer scores)

- **Pipeline:** Is the master branch read-only? Is the delivery pipeline strong
  enough to reject mistakes? Is static analysis mandatory for new changes? Are
  CI reports actually acted on?
- **Releases:** Documented, automated, working — happening at least weekly?
- **Code quality:** How many anti-patterns? Do key classes/methods carry in-code
  docs? How big and how visible is the technical debt?
- **Tests:** Coverage exists and is visible?
- **Tracking:** Every bug and feature is a ticket? Clean, documented Git history?
  Repo garbage-free? Repo under the customer's ownership?
- **Decisions:** Are key architectural decisions documented (e.g. ADRs)?

## How Claude should use this when helping

- **Default to rejection.** Review asking "what's wrong," not "looks fine." A
  no-findings approval on a non-trivial diff usually means the review didn't
  happen.
- **Cap at the three biggest problems**, each with problem + evidence + fix.
- **Don't manually run branches** to find bugs — when a runtime-only defect
  surfaces, recommend a regression test and file it.
- **Be the objective outsider.** As an agent with no loyalty to the code, Claude
  is well-placed to play the independent-review role (`/code-review`).
- **Never compromise** in a disagreement — resolve, stand firm, or defer to the
  architect.

## One-line summary for Claude

> The reviewer's job is to reject bad code, with the burden of proof on the
> reviewer: Four NOs (fear, compromise, bullshit, offense), the 3 most critical
> problems each driven to resolution, and never run the code — a runtime-only
> bug is a missing test.
