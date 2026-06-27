---
name: yegor-simba
description: Cap work-in-progress and back every status claim with evidence. From Yegor Bugayenko's SIMBA (Simplified Management By Artifacts) — manage by artifacts each with an owner and a reviewer, enforce hard caps on how many things are in flight at once, and require that every progress claim links to verifiable evidence (a PR, a doc, a file, a passing build). Completion is reported by the reviewer, not the owner. Use when work is sprawling across too many in-flight items, when a status report asserts progress without links, when an agent claims "done" without proof, or during a weekly review.
version: 0.1.0
last_reviewed: 2026-06-26
---

# Yegor SIMBA — WIP Caps & Evidence-Backed Status

Two failure modes quietly wreck a project: **too many things in flight at once** (nothing finishes, context-switching eats the day) and **status claims with nothing behind them** ("almost done", "mostly working"). SIMBA — Yegor's *Simplified Management By Artifacts* — kills both with hard caps on work-in-progress and a rule that **every progress claim must point at verifiable evidence.**

> A status without a link is a rumor. "Done" is a claim about an artifact — so show the artifact: the merged PR, the committed file, the green build. If you can't link it, it isn't done.

## Triggers
- Work is sprawling — too many tickets/branches/threads open at once, nothing closing.
- A status report or standup-style update asserts progress ("almost there", "90% done") without links.
- An agent (or you) claims a task is complete without pointing at the artifact that proves it.
- A weekly/Monday review where you take stock of what actually moved.

## Core rules

- **Cap work-in-progress — hard.** Yegor's SIMBA caps are concrete: no person *owns* more than ~3 artifacts, *reviews* more than ~4, or holds more than ~7 in total. The exact numbers matter less than the discipline: a small, fixed ceiling on in-flight items. Past the cap, you may not start new work — you finish or drop something first.
- **Every artifact has an owner and a reviewer.** Two distinct roles per artifact. The owner does the work; the reviewer judges it done. They are never the same actor (this is `yegor-merge-gate`'s no-self-blessing at the planning layer).
- **Completion is reported by the reviewer, not the owner.** The person doing the work doesn't get to declare their own completion percentage. The reviewer reports how done it actually is — because the owner is the worst judge of their own progress.
- **Every status claim links to evidence.** Each line of a progress report references a *verifiable artifact* — a PR number, a commit, a published doc, a passing build URL. Effort verbs with no link ("worked on", "looked into", "investigating") are not progress.
- **Keep the report small.** SIMBA bounds the weekly report itself: a handful of achievements (≤~7) and a handful of planned items (≤~7). A report longer than that is a signal that WIP has sprawled past the caps.

## For solo / AI-augmented work

- **The cap stops you and the agent from sprawling.** Solo + agents, it's easy to have eight half-finished branches and a dozen open tickets. A WIP cap (even just "≤3 things actively in progress") forces closure before new starts — which is what actually moves velocity (`yegor-velocity`).
- **Make the agent cite, not assert.** When Claude says "I've implemented X", the SIMBA rule is: show the diff / the file / the passing test. "Done" means *here is the artifact*, not *trust me*. This is the antidote to an agent reporting confident, unbacked completion.
- **You are the reviewer of the agent's owned work.** The agent owns the artifact; you (or a second agent / `/code-review`) judge completion. The owner-agent doesn't self-report 100%.
- **Weekly stock-take.** Once a week, list what closed (with links) and what's planned. If the list of in-flight items is long, that's the cap telling you to converge before diverging.

## How Claude should use this
- **When reporting progress:** link every claim. "Done: #142 (merged, PR #143). In progress: #145 (branch `fix-145`, 2 tests green, 1 red)." Never "almost done" with no artifact.
- **When WIP is sprawling:** name the cap. "That's six open branches — SIMBA says converge first. Which one closes today before we start another?"
- **When claiming completion:** show the artifact and defer the verdict. "Here's the diff and the passing build — but I wrote it, so it's not mine to bless; review it before we call it done."
- **In a weekly review:** produce a small, link-backed list of what actually closed, not a narrative of effort.

## Pitfalls
- **Unbacked status.** "Almost done / 90% / mostly working" with no artifact behind it — the rumor this skill exists to kill.
- **WIP sprawl.** A dozen open items, none closing; the cap is there precisely to prevent this.
- **Owner self-reporting completion.** The person doing the work declaring it done — the reviewer reports completion, not the owner.
- **Effort as progress.** Counting "worked on it" as movement; only delivered artifacts count.

## Cross-references
- `yegor-velocity` — closed-with-evidence is exactly what velocity counts; WIP caps drive closure.
- `yegor-merge-gate` — owner≠reviewer and "don't bless your own work" is the same no-self-blessing rule, here at the planning layer.
- `yegor-tickets` — the artifacts and their evidence live in the tracker; the link *is* the status.
- `yegor-microtasks` — small artifacts are easier to cap and to finish; big ones clog the WIP slots.
- `yegor-stuck` — when an item can't close, reveal it and drop/re-scope rather than holding a WIP slot open indefinitely.

## Deep reference
`research/philosophy_13_simba_wip_caps_evidence.md`
