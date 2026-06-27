---
name: yegor-pm
description: Project management and engineering-discipline skill set distilled from Yegor Bugayenko's XDSD methodology. Meta-orchestrator for 17 sub-skills (yegor-pdd, yegor-spikes, yegor-bdd, yegor-microtasks, yegor-tickets, yegor-architect, yegor-velocity, yegor-projections, yegor-nohelp, yegor-review, yegor-unit-tests, yegor-stuck, yegor-merge-gate, yegor-builds, yegor-simba, yegor-small-repos, yegor-personas). Triggers when planning work, breaking down tasks, managing issues, forecasting timelines, reviewing progress/code, writing tests, setting up CI/builds, handling blockers, capping work-in-progress, gating merges, deciding repo boundaries, evaluating a hard decision through multiple role lenses, or deciding on workflow approach.
version: 0.6.0
last_reviewed: 2026-06-26
---

# Yegor Project Management — Meta Skill

Coordinated set of skills based on Yegor Bugayenko's eXtremely Distributed Software Development (XDSD), adapted for solo and AI-augmented work.

> **Stack-agnostic.** This skill family has no language or build-tool coupling — it works for Python/pytest, Node/npm, Clojure, or any stack. Its only external dependencies are an issue tracker (`gh`/GitHub assumed; any tracker works conceptually) and, for `yegor-pdd`, the `pdd` gem — which scans source in any language. Examples below happen to use `gh`; substitute your tracker as needed.

## The 17 sub-skills

| Skill | One-liner |
|---|---|
| `yegor-pdd` | Every deferred sub-problem becomes a `@todo #N:Mm` puzzle comment at the code site. |
| `yegor-spikes` | When scope or code site is unknown, run a ≤60min research spike first to produce the inputs a puzzle needs. |
| `yegor-bdd` | Every piece of work is a complaint (have X / should have Y / repro), best expressed as a failing test. Reporter closes. Title must name the breakage. |
| `yegor-microtasks` | Cap every task at ~60min (default 30). Overrun → split into puzzles. |
| `yegor-tickets` | If it isn't in the tracker, it didn't happen. Write the comment before the chat reply. |
| `yegor-architect` | Separate architect mode (design in writing) from courier mode (execute agreed design). |
| `yegor-velocity` | Velocity = closed tickets/week. Not commits, not hours, not LOC. Supplemented by a multi-metric scorecard. |
| `yegor-projections` | Forecast from measured velocity (open ÷ close-rate, with an as-of date) — never a spec-derived promise. |
| `yegor-nohelp` | Push every reusable answer into the repo's docs. `NOTES.md` is the minimum. |
| `yegor-review` | The reviewer's job is to reject, not bless. Four NOs, 3 critical problems, never run the code. A testless PR is auto-reject. |
| `yegor-unit-tests` | Tests are first-class code that must be able to fail. Anti-pattern catalog + fakes over mocks + tests-first two-PR flow. |
| `yegor-stuck` | When blocked, reveal it — don't grind or fake green. Cheapest honest rung; never cut unit tests; stale work gets dropped. |
| `yegor-merge-gate` | Trunk is read-only; never bless your own merge. An impartial, zero-tolerance gate proves green. Never merge into a broken master. |
| `yegor-builds` | Tiered builds: Fast (local, seconds, unit) → Cheap (PR) → Preflight (gate) → Proper (release). Speed early, thoroughness late. |
| `yegor-simba` | Cap work-in-progress; every status claim links to a verifiable artifact. The reviewer reports completion, not the owner. |
| `yegor-small-repos` | One repo, one purpose, ~50k LOC, one language — small enough to fit one mind and an agent's context window. |
| `yegor-personas` | Council-of-personas decision evaluator: run a hard call through the relevant skills' strict lenses, then converge via an authority ladder. |

## When to invoke which sub-skill

| Situation | Load |
|---|---|
| Planning / scoping new work | `yegor-architect`, `yegor-microtasks` |
| Issue is large/fuzzy with unknown code site | `yegor-spikes` (scope first, puzzle later) |
| Writing code with stubs or deferrals | `yegor-pdd` |
| Filing or reviewing an issue | `yegor-bdd`, `yegor-tickets` |
| Reviewing a PR / diff / someone's code | `yegor-review` |
| Writing, reviewing, or refactoring tests | `yegor-unit-tests` |
| Reviewing project progress | `yegor-velocity`, `yegor-tickets` |
| Asked "how long will this take?" / forecasting a roadmap | `yegor-projections` (project from the measured rate, not the spec) |
| Answering a project-specific question | `yegor-nohelp` (check docs first) |
| Setting up / fixing CI, or a test loop is too slow | `yegor-builds` (tier the builds; fast loop, slow gate) |
| Work is sprawling, or a status claim has no evidence | `yegor-simba` (cap WIP; back every claim with an artifact) |
| Deciding repo boundaries / a repo is sprawling across concerns | `yegor-small-repos` (one repo, one purpose, ~50k LOC) |
| Tempted to redesign mid-implementation | `yegor-architect` (stop, drop a puzzle, switch modes) |
| User describes work informally | `yegor-bdd` (reshape into a complaint) |
| Blocked, thrashing, tempted to hack/fake a fix, or a ticket's gone stale | `yegor-stuck` (reveal it; cheapest honest rung; drop stale work) |
| About to merge / declare your own work done / CI is red | `yegor-merge-gate` (impartial zero-tolerance gate, never self-bless, never merge on red) |
| A non-trivial decision with competing defensible answers / a label or scope dispute / "what would the personas say?" | `yegor-personas` (convene the council; converge via the authority ladder) |

## Epic handling pipeline

There is no `@epic` annotation in PDD. Large features are handled by this pipeline:

```
Large/fuzzy GH issue
       │
       ▼
  yegor-spikes ─── run a ≤60m research/scope session
       │              document: current state, code sites, ROI, open questions
       │
       ▼
  yegor-architect ─ write the design in the issue
       │              decompose into N independent ≤60m units
       │
       ▼
  N bounded GH issues + N @todo puzzles at exact code sites
       │
       ▼
  yegor-pm priority queue ─ highest severity + shortest estimate first
       │                       skip blocked; resume when unblocked
       ▼
  resolve each puzzle → remove @todo → commit Closes #N → close issue
```

**Key rules:**
- Puzzles are ALWAYS ≤60m. If it can't fit, decompose further before adding the `@todo`.
- The parent issue stays open until all child puzzles are resolved.
- Blocked puzzles stay in the code (do not remove the `@todo`) but are skipped in priority order.
- Pre-decomposing everything upfront is waste — only decompose when you're about to start work.

## The engineering-discipline layer (review + tests)

`yegor-review` and `yegor-unit-tests` cover the *quality gate*, complementing the PM layer:

- A piece of work is a complaint, ideally a **failing/disabled test** (`yegor-bdd` test-as-proof).
- That test must be a *real* test, able to fail (`yegor-unit-tests`).
- The change is reviewed by an objective reviewer who rejects-by-default and never hand-QAs (`yegor-review`); a runtime-only bug becomes a new test, filed as a complaint.

## Stack ranking by daily impact (solo work)

1. **`yegor-pdd`** — install `pdd` CLI (free, MIT, `gem install pdd`); add `@todo` puzzles at stub sites.
2. **`yegor-microtasks`** — cap tasks at 60min.
3. **`yegor-tickets`** — write decisions as issue comments before continuing.
4. **`yegor-velocity`** — measure closed tickets per week (+ the multi-metric scorecard when one number misleads).
5. **`yegor-spikes`** — gate large/fuzzy work with a research session before coding.
6. **`yegor-bdd`** — frame issues as complaints (a failing test where possible); lint weak titles at filing time.
7. **`yegor-review`** — reject-by-default review on every diff; a testless PR is auto-reject.
8. **`yegor-unit-tests`** — run the anti-pattern catalog over every test diff; tests-first in their own PR.
9. **`yegor-stuck`** — when blocked, take the cheapest honest rung; never fake green; drop stale work.
10. **`yegor-merge-gate`** — impartial, zero-tolerance gate before merge; never self-bless, never merge on red.
11. **`yegor-builds`** — give the agent a seconds-long Fast build; push slow checks to the gate.
12. **`yegor-simba`** — cap work-in-progress; back every status claim with an artifact.
13. **`yegor-projections`** — answer "how long?" by projecting from the measured rate, not the spec.
14. **`yegor-architect`** — temporally separate design from execution.
15. **`yegor-small-repos`** — keep each repo to one purpose, ~50k LOC, one language.
16. **`yegor-nohelp`** — `NOTES.md` per project; keep docs short/ordered/measurable.
17. **`yegor-personas`** — for a hard call, convene the council and converge via the authority ladder (deliberate, not every decision).

## How Claude should use this meta-skill

When the user asks for help with a software project, mentally invoke this meta-skill and let it route to the right sub-skill(s). Surface the relevant rule briefly before acting:

- "Sounds like more than 60min — micro rule says split first."
- "Before code, let me write the design in the issue (architect mode)."
- "This stub should have a `@todo` puzzle attached."
- "Before I fix this, let me write the failing test that proves the bug."
- "Reviewing this diff — what's the strongest reason to reject it?"
- "How's progress? Let me count closed tickets this week."

Always link back to `research/` for the deep reference when the user asks why.

## Source repo

This skill family is git-source-controlled in the standalone `yegor-pm-skills` repo (its own MIT-licensed upstream). It is **not** vendored into `claude-config`: `~/.claude/skills/yegor-*` are symlinks pointing **directly** at this repo's `skills/` dirs (the same single-source-root pattern Pocock's skills use via `~/.agents/skills`). So there is exactly one on-disk copy of each skill — edit it here and the change is live; no mirror step. The dotfiles `claude-skills` install section clones this repo and creates the symlinks. Each skill has independent semver (`VERSION` file + `CHANGELOG.md`).

## Deep references

| Sub-skill | Research doc |
|---|---|
| yegor-pdd | `research/philosophy_01_pdd_puzzle_driven_development.md` |
| yegor-bdd | `research/philosophy_02_bdd_bug_driven_development.md` |
| yegor-microtasks | `research/philosophy_03_microtasks_microtasking.md` |
| yegor-tickets | `research/philosophy_04_tickets_ticket_as_conversation.md` |
| yegor-architect | `research/philosophy_05_architect_then_courier.md`, `research/philosophy_21_architect_authority.md` |
| yegor-velocity | `research/philosophy_06_velocity_closed_tickets.md` |
| yegor-nohelp | `research/philosophy_07_nohelp_documentation_first.md`, `research/philosophy_22_doc_structure.md` |
| yegor-review | `research/philosophy_08_review_serious_code_reviewer.md` |
| yegor-unit-tests | `research/philosophy_09_unit_tests_anti_patterns.md` |
| yegor-stuck | `research/philosophy_10_stuck_cut_corners.md`, `research/philosophy_19_zero_tolerance_and_stale_tickets.md` |
| yegor-merge-gate | `research/philosophy_11_merge_gate_readonly_master.md`, `research/philosophy_19_zero_tolerance_and_stale_tickets.md` |
| yegor-builds | `research/philosophy_12_four_builds_ci_maturity.md`, `research/philosophy_24_dependency_trust.md` |
| yegor-simba | `research/philosophy_13_simba_wip_caps_evidence.md` |
| yegor-projections | `research/philosophy_14_projections_no_estimates.md` |
| yegor-small-repos | `research/philosophy_15_small_repos_higher_quality.md` |
| yegor-review / yegor-unit-tests | `research/philosophy_16_tests_as_warranty_separate_prs.md` |
| yegor-bdd / yegor-tickets | `research/philosophy_17_bug_tracking_hygiene.md` |
| yegor-bdd | `research/philosophy_23_bug_report_richness.md` |
| yegor-velocity | `research/philosophy_18_multi_metric_velocity.md` |
| yegor-personas | `research/philosophy_20_personas_decision_council.md` |

Companion docs:
- `research/zerocracy_2026_status_and_evolution.md` — context on Yegor's tooling in 2026.
- `research/yegor_ideas_for_solo_dev_workflow.md` — synthesis for solo dev use.
