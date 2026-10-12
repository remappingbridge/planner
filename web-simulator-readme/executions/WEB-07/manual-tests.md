# WEB-07 — Numbered production-browser acceptance tests

**Gate status:** waiting for operator acceptance. **Do not use Debian/local HTML/npm/firmware flashing.** Open https://remappingbridge.github.io/ and https://remappingbridge.github.io/tests/ only after latest Pages run completed.

Keyboard: arrows = joystick directions, Enter/Space = joystick press, A/B/X/Y = HAT keys. Click the virtual hardware when keyboard focus is inside form controls.

1. **New brand position.** Look at the sticky virtual HAT. **Expected:** REMAPPINGBRIDGE is in its **upper-left corner** inside the physical panel, not in the right-side metadata.
2. **New virtual indicator position.** Look at the lower-left HAT corner. **Expected:** the text VIRTUAL DEVICE and its **yellow dot** appear **together in the lower-left corner**, not on the right.
3. **Right-side hardware specs.** Look to the right of A/B/X/Y. **Expected:** PICO 2 W, LCD 240 × 240, 9 HAT CONTROLS remain there, with no duplicate brand or virtual status.
4. **Sticky scroll and no overlap.** Scroll through Virtual Mouse Lab and Virtual Session. **Expected:** the HAT remains visible while the lower controls scroll; neither upper-left brand nor lower-left indicator obstructs joystick/LCD/keys.
5. **Zoom and narrow screen.** Test 150%, 200% Firefox zoom and a narrow window. **Expected:** brand and indicator remain readable and inside the HAT; no overlap with LCD image or extra horizontal scrolling. Right-side specs and vertical A/B/X/Y remain reachable.
6. **Start with a saved virtual mouse.** If needed in Virtual Mouse Lab, enter a name `Shortcut Mouse`, click Start Pair New, then Complete Successfully. Choose Connected demo to reach HOME. **Expected:** one saved virtual mouse and no physical Bluetooth request.
7. **Activate Custom Modifier.** HOME → REMAPPING OPTIONS → CUSTOM REMAPPING → EDIT CUSTOM → LEFT WILL BECOME → select MODIFIER → A (draft) → A again in EDIT CUSTOM (apply). **Expected:** profile is CUSTOM, LEFT is the one applied Modifier and MODIFIER SHORTCUTS is cyan only *after* Apply.
8. **Enter COMBINATIONS.** From REMAPPING OPTIONS focus MODIFIER SHORTCUTS and press joystick center. **Expected:** COMBINATIONS 1 OF 6 with two slots. RIGHT moves through pages 2..6 and wraps to 1; LEFT wraps backwards. UP/DOWN selects the pair; a single `|` appears on its **second/value** line.
9. **Assign a shortcut.** Select MODIFIER RELEASED (first slot on COMBINATIONS 1 OF 6) and press joystick center. **Expected:** SHORTCUTS 1–6 OF 30 opens. Select COPY, press A. Return to COMBINATIONS 1 OF 6; selected value shows COPY and cyan with focus.
10. **Shortcut page navigation and return.** Open the same assigned slot, page RIGHT to SHORTCUTS 2..5 and LEFT back. Choose ZOOM IN on SHORTCUTS 5 OF 30, press A. **Expected:** assigned slot now says ZOOM IN; reopening focuses **ZOOM IN on its own page**, in pastel cyan. B cancels navigation without changing the current assignment.
11. **UNAVAILABLE Modifier slot.** With LEFT applied as Modifier, go to COMBINATIONS 2 OF 6 and focus MOD + LEFT CLICK. **Expected:** the value says UNAVAILABLE in yellow, even when focused. The selected `|` still appears on the second/value line; joystick center **does not** open SHORTCUTS and A cannot erase another assignment.
12. **Reset selected slot.** Return to MODIFIER RELEASED (page 1, first slot), press A. **Expected:** ZOOM IN changes back to NOT CUSTOMIZED; it is gray/white rather than cyan. Pressing A again has no effect.
13. **MNT-12 Passthrough and draft exception.** With an applied Custom Modifier and at least one available assignment, switch to PASSTHROUGH DEFAULT and apply. **Expected:** MODIFIER SHORTCUTS ceases cyan, and combination values aren't cyan even if saved. Switch to a Custom profile **without applied Modifier**; merely drafting Modifier must also **not** activate cyan until Custom Apply.
14. **Distinct mice and reload.** Assign COPY to a slot for Mouse A; save a different action for Mouse B. Reload the webpage and reconnect each mouse. **Expected:** the two 12-entry shortcut arrays and Current/Cyan behavior remain independent. Remove one virtual mouse; the other's shortcuts remain.
15. **Browser-only regression page.** Open https://remappingbridge.github.io/tests/. **Expected:** `194/194 checks passed.` If any FAIL, report the exact English name. Sticky/corner layout is a **visual** operator check, not proven by isolated tests.

**WEB-07 not accepted** until the operator explicitly approves it. WEB-08 must remain unstarted.
