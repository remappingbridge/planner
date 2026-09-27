# MINT-02 — Contract Binding

Status: **BLOCKED**.

## Objective

Bind production mouse-ui adapter to accepted mouse-core contract implementation in the embedded runtime.

## Dependencies

MINT-01 ACCEPTED.

## Tasks

1. Wire Snapshot/Event publication to UI adapter.
2. Wire UI Intents to Core dispatcher.
3. Define scheduling/poll cadence without changing contract semantics.
4. Exercise all neutral conformance fixtures in composed runtime.
5. Prove mock is absent from production data path.

## Automated / documentary acceptance

- [ ] contract fixtures pass composed
- [ ] no mock-backed product state in production
- [ ] single-live/current/profile states project correctly

## Human acceptance

- [ ] integration trace review

## Deliverables

- new contract semantics
- hardware flow acceptance yet

## Forbidden scope

- production binding
- MINT-02 evidence

