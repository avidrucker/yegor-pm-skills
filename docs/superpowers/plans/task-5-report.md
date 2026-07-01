# Task 5 Report — wire assess-request-quality into family indexes (#36)

## What was added to each file

### README.md
Added one row to the "What's inside" skills table, after `yegor-personas`:
```
| `assess-request-quality` | **Request clarity gate.** Diagnose whether a live, in-conversation work-request is clear enough to act on — gate → ambiguity count → six checks → clarifying questions, never fabricate. |
```

### GLOSSARY.md
Added a new section at the end (after the Meta section), matching the `## Section — \`skill\`` heading pattern:
```
## Request clarity — `assess-request-quality`

### `assess-request-quality`
Diagnoses whether a **live, in-conversation work-request** is clear enough to act on...
[+ boundary note distinguishing it from `issue-review-skill`]
```

### skills/yegor-pm/SKILL.md
Added a new "Related / sibling skills" section at the very end of the file (after Deep references and Companion docs), using a table matching the file's existing table pattern. `assess-request-quality` was placed here rather than in the yegor-* sub-skills table because it is not a `yegor-*` skill. The entry includes the boundary note: it diagnoses a **live, in-conversation request**, whereas `issue-review-skill` reviews an **already-filed GitHub issue**.

## Verification

```
grep -rl 'assess-request-quality' README.md GLOSSARY.md skills/yegor-pm/SKILL.md | wc -l
```
Result: **3** (expected: 3)

## Commit

Hash: `ba7015e`
Message: `docs: wire assess-request-quality into family indexes (#36)`
