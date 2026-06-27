# Philosophy 24 — Trust-Based Dependency Versioning

> **Why this doc exists:** the `yegor-builds` skill makes builds reproducible
> through tiering; this doc adds the dependency-management half — how to pin
> versions by *trust* rather than dogmatically pinning or floating everything.
> Translated for solo + AI work, where an agent can audit manifests and turn
> version strategy into a recorded, checkable decision.
>
> **Primary source:**
> - Yegor Bugayenko, *My Recipe Against Dependency Hell* (2019-01-29) — https://www.yegor256.com/2019/01/29/dependency-hell.html

---

## The principle (paraphrased)

Two dogmatic version strategies both fail:

- **Pin everything to fixed versions, forever.** A *time bomb*: you never receive
  security or bug fixes until something forces a painful, all-at-once mass upgrade
  across a stale dependency tree.
- **Float everything (ranges/dynamic everywhere).** *Dependency hell*: a transitive
  minor/patch bump breaks your build with no warning and no clear culprit.

The middle path is **trust-based pinning**: decide each dependency's version
constraint by how much you trust its maintainers to honour semver.

- **Untrusted → fixed.** A small, sporadic, or low-reputation library gets an exact
  pin. You don't trust it to ship safe minors, so you absorb upgrades on your own
  schedule.
- **Trusted → ranges.** A high-reputation, actively-maintained, semver-disciplined
  library gets a range (`^`, `~>`, `>=`). You trust its minor/patch releases, so you
  take fixes automatically.

And the pin is a **decision with a recorded rationale**, not a habit.

## Why it works

- **It spends trust where it's earned.** Trusted projects have track records; floating
  them is low-risk and high-reward (free fixes). Untrusted ones don't; pinning them
  caps the blast radius of a bad release.
- **It dodges both failure modes.** Neither the stale-everything time bomb nor the
  float-everything surprise — risk is matched to the source.
- **A recorded rationale prevents future mystery.** "Why is this pinned to 1.2.3?"
  has an answer in the tracker, so a later maintainer (or agent) can re-evaluate
  instead of cargo-culting the pin.

## Canonical rules

- **Untrusted/low-reputation deps → fixed versions.**
- **Trusted/semver-disciplined deps → ranges.**
- **Record the trust rationale** with the pin (it's a decision — philosophy_04).
- **Avoid both extremes** — pin-everything (time bomb) and float-everything
  (dependency hell).

## Translating for solo + AI work

- **The agent audits the manifest.** It can scan `pom.xml`/`package.json`/`deps.edn`,
  flag deps that are fixed-pinned with no recorded reason or floated despite being
  low-trust, and propose a trust classification — making version strategy a
  reviewable decision rather than an accreted habit.
- **The agent records the rationale.** When it pins or floats, it writes the why next
  to the change (commit message + ticket), so the choice is auditable.
- **It pairs with the gate.** A floated low-trust dependency is exactly the kind of
  surprise the zero-tolerance merge gate (philosophy_19) exists to catch — but
  catching it at *pin time* is cheaper than at *break time*.

## Actionable guidelines

### How Claude should use this

- **When adding a dependency:** classify its trust (reputation, release cadence,
  semver discipline) and pick fixed-vs-range accordingly; record the reason.
- **When auditing a manifest:** flag unjustified fixed pins (time-bomb risk) and
  risky floats on low-trust deps (dependency-hell risk).
- **When a build breaks on an upgrade:** check whether the broken dep was over-trusted
  (floated when it shouldn't have been) and re-pin with a recorded note.

## Pitfalls

- **Pin-everything** — a stale tree that's a security/upgrade time bomb.
- **Float-everything** — transitive bumps breaking the build with no warning.
- **Unjustified pins** — a fixed version with no recorded reason, cargo-culted
  forever.
- **Mis-trusted dep** — floating a small/sporadic library as if it were a
  disciplined one.

## Integration with the other philosophies

- + [Tiered builds](./philosophy_12_four_builds_ci_maturity.md): reproducible builds
  depend on version strategy as much as on the build tiers.
- + [Tickets](./philosophy_04_tickets_ticket_as_conversation.md): a pin is a recorded
  decision, not a silent habit.
- + [Merge gate](./philosophy_11_merge_gate_readonly_master.md): a floated low-trust
  dep is the surprise the gate catches; pin-time is cheaper than break-time.

## One-line summary for Claude

> Don't dogmatically pin or float — pin by trust: fixed versions for
> untrusted/low-reputation deps (cap the blast radius), ranges for trusted
> semver-disciplined ones (take fixes for free), and record the reason for each.
> Pin-everything is a time bomb; float-everything is dependency hell.
