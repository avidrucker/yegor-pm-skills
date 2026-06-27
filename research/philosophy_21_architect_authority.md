# Philosophy 21 — The Architect's Authority (Bounded)

> **Why this doc exists:** the `yegor-architect` skill establishes architect-vs-
> courier mode separation; this doc adds the *authority* layer — what the
> architect's authority actually is, where its boundary lies, how it's enforced,
> and what happens when the architect is wrong. It supplies the tie-breaker rungs
> the `yegor-personas` council depends on (architect = rung 5; requirements =
> rung 1). Translated for solo + AI work, where Claude must enforce the boundary
> against itself.
>
> **Primary sources:**
> - Yegor Bugayenko, *Who Is an Architect?* (2014-10-12) — https://www.yegor256.com/2014/10/12/who-is-software-architect.html
> - Yegor Bugayenko, *Two Instruments of a Software Architect* (2015-05-13) — https://www.yegor256.com/2015/05/13/two-instruments-of-software-architect.html
> - Yegor Bugayenko, *What if the Architect is Wrong?* (2019-01-15) — https://www.yegor256.com/2019/01/15/what-if-architect-is-wrong.html

---

## The principle (paraphrased)

The architect has the final say on *how* a system is built and is personally
accountable for its technical quality (blame, not credit). But that authority is
**bounded**, and the boundary is what makes it trustworthy rather than tyrannical:

1. **Requirements are the architect's only boss.** The architect owns the *how*;
   the *what* belongs to the requirements/spec. A design decision is justified by
   pointing at the requirement that demands it — not by rank. When the spec is
   silent, the architect's job is to **amend the requirements** so the rule is
   documented, not to win an argument from authority.
2. **Two instruments, and only two.** The architect enforces design through exactly
   two tools: **filing bugs** (proactive — "should do X, does Y") and **doing code
   reviews** (reactive — rejecting divergence). Not meetings, not DMs. A rule that
   can't be a bug or a review comment isn't enforceable; make it a requirement.
3. **Eyes in proportion to risk.** The architect can be wrong. The safeguard isn't a
   committee vote — it's adding **independent reviewers** in proportion to the
   project's risk tolerance. High-stakes calls get more eyes before they're acted
   on; low-stakes ones don't.

## Why it works

- **Arguing from the spec, not from rank, removes "responsibility leakage."** If the
  architect had to *persuade* everyone, no one would own the decision. Deciding
  unilaterally — but justifying via requirements — keeps ownership crisp and the
  rationale auditable.
- **Two instruments keep enforcement visible and async.** Bugs and review comments
  live in the tracker (philosophy_04); they're durable, attributable, and don't
  require a meeting. Enforcement that lives in conversation evaporates.
- **Risk-scaled review beats both extremes.** "Architect is always right" is brittle;
  "decide everything by committee" is slow and mushy. Scaling the number of
  reviewers to the stakes spends scrutiny where it pays off.

## Canonical rules

- **Requirements are the only boss** — justify designs from the spec; amend the spec
  rather than argue from authority.
- **Enforce through bugs and reviews only** — if it can't be a bug or a review
  comment, make it a requirement.
- **Scale reviewers to risk** — more independent eyes for higher-stakes decisions;
  resolve disputes by amending requirements or adding reviewers, never by committee
  override.
- **Decide without persuading, but own the outcome** — unilateral call, total
  accountability (blame, not credit).

## Translating for solo + AI work

Solo, the architect, courier, and reviewer are all Claude — so the boundary must be
enforced *against itself*:

- **When Claude (architect-hat) makes a design call, it cites the requirement** — or
  writes the requirement down — rather than asserting "this is the right design."
  An undocumented design preference is a smell.
- **Enforcement is a filed bug or a review comment**, not a claim in chat. If Claude
  wants a design rule respected, it expresses it as one of the two instruments.
- **Higher-stakes call ⇒ ask for more eyes.** For a risky design decision, route it
  to an independent review pass (`/code-review`, a second agent) before acting —
  the solo form of "eyes in proportion to risk."
- **As a `yegor-personas` tie-breaker:** the architect-hat breaks design/technical
  ties (rung 5) and the requirements settle scope ties (rung 1). Claude must keep
  these straight even while holding every role.

## Actionable guidelines

### How Claude should use this

- **When a design call is challenged:** don't defend it from authority — point at the
  requirement, or propose amending the spec. "The contract says X" ends it; "I'm the
  architect" doesn't.
- **When enforcing a design rule:** file it as a bug or raise it in review; if it
  fits neither, write it into the requirements.
- **When the stakes are high:** ask for a second independent review before the
  decision is acted on.

## Pitfalls

- **Authority cosplay** — "because I designed it" instead of "because the spec
  requires it."
- **Verbal enforcement** — a design rule that lives in chat, enforceable by neither
  bug nor review.
- **Committee override** — resolving an architect dispute by vote instead of by
  amended requirements or more reviewers.
- **Infallibility** — treating the architect's call as unquestionable; the safeguard
  is more eyes, scaled to risk.

## Integration with the other philosophies

- + [Architect / Courier](./philosophy_05_architect_then_courier.md): mode
  separation is the *when*; this doc is the *authority*.
- + [Tickets](./philosophy_04_tickets_ticket_as_conversation.md): the two
  instruments and amended requirements all live in the tracker.
- + [Review](./philosophy_08_review_serious_code_reviewer.md): review is one of the
  two instruments; the architect is the review tie-breaker.
- + [Personas](./philosophy_20_personas_decision_council.md): supplies the council's
  rung-1 (requirements) and rung-5 (architect) authorities.

## One-line summary for Claude

> The architect decides *how* and owns the outcome, but the architect's only boss is
> the requirements — justify designs from the spec (or amend it), enforce only
> through filed bugs and code reviews, and when the call is risky or contested add
> independent reviewers in proportion to the risk. Never argue from rank; never
> override by committee.
