# MOD-02 — Testes físicos do operador (Pico 2 W)

**Status: MOD-02 CORRECTED BUILD ACCEPTED BY OPERATOR — 2026-10-11.** The operator reported two visual regressions: inactive slot should be standard gray and '+' after MOD was not drawn. The former CI/UF2 in [candidate.md](candidate.md) is superseded for the next physical test; do not reuse it to validate these fixes.

## Test cases — from connected HOME

- [x] **01 — Update in place:** flash exact MOD-02 candidate UF2 on Pico 2 W in BOOTSEL, with no flash_nuke; a previously saved Bluetooth mouse reconnects and the connected HOME screen loads.
- [x] **02 — Main route:** HOME connected → JOY PRESS (Remapping Options) → JOY DOWN twice (Modifier Shortcuts) → JOY PRESS; open `COMBINATIONS 1 OF 6`.
- [x] **03 — First page labels:** two logical combos `MODIFIER RELEASED IS` and `MOD + MIDDLE IS`, both values `NOT CUSTOMIZED`. Title magenta, selected label **and** value white, remaining slot rows light gray (ACTIONABLE; RGB565 0xC618), hints use their existing colors. Hints `JOY LEFT\RIGHT: PAGE`, `JOY PRESS: ACCESS`, `KEY A: RESET SELECTED`. No cyan applied shortcut. **On every label `MOD + ...`, the `+` must appear visibly in the LCD bitmap, not merely in a source string.**
- [x] **04 — Forward pages:** JOY RIGHT from 1→2→3→4→5→6→1, confirming on page 2 LEFT CLICK / RIGHT CLICK; page 3 FORWARD / BACKWARD; page 4 WHEEL UP / WHEEL DOWN; page 5 MOVE LEFT / MOVE RIGHT; page 6 MOVE UP / MOVE DOWN.
- [x] **05 — Reverse pages:** JOY LEFT from page 1 → 6; repeat through 5→4→3→2→1.
- [x] **06 — Pair selection:** JOY DOWN changes the selected pair as a unit (both rows white), JOY UP returns. From first pair JOY UP wraps to second; from second JOY DOWN wraps to first.
- [x] **07 — Preserve focus on paging:** select second pair on page 6, JOY RIGHT → page 1 second pair remains selected; JOY LEFT returns to page 6 second pair.
- [x] **08 — Idempotent RESET and ACCESS boundary:** KEY A on either pair leaves NOT CUSTOMIZED unchanged; JOY PRESS also leaves current page/selection unchanged (shortcut picker is MOD-03). No mouse/keyboard shortcut emitted, no flash reset.
- [x] **09 — Exit, reentry and lock:** KEY B → Remapping Options still focused on Modifier Shortcuts; JOY PRESS → COMBINATIONS 1 OF 6 first pair. KEY Y locks, first JOY PRESS unlocks only and returns HOME; no unintended choice.
- [x] **10 — Regression:** verify usual Mouse click, scroll, BLE disconnect/reconnect, Saved Devices colors (only connected Mouse name cyan), H/V DPI and rotation persist, and previous Custom remap remains functional. KEY X has no new Help page for COMBINATIONS in this gate.

## Evidence
- Firmware commit: [`fb568154d88d3e984a89f0c7e0b69aaaa0fefffd`](https://github.com/remappingbridge/remappingbridge/commit/fb568154d88d3e984a89f0c7e0b69aaaa0fefffd).
- Production UF2 for **original MOD-02, now superseded by corrective build**: [original artifact ZIP](https://github.com/remappingbridge/remappingbridge/actions/runs/38140599963/artifacts/11703161553) with SHA256 `84d2d478877c02c46dcba14d8fa83a2d3a122f1e63555d588dce19a877cb3d4a`. **Do not use this older UF2 to verify the two UI corrections.**
- Corrected production UF2: [GitHub Actions #231 artifact](https://github.com/remappingbridge/remappingbridge/actions/runs/38142378835/artifacts/11703770361), firmware SHA256 **`bdd8abe1601336f852dcab9b2c57e7f95d8ed5e3700c53feaafa087c04e09a12`**, 926720 bytes, commit `88dcc6baa33390dfb9e55426746e8f874e0a0259`. Host CTest **61/61 PASS**, Pico 2 W build PASS. See [visual-bugfix.md](visual-bugfix.md).
- Previous candidate CI: 61/61 PASS; Pico 2 W Release PASS. **Fresh corrective build required**. [CI run #225](https://github.com/remappingbridge/remappingbridge/actions/runs/38140599963).
- Physical test verdict: **APPROVED** by operator message «gate aceito. prossiga para o proximo», after corrected build delivered. Individual measurements/screenshots not supplied; no independent hardware measurements are claimed.
- Gate accepted: **YES — corrected candidate** SHA256 `bdd8abe1601336f852dcab9b2c57e7f95d8ed5e3700c53feaafa087c04e09a12`.
- MOD-03 unlocked: **YES**; user explicitly asked to proceed.

Firmware scenario reference: [MOD-02 specification](https://github.com/remappingbridge/remappingbridge/blob/feature/modifier-shortcuts-mod01/docs/modifier-shortcuts/mod02-combinations.md).
