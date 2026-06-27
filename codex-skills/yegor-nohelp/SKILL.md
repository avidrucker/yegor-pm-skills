---
name: yegor-nohelp
description: "Apply documentation-first NoHelp discipline: reusable project knowledge belongs in repo docs and tracker artifacts, not in chat, memory, or private explanations. Use when Codex is answering project-specific questions, debugging non-obvious behavior, discovering conventions, writing or reviewing README/spec docs, seeing repeated questions, or deciding whether an answer should become NOTES, README, ADR, or issue-tracker documentation."
---

# Yegor NoHelp

## Overview

Use this skill to prevent Codex from becoming the project knowledge base. Project-specific answers should land in durable repo documentation and issue-tracker artifacts. Chat can explain, but it must not be the only place the answer exists when the knowledge will be reused.

The original Claude Code source remains in `skills/yegor-nohelp/`. This Codex port keeps the documentation-first discipline and removes Claude-specific wording.

## Knowledge Flow

When answering a project-specific question:

1. Check existing docs first: `README`, `NOTES.md`, `docs/`, ADRs, and project-specific rule files.
2. Search the issue tracker if docs do not answer it.
3. If the answer is missing, treat the gap as a complaint: "X is undocumented."
4. Put the answer in two places when project state changes: the tracker issue/comment for traceability and the repo doc for future reuse.
5. Close the documentation gap only after the doc is updated, not merely after the user understands the answer.

Do not file or edit docs without authorization when the project rules require explicit go-ahead. Still surface the missing-doc gap.

## When To Write It Down

Write or propose documentation when:

- A user asks how project-specific behavior works.
- Codex discovers a non-obvious convention, setup step, failure mode, or architecture decision.
- Debugging takes more than about 10 minutes and produces a reusable finding.
- The same answer is searched for or asked twice across sessions.
- A design decision is made or a quality requirement is clarified.
- A ticket closes with knowledge future agents will need.

Minimum durable home: root `NOTES.md` for a lightweight discovery. Promote repeated or stable knowledge into README, `docs/`, or ADRs.

## What Counts As Documentation

Good durable locations:

- `NOTES.md` for free-form dated discoveries.
- `README.md` for setup, quick start, conventions, and common gotchas.
- `docs/decisions/` or `docs/adr/` for design choices and rationale.
- Issue comments with substantive resolution notes.
- Inline comments only for why non-obvious code exists.

Insufficient locations:

- Chat transcripts.
- Verbal explanations.
- Private notes outside the repo.
- Personal memory or "the agent knows this."
- Long issue threads with no summary or doc link.

## README And Doc Shape

Documentation must be useful, not just present:

- Keep README short, roughly two pages. Split detail into `docs/` and link out.
- Order README sections predictably: one-paragraph pitch, quick start, usage/use cases, contributing, releases/changelog.
- Avoid duplicating generated content such as API docs, CLI help, or changelogs. Link to the source.
- Write quality requirements as measurable thresholds, not adjectives. Prefer "page loads in <300ms" over "fast."
- Trim and reorganize when docs grow. Do not append indefinitely.
- Date unstable notes and prune stale entries.

## Answering Workflow

Before answering from memory:

1. Identify whether the question is project-specific or general.
2. If project-specific, check whether the answer is documented.
3. If documented, answer with the doc path and summarize only what is needed.
4. If undocumented, answer the user and state the doc gap.
5. If authorized, add the smallest durable note immediately.

For repeated questions, bias toward updating docs before giving another chat-only explanation.

## Debugging Workflow

When debugging reveals reusable knowledge:

1. Capture the symptom, cause, and fix or workaround.
2. Put the durable note where future agents will look first.
3. Link the note from the issue or closing comment when relevant.
4. Keep the final chat response short and point to the durable artifact.

## Pitfalls

- Writing a polished manual before writing one useful note.
- Hiding docs in a wiki or private folder no agent checks.
- Duplicating generated output by hand.
- Letting stale docs survive because they are "documentation."
- Treating documentation as optional overhead after the task is already closed.
- Answering the same project question from memory in every new session.

## Source References

Use the original Claude skill for deeper details: `skills/yegor-nohelp/SKILL.md`. For rationale, read:

- `research/philosophy_07_nohelp_documentation_first.md`
- `research/philosophy_22_doc_structure.md`
