---
name: yegor-pm
description: Project-management and engineering-discipline router distilled from Yegor Bugayenko's XDSD methodology for Codex agents. Use when planning or triaging project work, decomposing tasks, filing or reviewing issues, deciding whether to spike/design/code, handling blockers, reviewing tests or code, forecasting progress, gating merges, limiting WIP, or routing a hard process decision to the right Yegor rule set.
---

# Yegor PM

## Overview

Use this meta-skill to route software-project work through the Yegor discipline that fits the situation. It is stack-agnostic: apply it with any language, build tool, or issue tracker, and prefer the project's local rules when they are stricter.

The original Claude Code source remains in `skills/yegor-pm/`. This Codex port intentionally omits Claude slash-command language and references future Codex ports as optional sub-skills.

## Route The Work

Start by naming the relevant rule in one short sentence, then act. If the matching Codex sub-skill exists in the current session, load it; otherwise apply the summary below and consult the original source skill under `skills/` only when more detail is needed.

| Situation | Route |
|---|---|
| Planning or scoping new work | `yegor-architect`, `yegor-microtasks` |
| Large or fuzzy issue with unknown code site | `yegor-spikes` |
| Writing code with a deferred sub-problem | `yegor-pdd` |
| Filing or reviewing an issue | `yegor-bdd`, `yegor-tickets` |
| Reviewing a PR, diff, or code change | `yegor-review` |
| Writing, reviewing, or refactoring tests | `yegor-unit-tests` |
| Reviewing progress or ticket flow | `yegor-velocity`, `yegor-tickets` |
| Forecasting "how long?" | `yegor-projections` |
| Answering project-specific questions | `yegor-nohelp` |
| Setting up CI or making checks useful | `yegor-builds` |
| Work is sprawling or status lacks evidence | `yegor-simba` |
| Deciding repository boundaries | `yegor-small-repos` |
| Blocked, stale, thrashing, or tempted to fake green | `yegor-stuck` |
| About to merge, self-approve, or merge with red CI | `yegor-merge-gate` |
| Non-trivial decision with competing defensible answers | `yegor-personas` |

## Default Pipeline

For large or fuzzy work:

1. Run a bounded spike when the scope or code site is unknown.
2. Write the design in the issue before implementation.
3. Decompose into independent tasks that fit in about 60 minutes.
4. Put deferred work in the tracker, and for PDD projects attach a puzzle comment at the code site.
5. Work the highest-impact unblocked item first.
6. Close only when the code, test/evidence, issue update, and project-specific close protocol are all satisfied.

## Rules Of Thumb

- Prefer issues and durable comments over chat-only decisions.
- Shape work as a complaint where possible: have X, should have Y, repro or evidence.
- Keep tasks small; split when the work no longer fits a bounded session.
- Do not mix architect mode and courier mode. Design first, then execute the agreed design.
- Tests must be able to fail. A test that has never been red proves little.
- Review is a rejection search, not a blessing ritual.
- Never declare your own merge ready when the project requires an independent gate.
- When blocked, reveal the blocker and take the cheapest honest next step.

## Source References

Use the original Claude skill as the deeper source until each sub-skill has its own Codex port: `skills/yegor-pm/SKILL.md`. For rationale, follow the research doc links listed there instead of copying the research files into this Codex skill.
