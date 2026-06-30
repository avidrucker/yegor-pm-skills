# assess-request-quality — routing regression results

**Date:** 2026-06-29 · 3-way cross-fire check (vs `issue-review-skill`, `assess-goal`), 1 independent router each.

| Probe | Prompt (gist) | Expected | Got | Verdict |
|---|---|---|---|---|
| PR1 | "just clean up this gross config file" | assess-request-quality | assess-request-quality | ✅ |
| PR2 | "review issue #42, is it agent-ready?" | issue-review-skill | issue-review-skill | ✅ no cross-fire |
| PR3 | "sharpen my goal to get fit this year" | assess-goal | assess-goal | ✅ no cross-fire |

**Score: 3/3 — no cross-fire.** Pre-mortem Risk-4 (the skill worsening the routing it was born from) is mitigated: `assess-request-quality` fires only on the vague work-request and yields cleanly to its two nearest neighbours.

**Follow-up (when #31 lands):** fold PR1–PR3 into `evals/routing/evals-hard.json` for a full-family run.
