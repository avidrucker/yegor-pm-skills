# Philosophy 15 — Small Repositories, Higher Quality

> **Why this doc exists:** capture Yegor's case against monorepos — many small
> single-purpose repositories beat one big one — and the 2025 AI-era update that
> a small repo fits inside an agent's context window. Translate both for a solo
> developer working with AI agents, where "fits the agent's window" becomes a
> first-class reason to keep repos small.
>
> **Primary sources:**
> - Yegor Bugayenko, *Monolithic Repositories Are Evil* (2018-09-05) — https://www.yegor256.com/2018/09/05/monolithic-repositories.html
> - Yegor Bugayenko, *Smaller Repository, Higher Quality* (2025-11-16) — https://www.yegor256.com/2025/11/16/smaller-repository-higher-quality.html

---

## The principle (paraphrased)

A repository should hold **one problem, in one language, small enough to keep in
your head**. Yegor's concrete targets: around 50,000 lines, a single technology,
and a build that finishes in under a minute. A monorepo — many concerns and
stacks under one roof — erodes quality on every axis simultaneously: style
drifts (you can't enforce one strict standard across languages), tests thin out,
reviews skim because no one holds the whole thing in mind, and onboarding
stalls. Splitting into many small single-purpose repos reverses each of those.

The 2018 piece argues this from team-quality numbers. The 2025 piece adds a new
axis: a small repo **fits inside an AI agent's context window**, so the agent can
reason over the whole codebase rather than a retrieved slice.

## Why it works

- **Strictness is affordable at small scale.** A monolingual ~50k-line repo can
  run a zero-tolerance quality gate (philosophy_19) and deep tests without the
  per-language exceptions a polyglot monorepo forces.
- **Reviews and onboarding scale with comprehensibility.** A reviewer (or a
  newcomer, or an agent) can hold a single-purpose repo in mind; a 500k-line
  monorepo no one fully understands gets skimmed reviews and slow ramp-up.
- **The build stays fast.** Sub-minute builds are both a *consequence* of
  smallness and a *forcing function* for it — when the build crawls, the repo has
  usually outgrown one purpose (ties to philosophy_12's Fast build).
- **(AI era) The whole codebase as context beats a guessed slice.** An agent that
  loads the entire repo reasons over real call sites and invariants. A sprawling
  monorepo forces lossy retrieval, partial understanding, and hallucinated seams.

## Canonical rules

- **One repo, one purpose** — a second unrelated concern gets its own repo.
- **One language / technology per repo** — keep quality gates and the build
  monolingual.
- **Cap the size (~50k lines)** — a soft, checkable threshold (`cloc`/`tokei`),
  a signal to look for a seam, not a law.
- **Keep the build under a minute** — both effect and forcing function.
- **Split along problem seams, not arbitrarily** — each resulting repo must
  itself be single-purpose; never shard a cohesive codebase to hit a number.

## The AI-era argument (first-class now)

- **Whole-repo context > retrieved slice.** Fitting the codebase in the window
  means the agent reasons over the real thing, not a subset.
- **Smaller surface, fewer wrong assumptions.** Less unrelated code means fewer
  hallucinated module locations/behaviors.
- **This can outweigh monorepo convenience.** For AI-augmented work, "fits the
  agent's window" is a primary reason, not a footnote.

## Translating for solo + AI work

- **Favor small over convenient.** A monorepo *feels* easier solo (one checkout,
  one PR) but the agent pays in lost context. Default to a new repo for a
  genuinely separate concern.
- **Use the cap as a prompt, not a tripwire.** When a repo crosses ~50k lines or
  the build passes a minute, raise the question — "is there a seam worth splitting
  along, or is this still one cohesive purpose?" — and let the human decide.
  Don't auto-split.
- **Per-repo strictness becomes affordable.** Small + monolingual makes the
  zero-tolerance gate and deep tests realistic.

## Actionable guidelines

### How Claude should use this

- **When a repo sprawls:** name the cost in agent terms — "spans three stacks and
  ~120k lines; it no longer fits my context window. Is there a seam (the CLI? the
  API client?) to split out?"
- **When starting new work:** ask the scope question — "part of this repo's one
  purpose, or a separate concern that deserves its own repo?"
- **When the build crawls:** connect it to size — "well over a minute now, usually
  a sign the repo outgrew a single purpose."
- **Don't over-apply:** a cohesive 60k-line repo isn't a defect; the cap is a
  question to ask, not a quota to enforce.

## Pitfalls

- **Monorepo by default** — every concern as a folder because one checkout is
  convenient, until nothing fits in one mind or one window.
- **Polyglot tangle** — multiple stacks defeating per-language strictness and
  slowing the build.
- **Arbitrary shards** — splitting a cohesive codebase just to hit 50k lines.
- **Treating the cap as law** — auto-splitting at exactly 50k instead of finding
  a real seam.

## Integration with the other philosophies

- + [Merge gate](./philosophy_11_merge_gate_readonly_master.md): a small
  monolingual repo makes a zero-tolerance quality gate affordable.
- + [Tiered builds](./philosophy_12_four_builds_ci_maturity.md): sub-minute
  builds are the Fast-build target; small repos keep them fast.
- + [No-help](./philosophy_07_nohelp_documentation_first.md): a small
  single-purpose repo is far easier to document fully.
- + [Architect](./philosophy_05_architect_then_courier.md): repo boundaries are
  an architecture decision, made in writing before the courier work.

## One-line summary for Claude

> Keep each repo to one problem, one language, ~50k lines, a sub-minute build —
> small enough to hold in one mind and, now, inside an agent's context window.
> The cap is a prompt to look for a real seam, not a law; split along genuine
> problem boundaries, never to hit a number.
