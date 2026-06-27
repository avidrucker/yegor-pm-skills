# Research Pass 03 — plan: `yegor-personas` + strengtheners

> Status: **implemented 2026-06-26.** This is the planning artifact for the third
> research pass over Yegor Bugayenko's blog. Kept in-repo as the durable record of
> what was built and why. The deep references it produced live in
> `research/philosophy_20`–`24`.

## Context

This is the **third** research pass over Yegor Bugayenko's blog for this repo. The
first two passes produced **18 skills** (17 `yegor-*` + the `yegor-pm` meta) and
research docs `philosophy_01`–`19`. This pass had two goals: (1) mine the next
tier of articles to **strengthen existing skills** and patch gaps conservatively,
and (2) build a new **`yegor-personas`** skill — a "council of personas" that
evaluates a hard decision through the strict lens of each relevant `yegor-*` skill
(and Yegor's unstaffed roles PO/REQ/QA/TST), then converges to a recommendation
and names who has authority to break any tie.

Three parallel research agents (two web, one repo) produced the strengthener list,
Yegor's canonical role taxonomy (*Key Roles in a Software Project*, 2016), 17
persona cards, and the house style. User decisions (2026-06-26): defer the
requirements/spec gap and the speculative candidates to IDEAS; fold in **all four**
strengtheners; build `yegor-personas`.

Outcome: **1 new skill**, **4 strengthened skills**, **1 new + 4 enhancement
research docs**, and meta/README/GLOSSARY/IDEAS wiring.

## Part A — New skill: `yegor-personas`

New dir `skills/yegor-personas/` (`SKILL.md` + `VERSION` `0.1.0` + `CHANGELOG.md`)
plus `research/philosophy_20_personas_decision_council.md`.

**Creed:** Hard calls get a council, not a coin flip. Run the decision through the
strict lens of every persona with **standing**, let each give its pickiest
reading, then **converge** to one recommendation and name who breaks any tie.

**Procedure:** (1) state the decision as a one-line fork; (2) **select 3–5 personas
with standing** — never all 17; (3) take each reading in a fixed 3-line format;
(4) sort by **authority, not volume**; (5) converge via the authority ladder;
(6) record the convergence as a ticket artifact.

**Authority ladder (first match decides, then stop):**
1. Requirements are the ultimate boss (spec settles it; silence ⇒ file the gap).
2. Binary gates are unoverrideable (merge-gate / red build is not a council vote).
3. Objective measures decide themselves (pdd scan, ≤60m budget, spike, velocity).
4. The reporter owns their ticket (label/scope/closure — `yegor-bdd`).
5. The architect breaks technical ties (decides in writing, need not convince).
6. No compromise — name the concession (state the open conflict + who decides).
Invariants: role separation (a persona with a stake is advisory only); standing
beats volume.

**Unstaffed role-voices** Claude may seat: REQ (in the spec?), PO (in scope /
approved?), QA (process followed / artifacts present?), TST (what's the repro?).

**philosophy_20** anchor walkthrough: the contract-vs-code "is this a bug?" label
dispute → converge to "file it, NOT as a bug; frame as a CONTRACT-vs-code parity
divergence, runtime impact marked masked, prescribe neither." Sources: *Key Roles
in a Software Project* (2016), *What if the Architect is Wrong?* (2019), *Four NOs
of a Serious Code Reviewer* (2015).

## Part B — Strengthen 4 existing skills

1. **`yegor-architect` → 0.2.0** — authority layer: *requirements are the ultimate
   boss*, the *two instruments* (bugs + reviews), *what if the architect is wrong*
   (more eyes at lower risk tolerance). Sources: *Who Is an Architect?* (2014),
   *Two Instruments of a Software Architect* (2015), *What if the Architect is
   Wrong?* (2019). Deep ref `philosophy_21_architect_authority.md`.
2. **`yegor-nohelp` → 0.2.0** — doc-structure discipline: short, ordered docs
   (README ≤~2pp, no duplication of generated content), **measurable** quality
   requirements. Sources: *Elegant READMEs* (2019), *How We Write a Product Vision*
   (2014). Deep ref `philosophy_22_doc_structure.md`.
3. **`yegor-bdd` → 0.4.0** — report richness beyond the title: reproducible, rich
   (expected vs actual + environment), visible reporter effort. Source: *The Right
   Way to Report a Bug* (2018). Deep ref `philosophy_23_bug_report_richness.md`.
4. **`yegor-builds` → 0.2.0** — trust-based dependency versioning: fixed pins for
   low-trust deps, dynamic/range for trusted, record the rationale. Source: *My
   Recipe Against Dependency Hell* (2019). Deep ref
   `philosophy_24_dependency_trust.md`.

## Part C — Wire-up

- `skills/yegor-pm/SKILL.md` → **0.6.0**: register `yegor-personas` (17
  sub-skills) — frontmatter, table, routing row, stack-ranking, deep-reference
  rows for philosophy_20–24.
- `README.md`: "Seventeen" → "Eighteen"; add the row; extend both install loops +
  the `/yegor-*` list.
- `GLOSSARY.md`: new `## Decision council — yegor-personas` section (council,
  standing, authority ladder, convergence, REQ/PO/QA/TST) + inline terms for the
  four strengtheners.
- `skills/yegor-pm/IDEAS.md`: **I-007** (requirements/spec gap, deferred) and
  **I-008** (speculative/stack-coupled candidates declined: LLM interpretability
  gate, 9-step refactor, management/comp pieces).

## Verification

- `ls -d skills/yegor-* | wc -l` → **18**.
- Each skill's `VERSION` == top `CHANGELOG.md` `[x.y.z]`.
- `research/philosophy_2[0-4]*.md` present; zero broken `philosophy_NN` links.
- No stale counts in README/GLOSSARY/`yegor-pm`.
