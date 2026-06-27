#!/usr/bin/env bash
# tests/skill-smoke.sh — structural smoke test for yegor-pm Hermes skill ports
# Usage: bash tests/skill-smoke.sh [skill-name]
#        bash tests/skill-smoke.sh  (tests all yegor-* skills)
set -uo pipefail

SKILLS_DIR="${HOME}/.hermes/skills"
PATTERN="${1:-yegor-*}"
FAILED=0
PASSED=0
SKIPPED=0

# Forbidden patterns (Claude/Codex leakage)
FORBIDDEN=(
  "Rules for Claude"
  "This Codex port keeps the behavior"
  "Claude should use this"
  "When Claude should"
)

# Required frontmatter fields
REQUIRED_FIELDS=("name:" "description:" "version:" "metadata:")

check_skill() {
  local dir="$1"
  local name
  name=$(basename "$dir")
  local file="$dir/SKILL.md"

  if [[ ! -f "$file" ]]; then
    echo "  FAIL [$name] SKILL.md not found at $file"
    FAILED=$((FAILED + 1))
    return 1
  fi

  # 1. Required frontmatter fields
  for field in "${REQUIRED_FIELDS[@]}"; do
    if ! grep -q "^${field}" "$file"; then
      echo "  FAIL [$name] Missing frontmatter field: $field"
      ((FAILED++))
      return 1
    fi
  done

  # 2. name matches directory
  local yaml_name
  yaml_name=$(grep '^name:' "$file" | head -1 | sed 's/name: *//' | tr -d '"' | tr -d "'")
  if [[ "$yaml_name" != "$name" ]]; then
    echo "  FAIL [$name] Frontmatter name='$yaml_name' != directory name='$name'"
    ((FAILED++))
    return 1
  fi

  # 3. metadata.hermes.tags and related_skills present (4-space indent in nested YAML)
  if ! grep -q '^\s*tags:' "$file"; then
    echo "  FAIL [$name] Missing metadata.hermes.tags"
    ((FAILED++))
    return 1
  fi
  if ! grep -q '^\s*related_skills:' "$file"; then
    echo "  FAIL [$name] Missing metadata.hermes.related_skills"
    ((FAILED++))
    return 1
  fi

  # 4. No forbidden patterns
  for pattern in "${FORBIDDEN[@]}"; do
    if grep -qF "$pattern" "$file"; then
      echo "  FAIL [$name] Forbidden pattern found: '$pattern'"
      ((FAILED++))
      return 1
    fi
  done

  # 5. Body has at least one H2 section
  if ! grep -q '^## ' "$file"; then
    echo "  FAIL [$name] No H2 sections found in body"
    ((FAILED++))
    return 1
  fi

  # 6. Line count within bounds
  local lines
  lines=$(wc -l < "$file")
  if [[ "$lines" -lt 20 ]]; then
    echo "  FAIL [$name] Too short ($lines lines) — likely truncated"
    ((FAILED++))
    return 1
  fi
  if [[ "$lines" -gt 400 ]]; then
    echo "  WARN [$name] Very long ($lines lines) — possible bloat"
    ((SKIPPED++))  # warn but don't fail
  fi

  # 7. Cross-reference integrity: each related_skill resolves
  local refs
  refs=$(grep '^\s*related_skills:' "$file" | sed 's/.*related_skills: \[//;s/\].*//')
  if [[ -n "$refs" ]]; then
    IFS=',' read -ra ref_array <<< "$refs"
    for ref in "${ref_array[@]}"; do
      ref=$(echo "$ref" | tr -d ' ')
      if [[ ! -d "$SKILLS_DIR/$ref" ]]; then
        echo "  FAIL [$name] related_skill '$ref' not found in $SKILLS_DIR"
        ((FAILED++))
        return 1
      fi
    done
  fi

  echo "  PASS [$name] ($lines lines)"
  PASSED=$((PASSED + 1))
  return 0
}

echo "=== Yegor-PM Hermes Skill Smoke Test ==="
echo "Skills directory: $SKILLS_DIR"
echo "Pattern: $PATTERN"
echo ""

count=0
for dir in "$SKILLS_DIR"/$PATTERN; do
  [[ -d "$dir" ]] || continue
  check_skill "$dir" || true
  count=$((count + 1))
done

echo ""
echo "=== Results ==="
echo "Tested: $count"
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "Warnings: $SKIPPED"

if [[ "$FAILED" -gt 0 ]]; then
  exit 1
fi
exit 0
