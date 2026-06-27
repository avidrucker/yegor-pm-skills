# Research: Testing & Measuring Yegor-PM Hermes Skill Quality

## Audit findings — current state (18 skills)

### Structure consistency: PASS
All 18 installed skills have:
- Valid YAML frontmatter with `name`, `description`, `version`, `author`, `license`, `platforms`
- `metadata.hermes` block with `tags` and `related_skills`
- `related_skills` as inline YAML list

### Leakage audit: PASS
- No "Rules for Claude" sections remaining
- No "This Codex port keeps the behavior" notes
- No OpenAI/Codex-specific references (only legitimate meta-references like "consult the Claude source")

### Cross-reference integrity: PASS
All `related_skills` entries point to installed skills (no dangling references).

### Duplicate check: PASS
No collisions — each skill name maps to exactly one directory.

---

## Proposed testing strategy

### Layer 1 — Structural smoke test (scriptable, CI-friendly)

A script that verifies each SKILL.md:

```
For each skill dir in ~/.hermes/skills/yegor-*/:
  1. Frontmatter parses as valid YAML
  2. Required fields present: name, description, version, metadata.hermes.tags, metadata.hermes.related_skills
  3. name matches directory name (e.g. yegor-bdd/SKILL.md has name: yegor-bdd)
  4. No forbidden patterns: "Rules for Claude", "This Codex port", "Claude should"
  5. Every entry in related_skills resolves to an existing skill dir
  6. Body has at least one H2 section (not empty)
  7. Line count within reasonable bounds (30–300 lines — flags truncation or bloat)
```

**Tooling:** A shell script (`tests/skill-smoke.sh`) using `yq` or Python for YAML parsing. Exit 0 = all pass, exit 1 = failures listed.

**Run:** After every new port or edit to an existing port.

### Layer 2 — Semantic completeness test

Verify the port covers all sections from the Claude source:

```
For each ported skill:
  1. Read the Claude source (skills/yegor-X/SKILL.md)
  2. Extract H2 section headers
  3. For each source section, check if the Hermes port has a corresponding section (fuzzy match — not exact string, but topic coverage)
  4. Flag sections present in source but missing in port
```

**Tooling:** A Python script (`tests/skill-completeness.py`) that diffs section headers. Not automated in CI (requires reading the Claude source which may not be present in all environments), but run during the porting workflow.

### Layer 3 — Behavioral test (agent-level)

Verify the skill actually influences agent behavior when loaded:

```
For each skill, define 2-3 test prompts that should trigger the skill:
  - A prompt that should cause the agent to invoke the skill's guidance
  - A prompt where the skill's anti-patterns should be applied
  - A prompt where the skill's rules should be enforced

Run each prompt through the agent and check:
  - Did the agent follow the skill's rules?
  - Did the agent catch violations (e.g., weak title, missing evidence)?
  - Did the agent apply the correct workflow (e.g., two-PR, architect/courier separation)?
```

**Tooling:** This is the hardest layer. Options:
- Manual: run test prompts after each port, record results
- Semi-automated: a test harness that sends prompts to the agent and checks responses for expected keywords/behaviors
- Future: golden test suite with expected outputs

### Layer 4 — Regression detection

Detect when a skill edit breaks something:

```
After each edit:
  1. Re-run Layer 1 (structural smoke test)
  2. Compare line count vs previous — flag >50% change
  3. Verify description field still matches source (semantic similarity or manual review)
```

---

## Quality rubric (measurable criteria)

| Dimension | Metric | Pass threshold |
|-----------|--------|----------------|
| **Structural integrity** | Script exits 0 | All 7 checks pass |
| **Frontmatter completeness** | All required fields present | 6/6 fields |
| **Name consistency** | name == directory name | Exact match |
| **No leakage** | Forbidden pattern count | 0 |
| **Cross-reference integrity** | Dangling related_skills count | 0 |
| **Section coverage** | % of source H2 sections present in port | >= 80% |
| **Body substance** | Line count | 30–300 (not empty, not bloated) |
| **Description accuracy** | Description captures source's core philosophy | Manual review |
| **Agent compliance** | Test prompt pass rate | >= 2/3 prompts produce expected behavior |

---

## Concrete metrics to track per skill

1. **Smoke test pass** (boolean): does `tests/skill-smoke.sh` exit 0?
2. **Section coverage** (percentage): how many source sections are covered
3. **Line count** (number): tracks bloat/truncation over time
4. **Agent compliance score** (0-3): how many test prompts produce correct behavior

---

## Proposed workflow

### When porting a new skill:
1. Create the SKILL.md in `~/.hermes/skills/yegor-X/SKILL.md`
2. Run `tests/skill-smoke.sh` — must pass
3. Run `tests/skill-completeness.py` — review any missing sections
4. Run 2-3 manual test prompts — verify agent behavior
5. File the closing comment citing test results

### When editing an existing skill:
1. Edit the file
2. Re-run `tests/skill-smoke.sh` — must still pass
3. Verify line count hasn't changed by >50% (unless intentional rewrite)
4. Re-run test prompts if the edit changes behavior

### When improving a skill:
1. Run the full audit to establish baseline
2. Pick the lowest-scoring dimension
3. Improve it
4. Re-run audit to confirm measurable improvement
5. Close with metrics before/after

---

## Immediate action items

1. **Create `tests/skill-smoke.sh`** — the structural smoke test is the highest-value, lowest-effort tool. It catches real problems (broken frontmatter, dangling refs, leakage) and is fully scriptable.

2. **Define test prompts for each skill** — start with the most-used skills (yegor-bdd, yegor-pdd, yegor-architect). Even 2-3 prompts per skill gives us a behavioral baseline.

3. **Establish a "done" gate** — a skill is considered correctly ported when:
   - `skill-smoke.sh` passes
   - Section coverage >= 80%
   - At least 2/3 test prompts produce expected behavior

4. **Clean up the duplicate yegor-bdd** — there's a duplicate at `software-development/yegor-bdd/` that should be removed (blocked by user consent).

---

## What we should NOT do

- Don't try to test "agent does the right thing" with 100% coverage — it's an LLM, not a deterministic program. The behavioral test is a spot-check, not a proof.
- Don't enforce exact line counts or rigid formatting — the rubric uses bounds, not targets.
- Don't block a port on 100% section coverage if the source section doesn't apply to Hermes (e.g., "Rules for Claude" is intentionally removed, not missing).
