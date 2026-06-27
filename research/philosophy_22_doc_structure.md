# Philosophy 22 — Doc Structure: Short, Ordered, Measurable

> **Why this doc exists:** the `yegor-nohelp` skill says *write reusable answers
> down*; this doc adds the *shape* discipline — docs must be short, ordered, and
> non-duplicative, and quality requirements must be measurable numbers rather than
> adjectives. Translated for solo + AI work, where a bloated README rots as fast
> as no README and an agent can mechanically lint structure and check numeric
> thresholds.
>
> **Primary sources:**
> - Yegor Bugayenko, *Elegant READMEs* (2019-04-23) — https://www.yegor256.com/2019/04/23/elegant-readme.html
> - Yegor Bugayenko, *How We Write a Product Vision* (2014-10-20) — https://www.yegor256.com/2014/10/20/how-we-write-product-vision.html

---

## The principle (paraphrased)

Documentation that exists but is long, unordered, or duplicative is barely better
than none — readers bounce off it and it drifts out of sync. Two shape rules fix
most of it:

1. **Short, ordered, non-duplicative docs.** A README is **≤~2 pages**, with
   sections in a fixed order: a one-paragraph **pitch** (what/why) first, then
   quick-start, usage/use-cases, how-to-contribute, and where releases/changelog
   live — last. It does **not** hand-copy content that's generated elsewhere (API
   docs, CLI `--help`, the changelog); it links to the source so there's one place
   to be right.
2. **Measurable quality requirements.** "Fast," "scalable," "secure" are wishes,
   not requirements. A real quality requirement carries a **number**: "<300ms page
   load," "1k concurrent sessions," "zero high-severity CVEs at release." If an
   agent can't check it, it isn't a requirement.

## Why it works

- **Brevity forces understanding.** You can only write a 2-page README (or a
  60-word product statement) if you actually understand the thing. Length is often
  a substitute for clarity; capping it surfaces the muddle.
- **Fixed order makes docs skimmable and comparable.** A reader knows the pitch is
  first and contribution rules are last, every time — no hunting. Consistency
  across repos compounds.
- **No duplication means no drift.** Content maintained in two places is wrong in
  one of them within a release. Linking to the generated source keeps a single
  source of truth.
- **Numbers are checkable; adjectives aren't.** "Fast" can't pass or fail. "<300ms"
  can — by a test, in CI, by an agent. Measurable requirements turn quality from
  opinion into a gate (ties to the merge-gate, philosophy_19).

## Canonical rules

- **README ≤~2 pages** — split detail into `docs/`, keep the entry point skimmable.
- **Fixed section order** — pitch → quick-start → usage → contribute → releases.
- **No hand-duplication of generated content** — link to the source.
- **Quality requirements are numbers** — thresholds, not adjectives; an unmeasurable
  requirement isn't one.
- **Trim, don't append** — when a doc grows, cut and link out; length is a smell.

## Translating for solo + AI work

- **The agent lints the structure.** It can check README length, section presence
  and order, and flag a hand-copied changelog or `--help` block as duplication.
- **The agent rejects adjective requirements.** When a spec says "make it fast," the
  agent's move is to ask for the number ("fast = under what, on what?") before
  treating it as a requirement.
- **Short docs fit the agent's context too.** A 2-page README is loadable in full;
  a sprawling one forces lossy retrieval — the same argument as small repos
  (philosophy_15).

## Actionable guidelines

### How Claude should use this

- **When writing/reviewing a README:** keep it ≤2 pages, enforce the section order,
  and link out instead of duplicating generated docs.
- **When a requirement is an adjective:** push back for the number — "what's the
  measurable threshold for 'fast'?" — and write the requirement as that number.
- **When a doc has grown:** propose trimming and linking out, not appending another
  section.

## Pitfalls

- **Manual README** that grows into a manual — split and link.
- **Copy-pasted generated content** (changelog, API docs, `--help`) drifting out of
  sync.
- **Adjective requirements** ("fast", "secure") that can never pass or fail.
- **Append-by-default** — treating a longer doc as a better one.

## Integration with the other philosophies

- + [No-help](./philosophy_07_nohelp_documentation_first.md): the *write-it-down*
  rule; this doc disciplines the shape of what gets written.
- + [Small repos](./philosophy_15_small_repos_higher_quality.md): a small,
  single-purpose repo is what makes a 2-page README possible.
- + [Architect authority](./philosophy_21_architect_authority.md): measurable
  quality requirements are the spec the architect designs against and can amend.
- + [Merge gate](./philosophy_11_merge_gate_readonly_master.md): a numeric quality
  requirement can become a gate; an adjective can't.

## One-line summary for Claude

> Keep docs short, ordered, and non-duplicative — a README is ≤~2 pages, pitch
> first, contribution last, linking out to generated content instead of copying it
> — and write every quality requirement as a checkable number, never an adjective.
