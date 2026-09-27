# REMAPPING OPTIONS flow consolidation

Status: **AUTHORIZED BUNDLE / IMPLEMENTATION IN PROGRESS**.

Date: 2026-09-23.

## Operator authorization

The operator explicitly authorized implementing the remaining HOPE gates that belong to the `remapper-options` flow without waiting for physical acceptance between each screen, because these gates primarily consolidate already-existing profile/remap behavior behind the current Mouse UI v1 presentations.

HOPE-10 remains unaccepted until the resulting consolidated physical candidate is tested.

## Bundled gates

- HOPE-10 — remapper-options
- HOPE-29 — help-remapper-options
- HOPE-11 — passthrough-active
- HOPE-14 — passthrough-not-active
- HOPE-12 — standard-not-active
- HOPE-13 — standard-active
- HOPE-15 — escape-not-active
- HOPE-16 — escape-active
- HOPE-17 — custom-edit
- HOPE-18 — left
- HOPE-19 — right
- HOPE-20 — middle
- HOPE-21 — forward
- HOPE-22 — backward

These gates are implemented together on the existing `hope/hope-10-remapper-options` candidate branch and remain **PHYSICAL ACCEPTANCE PENDING** as one consolidated remapper-flow candidate.

## Authority comparison

The relevant sections in `mouse-ui/main` and `release/ui-layout-v1.0` are identical for all bundled screens. The current v1 text/behavior is therefore unambiguous.

## Operator improvements layered on top

Two explicit product improvements override the frozen v1 presentation where stated:

1. `remapper-options` title becomes **`REMAPPING OPTIONS`** instead of v1's `MOUSE OPTIONS`.
2. On `remapper-options`, exactly one profile may be cyan: the currently confirmed/applied profile. When a different profile becomes current, the previous profile must immediately revert to ordinary action tone. A selected row remains white even when it is the active profile.

## Consolidation requirements

- preserve the accepted runtime/persistence remap engine;
- replace legacy screen copy in-place rather than introducing parallel alternatives;
- use `STANDARD REMAP`, not historical `DEFAULT REMAP`;
- active/inactive preset screens use current Mouse UI v1 text;
- Custom apply success returns to `custom-edit`; no legacy `CUSTOM APPLIED` feedback screen remains in the flow;
- source editors use visible target order: LEFT, RIGHT, MIDDLE, ESCAPE, FORWARD, BACKWARD;
- source-editor current target is cyan, selected target white;
- KEY A applies selected source target and returns to Custom Edit; current Mouse UI behavior also permits Joy Press for that same action;
- KEY B from source editors returns to Custom Edit preserving the source row;
- Help owns KEY Y and returns to remapper-options preserving selection;
- active preset screens become their corresponding not-active screen if the current Mouse disconnects;
- global KEY Y lock behavior remains available on non-Help screens when a Mouse is saved, including screens where the hint is intentionally omitted.

## Acceptance policy

No bundled gate is marked ACCEPTED merely because implementation/CI succeeds.

The final consolidated UF2 must receive operator physical acceptance before promotion.
