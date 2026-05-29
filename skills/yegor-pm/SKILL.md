---
name: yegor-pm
description: Project management and engineering-discipline skill set distilled from Yegor Bugayenko's XDSD methodology. Meta-orchestrator for 10 sub-skills (yegor-pdd, yegor-spikes, yegor-bdd, yegor-microtasks, yegor-tickets, yegor-architect, yegor-velocity, yegor-nohelp, yegor-review, yegor-unit-tests). Triggers when planning work, breaking down tasks, managing issues, reviewing progress/code, writing tests, or deciding on workflow approach.
version: 0.3.0
last_reviewed: 2026-05-28
---

# Yegor Project Management — Meta Skill

Coordinated set of skills based on Yegor Bugayenko's eXtremely Distributed Software Development (XDSD), adapted for solo and AI-augmented work.

## The 10 sub-skills

| Skill | One-liner |
|---|---|
| `yegor-pdd` | Every deferred sub-problem becomes a `@todo #N:Mm` puzzle comment at the code site. |
| `yegor-spikes` | When scope or code site is unknown, run a ≤60min research spike first to produce the inputs a puzzle needs. |
| `yegor-bdd` | Every piece of work is a complaint (have X / should have Y / repro), best expressed as a failing test. Reporter closes. |
| `yegor-microtasks` | Cap every task at ~60min (default 30). Overrun → split into puzzles. |
| `yegor-tickets` | If it isn't in the tracker, it didn't happen. Write the comment before the chat reply. |
| `yegor-architect` | Separate architect mode (design in writing) from courier mode (execute agreed design). |
| `yegor-velocity` | Velocity = closed tickets/week. Not commits, not hours, not LOC. |
| `yegor-nohelp` | Push every reusable answer into the repo's docs. `NOTES.md` is the minimum. |
| `yegor-review` | The reviewer's job is to reject, not bless. Four NOs, 3 critical problems, never run the code. |
| `yegor-unit-tests` | Tests are first-class code that must be able to fail. Anti-pattern catalog + fakes over mocks. |

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
| Answering a project-specific question | `yegor-nohelp` (check docs first) |
| Tempted to redesign mid-implementation | `yegor-architect` (stop, drop a puzzle, switch modes) |
| User describes work informally | `yegor-bdd` (reshape into a complaint) |

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
4. **`yegor-velocity`** — measure closed tickets per week.
5. **`yegor-spikes`** — gate large/fuzzy work with a research session before coding.
6. **`yegor-bdd`** — frame issues as complaints (a failing test where possible).
7. **`yegor-review`** — reject-by-default review on every diff.
8. **`yegor-unit-tests`** — run the anti-pattern catalog over every test diff.
9. **`yegor-architect`** — temporally separate design from execution.
10. **`yegor-nohelp`** — `NOTES.md` per project.

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
| yegor-architect | `research/philosophy_05_architect_then_courier.md` |
| yegor-velocity | `research/philosophy_06_velocity_closed_tickets.md` |
| yegor-nohelp | `research/philosophy_07_nohelp_documentation_first.md` |
| yegor-review | `research/philosophy_08_review_serious_code_reviewer.md` |
| yegor-unit-tests | `research/philosophy_09_unit_tests_anti_patterns.md` |

Companion docs:
- `research/zerocracy_2026_status_and_evolution.md` — context on Yegor's tooling in 2026.
- `research/yegor_ideas_for_solo_dev_workflow.md` — synthesis for solo dev use.
