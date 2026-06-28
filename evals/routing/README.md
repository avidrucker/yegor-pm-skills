# Routing eval — yegor-pm family

A reusable regression suite that checks **skill triggering/routing**: given a realistic user prompt, does the right `yegor-*` skill fire, and do the keyword-trap negatives correctly fire *nothing*?

This is the cheapest, highest-leverage test for a large family with overlapping descriptions (bdd / tickets / review all touch issues; pdd / spikes / microtasks all touch breakdown). It catches **cross-triggering** and **false positives** without per-skill setup.

## Files
- `evals.json` — the labeled prompt set. Each entry: `prompt`, `expected_primary`, `acceptable` (also-defensible routes), `trap` (the overlapping skill we worry it mis-fires to), `should_trigger`.
- `skill_descriptions.md` — snapshot of the 18 family descriptions the router judges against. **Regenerate when descriptions change** (see below).
- `results-YYYY-MM-DD.md` — a dated scorecard from one run.

## How to run it

1. **Refresh the descriptions snapshot** (do this whenever any SKILL.md `description:` changed):
   ```bash
   cd skills
   out=../evals/routing/skill_descriptions.md; : > "$out"
   for d in $(ls -d yegor-* | sort); do
     f="$d/SKILL.md"; [ -f "$f" ] || continue
     name=$(awk -F': ' '/^name:/{print $2; exit}' "$f")
     desc=$(awk '/^description:/{flag=1; sub(/^description: */,""); print; next} flag && /^[a-zA-Z_]+:/{flag=0} flag{print}' "$f" | sed 's/^ *//' | tr '\n' ' ' | sed 's/  */ /g')
     printf '### %s\n%s\n\n' "$name" "$desc" >> "$out"
   done
   ```

2. **Judge each prompt with an independent router subagent.** For every entry in `evals.json`, spawn one subagent that:
   - reads `skill_descriptions.md`,
   - is told to act as Claude's skill router for the single `prompt`,
   - returns ONLY JSON: `{"primary": "<skill|none>", "secondary": [...], "confidence": "high|medium|low", "reasoning": "<=40 words"}`.

   Run them independently (no shared context) so prompts don't anchor each other. The exact subagent instruction used in the 2026-06-28 run is reproduced in `results-2026-06-28.md`'s method note and `docs/skills-eval-findings.md`.

3. **Score** `primary` against `expected_primary` (exact) and `acceptable` (soft pass), and confirm every `should_trigger: false` prompt routed to `none`. Write a new `results-YYYY-MM-DD.md`.

## Caveats (these bound how much a clean score means)
- **Router-judge ≈ live triggering, not identical.** The live harness also weighs "is this hard enough to need a skill" and has the meta `yegor-pm` + all non-yegor skills competing; this suite isolates the family.
- **n=1 per prompt** here. For a variance estimate, run each prompt 3× and report the trigger rate (the approach `skill-creator`'s `run_loop.py` uses).
- **The prompt set is only as hard as you make it.** The 2026-06-28 set was clean archetypes — good for confirming no cross-fire, weak at finding bugs. Add under-specified prompts, two-skills-in-sequence prompts, and meta-orchestrator-must-route-down prompts to actually stress it.

See `docs/skills-eval-findings.md` for the full writeup and the broader testing toolkit (behavioral evals, version A/B).
