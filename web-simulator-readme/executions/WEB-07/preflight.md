# WEB-07 — Preflight and operator layout addition

**Date:** October 12, 2026. **Gate:** candidate, awaiting operator acceptance.

## Authorization and baseline

The operator expressly accepted WEB-06 ("gate corrente aceito. prossiga para o proximo"). Operator acceptance is recorded in [WEB-06 acceptance](../WEB-06/operator-acceptance.md). Planner PR #25 merged as `0f3f02214af41067c57e16ff15aa2ecc46f8f136`. Accepted website WEB-06 `main` commit is `7b8449dd233016698d089015b28a811ddd643478`.

Latest firmware release checked: **v3.2.4** (tag `69a640d9767ec7198572eb9b5073ed71f8f3d202`); official 45-screen UI source blob `132010179de09ea81f4543e9ca83def09c0a743f`. No physical firmware, HID, BLE, UF2 or tag changes.

## New user-requested layout refinement

- Move **REMAPPINGBRIDGE** from right-side hardware metadata to the **upper-left corner** inside the sticky HAT panel.
- Move **VIRTUAL DEVICE**, including its **small yellow dot**, from right metadata to the **lower-left corner** inside the same panel.
- Hardware specifications remain at far right. Preserve the centered virtual joystick + 240x240 logical LCD + vertical A/B/X/Y and sticky scrolling of lower controls.
- Avoid source LCD overlap at mobile widths / increased zoom by reserving small top/bottom corner-label space where necessary.
- All public site labels/docs remain **English**; operator tests are on production Pages only, without local Debian commands.

## Original WEB-07 source contract

Firmware header stable modifier-combination IDs **0..11**: RELEASED, MIDDLE, LEFT, RIGHT, FORWARD, BACKWARD, WHEEL_UP, WHEEL_DOWN, MOVE_LEFT, MOVE_RIGHT, MOVE_UP, MOVE_DOWN. 6 pages of 2. Firmware shortcut IDs **1..30**, in 5 pages of 6, with ID 0 reserved for NOT CUSTOMIZED.

From v3.2.4 C:
- One combo matches the active **applied Modifier button** and is **UNAVAILABLE** (MIDDLE, LEFT, RIGHT, FORWARD, BACKWARD only), including when visually focused. Wheel/Move/RELEASED remain available.
- JOY_PRESS on an available combination opens the shortcut page containing any **currently assigned** ID, focusing its row, or page 1/row 1 if unassigned.
- KEY A in shortcut editor requests persistent assignment and returns to originating combo **only after confirmed write**. KEY A on assigned available combo resets it to NOT CUSTOMIZED, but never affects unavailable or unassigned slots.
- MNT-12: Modifier Shortcuts ciano only if **applied Custom** with a modifier, and assigned, available combination values then turn cyan; selected rows pastel cyan, unavailable values yellow, unassigned gray.
- MNT-13: exactly one pipe `|` in first column of selected value/**second row** of 2-line combo; no `>` glyph and no pipe in unselected entries.
- Mouse profiles with same shortcut IDs are isolated by virtual saved bond; browsers persist via WEB-05 localStorage validation.

**WEB-08 NOT STARTED**. Test live Pages and give explicit acceptance before implementing it.
