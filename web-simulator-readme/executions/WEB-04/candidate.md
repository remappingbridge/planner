# WEB-04 — Canonical screens, HAT layout and mock navigation

**State:** IMPLEMENTED AS CANDIDATE; ISOLATED JAVASCRIPT / DOM / CANVAS REGRESSION TESTS **90/90 PASS**; production-browser visual test and operator acceptance **PENDING**.

**Production test candidate** was merged into website `main` as SHA `19a5b7dd24c917ecc2810ad8230963f13e33d00e` via [site PR #5](https://github.com/remappingbridge/remappingbridge.github.io/pull/5). This merge is solely for the operator's production-browser tests, not operator acceptance. [GitHub Pages deployment run #38308243232](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38308243232) must be successful before claiming that the new UI is live. Accepted WEB-03 rollback SHA: `d78533cbd274647b5c521cf8132e2a2d148cf3e3`.

## Implemented website files

| File | WEB-04 changes |
|---|---|
| `assets/js/screens.js` **new** | Exact `screens[]` source initializers for **45** canonical v3.2.4 screens, each with nine original C rows and dynamic flags; original 22-character C source entries retained. |
| `assets/js/hat-interaction.js` | Release-driven screen route model for HOME, Saved/Search/Retry, Pair/Help, Remapping/Custom/Will Become, Movement/DPI/rotation, six COMBINATIONS and five SHORTCUTS pages; focus wrap, B returns, X Help, Y Lock/unlock and canceled input. Adds explicit 45-screen inspection for visual QA. Does not fake successful profile, shortcut or Movement commits. |
| `assets/js/ui-projector.js` **new** | 9×21 Canvas frame projection, source-derived hint spacing, 6 RGB565 semantic tones, dynamic visible rows, selected `|` in column 0; MNT-13 two-line combination pipe is on the **value/second** row 2/4. Includes baseline MNT-12 role constraints (nonapplied preview cannot promote current Shortcuts to cyan). |
| `index.html` | Removes **entire LCD BACKGROUND section**. Reorders physical layout: joystick **left**, LCD **center**, A/B/X/Y **right vertically in that order**. Adds collapsed `Inspect all 45 firmware screens` selector under existing demo-state area. Loads new static scripts. English-only. |
| `assets/css/app.css` | Compact center 240×240 LCD displayed at approximately 238px maximum plus housing, physical HAT three-column CSS grid; smaller responsive dimensions and pixelated bitmap scaling; removes old palette UI styling. |
| `assets/js/app.js` | Routes model events to LCD projection, virtual screen inspector; **always calls renderer with Gentle**. No backdrop selection or persistence. English command status reports `Preview only` when committing would require later gates. |
| `tests/index.html`, `tests/runner.js` | Browser-only test harness: **90 assertions** covering 45 screen renders, C source hashes, glyph bitmap samples, RGB/frames, menu routing, page wrap, Help, Lock, focus positions, Saved/Pair placeholders and HTML/Canvas interactions. |
| `README.md` | English public docs updated to describe physical-HAT layout, source provenance, 45-screen explorer and nonpersistent mock limitations. |

## Verification actually completed

- **45 unique canonical IDs** parsed directly from v3.2.4 C. Source initialized with 9 rows each, including two intentional 22-character literal C rows. No removed Standard/Escape feature screens.
- **90/90 PASS** when the actual `tests/runner.js` code executed in a JavaScript V8 runtime with a simulated DOM/Canvas2D. It individually rasterized **all 45** screens to 230,400-byte RGBA buffers, and verified the accepted Gentle whole-frame FNV hashes, selection marker placement, page cycles, HAT/keyboard and temporary mock scenarios. This **does not** imply real Firefox/Chromium was tested.
- All visible public site text is English, HAT button order is **A, B, X, Y**, Canvas size stays 240×240 logical pixels while CSS shrinks display. No LCD BACKGROUND UI or alternate palette click targets exist in the app. Background is fixed to Gentle `#300c39`.
- Regression scripts use no Node/npm/CDN/custom Pages build. Only `index.html` is an app page; `tests/index.html` is the browser harness.
- **Not yet tested by operator:** visual resemblance to physical Waveshare HAT, actual browser production deployment, mouse/touch/keyboard/HiDPI and genuine 90/90 result in Firefox. No claims that physical BLE or persistent settings were tested.

## Limitations

This gate brings **template/navigation coverage**, not final parity of effects or dynamic hardware-driven state. `PAIR NEW`, `REMOVE DEVICE`, `APPLY`, all shortcut assignments, Movement and custom profile changes that would require persistent commits report preview-only results, not success. Later WEB-05–07 gates implement the application-level simulation of those transactions. Source cells for unsupported dynamic changes still use documented, clearly fake demo data.

## Next step

After publication to `main` for production testing, **wait for the user's explicit WEB-04 acceptance**. Do not implement WEB-05 or silently mark the browser tests passed.
