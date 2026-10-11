# MOD-03 — Physical test and operator acceptance

**Status: ACCEPTED BY OPERATOR — 2026-10-11.** Build/CI evidence is tracked separately in [candidate.md](candidate.md).

From `home-connected`, with your previously bonded Mouse:
- [x] 01. Flash MOD-03 Pico 2 W production `.uf2` without flash_nuke; Mouse reconnects, saved name/DPI/rotation remain.
- [x] 02. HOME → REMAPPING OPTIONS → MODIFIER SHORTCUTS → COMBINATIONS 1 OF 6; select first logical combo (`MODIFIER RELEASED IS`) and `JOY PRESS`: opens SHORTCUTS 1-6 OF 30, COPY highlighted.
- [x] 03. `JOY RIGHT` visits all five pages (six labels each, exactly 30 names), then wraps 5→1. `JOY LEFT` from page 1 wraps to page 5. `JOY UP/DOWN` cycles six items within a page. Source spellings `ENTER\RETURN`, `PLAY\PAUSE`, `HOME SCREEN\PAGE` included. `KEY A APPLY AND BACK` footer.
- [x] 04. Select COPY on first combo; `KEY A` applies and returns to COMBINATIONS 1 with COPY in its value row. Reopening same combo focuses COPY. 2-row pair highlight white, unselected gray, plus glyph visible.
- [x] 05. On second combo (`MOD + MIDDLE IS`) choose ESCAPE (page 2 row 1), apply. It shows ESCAPE; first slot remains COPY. `KEY B` during a later edit cancels, leaving ESCAPE saved.
- [x] 06. On another combo, choose PLAY\PAUSE or BRIGHTNESS DOWN to exercise distant picker pages. Apply, go back and reopen; the stored value and focus return correctly.
- [x] 07. `KEY A RESET SELECTED` on configured combo returns value NOT CUSTOMIZED, without touching adjacent combos; repeat Reset is no-op and changes nothing.
- [x] 08. Power-cycle Pico, reconnect same Mouse and revisit all configured combos; assignments persist, including ESCAPE and any Consumer-labeled item. The configured action is NOT executed yet.
- [x] 09. Check `KEY Y` lock/unlock first event consumed, `KEY B` preserves combination page/row; `JOY PRESS` inside shortcut picker does not apply.
- [x] 10. Check regular mouse click, scroll, BLE reconnect, saved devices connected-name-only cyan, horizontal/vertical DPI and rotation; no USB keyboard shortcuts are emitted from merely configured combos.

**Additional migration regression (if upgrading from original v2 profile):** old Standard/Escape profile is now Passthrough; old Custom ESCAPE targets become source identities, never Modifier. Existing bonds/movement preserved. The migration is not an instruction to clear flash.

## Evidence
- Firmware SHA256: 6b5e3cdfbfc27b703ddfd3d08018289ce1c4fafc3fc9c04a6e2970e1c81e3445.
- Host tests 63/63 PASS; Pico production PASS (run 38143309171).
- Physical verdict: **APPROVED by operator message «gate aceito. prossiga»**. Individual screenshots and measurements were not supplied; no additional physical observations are claimed.
- Gate accepted: **YES**, expected UF2 SHA256 `6b5e3cdfbfc27b703ddfd3d08018289ce1c4fafc3fc9c04a6e2970e1c81e3445`.
- MOD-04 authorized: **YES**.
