# WEB-06 — Profile/Movement and sticky HAT candidate

**Status:** IMPLEMENTED CANDIDATE; **165/165 ISOLATED JS/DOM/CANVAS TESTS PASS**; production Firefox visual tests and operator approval pending.

## Responsive sticky physical HAT

- `index.html`: remove `.device__top`/ `.device__base` metadata above/below the virtual controls; transfer brand + virtual status + Pico/LCD/HAT info to a fourth metadata column at right **inside the display height**. Device receives `data-sticky-hat`.
- `assets/css/app.css`: `.device.device--sticky {position:sticky;top:8px;z-index:30}` for the full simulator (not position:fixed); narrower housing padding and 214px desktop CSS LCD footprint; left joystick, LCD, reduced-radius A/B/X/Y stack and right metadata on a single horizontal line. Mobile breakpoints adjust scales and gaps, keep the HAT within viewport. Normal lower panels remain scrollable below. Small-height and browser-zoom checks remain operator visual tests.
- Unchanged: logical Canvas 240×240, font 5×7, 45 templates, 9×21 source text, magenta/semantic foreground, fixed Gentle background `#300c39`, separate English key guide and one static app.

## Editable virtual saved profiles

- `assets/js/virtual-mice.js`: validates per-mouse profiles, gains in `[1,2,3,4,5,6,8,12]` quarters, rotation 0..3, single modifier target, Custom/Passthrough profile kinds and original 12-shortcut placeholders; `profileFor`, `applyProfile`, `resetMovement` write the selected virtual mouse's profile in localStorage or visibly memory-only fallback. No physical HID/BLE.
- `assets/js/hat-interaction.js`: loads selected/connected bond's **applied** profile, holds a separate `customTargets` draft, enforces Modifier exclusivity (previous source returns to its own native target; Forward/Backward distinct), KEY A in WILL BECOME sets a draft, KEY A in EDIT CUSTOM applies, B in EDIT CUSTOM **cancels uncommitted drafts**. Passthrough Apply switches profile without erasing saved custom targets. Movement has four slow/fast values per axis, joystick Left/Right pages, A applies gain/rotation, A on Movement Options resets all Movement values, retaining Custom.
- `assets/js/ui-projector.js`: Current/Cyan in Remapping Options and Will Become depends on **applied** state, not uncommitted draft; MNT-12 semantic behavior retained.
- `assets/js/app.js`: ties release-driven HAT commands to virtual profile storage; shows active profile/H/V/rotation in Virtual Mouse Lab, refreshes LCD after commit, prevents synthetic "connected demo" from applying when no saved mouse exists. **Fixes an inherited WEB-05 bug** where Mouse Lab click handlers were attached repeatedly by `paint()`; now listeners attach exactly once. Scenario selection indicators update with state.

## Verification actually performed

- **165/165 PASS**: executed the site's unmodified native `tests/runner.js` in isolated V8 with DOM and 2D Canvas mocks. Tests render all 45 original firmware screens, validate original font/foreground colors/accepted Gentle RGBA hashes, virtual pair/search/remove/timeout/reload, two independent applied Custom/Movement mouse profiles, exclusive Modifier, draft vs applied cyan, B cancellation, DPI page changes, per-mouse reset, and **real app-level HAT-to-storage wiring**.
- Source files contain no Node/npm, bundled framework/CDN, custom GitHub Actions or real BLE/HID. Site has one interactive app page plus separate browser test harness.
- **Not observed in an actual Firefox/Chromium browser:** sticky scroll/overlap, right metadata containment, button height/radius, 100–200% zoom, narrow viewport, browser CSS/layout and user-facing 165/165 result. These require manual operator inspection in the deployed production browser.

## Publication, acceptance and rollback

The operator requires testing at https://remappingbridge.github.io/ and https://remappingbridge.github.io/tests/. Website candidate branch is `web/web-06-profiles-movement-sticky-hat`, and any site PR merge is **for production-browser testing only**; it does **not** constitute acceptance. WEB-07 remains blocked until explicit operator acceptance.
