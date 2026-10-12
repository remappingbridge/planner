# WEB-02 — Canvas LCD candidate and verification

**State:** CODE IMPLEMENTED / STATIC RENDERER-REGRESSION PASS / **PRODUCTION-BROWSER VISUAL CHECKS & OPERATOR ACCEPTANCE PENDING**.

Site branch: `web/web-02-canvas-lcd-renderer`, based on WEB-01 accepted `main`. Web site implementation must remain separate from planner evidence.

## Delivered files

| Site file | WEB-02 change |
|---|---|
| `assets/js/lcd-renderer.js` (new) | Exact C-derived alphabet (26×7), digits (10×7), punctuation, geometry, RGB565-to-RGB8 conversion, 240×240 RGBA pixel rasterization, standard/didactic vertical layout, row/background semantics, span highlight, Canvas 2D `putImageData`. Pure functions and reusable frame API. |
| `index.html` | Replaces 9-row HTML `pre` preview with 240×240 Canvas, uses renderer before app bootstrap, provides three inline LCD magenta-backdrop presets; remains the only public app page, all English. |
| `assets/css/app.css` | Pixelated/crisp nearest-neighbor resizing, fills the responsive LCD housing, optional web background selectors with accessible 44px controls, no global navigation. |
| `assets/js/app.js` | Boots with v3.2.4 official tag metadata, unchanged v3.2.3 UX baseline, draws initial LCD, highlights matching pressed HAT labels, switches only background presets, retains nine demo controls and Clear. |
| `tests/index.html` and `tests/runner.js` | Browser-native **39 assertions**, including 240×240 Canvas, physical text/glyph geometry, palette conversion, pressed-KEY-A highlight, app integration, Original/Soft/Gentle selections and resets. |
| `tests/fixtures/lcd-goldens-v3.2.4.json` (new) | Six deterministic full 240×240 RGBA snapshots as FNV-1a 32-bit hashes, including all three backgrounds and KEY A pressed, plus pixel samples and exact y coordinates. No false claim of physical screenshots. |
| `README.md` | Source provenance and direct browser testing, no Node/npm/Actions. |

## Actual verification and limitations

- **PASS**: 26+10 bitmap glyph definitions were automatically extracted from the exact firmware C source and checked to have seven rows each.
- **PASS**: all changed app scripts parsed in a standalone JavaScript V8 execution environment; pure pixel raster was executed and its dimensions/colors/layout inspected.
- **PASS**: after adding snapshot hash assertions, the **real `tests/runner.js` was executed in a simulated DOM/Canvas 2D host**, yielding **39/39 checks PASS**. This is a genuine code-execution smoke/regression check but **NOT** a claim that Firefox/Chromium or the production URL were tested.
- **PASS**: 240×240 = 57,600 pixels = 230,400 RGBA bytes; title ink #ff00ff, physical original backdrop #080008; Soft #190b1d; Gentle #28142c. Didactic rows have y=`[8,39,64,89,114,139,164,189,214]`; standard hint-start row6 boundary y151. KEY A ink becomes #ffffff on press and returns gray on release.
- **PASS**: six frozen FNV-1a snapshot hashes embedded in the browser regression suite. Color deviations are only in magenta backdrop; all foreground glyph/palette values match the firmware C constants.
- **PASS**: published v3.2.4 is the latest firmware at preflight and its LCD source Git blobs are byte-identical with v3.2.3. The separate Zoom In HID change does not affect WEB-02.
- **Pending**: manual inspection of physical LCD vs screenshot, actual browser Canvas display at 100/200/300/400% zoom, keyboard/touch/HiDPI, GitHub Pages production deployment, choosing the final Original/Soft/Gentle background. These are **not** marked PASS.

## Explicit scope exclusions

WEB-02 implements no other firmware screen, no profile/mouse/BLE state, no Help/Lock/navigation, no persistent backdrops, no brightness above 100%, no real HID, no firmware release/tag/UF2 and no README rewrite in `remappingbridge`. Later gates own those features.

## Candidate status and transition

**Not accepted.** The site's PR should be inspected, made available in production according to the approved publication/acceptance workflow, and tested by the operator. Preserve WEB-01 accepted baseline until the WEB-02 candidate is approved. WEB-03 remains **NOT STARTED**.
