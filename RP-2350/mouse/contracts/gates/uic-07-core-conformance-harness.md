# UIC-07 — Core Conformance Harness

Status: **BLOCKED**.

## Objective

Prove the v1 candidate is implementable from the Core side before committing to full hardware architecture.

## Dependencies

UIC-05 candidate available.

## Tasks

1. Create minimal mouse-core C project/conformance harness or semantic stub using only candidate contract types.
2. Implement deterministic state transitions for contract fixtures, not Bluetooth/USB drivers.
3. Exercise registry identities, current Mouse, search results, profile/removal operations and correlation races.
4. Prove Core can publish candidate Snapshot/Event semantics without including mouse-ui headers.
5. Feed conformance vectors shared with UIC-06.

## Automated / documentary acceptance

- [ ] shared conformance vectors pass
- [ ] no mouse-ui private header is included
- [ ] single-live/correlation/commit-point invariants pass
- [ ] harness does not claim hardware support

## Human acceptance

- [ ] Core architecture review confirms candidate boundary is implementable without transport leakage

## Deliverables

- mouse-core conformance harness
- candidate fixture results
- UIC-07 evidence

## Forbidden scope

- BTstack/TinyUSB production stack
- physical acceptance claims
- copying frontend Product View

