# Movement Options — requirement and risk traceability

Status: PLANNED / 2026-10-10.
Source attachment: 'telas movement(1).md' (218 lines). Line numbers refer to the 2026-10-10 uploaded source, not to existing firmware. The attachment is source-of-intent. Inferred decisions are explicitly distinguished from its literal copy.

## Direct requirement -> planned gate -> evidence

| Source lines | Operator requirement | Planned screen gate | Tests |
|---|---|---|---|
| 1-8 | Inherit general rules; parentheses comments not UI; 1 gate per non-Help; 1 gate for all Help; cyan; value col16 Slow/col17 Fast | ALL / MOV-10 | 9x21 golden snapshots, tone precedence, gate count |
| 9-21 | Connected Home includes MOVEMENT OPTIONS while existing routes remain | MOV-07 | connected four options, selection/action order, nonconnected HOME unchanged |
| 23-38 | Movement Options menu H/V/rotation statuses; KEY A Reset All; per-Mouse persistence | MOV-01 | per-identity committed values, atomic Reset, race and rollback |
| 40-53 | H Slow 1/.75/.5/.25 and col16, Left/Right page, A apply, X Help | MOV-02 + MOV-10 | exact suffix column, labels, apply/cancel, help owner |
| 54-66 | Slow Help text, precision/gaming intent | MOV-10 | content, Any Key to original Slow page |
| 68-81 | H Fast 1.25/1.5/2/3 and col17 | MOV-03 + MOV-10 | exact suffix column, wrap, page state |
| 82-93 | Fast Help text, hi-res desktop/widescreen | MOV-10 | help content and correct return |
| 95-109 | Vertical Slow page; Slow/Fast paired pages for V; same for H | MOV-04 | no cross-axis paging, V-only commit |
| 110-123 | Vertical Slow uses shared Slow Help | MOV-10 | Help restores vertical caller and selection |
| 125-136 | Vertical Fast page 1.25/1.5/2/3, col17 | MOV-05 | exact layout, partial change without H edit |
| 137-150 | Vertical Fast uses shared Fast Help | MOV-10 | correct caller restoration |
| 152-164 | Counterclockwise Rotation options 0/90/180/270; A apply, B cancel, X Help | MOV-06 | four 90° matrices, back/cancel, label/color |
| 165-177 | Rotation Help describes anti-clockwise | MOV-10 | content/any key |
| 179-190 | Saved Devices page shows profile, H/V DPI, rotation, remove, L/R paging | MOV-08 | per-identity values on all pages, connected front page |
| 192-203 | Removal warning says pairing AND preferences deleted; Key Y Help | MOV-09 | correct identity pinned, cleanup atomic, Key Y behavior |
| 206-215 | Remove Help includes button remapping AND custom movements | MOV-10 | exact normalized copy, Key Y returns from Help |

## Technical provenance (verified)
- Repositories:
  - product: https://github.com/remappingbridge/remappingbridge/tree/release/v1.0.0
  - process history: https://github.com/remappingbridge/planner/tree/main/RP-2350/hope
  - approved rotation: https://github.com/remappingbridge/blu2usb/commit/a8c4c1d2826d83c839c01797e34501ceeeac10e2
  - approved 2x horizontal: https://github.com/remappingbridge/blu2usb/commit/eb696be901c521f83fda9fe85269fef2bca09547
- Product files inspected: docs/hope/00-final-screen-inventory.md, docs/hope/01-final-architecture.md, docs/hope/02-final-navigation.md; include/blu2usb/ux_model/ux_model.h, renderer/renderer.h, profiles/profiles.h, storage/storage.h; src/ux_model/ux_model.c, renderer/renderer.c, app/main.c, interaction/interaction.c, ble_hogp/ble_hogp_pico.c, storage/storage_pico.c, usb_hid/usb_hid.c; historical HOPE planning.
- Facts to pin: 29 screens, 3 connected HOME options, 9x21 renderer and 240x240 LCD, release-based pure backend, global button profile product record, saved BLE names keyed by identity, USB report int8 and original source consumption on success.

## Important conflicts, resolutions and future verification

A. **90 vs 270 degrees**: experiments used name rotation-90, user now requests 270 CCW. Screen Y grows down, so rotated vector (-y,x) corresponds to CCW 270° under mathematical orientation. Source physical vectors remain invariant; fail gate if convention produces reverse orientation.

B. **DPI terminology**: this is relative pointer gain, not setting a sensor's physical DPI; keep user text, don't pretend the firmware controls hardware DPI. Verify exact constant gain by comparing USB deltas before host acceleration.

C. **'KEY PRESS' / 'JOY X' terms**: original attachment uses 'KEY PRESS: ACCESS' and 'JOY X: HELP TO REMOVE' on respective screens. Existing Waveshare HAT controls are JOY PRESS and KEY X. Use runtime-native labels with recorded typo corrections, rather than inventing new input devices.

D. **Two FAST screen names**: source duplicated the Slow screen names in FAST sections. Use unique runtime IDs horizontal-fast-dpi and vertical-fast-dpi; 4 distinct DPI pages.

E. **Source Saved Devices differs from v1.0**: source omits STATUS line and visible KEY B, adds two preference summaries. Follow new source, keep hidden Back and old underlying bond/selection/removal protections; profiles remain globally active in current actual v1.0 unless a separately authorized initiative changes them.

F. **Source Delete Help Key Y** conflicts with v1.0 Key Y lock. Explicit new screen shortcut wins ONLY on remove-this; all other normal screens keep inherited Key Y lock, and all Help screens treat any key as Back. Existing KEY X Remove Help route is retired in place; removal feature itself unchanged other than deletion of movement preferences.

G. **'BUTTOM' typo** in source Help. Normalize to BUTTON; preserve warning that both button remapping and custom movement preferences are deleted.

H. **Column/row constraints**: 21 chars/9 rows. Confirm each literal body line and VALUE start col16 or 17 (1-based) after font projection. Do not display parenthetical commentary or clipped variable mouse names; preserve 1.0 sanitation/fallback.

I. **Back semantics on value screens**: source omits KEY B for DPI pages but says inherit global rules. Hidden Key B discards draft and returns to Movement Options. No implicit apply on Back or Help.

J. **Saved device count/capacity**: v1 UX shows max eight; persistence should cover at least all currently supported logical Mouse identities without slot leaks. Actual BLE DB capacity/tag layout must be inspected and host-tested during MOV-01 prior to freezing binary layout.

K. **Commit failure/UI feedback**: spec wants cyan applied values. Persist first, then make current cyan. No false optimistic apply, accidental reset of unrelated axis, or confirm on disconnected/stale identity.

L. **Help restoration**: common Help page reused for both horizontal and vertical Slow/Fast. Snapshot and restore originating page, selection and staged candidate on exit; pressing Key Y while Help active must not lock.

M. **Subpixel precision**: 1.25x and 0.25x cannot use a naive even-byte chunk from 2x experiment. Signed fixed-point remainder and USB-busy transactional flow must be proven mathematically for all eight factors and signed extremes.

## Deferred, explicitly NOT silently decided
- Exact storage tag IDs, TLV A/B atomicity and capacity limits: decide after inspecting host/BTstack flash implementation and confirming tag noncollision, before MOV-01 writes.
- Precise low-level zero-output/subpixel and settings-switch pending-ledger policy: choose one deterministic scheme and demonstrate conservation tests in MOV-01 before hardware candidate.
- Exact UI indication if a per-Mouse preference cleanup fails after a bond removal: no new unrequested screen; define a safe retry/recovery within existing flow, record evidence during MOV-09.
- Whether to change underlying globally active button profiles to per-Mouse: OUT OF SCOPE; new source says movement preferences per Mouse, not that v1.0 profile engine must be rewritten.

## Acceptance and closure
- Planning complete != implementation complete.
- Every gate starts PLANNED and remains nonaccepted until direct operator physical PASS after code, tests and UI navigation are observable.
- Do not start a gate or merge without separate implementation authorization.
