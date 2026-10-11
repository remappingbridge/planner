> 2026-10-10 EXECUTION OVERRIDE (explicit operator authorization): implementation has begun, and all screens have been staged on the isolated product branch. The operator requires any testable candidate to start from connected HOME, so MOV-07 HOME entry was advanced as a minimal prerequisite during MOV-01. This overrides the original note that the first reachable candidate would be MOV-07. MOV-01 and MOV-02 were physically accepted per operator statements on 2026-10-10; remaining gates await their own acceptance even where code and host tests pass. Exact manual scenarios, UF2 procedure and acceptance log are now in [06-physical-tests-per-gate.md](06-physical-tests-per-gate.md). PR Draft #22 is unmerged. Validated candidate SHA: ba64fdf9e1edd75c3f4f9be5116da8bb9f79fde8; 48 host tests and production UF2 build passed. Physical acceptance pending for all gates.

# Movement Options — implementation gates and acceptance protocol

Status: **MOV-01 E MOV-02 ACCEPTED; MOV-03 CI CANDIDATE; MOV-03–MOV-10 PHYSICAL ACCEPTANCE PENDING**. This historical plan is preserved below with the override above.
Target for future code: remappingbridge/remappingbridge / feature/movement-options-v1.0.
Base: release/v1.0.0 @ 30c4dd87922bb566248832ba4716774c0cb29755.
Planning evidence: remappingbridge/planner/movement-options/.

## Mandatory gate law
- Exactly ONE implementation gate for EACH of 9 non-Help screens (existing edited or new) and exactly ONE gate for ALL Help screens. This is 10 implementation gates, no stand-alone refactor/foundation gate.
- Infrastructure work belongs to the earliest screen gate requiring it, with explicit dependency and tests.
- A gate's code/test completion does not mean acceptance. Operator must verify the physical UF2 for the relevant observable flow. No auto-promotion to main or release.
- Planning files or creation of the target branch did not start MOV-01; execution began only after subsequent explicit authorization.
- No speculative/parallel legacy screens to fake a gate pass. No old layout as fallback for the modified home/saved/remove screens.
- Gates can be staged as one coherent feature branch; unreached screens remain host-test-only until user navigation is connected, and intermediate UF2 must NOT be presented as a full feature candidate. No debug-only navigation screens ship.
- For every gate, future execution record under movement-options/executions/MOV-XX/ should include pre-implementation.md, candidate.md, physical-acceptance.md, exact source HEAD, changed paths, test results, defect/rollback notes. These directories/files do not exist yet (no work started).
- On failure, fix in SAME gate, invalidate affected evidence, do not claim acceptance; no need to ask to start next gate when operator has separately authorized continuous work, but currently work is NOT authorized.

## Dependency-ordered screen gates

| Gate | Scope (one non-Help screen) | Implementation boundary / result |
|---|---|---|
| MOV-01 | movement-options | Add typed movement state, per-identity persistence, output math/chunk host tests and menu UI/RESET. Screen tested directly in UX host tests; NOT yet exposed from HOME. |
| MOV-02 | horizontal-slow-dpi | 0.25/0.5/0.75/1x, selection/current colors, col16, APPLY H only, cancel. |
| MOV-03 | horizontal-fast-dpi | 1.25/1.5/2/3x, col17, H Slow<->Fast wrap, retained draft and valid current state. |
| MOV-04 | vertical-slow-dpi | 0.25/0.5/0.75/1x, col16, APPLY V only, no H edits. |
| MOV-05 | vertical-fast-dpi | 1.25/1.5/2/3x, col17, V Slow<->Fast wrap, unaffected H. |
| MOV-06 | rotation | 0/90/180/270 CCW, exact direction math, apply/cancel, persists and updates runtime. |
| MOV-07 | home-connected | In-place fourth connected-HOME route. Remap remains first, Movement second, Saved third, Pair fourth; Help return index & wrap update; nonconnected HOME unchanged. This is first operator-reachable movement navigation. |
| MOV-08 | saved-devices | In-place per-identity H/V/rotation summaries for all saved pages, preserve actual existing profile semantics and selection/removal. |
| MOV-09 | remove-this | In-place warning, deletion integration for selected saved identity, deletion fault recovery, new KEY Y: HELP contract (Help page becomes fully implemented in MOV-10). |
| MOV-10 | ALL Help screens (one gate only) | Add shared help-slow-dpi, shared help-fast-dpi, rotation-help and update existing help-remove-this. Restore parent page/draft/selection. Any key exits, Key Y never locks from Help. |

Rationale: MOV-01 embeds the only necessary technical foundation rather than inventing a new foundation gate. MOV-02..06 fill the new submenu screens while they remain unavailable from connected HOME. MOV-07 exposes the complete non-Help flow. MOV-08..09 update already existing saved/remove screens. MOV-10 completes all user-visible Help routes in a single gate. During staging, a not-yet-implemented Help affordance should not misnavigate; the final candidate must be tested only when all Help pages exist.

## Minimum evidence for each gate
Every gate must record:
1. Baseline/working branch SHA and regression gate statuses; intended edited files; exact source requirement links.
2. Static snapshot of each of 9x21 cells, hints, tones, option indices and first/last character columns.
3. Control replay as press+release (not press-only) plus hidden Back/Y rules and selection/page wrap.
4. Correct side effects and rollback on failure; no optimistic cyan.
5. Clean host Debug/Release test and standard architecture/static tests; CI compile Pico 2 W UF2.
6. Explicit physical scenarios on accessible screens (when connected through MOV-07) and exact operator PASS before marking accepted.

## Detailed testing matrix / release gate

UX and visuals:
- connected HOME four options and correct selection order; no Movement route on searching/retry HOME;
- renderer 9 rows, <=21 columns for every new/changed screen, exactly col16 Slow and col17 Fast (1-based);
- current cyan, selected white, pressed hint white, help text static and hint region retained;
- 2-line rotation option is selected as one logical item, no phantom fourth logical option;
- no literal parenthetical comment text; no non-existent KEY PRESS as runtime input;
- 1x/1x/0 defaults; current H/V and angle persist on return; Reset all only chosen Mouse;
- every Slow/Fast Left/Right page wrap, Up/Down selection wrap, Help route and Key B candidate cancellation;
- A applies only chosen value, B cancels, no updates from page browsing or Help;
- remove page identifies correct Mouse despite selection reorder / reconnect.

Math / USB:
- all H,V factor combinations (8×8) against each of four quadrants (4) = 256 configurations with representative unit vectors;
- exact experiment fingerprints: 270 CCW ×(1,1) => (-y,x); 270 CCW ×(2,1) => (-2y,x);
- circles->ellipses for anisotropic factors, diagonals, axis inversion, opposite-direction symmetry;
- 0.25/0.5/0.75/1.25/1.5 rounding carry; repeated single-step, small deltas and cancellation;
- output saturation at -128/+127, -INT32_MIN widening, max16/max32 input, 10k+ accumulated counts;
- repeated USB busy attempts are deterministic, no double consumption or double scaling, preserves wheel/pan;
- lock does not interrupt mouse forwarding; change while held mouse/key; no stuck buttons or fake Escape.

Persistence and identity:
- pre-upgrade 1.0 saved bonds + names + global CustomTemplate untouched;
- new Mouse defaults; two saved Mice A/B with distinct H/V/rotations; switch A/B, BLE rotating private address, reconnect, physical slot reuse;
- all eight saved-page slots with exact values, Saved Devices page reorder/connected front; unchanged profile semantics;
- power interruption during write; corrupted/current/old TLV versions; transactional rollback;
- reset affects only A; remove A does not delete B; re-pair removed A starts default; no orphan preference leak.

Physical walkthrough (operator):
1. Reflash safe migration build on Pico 2 W (no blanket storage erase) and connect previously saved Mouse.
2. Confirm default H/V/0 and an unchanged button mapping; inspect connected HOME.
3. Set H=2x, V=1x, rotation=270° via screens: physically move front/back, left/right, circles, and verify previous approved behavior.
4. Set fractional Slow then Fast on both axes and measure consistent relative travel with host linear acceleration; verify exact layouts/tones.
5. Disconnect/reconnect/power-cycle; confirm settings restore and movement remains active with LCD locked.
6. Pair a second Mouse, choose distinct settings; switch Mice; Saved Devices must show each value correctly.
7. Remove first Mouse, confirm deleted preferences, reconnect/re-pair and ensure defaults; second Mouse unaffected.
8. Navigate every Help, Back, Cancel, Reset, wrap, lock/unlock and failure/cancel scenario.
9. Verify profile preset/custom remap, Lift Forward held correction, wheel, pan, drag, HID synthetic Escape, and fixed USB identity remained intact.

## Gate state ledger
MOV-01 ACCEPTED (operator confirmation 2026-10-10; record: executions/MOV-01/physical-acceptance.md)
MOV-02 ACCEPTED (operator confirmation 2026-10-10, SHA `f13425c2c1ec8642803fa2398cd3f67606d440e6`; record: executions/MOV-02/physical-acceptance.md)
MOV-03 HOST CI 50/50 PASS + PICO UF2 PASS / PHYSICAL PENDING (SHA `326c5f11164932aad5415783197d01cbc180de2e`, artifact 11686925370; Fast DPI and Saved Devices active-name cyan; tests/test_mov03_horizontal_fast.c)
MOV-04 CODE STAGED / PHYSICAL PENDING
MOV-05 CODE STAGED / PHYSICAL PENDING
MOV-06 CODE STAGED / PHYSICAL PENDING
MOV-07 CODE STAGED / PHYSICAL PENDING (HOME route advanced)
MOV-08 CODE STAGED / PHYSICAL PENDING
MOV-09 CODE STAGED / PHYSICAL PENDING
MOV-10 CODE STAGED / PHYSICAL PENDING

## Stop rule
After this planning document is committed: **STOP**. Do not edit firmware, add runtime screen IDs, run a build as proof of implementation, merge main, open a release PR, or describe any gate as completed until the operator explicitly authorizes implementation.
