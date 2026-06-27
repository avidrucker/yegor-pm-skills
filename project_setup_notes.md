# Project Setup Notes

> Reference for working with this repo: how the skills are wired up, how to bump them, and the gotchas Claude hit while building the initial set on Windows. Read this first if returning after a break.

**Repo:** `C:\Users\Admin\Documents\Study\AI\yegor\`
**Initial commit:** `aa241e1` (2026-05-23)

---

## 1. Repo layout

```
yegor/
├── .git/
├── .gitignore                          # scripts/, .claude/, OS junk
├── project_setup_notes.md              # this file
├── XDSD_YouTube_Talk/
│   ├── key_takeaways.md                # tracked
│   ├── XDSD_talk_yegor_2016.srt        # tracked on `talks` branch only
│   └── XDSD_talk_yegor_2016.txt        # tracked on `talks` branch only
├── research/                           # deep reference docs (tracked)
│   ├── philosophy_01_pdd_puzzle_driven_development.md
│   ├── philosophy_02_bdd_bug_driven_development.md
│   ├── philosophy_03_microtasks_microtasking.md
│   ├── philosophy_04_tickets_ticket_as_conversation.md
│   ├── philosophy_05_architect_then_courier.md
│   ├── philosophy_06_velocity_closed_tickets.md
│   ├── philosophy_07_nohelp_documentation_first.md
│   ├── yegor_ideas_for_solo_dev_workflow.md
│   └── zerocracy_2026_status_and_evolution.md
├── scripts/                            # gitignored (personal utilities)
│   └── srt-to-txt-converter.py
└── skills/                             # source-of-truth for Claude skills (tracked)
    ├── yegor-pm/        { SKILL.md, VERSION, CHANGELOG.md }
    ├── yegor-pdd/       { ... }
    ├── yegor-bdd/       { ... }
    ├── yegor-microtasks/ { ... }
    ├── yegor-tickets/   { ... }
    ├── yegor-architect/ { ... }
    ├── yegor-velocity/  { ... }
    └── yegor-nohelp/    { ... }
```

**Live link:** each `skills/yegor-<slug>/` is junction-linked into `C:\Users\Admin\.claude\skills\yegor-<slug>` so Claude Code auto-loads them in every session. Edit in this repo → live next session.

---

## 2. Using the skills

| Invocation | Effect |
|---|---|
| `/yegor-pm` | Loads the meta orchestrator. Default everyday entry point. |
| `/yegor-pdd` | Just the Puzzle Driven Development rules. |
| `/yegor-bdd` | Just Bug Driven Development (complaint shape). |
| `/yegor-microtasks` | Just the ≤60-minute sizing rule. |
| `/yegor-tickets` | Just the ticket-as-conversation discipline. |
| `/yegor-architect` | Just the architect↔courier mode separation. |
| `/yegor-velocity` | Just the closed-tickets-per-week metric. |
| `/yegor-nohelp` | Just the documentation-first knowledge rule. |

**Pattern:** the meta-skill (`yegor-pm`) is the natural daily driver. Use individuals when you want one rule loaded without the others — e.g., `/yegor-velocity` for a focused weekly review.

**Deep reference:** each `SKILL.md` is the action layer (rules + triggers). Each `research/philosophy_NN_*.md` is the context layer (sources, rationale, pitfalls). When in doubt, the SKILL.md links to its research doc.

---

## 3. Bumping a skill version

Each skill is independently semver-versioned. Two places hold the version number — keep them in sync.

### Workflow

1. Edit `skills/yegor-<slug>/SKILL.md`.
2. Bump `skills/yegor-<slug>/VERSION` (single line, e.g. `0.1.1`).
3. Update the `version:` field in the SKILL.md YAML frontmatter to match.
4. Add a `## [X.Y.Z] — YYYY-MM-DD` section to `skills/yegor-<slug>/CHANGELOG.md`.
5. Commit: `git commit -m "yegor-<slug> X.Y.Z: <one-line reason>"`

### Semver rules for this repo

- **Patch** (`0.1.0` → `0.1.1`) — typo, clarification, broken-link fix, no behavior change.
- **Minor** (`0.1.0` → `0.2.0`) — added rule, expanded guidance, new cross-reference, refined trigger.
- **Major** (`0.1.0` → `1.0.0`) — the principle itself changed, or the recommended action under the same trigger inverted.

### Coordinated milestones

For a "the whole stack is in good shape right now" snapshot, tag the repo:

```powershell
git tag yegor-skills-v0.1.0
git tag yegor-skills-v0.2.0  # when next coordinated cut happens
```

Individual skill versions can move independently; the tag is the "system as a whole" mark.

---

## 4. Issues encountered during the build, and how to avoid them next time

These are real things that went wrong while constructing this set. Documented so a future session doesn't repeat them.

### 4a. Working-directory drift between Bash and PowerShell tool calls

**What happened:** an early Bash command used `cd "..."`. That `cd` persisted, so subsequent PowerShell calls ran from `XDSD_YouTube_Talk\` instead of the project root. `git init` and `New-Item -Path "skills\..."` therefore created artifacts in the wrong subdirectory; renames failed because the relative `research\` path didn't exist there.

**How to avoid:**
- Never prefix tool commands with `cd` or `Set-Location`. The harness sets the working directory.
- When in doubt, use **absolute paths** from the project root in every command — especially in PowerShell after any prior Bash call.
- If recovery is needed: `Remove-Item -Recurse -Force` the misplaced artifacts, re-run with absolute paths, and use `git -C <abs-root>` for git invocations.

### 4b. PowerShell 5.1 UTF-8 mojibake on read-modify-write

**What happened:** the cross-reference rename pass used `Get-Content $f.FullName -Raw` to read the research files, did a `-replace` on the filenames inside, then wrote back with `[System.IO.File]::WriteAllText`. The read step defaulted to the system ANSI codepage (Windows-1252) instead of UTF-8, so multi-byte UTF-8 sequences for `—`, `≤`, `→`, curly quotes, etc. were reinterpreted as cp1252 characters and then written back as UTF-8 — producing classic mojibake like `â€"` in place of `—`.

**How to avoid:**
- For PowerShell 5.1 read/write of UTF-8 files, use the explicit .NET APIs **on both ends**:
  ```powershell
  $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
  # ... modify ...
  [System.IO.File]::WriteAllText($path, $content)   # WriteAllText defaults to UTF-8 no-BOM
  ```
- Avoid `Get-Content -Raw` for files with any non-ASCII characters unless you pass `-Encoding utf8` (and remember that PowerShell 5.1 utf8 writes a BOM by default — prefer the .NET API for clean no-BOM output).
- For arbitrary file edits, prefer Claude's `Edit` or `Write` tools over PowerShell read-modify-write — they handle UTF-8 cleanly.

**Recovery recipe** (if it happens again): reverse the encoding error.
```powershell
$cp1252 = [System.Text.Encoding]::GetEncoding(1252)
foreach ($f in Get-ChildItem "<dir>\*.md") {
  $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
  $mojibake = [System.Text.Encoding]::UTF8.GetString($bytes)
  if ($mojibake -match 'â€') {
    $reEncoded = $cp1252.GetBytes($mojibake)
    $original = [System.Text.Encoding]::UTF8.GetString($reEncoded)
    [System.IO.File]::WriteAllText($f.FullName, $original)
  }
}
```

### 4c. Windows symlinks vs junctions

**Decision made:** `mklink /J` (directory junction) rather than `mklink /D` (symbolic link).

**Why:**
- Symlinks on Win10 Home require Developer Mode or admin elevation. Junctions don't.
- Functionally identical for the skills-folder use case (both transparent to readers; junctions only work for directories on the same volume, which is fine here).

**Recovery:** if the source folder is moved or deleted, junctions dangle silently. To recreate:
```powershell
foreach ($s in @("yegor-pm","yegor-pdd","yegor-bdd","yegor-microtasks","yegor-tickets","yegor-architect","yegor-velocity","yegor-nohelp")) {
  cmd /c mklink /J "C:\Users\Admin\.claude\skills\$s" "C:\Users\Admin\Documents\Study\AI\yegor\skills\$s"
}
```

### 4d. CRLF warnings on first `git add`

**What you'll see:** a wall of "LF will be replaced by CRLF in <file>" warnings.

**This is normal.** Windows git's `core.autocrlf=true` default converts line endings on commit. Files keep LF in your working dir; CRLF goes into the index. No action needed.

**Only worth investigating if:** you start collaborating across OSes and see whitespace-only diffs on every file. Then consider a `.gitattributes` policy.

### 4e. 0pdd.com hosted bot is broken

Yegor's hosted GitHub bot for converting `@todo` puzzles into issues has its latest release (Feb 2024) tagged "web-service is broken." Use the local `pdd` CLI (`gem install pdd`) instead. The `yegor-pdd` skill already documents this — repeat here so it doesn't get lost.

---

## 5. Other gotchas worth remembering

- **The skill description field matters.** Claude Code uses the `description:` in YAML frontmatter to decide whether to invoke. Keep it trigger-focused ("Use when...") rather than purely descriptive.
- **Frontmatter version field ≠ VERSION file.** They must be bumped together. A pre-commit hook could enforce this if it ever becomes a maintenance issue.
- **Junctions don't track moves.** If you rename a `skills/yegor-<slug>/` folder, the junction breaks silently. Update it manually.
- **The `.claude/` folder is gitignored.** Project-local Claude Code state (settings, transcripts) is intentionally not tracked — it's machine-specific. If you ever need to share a `settings.json` from there, copy it out and commit it explicitly.
- **`scripts/` is also gitignored** per preference (personal utilities, not part of the project). The `srt-to-txt-converter.py` lives there for reuse; it's MIT-spirit reusable but not tracked here.

---

## 6. Quick reference commands

```powershell
# Status
git -C "C:\Users\Admin\Documents\Study\AI\yegor" status --short
git -C "C:\Users\Admin\Documents\Study\AI\yegor" log --oneline -n 10

# Verify a skill is loadable
Get-ChildItem "C:\Users\Admin\.claude\skills\yegor-*"

# Bump a skill (manual workflow)
# 1. Edit skills/yegor-<slug>/SKILL.md
# 2. Update version field in frontmatter
Set-Content "skills\yegor-<slug>\VERSION" "0.1.1"
# 3. Add CHANGELOG entry
# 4. Commit
git commit -am "yegor-<slug> 0.1.1: <reason>"

# Use the script anywhere
python "C:\Users\Admin\Documents\Study\AI\yegor\scripts\srt-to-txt-converter.py" input.srt
```

---

## 7. Future maintenance prompts

The source of truth for these skills is **this repo**. Freshness checks should look here, not directly at Yegor's blog.

### "Is my installed skill up-to-date?"

1. Note the local `version:` field (in `SKILL.md` frontmatter or the `VERSION` file).
2. Compare against the repo's latest:
   ```powershell
   git -C "C:\Users\Admin\Documents\Study\AI\yegor" log --oneline -- skills/yegor-<slug>/
   Get-Content "C:\Users\Admin\Documents\Study\AI\yegor\skills\yegor-<slug>\CHANGELOG.md" -Tail 30
   ```
3. If working from a clone of a GitHub remote (see §8): `git -C <repo-root> pull` to sync.
4. If the repo advanced past your local version, review the CHANGELOG entries since your last sync and decide whether to adopt.

### "A rule keeps tripping me up in real work"

That's the signal to refine. The flow:

1. Edit the rule in `skills/yegor-<slug>/SKILL.md`.
2. Bump VERSION + frontmatter version field (per §3).
3. Add a CHANGELOG entry naming the friction that triggered the change.
4. Commit. Push if this repo has a remote (`git push`).

### Consumers on other machines

- Treat the master branch of this repo as upstream.
- Personal customizations belong on a branch named `<machine>-tweaks` or similar; rebase onto master when adopting upstream changes.
- To pick up upstream: `git pull` in the directory the junctions point into. The junctions transparently surface the new content to Claude on the next session.

### Going deeper (low-frequency, deliberate)

If the question is "have Yegor's underlying views evolved?" rather than "is my installed copy current?", that's a research task, not a maintenance task. Re-run the research flow (read recent yegor256.com posts, update `research/philosophy_NN_*.md`, then bump the corresponding `skills/yegor-<slug>/` based on whether the philosophy itself shifted). This is the path Section 4 of `research/yegor_ideas_for_solo_dev_workflow.md` describes.
