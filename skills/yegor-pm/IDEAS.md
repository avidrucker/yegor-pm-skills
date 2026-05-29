# Yegor-PM family — deferred ideas

A flat list of enhancements considered for the yegor-pm family of skills
(yegor-pdd, yegor-spikes, yegor-bdd, yegor-microtasks, yegor-tickets,
yegor-architect, yegor-velocity, yegor-nohelp, puzzle-velocity) that we
chose not to implement now. Each entry: what, why deferred, when to revisit.

Add new ideas here rather than as scattered TODOs in the SKILL.md files.

---

## I-001 — Pre-commit hook: reject files containing conflict markers

**What:** A repository-level `pre-commit` hook that runs
`git diff --cached --check` (or a plain `grep -lE '^<<<<<<<|^=======|^>>>>>>>'`
against the staged file list) and aborts the commit if any staged file still
contains raw conflict markers.

**Why it would help:** belt-and-suspenders for the `puzzle-velocity` skill's
CSV merge-conflict resolution path. The skill's protocol (v0.4.0) already
prescribes a `grep` guard between resolution and `git add`, but a hook would
catch the failure mode mechanically — even when an agent (or human) forgets
the guard, or when an upstream tool fails silently (e.g. an Edit that didn't
apply, leaving the markers in place).

**Why deferred:**
- The 0.4.0 protocol guard catches the same failure mode at the right step
  (before `git add`), and has now been documented across the skill + the
  lccjs `docs/puzzle-velocity.md` mirror. We want to see whether the
  protocol-level fix is enough in practice before adding hook machinery.
- A hook is per-repo infrastructure; the skill protocol is portable across
  every project that adopts puzzle-velocity. Fixing it at the protocol layer
  scales further with no per-project install step.
- Hooks have a small but real maintenance cost (installing, keeping in sync
  across worktrees, handling `--no-verify` bypasses). Not worth paying that
  cost without evidence the protocol guard isn't enough.

**When to revisit:**
- If a second incident ships conflict markers despite the v0.4.0 protocol —
  that's the signal the protocol alone isn't enough and the hook should be
  built.
- Or if a project picks up puzzle-velocity and explicitly asks for the hook
  as part of the setup.

**Surfaced by:** lccjs #139 close (2026-05-28); see `puzzle-velocity`
0.4.0 CHANGELOG entry and lccjs commit `a19d115` for the failure-mode trace.

**Owner / scope when revisited:** small DEV puzzle, ~10–15m H, single file
(`.git/hooks/pre-commit` or `.husky/pre-commit` depending on the project).
