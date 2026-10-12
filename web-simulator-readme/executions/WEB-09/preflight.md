# WEB-09 — Preflight and acceptance boundary

**Date:** 2026-10-12. **Status:** explicitly authorized following WEB-08 acceptance. **WEB-10 NOT STARTED**.

The operator said **"gate corrente aceito. prossiga para o proximo"** after WEB-08, while additionally requiring these changes **in WEB-09**:
- Move `PICO 2 W`, `LCD 240 × 240`, and `9 HAT CONTROLS` into the **bottom-right corner of their right-hand HAT container**, not the middle.
- **Remove the entire dispensable `DISPLAY CONTROLS · WEB-08` brightness/density panel**, not only its eyebrow title. Don't replace with new controls. The Lock must still blank the LCD and unlock must restore the normal source screen. Preserve WEB-08 mobile large touch controls.

Operator acceptance filed at [WEB-08/operator-acceptance.md](../WEB-08/operator-acceptance.md). Planner WEB-08 PR #27 merged at `5c374db175345afe05174995a9d466851aca253c`. Accepted website WEB-08 main SHA `9ba5732b31601ed4b92300fce8b29f87a21fab9c`, successful Pages run #38318887192.

Latest firmware release verified unchanged: **v3.2.4**, target `69a640d9767ec7198572eb9b5073ed71f8f3d202`. Authoritative C UX blob `132010179de09ea81f4543e9ca83def09c0a743f`; source LCD rasterizer blob `61c4fe3d547ba05c3e24de86518d807047b50a77`. Preserve 45 original screens, 240×240 / 9×21 bitmap, MNT-12/MNT-13, fixed Gentle `#300c39`, physical HAT with brand upper-left, yellow-dot Virtual Device lower-left and sticky on scroll.

WEB-09 gate definition [WEB-09.md](../../gates/WEB-09.md): browser Inspector with semantic source ID/240×240 bounds, deterministic modern UX scenarios (First Use, Connected/multiple, Remove, stale/failure, timeout, Movement/Custom, Modifier Shortcuts), bounded event timeline, Copy Reference and local PNG/JSON/TXT evidence. Expand/reveal on same page and keep collapsed by default. Never introduce obsolete v1 screens, real HID/BLE, remote logging, telemetry, server API, Node/npm/bundler or GitHub Actions workflow.

Site branch `web/web-09-diagnostics-inspector-clean-hat`, planner evidence branch `web/web-09-evidence`. **Rollback** to accepted WEB-08 website main `9ba5732b31601ed4b92300fce8b29f87a21fab9c` if operator rejects WEB-09.
