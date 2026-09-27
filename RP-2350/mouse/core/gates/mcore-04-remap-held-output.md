# MCORE-04 — Remap & Held-output Safety

Status: **BLOCKED**.

## Objective

Implement Passthrough/Standard/Escape/Custom transformations and one centralized held-output cleanup policy.

## Dependencies

MCORE-03 ACCEPTED.

## Tasks

1. Pure remap engine for four profile kinds.
2. Global Custom template consumption.
3. Synthetic Escape state alongside Mouse output state.
4. Cleanup on disconnect/profile change/handoff/remove/reset.
5. Property/tests preventing stuck output.

## Automated / documentary acceptance

- [ ] mapping truth tables pass
- [ ] movement/wheel/pan policy preserved
- [ ] all transition paths release held output
- [ ] no output transport dependency in pure remap engine

## Human acceptance

- [ ] review held-output safety traces

## Deliverables

- TinyUSB transport
- persistence commit

## Forbidden scope

- remap engine
- state/cleanup tests

