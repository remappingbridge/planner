# UIC execution process

## Branches

Use focused branches in the repository that owns the artifact being changed, e.g. `uic/uic-00-semantic-inventory` in `remappingbridge/mouse`. Adapter candidates use corresponding branches in `mouse-ui`/`mouse-core`.

## Evidence

Record each executed gate under `mouse/contracts/executions/<gate>/` with exact commits, checks, known limitations and acceptance.

## Release discipline

`contracts/ui-core/releases/v1.0.0/` may be created only by UIC-08 after both sides demonstrate conformance. Draft naming does not imply compatibility guarantees.

## Change control

If contract analysis discovers a required UX change, stop and open a versioned mouse-ui candidate; do not silently edit frozen UI Layout 1.0.
