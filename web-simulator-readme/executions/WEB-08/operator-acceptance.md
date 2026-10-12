# WEB-08 — Operator acceptance and WEB-09 handoff

**Date:** October 12, 2026. **Decision:** ACCEPTED, operator stated **"gate corrente aceito. prossiga para o proximo"**.

The site WEB-08 candidate was merged via [PR #9](https://github.com/remappingbridge/remappingbridge.github.io/pull/9) into `main` commit `9ba5732b31601ed4b92300fce8b29f87a21fab9c`. GitHub Pages build and deploy run #38318887192 completed successfully. Native source runner executed 226/226 in an isolated JS DOM/Canvas2D environment; this is not a claim that the operator separately verified a browser run.

**WEB-09 explicitly authorized**, with two extra operator requirements:
1. Move **PICO 2 W**, **LCD 240 × 240**, **9 HAT CONTROLS** to the **bottom-right corner** of their containing HAT panel (not center-right), preserving right alignment and compact sticky physical HAT.
2. Remove the **entire `DISPLAY CONTROLS · WEB-08` / LCD appearance panel**—the operator describes its brightness/density controls as dispensable. Eliminate the visible controls and related redundant explanatory copy. Preserve effective Lock black screen, underlying source framebuffer/Gentle and other accepted functionality. The WEB-08 experimental display module need not be exposed as a feature. Do not replace it with another control or exceed brightness 100%.

WEB-09 planned scope: modern browser-only diagnostic inspector, semantic ID + 240×240 bounds, deterministic UX scenarios, event timeline, copy reference and local JSON/TXT/PNG evidence. No real device, HID, network upload or deprecated v1 menus.

Do not begin WEB-10 before WEB-09 acceptance.
