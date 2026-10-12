# WEB-07 — 12 combinations, 30 shortcuts, applied cyan and HAT identity corners

**Status:** CANDIDATE IMPLEMENTED; **194/194 isolated JavaScript DOM/Canvas assertions PASS**; production-browser visual tests and operator acceptance **PENDING**.

## Website changes

- `index.html`: **REMAPPINGBRIDGE** positioned at the top-left inside sticky device, **VIRTUAL DEVICE** and yellow LED dot at bottom-left. The right metadata panel retains only PICO 2 W / LCD 240 x 240 / 9 HAT CONTROLS. Labels stay outside source Canvas.
- `assets/css/app.css`: corner-absolute positioning relative to the **sticky device**, not page; top/bottom bands on screens ≤540px to prevent corner text from covering LCD pixels. Existing centered cross joystick, square LCD, reduced-radius buttons, far-right hardware metadata remain.
- `assets/js/hat-interaction.js`: source-defined **12 stable combo ordinals**, **31 shortcut names** (index 0 NOT CUSTOMIZED, 1..30 actions), six/two and five/six page navigation with wrap, saved-assignment focus, unavailable slot guard, KEY A reset from combo and Apply from shortcut editor. `confirmShortcut` returns to original combination only after model commit. Modifier activity is computed using **applied target**, not draft target.
- `assets/js/ui-projector.js`: exact 30 action display strings; available assigned value is cyan only for applied CUSTOM + Modifier; focused pastel cyan, unassigned gray, unavailable informational yellow even focused. `|` remains at column 0 on combo's second/value line; selected unavailable pipe inherits white label focus and does not recolor the disabled value.
- `assets/js/app.js`: set/reset callback persists **only the currently selected saved virtual mouse's profile** via existing validated store; no connected/saved mouse means explicit error and no fake commit. Unavailable combinations cannot commit. The HAT returns to original combo only after validated and persisted virtual transaction.
- `tests/runner.js`: prior 165 regression checks plus 29 new checks, including C-identical 30 strings, all 12 combo slots, MNT-12/MNT-13 tones, every owning-modifier unavailable case, draft/passthrough distinction, assigned page auto-focus, success and zero reset, persistence and actual app-level HAT clicks.
- `README.md`, `tests/index.html`: all English, updated 194 assertions and original-source behavior.

## Site candidate publication

Website [PR #8](https://github.com/remappingbridge/remappingbridge.github.io/pull/8) was merged into site `main` **for production-browser testing only**, commit `5f2597946c1af04ceb08c9eec301dc867675c248`. [GitHub Pages deployment #38316811734](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38316811734) is the associated production run; its build/deploy completion must be verified before claiming this version is live. WEB-07 remains pending operator acceptance, and the planner [PR #26](https://github.com/remappingbridge/planner/pull/26) remains draft.

## Test result and limitations

The website's **actual browser JS runner** executed under an isolated V8 with simulated DOM and Canvas2D. Result: **194/194 PASS**, including old 45/45 canonical LCD rasterizations. **This is not a claim of live Firefox production testing or visual screenshot verification**. CSS corner positions, sticky scroll, zoom and clipping must be checked by operator on production site.

No real BLE/HID, input shortcut dispatch or firmware change. Virtual shortcuts are browser-local saved assignments only. WEB-08 remains unstarted, and merging a site PR for test availability does **not** indicate operator acceptance.

Rollback: accepted WEB-06 site main `7b8449dd233016698d089015b28a811ddd643478`, candidate branch `web/web-07-modifier-shortcuts-hat-corners`.
