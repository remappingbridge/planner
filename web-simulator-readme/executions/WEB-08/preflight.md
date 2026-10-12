# WEB-08 — Preflight and accepted baseline

**Date:** October 12, 2026. **Operator-authorized gate:** WEB-08 HAT/LCD visual, responsive and web brightness 0–100%. WEB-09 not started.

## Explicit authorization

The operator said **"gate aceito. prossiga"** after WEB-07. [WEB-07 acceptance](../WEB-07/operator-acceptance.md) records the gate close. Planner evidence PR #26 merged as `773387df25290d616460a0687d771c9c193b27b0`, website accepted WEB-07 main `5f2597946c1af04ceb08c9eec301dc867675c248` (Pages deployment #38316811734 succeeded).

## Firmware and scope freeze

Latest verified firmware release remains **v3.2.4**, tag SHA `69a640d9767ec7198572eb9b5073ed71f8f3d202` (October 12, 2026). Canonical C UX blob `132010179de09ea81f4543e9ca83def09c0a743f`; LCD renderer blob `61c4fe3d547ba05c3e24de86518d807047b50a77`. There are 45 source layouts and a 240×240 logical framebuffer, 5×7 original glyphs, 9×21 grid, six RGB565 semantic foreground tones and MNT-12/MNT-13 focus/Modifier rules. WEB-08 never changes source C, HID, firmware UF2 or BLE.

- Preserve accepted left-corner REMAPPINGBRIDGE / left yellow-dot VIRTUAL DEVICE, right hardware spec metadata, left joystick, center LCD, vertical A/B/X/Y, sticky viewport behavior and **Gentle #300c39** background without a backdrop selector.
- Improve browser-only presentation: rounded HAT controls, clear Hover/Pressed/Focus, subtle frame/panel shadows, CSS-pixel scaling independent of brightness, density choice, mobile/HiDPI, contrast and reduced motion.
- Browser-only brightness preference **min 0/max 100/step 1**. Display CSS multiplier must never exceed **1**. Lock effectively blackens the LCD and reports 0%, while preserving the remembered user setting; unlock consumes first HAT release and restores chosen brightness.
- Browser-only UI preferences stored under their own schema/key `remappingbridge.display.v1`, separate from eight saved virtual mice and any source profile. On invalid/corrupt/blocked localStorage, safe default/memory-only fallback; never imply physical backlight.
- **No editorial website header, hero, navbar, footer, external CDN, backend, npm or project-owned workflow**. One static application with browser-only regression page. Website/README/ARIA/user-visible text remains English.
- At narrow widths the visually faithful physical HAT is compact. A separately labeled nine-control mobile panel with **44×44 CSS pixel buttons** supplies finger-friendly targets without distorting the physical 240×240 display or source button arrangement.

Implementation branches: website `web/web-08-responsive-brightness`; planner `web/web-08-evidence`. **Rollback** to website accepted WEB-07 SHA `5f2597946c1af04ceb08c9eec301dc867675c248` if operator does not accept the production candidate.
