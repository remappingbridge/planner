# MOD-02 — Testes físicos do operador (Pico 2 W)

**Status: PENDING OPERATOR ACCEPTANCE.** CI/UF2 evidence will be registered in `candidate.md` after the final production build.

## Test cases — from connected HOME

- [ ] **01 — Update in place:** flash exact MOD-02 candidate UF2 on Pico 2 W in BOOTSEL, with no flash_nuke; a previously saved Bluetooth mouse reconnects and the connected HOME screen loads.
- [ ] **02 — Main route:** HOME connected → JOY PRESS (Remapping Options) → JOY DOWN twice (Modifier Shortcuts) → JOY PRESS; open `COMBINATIONS 1 OF 6`.
- [ ] **03 — First page labels:** two logical combos `MODIFIER RELEASED IS` and `MOD + MIDDLE IS`, both values `NOT CUSTOMIZED`. Title magenta, selected label **and** value white, remaining text off-white/yellow. Hints `JOY LEFT\RIGHT: PAGE`, `JOY PRESS: ACCESS`, `KEY A: RESET SELECTED`. No cyan applied shortcut.
- [ ] **04 — Forward pages:** JOY RIGHT from 1→2→3→4→5→6→1, confirming on page 2 LEFT CLICK / RIGHT CLICK; page 3 FORWARD / BACKWARD; page 4 WHEEL UP / WHEEL DOWN; page 5 MOVE LEFT / MOVE RIGHT; page 6 MOVE UP / MOVE DOWN.
- [ ] **05 — Reverse pages:** JOY LEFT from page 1 → 6; repeat through 5→4→3→2→1.
- [ ] **06 — Pair selection:** JOY DOWN changes the selected pair as a unit (both rows white), JOY UP returns. From first pair JOY UP wraps to second; from second JOY DOWN wraps to first.
- [ ] **07 — Preserve focus on paging:** select second pair on page 6, JOY RIGHT → page 1 second pair remains selected; JOY LEFT returns to page 6 second pair.
- [ ] **08 — Idempotent RESET and ACCESS boundary:** KEY A on either pair leaves NOT CUSTOMIZED unchanged; JOY PRESS also leaves current page/selection unchanged (shortcut picker is MOD-03). No mouse/keyboard shortcut emitted, no flash reset.
- [ ] **09 — Exit, reentry and lock:** KEY B → Remapping Options still focused on Modifier Shortcuts; JOY PRESS → COMBINATIONS 1 OF 6 first pair. KEY Y locks, first JOY PRESS unlocks only and returns HOME; no unintended choice.
- [ ] **10 — Regression:** verify usual Mouse click, scroll, BLE disconnect/reconnect, Saved Devices colors (only connected Mouse name cyan), H/V DPI and rotation persist, and previous Custom remap remains functional. KEY X has no new Help page for COMBINATIONS in this gate.

## Evidence
- Firmware commit / SHA: PENDING final CI verification.
- Production `blu2usb_picow.uf2` / SHA256: PENDING final CI verification.
- CI host tests + Pico Release: PENDING final run verification.
- Physical test verdict: **PENDING operator**.
- Gate accepted: **NO**.
- MOD-03 unlocked: **NO**.

Firmware scenario reference: [MOD-02 specification](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod01/docs/modifier-shortcuts/mod02-combinations.md).
