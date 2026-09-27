# UIC-01 — Snapshot Model

Status: **BLOCKED**.

## Objective

Define the normative product truth Core can expose to UI without exposing Core internals.

## Dependencies

UIC-00 ACCEPTED.

## Tasks

1. Define saved Mouse identity/name/confirmed profile semantics.
2. Define zero/one current Mouse semantics and atomic snapshot consistency.
3. Define global Custom template/applied state ownership required by v1.
4. Define search/operation observable state needed for UI projection.
5. Define snapshot revision/lifetime semantics independent of callbacks.
6. Create snapshot fixtures for first-use, connected, offline, pending apply, dirty Custom, removal and handoff.

## Automated / documentary acceptance

- [ ] fixtures can reproduce all cross-boundary UI 1.0 states
- [ ] snapshot contains no screen/navigation/pixel fields
- [ ] snapshot invariant forbids more than one current authoritative Mouse
- [ ] confirmed profile cannot be confused with requested/pending profile

## Human acceptance

- [ ] review accepts snapshot as sufficient for all frozen UI screens/flows

## Deliverables

- final event transport API
- backend driver objects
- frontend-private Product View layout

## Forbidden scope

- normative Snapshot section
- language-neutral fixtures
- UIC-01 evidence

