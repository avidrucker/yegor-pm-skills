# Zerocracy & Yegor Bugayenko: 2026 Status, Architecture, and Evolution of Views

> **Original research query:** Investigate Zerocracy and Yegor's other automated tools for managing software engineering work as inspired by the XDSD talk. What's their current status in 2026 (maintained, growing, declining, deprecated)? Piece together the architecture of his project-management automation suite. Has Yegor's view on software project management evolved since the 2016 talk?
>
> **Sources consulted:** yegor256.com homepage and tag pages, github.com/zerocracy, github.com/0crat, github.com/yegor256/xdsd, zerocracy.com, multiple 2025–2026 blog posts, Crunchbase profile.
>
> **Research date:** 2026-05-23

## 1. Zerocracy — current status (May 2026)

**Active, but pivoted.** Two things happened: the company-as-a-business mostly receded (Yegor stopped being CEO in Sept 2019; he's now Director of the System Programming Lab at Huawei in Moscow), but the tooling under the `zerocracy` GitHub org is actively maintained right now — most repos have commits within the last week (`judges-action`, `baza.rb`, `pages-action`, `fbe`, `pgtk` all touched May 18–23 2026).

Meanwhile the original `0crat` / "Zerocrat the bot" identity is essentially dormant in public: the `0crat` GitHub account has zero public repos. Blog coverage tagged `zerocracy` peaked in 2018 (12 posts) and tapered off in early 2019 — the last post tagged "zerocracy" on yegor256.com is from March 2019. So the *brand* and *marketing momentum* have declined, but the *engineering* underneath has been rebuilt around a new architecture.

Popularity is **niche but stable**: star counts are modest (`judges-action` 31★, `pages-action` 15★, `zerocracy-mcp-server` 9★, the original `yegor256/xdsd` 45★). It's not gaining mainstream traction; it's a small platform with a committed maintainer.

## 2. Architecture of the 2026 automation suite

The pipeline today is a **self-hostable GitHub-Actions pipeline**, not a SaaS chatbot anymore:

```
GitHub repo activity
        │
        ▼
┌────────────────────┐    cron (hourly)
│  judges-action     │  ◄── Ruby GitHub Action
│  (runs "judges")   │
└─────────┬──────────┘
          │ emits
          ▼
┌────────────────────┐
│     Factbase       │  ◄── structured store of facts/points/judgments
│  (fbe library)     │
└─────────┬──────────┘
          │ consumed by
          ▼
┌────────────────────┐
│   pages-action     │  ◄── XSLT → HTML dashboard
│  (gh-pages site)   │
└─────────┬──────────┘
          │
          ▼
   Zerocrat bot → GitHub issue comments notifying devs of points
```

Component roles:

- **Judges** — pluggable evaluation modules. Each judge inspects activity and awards/deducts points (rewards merged PRs, penalizes stale work, etc.).
- **Factbase** (`fbe` = "FactBase Extended") — the accumulating ledger of all findings.
- **Swarms** (`swarm-template`) — scaffolding for teams to build *their own* judge bundles. Decentralization moved into the tool itself: instead of one central judge, you spin up swarms.
- **`baza.rb`** — Ruby client for the Zerocracy API.
- **`pgtk`** — PostgreSQL toolkit underpinning persistence.
- **`zerocracy-mcp-server`** (TypeScript, latest release May 2025) — exposes the platform to Claude Desktop / AI agents via MCP. Paired with the GitHub MCP server it produces what they call "AI-driven vibe-management."

Onboarding flow per zerocracy.com/how-it-works: register → get token → install the GitHub Actions workflow → judges run on schedule → HTML summary published → Zerocrat bot posts scores. Real-money payout is optional ("microbudgeting" funded by the customer).

## 3. Has his view evolved since 2016?

**Core philosophy: largely the same. The mechanism: substantially modernized.**

What hasn't changed:

- Ticket-driven communication remains sacred. The May 2025 post "Stop Asking and Suggesting — Just Complain" argues for **Bug Driven Development**: every piece of work is a *complaint* demanding a code patch, not a discussion. Same NoMeetings / "communication through tickets" pillar from the 2016 talk, sharpened.
- Architect-driven discipline. The May 2026 post "Couriers, Not Coders" reiterates: developers must get the architect's acceptance *before* opening a PR; trust is earned by delivering flawless work that merges without rechecking. Direct continuation of XDSD's "final design decisions are made by one person."
- The XDSD repo and xdsd.org are still up and not archived.

What's evolved:

- **From centralized SaaS bot → decentralized GitHub-native pipeline.** The 2018 "Zerocrat: a project manager that never sleeps" was a chatbot product you paid to host your project. The 2024–2026 incarnation is a GitHub Action + Factbase that you install in your own repo and can extend with your own judges. The architecture itself became "extremely distributed."
- **AI is now first-class.** The March 2026 post "Fast Software: More Programmers, Not Fewer" reframes programmers as *AI operators* — small shops will build IDE-scale products for a few thousand dollars; the world needs *more* of these operators, not fewer. The MCP server (released May 2025) bakes AI assistants directly into the management loop.
- **The economics are quieter.** The 2016/2018 era leaned hard on per-task payment as the primary motivator. The current public-facing material foregrounds *points and dashboards*; monetary payout is now an optional add-on for funded teams rather than the central pitch.

**Bottom line:** XDSD's philosophy — individual responsibility, ticket-mediated communication, architect-led design, results over hours — is intact and Yegor still writes from it in 2025–2026 posts. The Zerocracy *product* moved from "chatbot startup" to "open-source GitHub-Actions pipeline with an MCP server bolted on," reflecting both his exit from CEO and the AI-agent era. The brand is past its hype peak (declining mindshare since 2019), but the codebase is alive this month.

## Sources

- [Yegor's blog homepage](https://www.yegor256.com/)
- [Zerocracy posts tag (chronology)](https://www.yegor256.com/tag/zerocracy.html)
- [Bug Driven Development (May 2025)](https://www.yegor256.com/2025/05/25/bug-driven-development.html)
- [Fast Software: More Programmers, Not Fewer (Mar 2026)](https://www.yegor256.com/2026/03/05/fast-software.html)
- [Couriers, Not Coders (May 2026)](https://www.yegor256.com/2026/05/03/no-mercy.html)
- [Zerocracy GitHub org](https://github.com/zerocracy)
- [judges-action repo](https://github.com/zerocracy/judges-action)
- [zerocracy-mcp-server](https://github.com/zerocracy/zerocracy-mcp-server)
- [swarm-template](https://github.com/zerocracy/swarm-template)
- [zerocracy.com/how-it-works](https://www.zerocracy.com/how-it-works)
- [0crat GitHub account (now empty)](https://github.com/0crat)
- [yegor256/xdsd repo](https://github.com/yegor256/xdsd)
- [xdsd.org](https://www.xdsd.org/)
- [Yegor Bugayenko on Crunchbase (career history)](https://www.crunchbase.com/person/yegor-bugayenko)
