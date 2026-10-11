# MOD-00 — Pre-implementation baseline and constraints

**Status: REVIEWED / DOCUMENTATION-ONLY.** 2026-10-11. No firmware branch, no code, no UF2, no physical tests, no profile storage write. Target: RemappingBridge release tag [v2.0.0](https://github.com/remappingbridge/remappingbridge/releases/tag/v2.0.0).

## Inputs actually verified
1. Operator-provided `TELAS MODIFIER.md`, including prose rules, 1 Remapping Options screen, 6 combinations screens, 5 shortcuts screens, and the parameterized template for five WILL BECOME screens.
2. v2.0 source: `src/ux_model/ux_model.c`/`include/blu2usb/ux_model/ux_model.h` (38 screens, four existing remapping entries, 5 WILL BECOME), `include/blu2usb/domain/profile.h` (4 profile kinds; target ESCAPE), `src/profiles/profiles.c` (schema 2), `include/blu2usb/usb_hid/usb_hid.h` and `src/usb_hid/usb_descriptors.c` (two HID interfaces, Mouse and Keyboard), `src/app/main.c` (USB service/composition), `include/blu2usb/movement/movement.h`/`src/movement/movement.c` (rotation then gain; raw deltas).
3. Planner `modifier-shortcuts/01..07` and accepted `movement-options` implementation history.
4. Upstream TinyUSB examples: https://docs.tinyusb.org/en/latest/examples/device/hid_composite.html and https://docs.tinyusb.org/en/latest/reference/class/hid.html illustrate Consumer and Keyboard as separate report IDs on a single interface. This is **precedent for feasibility, not proof of compatibility** with our boot-keyboard configuration or target hosts.

## Source-to-implementation guardrails
- **Do not implement** Standard/Escape removal or set a new schema version in MOD-00; merely document and review the migration.
- Never edit/re-tag the v2.0.0 release; physical tests in MOD-01+ must create a new UF2 candidate.
- Status `UNAVAILABLE` is a derived effect of modifier-source collision, **not** a stored shortcut ID; stored assignment must be recoverable.
- Runtime must consume physical modifier down and not emit held USB key after disconnect/reprofile.
- No independent BLE service, background host agent, debug USB/UART, or HID emulation outside current composition.
- No OS-independent promise for Home, Zoom, Screenshots, Brightness, or media without OS/platform-specific testing.

## Source inventory audit
- Remapping Options: 1 **changed** existing screen.
- Combinations: 6 new screens.
- Shortcuts: 5 new screens.
- WILL BECOME: 5 **changed** existing screens, not 5 new.
- Standard/Escape: four v2 feedback/apply screens removed from reachable runtime and eventual screen inventory.
- Estimated enum count: 38 − 4 + 11 = **45**; assertions to run only in future MOD-01/02.
- `fixtures/mod-00-source-layouts.json`: 17 screens (1 + 6 + 5 + 5), **153 rows**, each row no more than 21 characters, preserving the attached *as-drawn* strings (not silently corrected).
- Fixture omission: parentheses containing sample-variable comments (never display); WILL BECOME heading instantiated for each source. Combo value rows (2 and 4) are dynamic examples.

## Gate artifact inventory
- `candidate.md`: normative decisions proposed for operator's review and test criteria.
- `../../fixtures/mod-00-source-layouts.json`: frozen **source evidence**, not yet the approved normalized UI copy.
- `operator-acceptance.md`: checklist and operator acceptance **PENDING**.
- Architecture source plans `01..07` preserved; any corrections are annotated, not silently backfilled into prior original source.

No test runner or real hardware test is meaningful for a document-only gate. Reviewing consistency, count, copy and scope is the gate's verification activity.
