---
name: yegor-pm
description: Project management skill set distilled from Yegor Bugayenko's XDSD methodology. Meta-orchestrator for 7 sub-skills (yegor-pdd, yegor-bdd, yegor-microtasks, yegor-tickets, yegor-architect, yegor-velocity, yegor-nohelp). Triggers when planning work, breaking down tasks, managing issues, reviewing progress, or deciding on workflow approach.
version: 0.1.0
last_reviewed: 2026-05-23
---

# Yegor Project Management — Meta Skill

Coordinated set of 8 skills based on Yegor Bugayenko's eXtremely Distributed Software Development (XDSD), adapted for solo and AI-augmented work.

## The 7 sub-skills

| Skill | One-liner |
|---|---|
| `yegor-pdd` | Every deferred sub-problem becomes a `@todo #N:Mm` puzzle comment at the code site. |
| `yegor-bdd` | Every piece of work is a complaint (have X / should have Y / repro). Reporter closes. |
| `yegor-microtasks` | Cap every task at ~60min (default 30). Overrun → split into puzzles. |
| `yegor-tickets` | If it isn't in the tracker, it didn't happen. Write the comment before the chat reply. |
| `yegor-architect` | Separate architect mode (design in writing) from courier mode (execute agreed design). |
| `yegor-velocity` | Velocity = closed tickets/week. Not commits, not hours, not LOC. |
| `yegor-nohelp` | Push every reusable answer into the repo's docs. `NOTES.md` is the minimum. |

## When to invoke which sub-skill

| Situation | Load |
|---|---|
| Planning / scoping new work | `yegor-architect`, `yegor-microtasks` |
| Writing code with stubs or deferrals | `yegor-pdd` |
| Filing or reviewing an issue | `yegor-bdd`, `yegor-tickets` |
| Reviewing project progress | `yegor-velocity`, `yegor-tickets` |
| Answering a project-specific question | `yegor-nohelp` (check docs first) |
| Tempted to redesign mid-implementation | `yegor-architect` (stop, drop a puzzle, switch modes) |
| User describes work informally | `yegor-bdd` (reshape into a complaint) |

## Stack ranking by daily impact (solo work)

1. **`yegor-pdd`** — install `pdd` CLI (free, MIT, `gem install pdd`); add `@todo` puzzles at stub sites.
2. **`yegor-microtasks`** — cap tasks at 60min.
3. **`yegor-tickets`** — write decisions as issue comments before continuing.
4. **`yegor-velocity`** — measure closed tickets per week.
5. **`yegor-bdd`** — frame issues as complaints.
6. **`yegor-architect`** — temporally separate design from execution.
7. **`yegor-nohelp`** — `NOTES.md` per project.

## How Claude should use this meta-skill

When the user asks for help with a software project, mentally invoke this meta-skill and let it route to the right sub-skill(s). Surface the relevant rule briefly before acting:

- "Sounds like more than 60min — micro rule says split first."
- "Before code, let me write the design in the issue (architect mode)."
- "This stub should have a `@todo` puzzle attached."
- "How's progress? Let me count closed tickets this week."

Always link back to `research/` for the deep reference when the user asks why.

## Source repo

This skill is git-source-controlled in the project where it was authored. SKILL.md files in `~/.claude/skills/yegor-*` are directory junctions to that repo — edit in the repo, changes are live. Each skill has independent semver (`VERSION` file + `CHANGELOG.md`).

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

Companion docs:
- `research/zerocracy_2026_status_and_evolution.md` — context on Yegor's tooling in 2026.
- `research/yegor_ideas_for_solo_dev_workflow.md` — synthesis for solo dev use.
