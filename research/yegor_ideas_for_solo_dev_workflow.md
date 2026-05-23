# Applying Yegor / Zerocracy Ideas to a Solo Developer Workflow

> **Original research query:** How concretely could Zerocracy or Yegor's architecture ideas/solutions help me as a solo dev to stay organized and increase project momentum/velocity? How might rebuilding one or more of Yegor's services offer me personal value as a SWE/UX hybrid? What skills can I extract from his philosophies (e.g. Puzzle Driven Development, converting TODO comments into issues) to improve my workflows?
>
> **Research date:** 2026-05-23
>
> **Companion doc:** [zerocracy_2026_status_and_evolution.md](./zerocracy_2026_status_and_evolution.md)

---

## TL;DR

- **Install `pdd` and adopt puzzle syntax today.** It is the single highest-leverage idea for solo work — turns context-loss into tracked items automatically. Actively maintained (latest release Feb 2026).
- **Skip the `0pdd.com` hosted bot.** Latest release (Feb 2024) is literally tagged "web-service is broken." Use the CLI locally or self-host.
- **Borrow philosophies, not the full stack.** The Factbase / Judges / GitHub Actions pipeline is built for *evaluating other people* — it has little juice solo. BDD framing, micro-tasking, and ticket-as-decision-log do.
- **Rebuild for portfolio + UX value, not workflow.** The existing pages-action is XSLT with minimal UX polish — there's a real gap a SWE/UX hybrid could fill with a personal "dev-dashboard" tool.

---

## 1. The directly usable thing: Puzzle Driven Development (PDD)

This is the gem of Yegor's tooling for solo developers. It addresses the universal problem of *context loss between sessions*: you write a stub, leave a TODO, then forget what it was for or where it was.

### How it works

A puzzle is just a structured comment in your source code:

```java
/**
 * @todo #234:15m/DEV This validator doesn't handle the
 *  empty-string case yet. Need to decide whether to throw
 *  or coerce to null — see issue #234.
 */
```

The format:

- One of `@todo`, `TODO`, or `TODO:` keyword.
- `#234` — a ticket locator (typically the parent GitHub issue).
- `:15m` — time estimate (minutes).
- `/DEV` — role tag (optional).
- Free-text description.

The `pdd` CLI (`gem install pdd`) scans your codebase, emits XML listing every puzzle with location, ticket, estimate, and description. You then either pipe that into the `0pdd` hosted bot (which auto-files GitHub issues for new puzzles and auto-closes them when you delete the comment), or process the XML yourself.

### Why it matters for a solo dev

The XDSD talk pitched PDD as a way for one developer to *hand off* uncertain pieces to others. Solo, the value is different but real:

1. **Compiler-checked TODOs** — every deferred decision is forced into a structured, scannable form. No more "I'll remember this."
2. **Estimate hygiene** — the `:15m` discipline trains you to size tasks honestly. Repeated underestimates teach you about yourself.
3. **Self-handoff across sessions** — when you come back to a file in a week, `pdd` gives you a worklist instead of grepping for "TODO".
4. **Language-agnostic** — works on any file with comments; no IDE plugin lock-in.

### Solo recipe

```bash
gem install pdd
pdd --source . --file puzzles.xml   # scan
```

Add a pre-push hook that runs `pdd` and lists unresolved puzzles. Optionally write a tiny script that converts the XML into GitHub issues via `gh issue create` — that gives you the 0pdd workflow without the broken hosted bot.

---

## 2. Status check on every tool in his suite, from a solo-dev lens

| Tool | What it is | Maintained? | Useful solo? |
|---|---|---|---|
| `yegor256/pdd` CLI | Scans code → XML of puzzles | ✅ active (Feb 2026) | **Yes — install today** |
| `yegor256/0pdd` bot | GitHub bot auto-files puzzles as issues | ⚠️ marked "broken" Feb 2024 | Self-host or DIY with `gh` CLI |
| `zerocracy/judges-action` | GH Action that scores team activity into a Factbase | ✅ active (May 2026) | Limited — gamification needs peers |
| `zerocracy/pages-action` | Renders Factbase → HTML dashboard | ✅ active (May 2026) | Limited — but UX-poor (XSLT), see §4 |
| `zerocracy/fbe` | Factbase Extended library | ✅ active | Internal library — only if you build on the stack |
| `zerocracy/swarm-template` | Scaffolding to build judge bundles | ✅ active | Only if rebuilding |
| `zerocracy/zerocracy-mcp-server` | Exposes Zerocracy to Claude/AI via MCP | ✅ active (May 2025) | Only if you use the full pipeline |
| `yegor256/xdsd` (methodology repo) | Methodology site | 🟡 dormant-ish, not archived | Reading reference |

The headline: **`pdd` is the only piece you can install and immediately benefit from as a solo dev.** Everything else either assumes a team or is infrastructure for the team-evaluation pipeline.

---

## 3. Extractable philosophies (the higher-leverage layer)

The tools are narrow; the principles travel. These are the ones that adapt well to solo work:

### 3a. Bug Driven Development — frame every change as a complaint

From his May 2025 post: every piece of work — feature, refactor, doc fix — is filed as a *complaint*. The complaint must justify itself or it doesn't get worked.

**Solo application:** issue titles start with what's wrong, not what's wanted. "The settings dialog is unreachable from the editor" beats "Add settings entry point." It forces you to articulate the pain, which is the same exercise UX research demands. Two birds.

### 3b. Micro-tasking — sub-1-hour units, always

XDSD's defining mechanic: tasks ≤ ~1 hour, "thousands per mid-size project." The 2014 "Incremental Billing" post puts the rationale as fine-grained tracking + motivation + flexibility.

**Solo application:** if a ticket would take more than an hour, split it before starting. The split itself is design work. It also gives you frequent closure dopamine — critical when no one else is celebrating.

### 3c. The ticket *is* the conversation

"Stop Chatting, Start Coding" (2014) and the continued ticket-driven discipline in 2025/2026 posts: decisions don't exist until they're in the issue tracker. No verbal/Slack decisions.

**Solo application:** before you change direction, write the decision as an issue comment. Future-you reads it. This is the single most underrated practice for solo continuity — it lets you onboard yourself back into a project after months away.

### 3d. Architect-decides, then ship

"Couriers, Not Coders" (May 2026): the architect accepts the feature request *before* a PR is opened. The PR is delivery, not design.

**Solo application:** you wear both hats, so the discipline is *temporal separation*. Spend a session designing the issue (architect mode). Spend the next session implementing what's already been agreed (courier mode). Don't mix. This kills the most common solo failure mode: re-architecting mid-implementation.

### 3e. Velocity = closed tickets, not commits

The 250-developers / 25-projects data point from XDSD measured productivity in closed tasks, not LOC or hours.

**Solo application:** your weekly review counts closed issues. If the number is zero but the commit count is 40, you're churning, not progressing. This is a brutal but clarifying solo metric.

### 3f. NoHelp / documentation-first

From the 2016 talk (your 08:41 takeaway): XDSD discourages reliance on experts; knowledge sharing happens via docs.

**Solo application:** when you Google the same thing twice, write it into the repo's `NOTES.md`. You are the only expert; document yourself. This compounds.

---

## 4. Should you rebuild any of his services? (The SWE/UX hybrid angle)

**For workflow value: mostly no.** The existing pieces either work (`pdd`) or are team-oriented (everything in `zerocracy/`). Rebuilding for personal use would be re-doing solved problems.

**For learning + portfolio value: yes, selectively.** Here are the highest-leverage rebuild targets for someone with your hybrid skillset:

### Highest payoff — a polished personal puzzle dashboard

The existing `pages-action` is XSLT-rendered HTML. Functional but visually dated and inflexible. There's a clear UX gap a SWE/UX hybrid could fill:

- Modern web UI (React/Vue/Svelte — your pick) showing your puzzles, ticket velocity, time-to-close distribution, stalest issues.
- Fed by the `pdd` XML output + GitHub API.
- Shippable as a CLI that emits a static site, or a GitHub Action.

**What you'd learn:** GitHub API at depth, GitHub Actions authoring, XML/JSON pipelines, dashboard UX (sparse data, time-series, status states), shipping a hybrid CLI-and-web product. Strong portfolio piece because the *problem space is concrete* and the *existing alternative is ugly*.

### Medium payoff — a minimal puzzle scanner in TypeScript/Python

Reimplementing `pdd` itself in a language you use daily teaches you:

- Multi-language comment parsing (regex, basic lexing).
- Idempotent issue sync against GitHub (which is harder than it looks: dedup, closure detection, edit handling).
- Designing a config format and CLI ergonomics.

Smaller than the dashboard, but very crisp scope.

### Lower payoff — your own MCP server

The `zerocracy-mcp-server` shows the pattern. Building your own (e.g., exposing *your* PDD scanner + GitHub status + dev journal to Claude) is current, learnable in a weekend, and demonstrates AI-integration fluency. The downside: MCP server skeletons are now generic enough that the *novelty* is low.

### Don't bother rebuilding

- `judges-action` / `fbe` / `pgtk` — pure infrastructure for team scoring. No solo value, no UX surface, no interesting portfolio story.
- Full `0pdd` web-service rewrite — large surface area, narrow user base, mostly DevOps.

---

## 5. Concrete starter checklist

If you want to act on this in the next session:

1. `gem install pdd` (needs Ruby — install if not present).
2. Pick one active project. Add three puzzle comments in places where you currently have a vague mental note.
3. Run `pdd --source . --file puzzles.xml`. Look at the XML.
4. Open three GitHub issues from those puzzles manually. Note the ticket numbers.
5. Update the puzzle comments to reference the ticket IDs (`@todo #N:30m`).
6. Add a `NOTES.md` to that repo. Capture one decision in it.
7. At end of session, count: closed issues today vs commits today. Calibrate.

If you want to build instead of consume:

1. Spend 30 min reading the README of `yegor256/pdd` to see the XML schema.
2. Sketch a single-page web UI on paper: what would your *ideal* solo dashboard look like? (Closed-this-week, stalest puzzles, time-to-close trend.)
3. Decide whether the rebuild target is the *dashboard* (UX-heavy) or the *scanner* (parsing-heavy). Pick the one that's weaker in your current skill profile.

---

## Sources

- [pdd CLI on GitHub](https://github.com/yegor256/pdd)
- [0pdd hosted bot (web-service marked broken in latest release)](https://github.com/yegor256/0pdd)
- [Puzzle Driven Development article (2010)](https://www.yegor256.com/2010/03/04/pdd.html)
- [PDD in Action (2017)](https://www.yegor256.com/2017/04/05/pdd-in-action.html)
- [Incremental Billing (2014)](https://www.yegor256.com/2014/10/21/incremental-billing.html)
- [Stop Chatting, Start Coding (2014)](https://www.yegor256.com/2014/10/07/stop-chatting-start-coding.html)
- [Bug Driven Development (May 2025)](https://www.yegor256.com/2025/05/25/bug-driven-development.html)
- [Couriers, Not Coders (May 2026)](https://www.yegor256.com/2026/05/03/no-mercy.html)
- [Zerocracy GitHub org (architecture context)](https://github.com/zerocracy)
- [Companion doc: 2026 status and architecture evolution](./zerocracy_2026_status_and_evolution.md)
