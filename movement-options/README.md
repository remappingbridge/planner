# RemappingBridge — Movement Options | Implementation candidate

Status: **MOV-01 + MOV-02 + MOV-03 + MOV-04 ACCEPTED / MOV-05 HOST CI 52/52 + PICO UF2 PASS / MOV-05 PHYSICAL PENDING**
Date: 2026-10-10.
Owner repository: remappingbridge/remappingbridge.
Planning repository: remappingbridge/planner, directory at repository root: movement-options/.
Target branch already created: feature/movement-options-v1.0.
Immutable implementation baseline: release/v1.0.0 @ 30c4dd87922bb566248832ba4716774c0cb29755.
Baseline at branch creation: identical to release/v1.0.0 (0 ahead / 0 behind), before implementation. The feature branch now contains unmerged Movement Options changes.
Do not modify release/v1.0.0, product main, blu2usb or mouse-ui for this feature; work only on the isolated implementation branch.

## Scope
Plan a new navigable MOVEMENT OPTIONS flow on connected HOME, with independent horizontal/vertical relative-pointer gain, four counterclockwise rotations, per-saved-Mouse persistence, Saved Devices display, and deletion/help copy. Preserve existing remapping, pairing, reconnect, keyboard Escape, Logitech HID++, lock and USB identity.

**Planning baseline is immutable.** Implementation began only after explicit authorization on 2026-10-10. The product branch now contains screen and runtime changes; this planner directory does not carry firmware code. No gate is accepted without operator physical validation.


## Current execution gate (2026-10-10)
- Operator accepted MOV-03 after testing candidate `326c5f11164932aad5415783197d01cbc180de2e` (50 host tests and Pico UF2 passed), including Saved Devices only-connected-name cyan rule.
- MOV-04 Vertical Slow dedicated host test added and passed as part of 51/51 tests for source SHA `036e5bd930b11b3c79ceeac6332dac7c21844d57`; Pico production build completed: https://github.com/remappingbridge/remappingbridge/actions/runs/38097344728, artifact `11686156439`, UF2 SHA256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`. Binary is identical to MOV-03 because no firmware runtime changes were required in MOV-04, only new tests.
- Read `executions/MOV-04/{pre-implementation,candidate,physical-acceptance}.md`; no physical acceptance for MOV-04 yet.

## Current execution gate MOV-05 (2026-10-10)
- MOV-04 Vertical Slow received explicit operator acceptance on 2026-10-10; record: [executions/MOV-04/physical-acceptance.md](executions/MOV-04/physical-acceptance.md).
- MOV-05 Vertical Fast (1.25/1.5/2/3x) has a dedicated 52nd host regression test and 52/52 PASS in CI https://github.com/remappingbridge/remappingbridge/actions/runs/38097711254 for SHA `59c01a2bcec78267fa2b0baa0ddfa4989353a4c7`.
- Runtime was already staged; MOV-05 adds focused tests, not firmware code. Pico UF2 artifact `11686186807` has SHA-256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`, identical to MOV-04. No additional flash is necessary if MOV-04 is still installed. Physical acceptance remains PENDING.
- Physical walkthrough: [executions/MOV-05/physical-acceptance.md](executions/MOV-05/physical-acceptance.md).

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
- On 2026-10-10 the operator accepted MOV-01 (see executions/MOV-01/physical-acceptance.md). MOV-02 candidate `f13425c2c1ec8642803fa2398cd3f67606d440e6` passed 49/49 host tests and Pico 2 W production build in run 38095384245. Artifact `11685218547`, extracted UF2 SHA-256 `ef6b259dc2f75a8b71f441a94873aa2d23ed49b06ada23ad2c1fd70256d9e91d`. MOV-02 was accepted by the operator on 2026-10-10 (see executions/MOV-02/physical-acceptance.md). MOV-03 now covers Horizontal Fast DPI and the requested Saved Devices identity-only cyan treatment. MOV-03–MOV-10 remain pending physical acceptance.
- Order changed at operator request: connected HOME is navigable from first development stage so tests start in HOME. No screen is physically ACCEPTED yet.

## To resume
Check this directory, compare target branch HEAD to pinned release, read the gate plan, implement only an authorized gate in feature/movement-options-v1.0, record exact commit SHA/build/test evidence, obtain operator physical acceptance before marking any gate ACCEPTED. Do not merge or publish a release without a separate decision.
