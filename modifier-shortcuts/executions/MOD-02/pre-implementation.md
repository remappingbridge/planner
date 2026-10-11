# MOD-02 — Six combinations pages

**State: CODE IMPLEMENTED, CANDIDATE CI + PHYSICAL GATE OPEN — 2026-10-11**

**Dependency:** MOD-01 physically accepted by operator (message "gate aceito. prossiga", 2026-10-11). Baseline unchanged: the same feature branch descending from tag `v2.0.0`.

- Firmware branch: [feature/modifier-shortcuts-mod01](https://github.com/remappingbridge/remappingbridge/tree/feature/modifier-shortcuts-mod01).
- Review PR: [#23, draft](https://github.com/remappingbridge/remappingbridge/pull/23). Do not merge or release until separately authorized.
- Full physical flow: [docs/modifier-shortcuts/mod02-combinations.md](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod01/docs/modifier-shortcuts/mod02-combinations.md).
- Source canonical text: `TELAS MODIFIER.md` / 6 fixtures of MOD-00, with typos corrected only as explicitly approved in MOD-00: `OF`, `WHEEL`, `NOT CUSTOMIZED`.

## In-scope
- Six COMBINATIONS pages and 12 stable IDs, two slots/page.
- 9×21, label + value per slot, option-level highlight on both rows.
- JOY UP/DOWN cycles slots; JOY LEFT/RIGHT cycles pages with wrap; selection preserved on page changes.
- From home-connected → Remapping Options → Modifier Shortcuts → COMBINATIONS page 1.
- Key B returns to Remapping Options selecting Modifier Shortcuts; first page/slot after reentry.
- KEY A Reset on NOT CUSTOMIZED returns no command, creates no flash write.
- JOY PRESS (hint ACCESS) remains no-op before MOD-03; no dummy screen created.
- KEY Y lock/unlock first-key-consumed; KEY X is no-op until Help copy approved.
- Global presets, profile flash-v2 schema, old Custom ESCAPE target, HID and Movement preserved.

## Out-of-scope
- Five SHORTCUTS picker pages and storing 30 actions (MOD-03).
- Choosing modifier and UNAVAILABLE masks (MOD-04).
- Executing shortcut HID events (MOD-05+).
- Any new USB HID interface, consumer controls or existing Bluetooth changes.

## Test plan
- Compile and run inherited CTest plus MOD02 C+Python invariants (screen inventory 40).
- Build production Pico 2 W Release; capture downloadable UF2 and SHA256.
- Operator runs physical test scenarios from HOME connected, recorded in `physical-acceptance.md`.
- **Explicit operator acceptance required for starting MOD-03**.
