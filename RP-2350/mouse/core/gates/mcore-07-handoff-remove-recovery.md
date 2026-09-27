# MCORE-07 — Handoff, Remove & Recovery

Status: **BLOCKED**.

## Objective

Complete multi-step product transactions and recovery semantics around Pair New, removal, cancellation and power/session faults.

## Dependencies

MCORE-06 ACCEPTED.

## Tasks

1. Atomic authoritative-session handoff.
2. Live Mouse removal cleanup + persistent/bond deletion.
3. Preserve old current on Pair cancel/timeout before commit.
4. Correlation/stale/late result safety under real async callbacks.
5. Reboot/power recovery for interrupted transactions.

## Automated / documentary acceptance

- [ ] single-live invariant under all faults
- [ ] remove only reports success at commit
- [ ] late callbacks cannot resurrect abandoned operation
- [ ] recovery fixtures deterministic

## Human acceptance

- [ ] physical handoff/remove/fault scenarios accepted

## Deliverables

- UI layout changes
- final product composition

## Forbidden scope

- transaction/recovery implementation
- MCORE-07 evidence

