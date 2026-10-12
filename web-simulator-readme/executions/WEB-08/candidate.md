# WEB-08 — Responsive HAT, accessibility and safe LCD brightness

**Status:** IMPLEMENTED CANDIDATE, operator browser acceptance PENDING. **226/226 native runner checks passed in an isolated V8 DOM/Canvas2D environment**, not independently observed on the live website.

## Implemented

- `index.html`: no extra editorial brand/header above HAT; the application starts directly with the sticky physical simulator. The accepted WEB-07 corner branding, upper-left REMAPPINGBRIDGE, bottom-left yellow-dot VIRTUAL DEVICE, right-hand PICO/LCD/HAT specs, compact central 240×240 logical display, left joystick and vertical right A/B/X/Y remain in the device. Added **LCD appearance** panel: English native range `0..100`, per-step current %, effective brightness %, **Compact/Standard/Spacious** UI density select and clear browser-only local persistence message. Added a responsive **nine-button large mobile touch panel** under the display controls, shown only at <=540px, with all buttons at least 44×44 CSS pixels (not a replacement firmware screen).
- `assets/js/display-settings.js` (new): strict `brightness:0..100` clamp and schema `remappingbridge-display-v1`; local preference `remappingbridge.display.v1`, density enum, safe fallback if browser storage is corrupt/unavailable, read-only requested/effective/factor snapshots. Lock always forces effective brightness 0 without overwriting requested preference; unlock restores requested value.
- `assets/js/app.js`: browser display model and UI bound natively; **CSS `filter:brightness(factor)` on Canvas only, factor 0..1**, never redraw/darken the underlying RGB565 framebuffer pixels; density controls only app panel spacing via `data-density`. Lock keeps original black framebuffer and 0% effective even if user stored 73%, slider disabled during Lock. Existing HAT release/Help/Lock and 194 WEB-07 regression workflows retained. Mobile buttons route through the same HAT input behavior without duplicating firmware controls.
- `assets/css/app.css`: enhance LCD housing/panel visual depth, visible focus rings, native range/select contrast, responsive single-column settings, density-based panel spacing and 44px mobile touch targets, reduced-motion suppression; keep the physical small HAT and sticky behavior, CSS/HiDPI bitmap scaling and fixed Gentle #300c39.
- `README.md`, `tests/index.html`, `tests/runner.js`: English-only explanation and **226 assertions** (194 original plus 32 new display and touch checks).

## Production candidate publication

Website [PR #9](https://github.com/remappingbridge/remappingbridge.github.io/pull/9) was merged to website `main` only to publish the WEB-08 candidate, commit `9ba5732b31601ed4b92300fce8b29f87a21fab9c`. Associated [GitHub Pages run #38318887192](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38318887192) is the deployment verification reference. Publication does **not** imply operator acceptance; planner [PR #27](https://github.com/remappingbridge/planner/pull/27) stays draft until explicit acceptance. WEB-09 remains blocked.

## Automated validation and limitations

Actual `tests/runner.js` executed in **isolated V8** with simulated native DOM/Canvas2D: **226/226 PASS**. Tests include source 45/45 rasterized screens, accepted pixel golden checks, source 12/30 shortcuts, saved mouse profiles, browser display module clamp/validation, preferences persistence/blocked-store fallback, lock/unlock effective brightness and restored 27%, Canvas style factor bounded <=1, native range/density events and extra nine touch controls.

**Not proved by isolated execution:** production Firefox/Chromium with native CSS layout, 320px/768px/2K widths, 150–200% browser zoom, reduced-motion, actual HiDPI or touch hardware, screen-reader label reading, focus/contrast visual quality, sticky viewport coverage. These are explicit operator manual tests in [manual-tests.md](manual-tests.md).

No actual backlight, hardware HID/BLE, firmware, UF2 or simulated mouse bond schema was modified. WEB-09 not started. Site merge is to publish candidate for production-browser testing, never an automatic gate acceptance.
