# WEB-03 — Release-driven HAT/Help/Lock candidate

**State:** IMPLEMENTED / ISOLATED AUTOMATED REGRESSION `80/80 PASS` / **PRODUCTION-BROWSER OPERATOR ACCEPTANCE PENDING**.

[Site PR #4](https://github.com/remappingbridge/remappingbridge.github.io/pull/4): `web/web-03-hat-help-lock-gentle` → `main`.

**Production candidate published to website main** via squash commit `d78533cbd274647b5c521cf8132e2a2d148cf3e3`. This merge is solely to enable operator testing through GitHub Pages and **does not mean operator acceptance**. [Pages run #38305839675](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38305839675). Exact source blobs of `index.html`, the renderer, HAT engine, app bootstrap and test runner in production main were compared to the WEB-03 candidate branch and all matched.

## Implementation delivered

- `assets/js/hat-interaction.js` adds a pure, firmware-derived input and limited HOME/HELP state machine. Screens supported explicitly are the FIRST tutorial, connected HOME, searching HOME, retry HOME, and the three corresponding Help templates. **This is not 45-screen WEB-04.**
- Pressing sets held state; **release** triggers one event; repeated keydown cannot increment or navigate; a canceled/lost release cannot trigger an event.
- Only allowed screens lock on **KEY Y release**; FIRST is didactic and cannot lock; Help accepts **KEY B** return or **KEY Y** lock, ignoring the other controls. Unlock first control press/release is consumed; HOME selection is resolved from the explicit demo scenario, preventing accidental menu activation.
- Browser maps global ArrowUp/Down/Left/Right, Enter, Space and A/B/X/Y; excludes input/select/textarea/button/link/contenteditable and Ctrl/Alt/Meta shortcuts. Buttons work with pointer, touch through Pointer Events and native accessibility clicks.
- HOME selection wraps with MNT-13 `|` in column zero. HOME JOY PRESS does not invent full navigation; shows `This menu route is planned for WEB-04.`
- Three **explicit virtual contexts** permit testing Help and Lock without fake BLE/persisted profiles.
- The previously chosen Gentle background is now the more vivid, less gray **`#300c39`**, the default. Original and Soft remain as comparison; foreground colors are untouched. Deterministic RGBA hashes for Gentle update to `a19c1e15` normal, `53515495` pressed KEY A.
- Tests page/README/HTML/CSS are English. Single static app; no Node/npm/framework/CDN, backend, site Actions workflows, real BLE/HID, firmware release, or UF2.

## Tests actually performed

1. **80/80 PASS** by executing the **unmodified browser test runner** (as authored in site `tests/runner.js`) inside an isolated JavaScript V8 environment with DOM and Canvas2D mocks. Tests cover original glyph/RGB565/240×240 colors and image hash snapshots, 9 HAT controls, focus wrap, Help context, Lock and unlock, lost-release cancellation, global keyboard entry, pointer cancellation, demo states, error handling and reset.
2. Checked all static site paths: one `index.html`, `.nojekyll`, local CSS/JS, no `package.json`, Node modules or authored GitHub Actions workflow.
3. Confirmed firmware release v3.2.4 and original renderer blob from WEB-02 remain unchanged.
4. **Not performed:** real Firefox/Chromium production Pages browser test, hardware screen comparison, touch/HiDPI physical observation. These remain the operator's role; the successful isolated harness is not passed off as actual production-browser evidence.

## Publication vs acceptance

To satisfy the operator's **production-only testing** requirement, site PR #4 may be merged and the GitHub Pages deployment checked. **This publication is not an acceptance.** WEB-03 is accepted only after operator confirmation. WEB-04 remains NOT STARTED. If the operator asks for a different Gentle hue or reports keyboard/touch issues, fix WEB-03 and republish rather than advancing.
