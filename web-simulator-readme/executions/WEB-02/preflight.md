# WEB-02 — Preflight and frozen source

**Date:** October 12, 2026. **State:** implementation candidate; operator acceptance PENDING.

## Mandatory dependencies

- WEB-00 canonical 45-screen/9×21 source baseline was accepted and recorded in [WEB-00 acceptance](../WEB-00/operator-acceptance.md).
- WEB-01 static web app was accepted and merged, and [operator acceptance](../WEB-01/operator-acceptance.md) establishes testing in the **production browser only**, not on Debian.
- English-only maintenance completed for web, firmware and GitHub Release descriptions ([audit](../WEB-01/english-audit.md)).
- Site `main` before WEB-02: `9b95bc964928b5912f0d46ae82434bdd9c3130a6`.
- WEB-02 implementation branch: `remappingbridge/remappingbridge.github.io:web/web-02-canvas-lcd-renderer`.
- Firmware **latest** release at preflight: **v3.2.4** (tag commit `69a640d9767ec7198572eb9b5073ed71f8f3d202`), a change to Zoom In HID shortcut only; it **does not change** the LCD contract.
- Verified Git blobs in **v3.2.3 and v3.2.4** match exactly:
  - `src/renderer/renderer.c`: `61c4fe3d547ba05c3e24de86518d807047b50a77`
  - `include/blu2usb/renderer/renderer.h`: `b8991b948042d48757b1177c07eebd90fb6b9cea`
  - `src/ux_model/ux_model.c`: `132010179de09ea81f4543e9ca83def09c0a743f`
- No source change to Bluetooth pairing, firmware code, release tags, checksum, binaries, or the firmware repository is in the WEB-02 scope.

## Scope and architecture

- The only app page remains `index.html`. Add a native `<canvas width="240" height="240">` and a separate pure JavaScript LCD rasterizer file. It runs with classic relative `defer` scripts, no Node, bundler, CDN or custom Pages build.
- Port firmware C's 5×7 ASCII bitmaps, 2× logical glyph scale, 9 rows, 21 columns, charAdvance 11, didactic and standard y positions, RGB565 semantic foreground colors, and full-frame background/row handling.
- Pixels are assembled as an RGBA buffer and blitted via `putImageData`; the **logical bitmap stays 240×240** regardless of devicePixelRatio, and CSS `image-rendering: pixelated` avoids blurred HiDPI zoom.
- Show `SEARCHING FIRST MOUSE` only, taken byte-for-byte from the WEB-00 firmware template. Its first two non-title rows are static yellow, other didactic rows gray, pressed control span temporarily turns white exactly like C, but **no firmware navigation, HELP, LOCK or BLE behavior** is implemented (WEB-03+).
- Only allowed browser deviation: dark-magenta background variants. **Original** #080008 is physical RGB565 expanded; **Soft** #190b1d and **Gentle** #28142c lighten **only** the LCD background. Original magenta title is unchanged. User selects a final preferred tone as part of acceptance; default during evaluation is Soft.
- No brightness slider or >100% brightness multiplier (WEB-08). No additional page, navbar or footer.

## Production browser requirement

The operator explicitly does not want Debian/local testing. The acceptance checklist targets `https://remappingbridge.github.io/` and `https://remappingbridge.github.io/tests/` **after the candidate becomes available on the production Pages deployment**. As of this gate's preflight, the URL's live HTTP status and GitHub Pages settings were **not** independently confirmed; repository branch/PR does not mean a working production URL.

## Rollback

Only the website candidate branch and (if needed) its PR should be discarded before acceptance. The accepted WEB-01 site `main`, canonical planner fixtures and firmware remain unchanged. No new physical UF2 is required for a renderer-only web gate.
