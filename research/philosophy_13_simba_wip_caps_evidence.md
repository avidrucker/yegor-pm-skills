# Philosophy 13 — SIMBA: WIP Caps & Evidence-Backed Status

> **Why this doc exists:** capture Yegor's SIMBA method — manage by artifacts,
> cap work-in-progress hard, and require every progress claim to link to
> verifiable evidence — and translate it for a solo developer working with AI
> agents, where the two failure modes (sprawl across half-finished work, and an
> agent reporting confident but unbacked "done") are acute.
>
> **Primary source:**
> - Yegor Bugayenko, *SIMBA: Simplified Management By Artifacts* (2021-09-09) — https://www.yegor256.com/2021/09/09/simba.html
> - Related: *The Pain of Daily Reports* (2020-11-03) — https://www.yegor256.com/2020/11/03/daily-reports.html (deliverables-not-activity)

---

## The principle (paraphrased)

SIMBA manages a project as a set of **artifacts**, each with an **owner** (who
produces it) and a **reviewer** (who judges it). Three mechanisms hold it
together:

1. **Hard WIP caps.** A person owns no more than ~3 artifacts, reviews no more
   than ~4, and holds no more than ~7 in total. Once you hit the cap you cannot
   take on more — you must finish or shed something first.
2. **Reviewer-reported completion.** The owner does not report how done their own
   work is; the *reviewer* reports completion percentage. The producer is the
   worst judge of their own progress.
3. **Evidence-backed reporting.** A weekly (Monday) report where every status
   item links to a verifiable artifact — a PR, a document, a file, a passing
   build. The report is bounded: a handful of achievements and a handful of
   planned items.

The exact numbers (3 / 4 / 7) are less important than the two disciplines they
encode: *bound the things in flight* and *back every claim with an artifact*.

## Why it works

- **WIP caps force convergence.** Unbounded in-progress work means constant
  context-switching and nothing closing. A small fixed ceiling makes "finish
  before you start" structural, not aspirational — and finishing is what
  velocity actually measures (philosophy_06).
- **Owner≠reviewer removes the ego from the estimate.** The person who did the
  work over-rates its doneness ("just one more thing"). A separate reviewer
  reporting completion is the planning-layer form of the merge gate's
  no-self-blessing (philosophy_11).
- **Evidence kills rumors.** "Almost done" is unfalsifiable. "Merged in PR #143"
  is checkable. Requiring a link turns status from narrative into fact, and
  makes activity-theatre ("worked on", "looked into") visibly not-progress.
- **A bounded report is a sprawl detector.** If you can't fit the week's
  achievements in ~7 lines, WIP has exceeded the caps — the report length itself
  is the signal.

## Canonical rules

- **Cap WIP hard** — own ~≤3, review ~≤4, hold ~≤7; past the cap, finish or drop
  before starting.
- **Every artifact has an owner and a reviewer** — two distinct actors.
- **The reviewer reports completion, not the owner.**
- **Every status claim links to a verifiable artifact** — PR/commit/doc/build;
  effort verbs without links are not progress.
- **Keep the report small** — ≤~7 achievements, ≤~7 planned; overflow means
  sprawl.

## Translating for solo + AI work

- **The cap stops you and the agent from sprawling.** Eight half-finished
  branches and a dozen open tickets is the default failure mode of solo + agent
  work. A WIP cap (even just "≤3 actively in progress") forces closure before new
  starts.
- **Make the agent cite, not assert.** When Claude says "I implemented X", the
  SIMBA rule is *show the artifact* — the diff, the file, the passing test.
  "Done" means "here is the evidence", never "trust me". This is the direct
  antidote to an agent reporting confident, unbacked completion.
- **You are the reviewer of the agent's owned work.** The agent owns the
  artifact; you (or a second agent / `/code-review`) judge completion. The
  owner-agent doesn't self-report 100%.
- **Weekly stock-take.** List what closed (with links) and what's planned. A long
  in-flight list is the cap telling you to converge before diverging.

## Actionable guidelines

### How Claude should use this

- **When reporting progress:** link every claim — "Done: #142 (merged, PR #143).
  In progress: #145 (branch `fix-145`, 2 green / 1 red)." Never "almost done"
  with no artifact.
- **When WIP is sprawling:** name the cap and force a choice — "Six open branches;
  which one closes today before we open another?"
- **When claiming completion:** show the artifact and defer the verdict — "Here's
  the diff and the passing build; I wrote it, so review it before we call it
  done."
- **In a weekly review:** produce a small, link-backed list of what actually
  closed, not a narrative of effort.

## Pitfalls

- **Unbacked status** — "almost done / 90% / mostly working" with no artifact.
- **WIP sprawl** — many open items, none closing.
- **Owner self-reporting completion** — the producer declaring their own work
  done instead of the reviewer.
- **Effort as progress** — counting "worked on it" as movement.

## Integration with the other philosophies

- + [Velocity](./philosophy_06_velocity_closed_tickets.md): closed-with-evidence
  is exactly what velocity counts; WIP caps drive closure.
- + [Merge gate](./philosophy_11_merge_gate_readonly_master.md): owner≠reviewer
  is the same no-self-blessing rule, here at the planning layer.
- + [Tickets](./philosophy_04_tickets_ticket_as_conversation.md): the artifacts
  and their evidence live in the tracker; the link *is* the status.
- + [Microtasks](./philosophy_03_microtasks_microtasking.md): small artifacts are
  easier to cap and finish; big ones clog the WIP slots.
- + [Stuck](./philosophy_10_stuck_cut_corners.md): when an item can't close,
  reveal it and drop/re-scope rather than holding a WIP slot open forever.

## One-line summary for Claude

> Cap the things in flight (own ≤~3, hold ≤~7) and back every status claim with a
> link to a real artifact — PR, commit, doc, green build. "Done" is a claim about
> an artifact, so show it; the reviewer (you), not the owner (the agent), reports
> completion.
