---
name: yegor-small-repos
description: Prefer many small single-purpose repositories over one monorepo. From Yegor Bugayenko's "Monolithic Repositories Are Evil" and "Smaller Repository, Higher Quality" — a repo capped around ~50k lines, one language/technology, one problem scope, builds in under a minute. Small repos get stricter style, deeper tests, better reviews, faster onboarding — and, in the AI era, fit inside an agent's context window. Use when a repo is sprawling across many concerns/languages, when builds crawl, when onboarding (human or agent) is hard, or when deciding whether to split.
version: 0.1.0
last_reviewed: 2026-06-26
---

# Yegor Small Repos — One Repo, One Purpose, Under ~50k Lines

A repository should hold **one problem, in one language, small enough to keep in your head — or in an agent's context window.** Yegor's target: around 50,000 lines, a single technology, a build that finishes in under a minute. Past that, quality erodes on every axis at once — style drifts, tests thin out, reviews skim, onboarding stalls.

> A small repo is a quality multiplier. Stricter style is enforceable, tests can be deep, a reviewer can actually hold the whole thing in mind, a newcomer is productive in a day — and an AI agent can load the *entire* codebase, not a guessed-at slice of it.

## Triggers
- A repo is sprawling across many unrelated concerns or multiple languages/stacks.
- The build is slow (well over a minute) and getting slower.
- Onboarding — a human *or* an agent — is hard because no one can hold the whole thing in mind.
- Deciding whether to start a monorepo or split an existing one.
- An agent keeps losing context because the codebase doesn't fit its window.

## Core rules

- **One repo, one purpose.** A repository solves a single problem. When a second, unrelated concern shows up, it gets its own repo — not a new top-level folder in this one.
- **One language / technology per repo.** Mixing stacks defeats strict per-language quality gates and makes the build a polyglot tangle. Keep it monolingual where you can.
- **Cap the size (~50k lines is the working ceiling).** It's a soft, checkable threshold (`cloc`/`tokei`), not a law. Crossing it is a *signal* to ask "is there a seam to split along?", not an automatic mandate.
- **Keep the build under a minute.** A sub-minute build is both a consequence of smallness and a forcing function for it. When the build crawls, the repo has probably outgrown one purpose.
- **Split along problem seams, not arbitrarily.** When you do split, cut where the concerns are genuinely separate (a library, a service, a tool) — so each resulting repo is itself single-purpose. Don't shard a cohesive codebase just to hit a number.

## The AI-era argument

The 2025 update adds a reason that didn't exist when the original was written: **a small repo fits inside an agent's context window.**

- **The whole codebase as context beats a retrieved slice.** An agent that can load the entire repo reasons over real call sites and invariants, not a guessed-at subset. A sprawling monorepo forces lossy retrieval and partial understanding.
- **Smaller surface, fewer hallucinated seams.** Less unrelated code means fewer wrong assumptions about where something lives or how a far-flung module behaves.
- **This is a *first-class* reason now, not a nice-to-have.** For AI-augmented work, "fits the agent's window" can outweigh the convenience of a single checkout.

## For solo / AI-augmented work

- **Favor small over convenient.** Solo, a monorepo *feels* easier (one checkout, one PR). But the agent pays for it in lost context. Default to a new repo for a genuinely separate concern.
- **Use the cap as a prompt, not a tripwire.** When a repo crosses ~50k lines or the build passes a minute, raise it: "this has grown past the small-repo ceiling — is there a seam worth splitting along, or is it still one cohesive purpose?" Let the human decide; don't auto-split.
- **Per-repo strictness becomes affordable.** A small monolingual repo can run a zero-tolerance quality gate (`yegor-merge-gate`) and deep tests without the polyglot exceptions a monorepo forces.

## How Claude should use this
- **When a repo sprawls:** name the cost in agent terms. "This spans three stacks and ~120k lines — past the small-repo ceiling, and it no longer fits my context window. Is there a seam (the CLI? the API client?) to split into its own repo?"
- **When starting new work:** ask the scope question. "Is this part of *this* repo's one purpose, or a separate concern that deserves its own repo?"
- **When the build crawls:** connect it to size. "The build's well over a minute now — usually a sign the repo has outgrown a single purpose."
- **Don't over-apply.** A cohesive 60k-line repo isn't a problem to fix; the cap is a question to ask, not a quota to enforce.

## Pitfalls
- **Monorepo by default.** Adding every new concern as a folder because one checkout is convenient — until nothing fits in one mind or one context window.
- **Polyglot tangle.** Multiple stacks in one repo defeating per-language strictness and slowing the build.
- **Arbitrary shards.** Splitting a cohesive codebase just to hit 50k lines, producing repos that aren't actually single-purpose.
- **Treating the cap as law.** Auto-splitting at exactly 50k instead of using it as a prompt to look for a real seam.

## Cross-references
- `yegor-merge-gate` — a small monolingual repo makes a zero-tolerance quality gate affordable; polyglot monorepos force exceptions.
- `yegor-builds` — sub-minute builds are the Fast-build target; small repos are how you keep them fast.
- `yegor-nohelp` — a small single-purpose repo is far easier to document fully in `NOTES.md`.
- `yegor-architect` — choosing repo boundaries (split or not) is an architecture decision, made in writing before the courier work.

## Deep reference
`research/philosophy_15_small_repos_higher_quality.md`
