---
name: yegor-bdd
description: "Apply Bug Driven Development by shaping work as a neutral complaint: have X, should have Y, with repro or evidence. Use when Codex is filing, reviewing, rewriting, or closing issues; when a user describes work as a request, suggestion, question, or vague topic; when deciding whether a bug report is actionable; or when a fix needs a proving failing/disabled test."
---

# Yegor BDD

## Overview

Use this skill to turn work into actionable complaints. A good ticket says what exists now, what should exist instead, and how to reproduce or prove the gap. Prefer neutral, specific evidence over requests, wishes, or chat-only decisions.

The original Claude Code source remains in `skills/yegor-bdd/`. This Codex port keeps the discipline and removes Claude slash-command assumptions.

## Complaint Shape

Every work item should answer:

1. **Title:** a declarative complaint naming the breakage.
2. **Have:** the current state or observed behavior.
3. **Should have:** the desired state or expected behavior.
4. **Repro or evidence:** steps, command, failing output, screenshot, trace, or disabled/failing test that proves the gap.

Examples:

| Weak request | Complaint |
|---|---|
| "Add settings menu" | "Settings are inaccessible from the main UI" |
| "Improve date parsing" | "Date parser fails on ISO inputs with milliseconds" |
| "Write Windows install docs" | "Windows installation is undocumented" |

## Title Lint

Before filing or accepting a ticket, lint the title:

- Reject question titles: `?`, "why", "how", "what", "when", "where", "can", "does", "is".
- Reject bare topics or wishes: "Date parsing", "Settings menu", "Add dark mode".
- Require a breakage signal such as "fails", "wrong", "missing", "crashes", "undocumented", "instead", "broken", or "should".
- Auto-propose a declarative rewrite in the same response.

Good title shape: "`<thing>` currently `<wrong behavior>`" or "`<thing>` fails/misses/returns `<specific gap>`".

## Report Richness

A good body is:

- **Reproducible:** starts from a clean, known state with exact inputs, commands, versions, commits, or data.
- **Rich:** states expected vs. actual behavior and any relevant environment.
- **Effortful:** shows the reporter narrowed the case and attached useful output instead of delegating all discovery.

If a report is missing these, ask for the specific missing facts or draft the missing section when the evidence is already available.

## Test As Proof

Prefer a failing or disabled test as the complaint:

- A disabled/skipped test annotated with the issue number is a machine-checkable report.
- A fix is not done until it includes a test that fails against the old behavior and passes with the fix.
- If the project can separate changes, add or enable the proving test first, then fix the code in a later change.
- If a test cannot be written yet, keep the prose report reproducible and evidence-backed.

Route detailed test-quality questions to `yegor-unit-tests` when that Codex skill is available.

## Filing Workflow

1. Restate the complaint: "Have X; should have Y; evidence Z."
2. Rewrite weak titles into complaint titles before filing.
3. Keep one complaint per issue. Split stacked complaints.
4. Include repro/evidence, expected vs. actual, and environment where relevant.
5. Link or embed the proving test when one exists.
6. File only when the project rules authorize filing; if the user only asked a question, answer first.

## Review Workflow

When reviewing an existing issue:

- Mark it **ready** only if the complaint shape is present and narrow enough to act on.
- Ask for exact repro/evidence when the agent cannot start without it.
- Push back on feature requests disguised as complaints unless they name a concrete wrong current behavior.
- Route unknown code-site or non-reproducing reports to a bounded spike instead of pretending the bug is specified.

## Closure

The reporter owns closure. The solver finishes the work and asks for verification; the reporter verifies the complaint is resolved and closes.

For solo-agent work, switch hats deliberately:

1. Reporter: write the complaint.
2. Solver: make the proving evidence pass.
3. Reporter: verify the complaint is gone before closing.

Exceptions: duplicates, direct-answer questions, and explicit won't-fix decisions with a documented reason.

## Comment Hygiene

- Address comments to a specific person when the tracker convention supports it.
- Each comment should either argue for closing or name the concrete condition that keeps the issue open.
- Use reactions for "+1", "agreed", or "thanks" instead of adding noise comments.

## Source References

Use the original Claude skill for deeper details: `skills/yegor-bdd/SKILL.md`. For rationale, read:

- `research/philosophy_02_bdd_bug_driven_development.md`
- `research/philosophy_17_bug_tracking_hygiene.md`
- `research/philosophy_23_bug_report_richness.md`
