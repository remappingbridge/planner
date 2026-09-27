# UIC-03 — Async Results & Ownership

Status: **BLOCKED**.

## Objective

Freeze request correlation, completion, cancellation, stale/late handling and ordering semantics required by UI 1.0.

## Dependencies

UIC-02 ACCEPTED.

## Tasks

1. Define correlation/request identity and allocation ownership.
2. Define Pending/Success/Failure lifecycle for searches and product operations.
3. Define cancellation semantics: physical cancellation, logical invalidation, or both.
4. Specify that stale/late results cannot confirm abandoned/newer UI work.
5. Specify Pair New handoff ordering and single-live authority.
6. Specify profile apply and removal commit points.
7. Define connection-changed events independent of screen state.

## Automated / documentary acceptance

- [ ] race fixtures cover cancel+late result, stale operation, disconnect during active profile and Pair handoff
- [ ] all terminal states are unambiguous and correlated
- [ ] ordering prevents dual authoritative Mouse state
- [ ] commit points match frozen business rules

## Human acceptance

- [ ] architecture review accepts cancellation and ordering semantics

## Deliverables

- threading implementation
- specific event loop
- hardware timing proof

## Forbidden scope

- normative async/ordering section
- race sequence diagrams/fixtures
- UIC-03 evidence

