---
name: yegor-merge-gate
description: The trunk (master/main) is read-only and the author never blesses their own merge. From Yegor Bugayenko — no one merges by hand; an automated gate runs the full suite in a clean environment and merges only if green. The gate is zero-tolerance — any single lint/static-analysis violation fails it (warnings == errors, no allowlist). Never merge into a broken master — when the build is red, the only allowed change is the one that fixes it. Use when deciding a PR is ready, before merging, when CI/master is red, or when an agent is about to declare its own work done.
version: 0.2.0
last_reviewed: 2026-06-26
---

# Yegor Merge Gate — Read-Only Master, No Self-Blessing

The trunk branch is **read-only**. No human — not even the repo owner — pushes to it directly. Every change reaches the trunk through an **automated gate** that merges the branch into a fresh, clean environment, runs the **full** test suite, and pushes **only if green**. Otherwise the branch is rejected.

> No matter how good your CI is, it won't help unless the master branch is read-only. If people can push directly, "green CI" is just a suggestion.

## Triggers
- About to merge a PR / branch into master/main.
- Deciding whether a change is "merge-ready."
- CI is red, or master is broken.
- An agent (or you) is about to declare its **own** work done and merge it.

## Core rules

- **Master is read-only.** Direct pushes to the trunk are forbidden. Turn on branch protection so the only path in is a gated merge.
- **The author never self-blesses the merge.** The person (or agent) who wrote the change does not get to declare it merge-ready and push it. A **separate gate proves it green first** — CI in a clean environment, and/or an independent reviewer. Writing the code and admitting it to the trunk are two different hats; never wear both at once.
- **The gate runs the full suite in a clean environment.** Not "it passed on my machine." The gate merges into a fresh checkout/container, runs everything, and only then fast-forwards the trunk. A flaky/partial run is not a gate.
- **Never merge into a broken master.** When the build is red, accept **no** new changes except the one that fixes the build. Don't stack work on a red trunk — every later failure is now ambiguous.
- **Build-fixes ship alone.** The change that repairs a red master is its own isolated PR, not bundled with feature work. File the broken-build as a complaint and let the fix go in first.
- **The gate is zero-tolerance.** Treat the quality bar as binary: **any single** lint or static-analysis violation fails the whole build. No warnings-only mode, no severity downgrade, no per-rule allowlist that accumulates "known issues". Warnings are errors. This is harsh by design — a gate that lets "just one warning" through is not a gate, and a thousand suppressed warnings is where quality goes to die. The check reduces to one boolean an agent can enforce: *did the linter/analyzer exit non-zero? → reject.*

## For solo / AI-augmented work

- **CI is the non-negotiable gate.** Solo, it's tempting to push to main directly "because it's just me." Don't — protect the branch and let CI be the impartial gate you can't argue with.
- **An author-agent must not merge its own PR unchecked.** If Claude wrote the change, Claude doesn't also get to declare it done and merge it. Require a passing CI run and/or an independent review pass (e.g. `/code-review`, or a second agent) as the gate. This is the automation-era version of "no self-blessing."
- **Red trunk halts new work.** If `main` is red, the next thing you do is fix the build — in its own branch/PR — before starting or merging anything else.

## How Claude should use this
- **Before proposing a merge:** confirm the gate is green ("CI is passing on this branch — safe to merge") rather than asserting readiness from having written it.
- **When master is red:** refuse to layer new work. "Master's build is broken — the only change I'll merge right now is the fix. Let me file the broken-build bug and fix it first."
- **When asked to merge own work:** name the gate. "I wrote this, so I shouldn't be the one to bless it — let's get CI green and an independent review before it lands."

## Pitfalls
- **"Green on my machine."** A local pass is not the gate; the gate is a clean-environment full-suite run.
- **Self-merge.** Author pushing their own work to the trunk without an impartial gate — the failure mode this skill exists to stop.
- **Stacking on red.** Merging features while master is broken, so the next red is unattributable.
- **Bundling the build-fix.** Hiding a trunk repair inside a feature PR instead of shipping it isolated and first.
- **Warning creep.** Letting "just this one warning" through, or parking violations on an ever-growing allowlist, until the quality bar is fiction. Zero-tolerance means zero.

## Cross-references
- `yegor-review` — the independent review layer is half the gate; the reviewer rejects, the gate enforces green.
- `yegor-bdd` — a broken master is a complaint; the build-fix is its dedicated change.
- `yegor-velocity` — only gated-and-merged work counts as closed.
- `yegor-tickets` — the broken-build bug and its fix live in the tracker.
- `yegor-builds` — the gate is the Preflight build; the zero-tolerance lint is rung 6 of the CI-maturity ladder.
- `yegor-unit-tests` — "every change ships a test" (rung 5) is the test half of the gate; this is the static-analysis half.

## Deep reference
- `research/philosophy_11_merge_gate_readonly_master.md`
- `research/philosophy_19_zero_tolerance_and_stale_tickets.md` (the zero-tolerance quality bar)
