# MOD-02 — visual corrective candidate (operator feedback)

**Date:** 2026-10-11. **Status:** CODE FIXED + HOST TESTS PASS / PRODUCTION UF2 IN BUILD / PHYSICAL ACCEPTANCE PENDING.

This is a bug fix to the **same MOD-02 gate**, not an authorization to proceed to MOD-03.

## Reported defects (operator)

1. **Inactive option color:** On every `COMBINATIONS 1..6` page, both lines of the nonselected slot (label and NOT CUSTOMIZED) must have the existing standard light-gray actionable tone, `BLU2USB_UI_TONE_ACTIONABLE`, mapped to `BLU2USB_COLOR_LIGHT_GRAY = 0xc618`, not the yellow static tone `0xffb8`. Selected pair stays white. Titles, hints, Saved Devices colors and all other pages remain unchanged.
2. **Missing '+' symbol:** Source screen strings already contained `MOD + MIDDLE IS`, `MOD + LEFT CLICK IS`, etc. But the hardcoded renderer's 5×7 glyph function lacked a '+' case, rendering it completely blank on physical LCD. Add symmetric 5×7 plus bitmap: full middle horizontal line at row 3, centered vertical line in rows 1..5. Keep literal screen wording including spaces `MOD +` from layout, no textual substitution.

## Implementation and evidence

- Target branch `feature/modifier-shortcuts-mod01`, same lineage of prior accepted MOD-01 and MOD-02 candidate.
- Changes in `src/renderer/renderer.c`: add `case '+'` in `glyph_row` and switch only combination-screen inactive row tones from STATIC → ACTIONABLE (rows 1..4, before selected emphasis).
- `tests/test_mod02_combinations.c`: update pair-tone expectations, add **pixel-level render test** with display HAL capturing the '+' glyph and asserting its 10×14 RGB565 pixels against expected 5×7 bitmap, across both slot positions on all six pages and selected/unselected states.
- Text templates in `src/ux_model/ux_model.c` unchanged (the '+' was present already).
- Compatibility: no changes to BLE, USB HID descriptors, Movement, persistence or controls.
- CI: `61/61` tests passed in first correction run; production build SHA/ZIP pending and will be linked in final artifact addendum.
- Physical acceptance: original MOD-02 tested by operator and defects reported. Corrective firmware must be flashed and rechecked. No physical success/acceptance has yet been declared.
