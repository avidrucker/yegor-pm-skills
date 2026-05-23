# yegor-pm-skills

Eight versioned Claude Code skills distilled from Yegor Bugayenko's [XDSD](https://www.xdsd.org/) methodology — practical project-management rules a solo developer (and the AI agents helping them) can actually follow.

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

Each skill ships `SKILL.md` + `VERSION` + `CHANGELOG.md` and can be bumped independently. The `research/` folder contains the deep-reference doc each skill is distilled from, citing Yegor's primary sources.

## Install

Clone the repo, then symlink each skill into your Claude Code user-wide skills folder.

### Windows

```powershell
git clone git@github.com:avidrucker/yegor-pm-skills.git
$root = (Resolve-Path .\yegor-pm-skills).Path
foreach ($s in @("yegor-pm","yegor-pdd","yegor-bdd","yegor-microtasks","yegor-tickets","yegor-architect","yegor-velocity","yegor-nohelp")) {
  cmd /c mklink /J "$env:USERPROFILE\.claude\skills\$s" "$root\skills\$s"
}
```

`mklink /J` creates a directory junction. No admin or Developer Mode required.

### macOS / Linux

```bash
git clone git@github.com:avidrucker/yegor-pm-skills.git
ROOT="$(pwd)/yegor-pm-skills"
mkdir -p "$HOME/.claude/skills"
for s in yegor-pm yegor-pdd yegor-bdd yegor-microtasks yegor-tickets yegor-architect yegor-velocity yegor-nohelp; do
  ln -s "$ROOT/skills/$s" "$HOME/.claude/skills/$s"
done
```

## Use

In any Claude Code session:

- `/yegor-pm` — meta orchestrator (the daily entry point)
- `/yegor-pdd`, `/yegor-bdd`, `/yegor-microtasks`, `/yegor-tickets`, `/yegor-architect`, `/yegor-velocity`, `/yegor-nohelp` — individual rule sets

Each skill's `SKILL.md` is the action layer (triggers + rules). Each `research/philosophy_NN_*.md` is the context layer (sources + rationale). When in doubt, the SKILL.md links to its research doc.

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

Each `research/philosophy_NN_*.md` includes the full source list for its skill.

## License

MIT — see [LICENSE](./LICENSE).
