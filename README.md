# yegor-pm-skills

Eighteen versioned Claude Code skills distilled from Yegor Bugayenko's [XDSD](https://www.xdsd.org/) methodology — practical project-management rules a solo developer (and the AI agents helping them) can actually follow.

## What's inside

| Skill | One-liner |
|---|---|
| `yegor-pm` | Meta-orchestrator. Routes to the right sub-skill based on what you're doing. Daily driver. |
| `yegor-pdd` | **Puzzle Driven Development.** Every deferred sub-problem becomes a `@todo #N:Mm` comment at the code site. |
| `yegor-bdd` | **Bug Driven Development.** Every piece of work is a complaint with shape "have X / should have Y / repro." Reporter closes. |
| `yegor-microtasks` | Cap every task at ~60 minutes (default 30). Overrun → split into puzzles. |
| `yegor-tickets` | If it isn't in the issue tracker, it didn't happen. Write the comment before the chat reply. |
| `yegor-architect` | Separate architect mode (design in writing) from courier mode (execute agreed design). Never mix. |
| `yegor-velocity` | Velocity = closed tickets per week. Not commits, not hours, not LOC. |
| `yegor-nohelp` | Knowledge sharing through docs, not by tapping experts. `NOTES.md` is the minimum. |
| `yegor-spikes` | When scope/code-site is unknown, run a ≤60min research spike before writing a puzzle. |
| `yegor-review` | **Code review.** Reject, don't bless. Four NOs, 3 critical problems, never run the code. |
| `yegor-unit-tests` | **Test quality.** Tests must be able to fail. Anti-pattern catalog + fakes over mocks. |
| `yegor-stuck` | **Stuck protocol.** Reveal the blocker, don't be a hero. Cheapest honest rung; never fake green; never cut tests. Stale work gets dropped, not held. |
| `yegor-merge-gate` | **Merge gate.** Trunk is read-only; never bless your own merge. Never merge into a broken master. Zero-tolerance quality bar. |
| `yegor-builds` | **Tiered builds.** Fast (local, seconds, unit) → Cheap (PR) → Preflight (the gate) → Proper (release). Speed early, thoroughness late. |
| `yegor-simba` | **WIP caps + evidence.** Cap work-in-progress; every status claim links to a verifiable artifact. The reviewer reports completion, not the owner. |
| `yegor-projections` | **No-estimates.** Forecast from measured velocity (open ÷ close-rate), with an as-of date — never a spec-derived promise. |
| `yegor-small-repos` | **Small repos.** One repo, one purpose, ~50k LOC, one language — small enough to fit one mind and an agent's context window. |
| `yegor-personas` | **Decision council.** Run a hard call through the relevant skills' strict lenses (+ the PO/REQ/QA/TST roles), then converge via an authority ladder. |

Each Claude skill ships `SKILL.md` + `VERSION` + `CHANGELOG.md` and can be bumped independently. The `research/` folder contains the deep-reference doc each skill is distilled from, citing Yegor's primary sources.

Codex-usable ports live separately under `codex-skills/`. These ports do not replace or mutate the Claude Code skills under `skills/`.

See [`GLOSSARY.md`](./GLOSSARY.md) for short definitions of the vocabulary these skills use — PDD, puzzle, spike, microtask, complaint, velocity, architect/courier, the Four NOs, and more.

## Install

Clone the repo, then symlink each skill into your Claude Code user-wide skills folder.

### Windows

```powershell
git clone git@github.com:avidrucker/yegor-pm-skills.git
$root = (Resolve-Path .\yegor-pm-skills).Path
foreach ($s in @("yegor-pm","yegor-pdd","yegor-bdd","yegor-microtasks","yegor-tickets","yegor-architect","yegor-velocity","yegor-nohelp","yegor-spikes","yegor-review","yegor-unit-tests","yegor-stuck","yegor-merge-gate","yegor-builds","yegor-simba","yegor-projections","yegor-small-repos","yegor-personas")) {
  cmd /c mklink /J "$env:USERPROFILE\.claude\skills\$s" "$root\skills\$s"
}
```

`mklink /J` creates a directory junction. No admin or Developer Mode required.

### macOS / Linux

```bash
git clone git@github.com:avidrucker/yegor-pm-skills.git
ROOT="$(pwd)/yegor-pm-skills"
mkdir -p "$HOME/.claude/skills"
for s in yegor-pm yegor-pdd yegor-bdd yegor-microtasks yegor-tickets yegor-architect yegor-velocity yegor-nohelp yegor-spikes yegor-review yegor-unit-tests yegor-stuck yegor-merge-gate yegor-builds yegor-simba yegor-projections yegor-small-repos yegor-personas; do
  ln -s "$ROOT/skills/$s" "$HOME/.claude/skills/$s"
done
```

## Use

In any Claude Code session:

- `/yegor-pm` — meta orchestrator (the daily entry point)
- `/yegor-pdd`, `/yegor-bdd`, `/yegor-microtasks`, `/yegor-tickets`, `/yegor-architect`, `/yegor-velocity`, `/yegor-nohelp`, `/yegor-spikes`, `/yegor-review`, `/yegor-unit-tests`, `/yegor-stuck`, `/yegor-merge-gate`, `/yegor-builds`, `/yegor-simba`, `/yegor-projections`, `/yegor-small-repos`, `/yegor-personas` — individual rule sets

Each skill's `SKILL.md` is the action layer (triggers + rules). Each `research/philosophy_NN_*.md` is the context layer (sources + rationale). When in doubt, the SKILL.md links to its research doc.

## Codex skills

The Codex ports are installed separately from the Claude Code skills. To install the current ports:

```bash
git clone git@github.com:avidrucker/yegor-pm-skills.git
ROOT="$(pwd)/yegor-pm-skills"
mkdir -p "$HOME/.codex/skills"
for s in yegor-pm yegor-pdd yegor-bdd; do
  ln -s "$ROOT/codex-skills/$s" "$HOME/.codex/skills/$s"
done
```

Current Codex port status:

- `codex-skills/yegor-pm/` — Codex-native meta-orchestrator port of `skills/yegor-pm/`.
- `codex-skills/yegor-pdd/` — Codex-native Puzzle Driven Development port of `skills/yegor-pdd/`.
- `codex-skills/yegor-bdd/` — Codex-native Bug Driven Development port of `skills/yegor-bdd/`.

Verification checklist for the current ports:

- `skills/yegor-pm/` remains the original Claude Code skill.
- `codex-skills/yegor-pm/` is the matching Codex skill.
- `skills/yegor-pdd/` remains the original Claude Code skill.
- `codex-skills/yegor-pdd/` is the matching Codex skill.
- `skills/yegor-bdd/` remains the original Claude Code skill.
- `codex-skills/yegor-bdd/` is the matching Codex skill.

## Bumping a skill

See [`project_setup_notes.md`](./project_setup_notes.md) §3 for the full workflow. Short version:

1. Edit `skills/yegor-<slug>/SKILL.md`.
2. Bump `VERSION` and the `version:` field in the SKILL.md frontmatter (keep them in sync).
3. Add a `## [X.Y.Z] — YYYY-MM-DD` section to `CHANGELOG.md`.
4. Commit: `git commit -m "yegor-<slug> X.Y.Z: <one-line reason>"`.

Semver convention used here:
- **Patch** — typo/clarification, no behavior change.
- **Minor** — added rule, expanded guidance, refined trigger.
- **Major** — the principle itself changed.

For coordinated milestones across the whole stack: `git tag yegor-skills-vX.Y.Z`.

## Why these skills exist

Yegor Bugayenko's [XDSD methodology](https://www.xdsd.org/) was originally designed for distributed *teams*: pay-per-task, ticket-mediated communication, architect-led design, no meetings, no informal help channels. This repo adapts the philosophies for solo developers working with AI agents — the same disciplines, applied to a context where the "team" is you + Claude.

Background research is in [`research/zerocracy_2026_status_and_evolution.md`](./research/zerocracy_2026_status_and_evolution.md) and [`research/yegor_ideas_for_solo_dev_workflow.md`](./research/yegor_ideas_for_solo_dev_workflow.md).

## Talk transcript

The full SRT and plain-text transcript of Yegor's 2016 XDSD talk live on the `talks` branch:

```
git checkout talks
```

Kept off `main` so a default clone stays lean.

## Credits

All philosophies are distilled from [Yegor Bugayenko](https://www.yegor256.com/)'s writings on eXtremely Distributed Software Development, including:

- *Puzzle Driven Development* (2010, 2017)
- *Stop Chatting, Start Coding* (2014)
- *How XDSD Is Different* (2014)
- *Three Things I Expect From a Software Architect* (2015)
- *Five Principles of Bug Tracking* (2014)
- *Let the Bug Reporter Have the Last Word* (2025)
- *Stop Asking and Suggesting — Just Complain* / Bug Driven Development (2025)
- *Couriers, Not Coders* (2026)
- *Four NOs of a Serious Code Reviewer* (2015)
- *Does Code Review Involve Testing?* (2019)
- *You Do Need Independent Technical Reviews!* (2014)
- *Unit Testing Anti-Patterns, Full List* (2018)
- *Built-in Fake Objects* (2014)
- *Write Unit Tests, Don't Waste Our Money!* (2025)
- *How to Cut Corners and Stay Cool* (2015)
- *Master Branch Must Be Read-Only* (2014) / *Rultor* (2014)
- *We Don't Merge into a Broken Master Branch* (2025)
- *Five Principles of Bug Tracking* (2014)

Each `research/philosophy_NN_*.md` includes the full source list for its skill.

## Deliberate non-goal: the OOP / "Elegant Objects" corpus

Yegor's *most-read* writing is his OOP / code-design corpus — *Getters/Setters
Is Evil*, *Why NULL Is Bad*, *Objects Should Be Immutable*, *Don't Create Objects
That End With -ER*, *ORM Is an Offensive Anti-Pattern*, and the rest of the
[Elegant Objects](https://www.elegantobjects.org/) rule set. **This repo
deliberately does not cover it.** Two reasons: (1) the family is intentionally
*stack-agnostic*, and much of that corpus is Java/OOP-specific and translates
poorly to functional or non-OO stacks; (2) it's his most contested material, and
folding it in would change this from a process/discipline toolkit into a
code-style opinion engine. The gap is a conscious scope boundary, not an
oversight — see `skills/yegor-pm/IDEAS.md` (entry I-002) for the full rationale
and the conditions under which it might be revisited.

## License

MIT — see [LICENSE](./LICENSE).
