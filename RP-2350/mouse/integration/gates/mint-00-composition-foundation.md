# MINT-00 — Composition Foundation

Status: **BLOCKED**.

## Objective

Create the final product build that pins compatible frozen UI, released contract and accepted Core revisions.

## Dependencies

MCORE-08 ACCEPTED.

## Tasks

1. Pin exact UI Layout 1.0-compatible UI revision, contract v1.0.0 and Core baseline.
2. Create reproducible RP2350 firmware composition/build.
3. Define ownership of clocks/event loop between UI and Core.
4. Create integration-only adapters; do not merge repositories' private internals.
5. CI builds exact pinned composition.

## Automated / documentary acceptance

- [ ] reproducible build
- [ ] component version compatibility checks pass
- [ ] no private cross-repo include leakage

## Human acceptance

- [ ] architecture review of composition

## Deliverables

- physical UX acceptance
- silent contract forks

## Forbidden scope

- integration build
- pin manifest
- MINT-00 evidence

