# HOPE-04 — pre-implementation

Status: **AUTHORIZED / IMPLEMENTED CANDIDATE IN VALIDATION**.

Date: 2026-09-24.

## Accepted baseline

- repository: `remappingbridge/remappingbridge`
- baseline main commit: `5c62a98a4495570237d7b4b223a090bea1020990`
- the consolidated remapper-flow physical candidate was explicitly accepted by the operator before HOPE-04 started.

## Gate scope

HOPE-04 implements only `saved-devices`.

- replace the inherited multi-device fake/legacy presentation in-place;
- show one saved Mouse per page;
- show page/count, name, connected/disconnected status and current profile;
- Joy Left/Right changes saved Mouse page;
- Key B returns through the HOME resolver;
- preserve global Key Y lock behavior when a Mouse is saved;
- remove the old Keyboard/Composite pairing UX paths required by the HOPE-04 plan;
- do not implement `remove-this` early: Joy Press remains inert until HOPE-05.

## Runtime constraint

The accepted firmware stores BLE bonds in BTstack LE device DB but only has a runtime name for the currently connected Mouse. HOPE-04 therefore uses the real connected bond index and real current name for the connected page, while disconnected pages use the canonical `UNKNOWN MOUSE` fallback. No speculative per-Mouse registry/persistence architecture is introduced in this gate.
