# MCORE-08 — Core Hardware Baseline

Status: **BLOCKED**.

## Objective

Freeze an accepted Core implementation conforming to UI↔Core v1 with physical backend evidence.

## Dependencies

MCORE-07 ACCEPTED.

## Tasks

1. Run full released contract conformance.
2. Run complete physical Bluetooth/USB/persistence/remap matrix.
3. Sanitizer/static/host tests where applicable.
4. Architecture/dependency audit.
5. Freeze exact Core commit and evidence.

## Automated / documentary acceptance

- [ ] all host/conformance tests green
- [ ] all contract invariants pass
- [ ] build reproducible

## Human acceptance

- [ ] explicit acceptance of physical backend matrix

## Deliverables

- final UI+Core integration claim

## Forbidden scope

- accepted Core baseline ref
- hardware evidence
- MCORE-08 record

