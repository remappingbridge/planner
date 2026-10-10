# RemappingBridge — Movement Options | Implementation candidate

Status: **IMPLEMENTATION CANDIDATE / HOST CI PASSED (48/48) / PICO CI PENDING / PHYSICAL ACCEPTANCE PENDING**
Date: 2026-10-10.
Owner repository: remappingbridge/remappingbridge.
Planning repository: remappingbridge/planner, directory at repository root: movement-options/.
Target branch already created: feature/movement-options-v1.0.
Immutable implementation baseline: release/v1.0.0 @ 30c4dd87922bb566248832ba4716774c0cb29755.
Baseline comparison: feature/movement-options-v1.0 is identical to release/v1.0.0 (0 ahead / 0 behind).
Do not modify release/v1.0.0, main, blu2usb or mouse-ui during this planning phase.

## Scope
Plan a new navigable MOVEMENT OPTIONS flow on connected HOME, with independent horizontal/vertical relative-pointer gain, four counterclockwise rotations, per-saved-Mouse persistence, Saved Devices display, and deletion/help copy. Preserve existing remapping, pairing, reconnect, keyboard Escape, Logitech HID++, lock and USB identity.

**Planning baseline is immutable.** Implementation began only after explicit authorization on 2026-10-10. The product branch now contains screen and runtime changes; this planner directory does not carry firmware code. No gate is accepted without operator physical validation.

## Sources and precedence
1. Operator's attachment 'telas movement(1).md', supplied 2026-10-10, especially explicit controls, copy, gate split and cyan rules. Source text takes priority for this new flow.
2. Runtime-verified RemappingBridge v1.0 code and final documentation (not superseded G06 proposals).
3. Existing accepted v1.0 behavior and design rules wherever the attachment is silent.
4. Experiments remappingbridge/blu2usb: experimental/g06-rotation-90 @ a8c4c1d and experimental/g06-rotation-90-horizontal-2x @ eb696be (reference-only, do not cherry-pick blindly).
5. Clearly labeled architectural/UI inference, resolved toward minimal change.

Known final v1.0 authorities:
- remappingbridge/remappingbridge/docs/hope/{00-final-screen-inventory,01-final-architecture,02-final-navigation}.md
- src/{ux_model/ux_model.c,renderer/renderer.c,app/main.c,ble_hogp/ble_hogp_pico.c,profiles/profiles.c,storage/storage_pico.c}
- RP-2350/hope in this planning repository for historical gate and operator acceptance process.
- Historical docs/ux and docs/technical descriptions are secondary if conflicting with final HOPE.

## Files
- 00-baseline-and-decisions.md — frozen baseline, source ambiguities, exact behavior/inference and explicit non-goals.
- 01-screen-contracts-and-navigation.md — complete screen inventory, texts, wireframes, input/Back/Help/lock behavior, colors and grid.
- 02-runtime-and-movement-math.md — pipeline, transform order, lossless chunking, atomic application, safety and exact physical mapping.
- 03-identity-persistence-and-migration.md — per-Mouse storage, BLE identity, migration, removal, error handling, recovery.
- 04-gates-tests-and-acceptance.md — exactly nine non-Help screen gates plus exactly one Help gate, dependencies, test/evidence matrix and status.
- 05-requirement-traceability.md — attachment-to-decision-to-test traceability, alternatives, and deferred questions.
- 06-physical-tests-per-gate.md — 30 physical test scenarios organized into MOV-01 through MOV-10, build/UF2 and operator acceptance instructions.

## Architectural invariants
- No second Core layer, UI↔Core framework, global event bus, debug screens, CDC interface or USB descriptor change.
- No host Input Remapper dependency; firmware must work from initial mouse connection and with LCD locked.
- No changes to Mouse button remapping semantics or global CustomTemplate.
- No personal settings leakage between bonded Mice; logical BLE identity, not ordinal, is the key.
- No accidental pointer motion loss, repeated transform or half-step loss when USB reports saturate.
- Save succeeds before confirming APPLY/RESET on screen; explicit failure leaves previous settings effective.
- UI actions fire on release; current values cyan, selected row white; saved Mouse controls remain available during reconnect/disconnect according to existing policies.
- All layouts use existing 9×21 grid/240×240 pixel relocation.

## Active implementation
- PR Draft #22: https://github.com/remappingbridge/remappingbridge/pull/22
- Product branch: `feature/movement-options-v1.0`, release base pinned as documented above.
- On 2026-10-10 host CI for SHA `337d929744b29bd0b8ce484779200c9b2174f40c` passed all 48 tests. Check Pico job and the final UF2 artifact for exactly that SHA before physical tests.
- Order changed at operator request: connected HOME is navigable from first development stage so tests start in HOME. No screen is physically ACCEPTED yet.

## To resume
Check this directory, compare target branch HEAD to pinned release, read the gate plan, implement only an authorized gate in feature/movement-options-v1.0, record exact commit SHA/build/test evidence, obtain operator physical acceptance before marking any gate ACCEPTED. Do not merge or publish a release without a separate decision.
