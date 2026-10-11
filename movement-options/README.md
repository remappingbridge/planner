# RemappingBridge — Movement Options | Implementation candidate

Status: **MOV-01–MOV-09 ACCEPTED / MOV-10 HOST CI 59/59 + PICO UF2 PASS / MOV-10 PHYSICAL PENDING**
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

## Current execution gate MOV-06 (2026-10-10)
- The operator accepted MOV-05 (Vertical Fast): see executions/MOV-05/physical-acceptance.md.
- MOV-06 Rotation (0/90/180/270) with H/V output-axis scaling and 270° + H2x has dedicated host test tests/test_mov06_rotation.c; 53/53 tests PASS on commit `e6834c3bc1a28b3ce20f0e6c192d15ba65daf5f5`.
- CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38098014017, host 53/53 PASS and Pico UF2 PASS, artifact `11686117401`, UF2 SHA256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`. It is bit-for-bit identical to MOV-05.
- Physical checklist: executions/MOV-06/physical-acceptance.md. No physical acceptance yet.

## MOV-07 active gate (2026-10-10)
- Operator explicitly accepted MOV-06 Rotation: [acceptance](executions/MOV-06/physical-acceptance.md).
- MOV-07 Home Connected checks 4 connected HOME destinations, original Help/Back and lock behavior, saved-search/retry/reconnect and HID continuity while LCD locked.
- Dedicated host navigation test and Pico runtime-source guard added: `test_mov07_home_connected.c`, `test_mov07_home_runtime_source.py` (+2 tests), 55/55 PASS at source SHA `23657734a172f4bd9dc61665ff57acf5230b3568`.
- CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38098381892, host 55/55 PASS and Pico UF2 PASS, artifact `11686122817`. Extracted UF2 SHA256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`, byte-identical to the operator-accepted MOV-06.
- Physical instructions: [executions/MOV-07/physical-acceptance.md](executions/MOV-07/physical-acceptance.md). No physical acceptance yet.

## MOV-08 active gate (2026-10-10)
- Operator accepted MOV-07 Home Connected; the signed-off candidate is recorded at [executions/MOV-07/physical-acceptance.md](executions/MOV-07/physical-acceptance.md).
- MOV-08 Saved Devices tests per-mouse H/V/Rotation by logical bond and pagination, front-page current identity, identity-only cyan color, global-profile provenance, long names, disconnected/reconnected view, zero saved devices and safe Remove This navigation. No new screen is added.
- New test `tests/test_mov08_saved_devices.c` registered in CTest; 56/56 host tests PASS. Pico production UF2 PASS. Source SHA `7a18ee16a486a17d676f5ba10be58432a0965bc3`, CI https://github.com/remappingbridge/remappingbridge/actions/runs/38098664052. Artifact `11686753895`, UF2 SHA256 `bc29783cb23c75f046d115b22509b9a042c1c8c6aab98cb24eed7d97095b3f0e`, bit-for-bit identical to accepted MOV-07.
- Full physical checklist: [executions/MOV-08/physical-acceptance.md](executions/MOV-08/physical-acceptance.md). Awaiting operator confirmation.

## MOV-09 active gate (2026-10-10)
- Operator accepted MOV-08 Saved Devices (per-bond DPI/rotation and identity-only cyan): [executions/MOV-08/physical-acceptance.md](executions/MOV-08/physical-acceptance.md).
- MOV-09 Remove This Mouse tests bond-scoped deletion, Help/Cancel, pending single-command safety, storage rollback and failure handling. Firmware fix publishes `REMOVE_FAILED` when logical bond vanishes before removal, so UI can leave pending state.
- New C host test and Pico BLE source-contract test give 58/58 PASS on source SHA `6a75b6212a152e34fec457b481e9bb513e5898ae`, CI https://github.com/remappingbridge/remappingbridge/actions/runs/38099188203. Pico 2 W production build verified; artifact `11687290125`, UF2 SHA256 `dbbeb26fd013facccacb226d8b9e3bdba487871a146560f18c8ed28130721bdc`, differs from MOV-08 and REQUIRES reflash for this gate.
- Physical checklist (involves actual deletion of one mouse's bond/preferences): [executions/MOV-09/physical-acceptance.md](executions/MOV-09/physical-acceptance.md); requires operator confirmation.

## MOV-10 final gate (2026-10-11)
- Operator physically accepted MOV-09 on 2026-10-11. Acceptance record: [executions/MOV-09/physical-acceptance.md](executions/MOV-09/physical-acceptance.md).
- MOV-10 tests all new or updated Help screens as ONE combined gate: shared H/V Slow DPI Help, shared H/V Fast DPI Help, Rotation Help and Remove Mouse Help.
- Dedicated `tests/test_mov10_all_help.c` validates every full 9×21 Help screen, Any Key return including Y/A/B/JOY, no accidental APPLY/REMOVE/lock, exact parent and candidate/selection restore and pending removal safety. Test registered in CMake; host 59/59 PASS.
- CI: https://github.com/remappingbridge/remappingbridge/actions/runs/38136123704 for source SHA `f38c4984c2c1ebe28401dc9a3f410a62e132160a`; Pico production UF2 PASS, artifact `11701285206`, SHA-256 `dbbeb26fd013facccacb226d8b9e3bdba487871a146560f18c8ed28130721bdc`, byte-for-byte identical to accepted MOV-09; reflash unnecessary if MOV-09 remains installed.
- Operator physical checklist: [executions/MOV-10/physical-acceptance.md](executions/MOV-10/physical-acceptance.md). This final gate is **NOT yet accepted** and PR #22 stays Draft/unmerged.

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
