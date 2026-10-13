# WEB-13 — Preflight

**State:** authorized by explicit operator acceptance of WEB-12 on October 12, 2026 (America/Sao_Paulo). WEB-12 planner evidence [PR #31](https://github.com/remappingbridge/planner/pull/31) merged as `df2d787ea4836f654fc4ef6c43758b6d6f8e87b5`.

## Baseline and provenance

- Firmware documentation repository `remappingbridge/remappingbridge` original `main` before WEB-13: `131b30758e4f5993f64480e2eadafff28699a570`, with accepted visually prioritized hero, source-backed hardware assembly, two SVG diagrams, correct Pico 2 W/LCD labels, v3.2.4 stable UF2/checksums and long-form safety cautions.
- Web source `remappingbridge/remappingbridge.github.io` `main` **`26aaac5c7939ddc8883aa756c6a575a3d36b808a`**; [successful GitHub Pages deploy run #38325202264](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38325202264) for exactly this SHA. Published source `index.html`, `assets/css/app.css` and `assets/js/screens.js` at that SHA show compact sticky HAT, brand upper-left, yellow virtual-device lower-left, joystick/LCD/A-B-X-Y/specs, demo states and Virtual Mouse Lab; HOME source literals are pinned to firmware `v3.2.4`.
- Latest stable firmware release at preflight: [v3.2.4](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.4). No firmware or version change allowed.
- [Gate scope](../../gates/WEB-13.md): **static clickable image/GIF/SVG preview**, real Pages link plus text link, short guide HOME → Movement → Modifier, alt/zoom/mobile, honest simulator disclaimer. The GitHub README cannot host interactive JavaScript/iframe and must not misrepresent an illustration as a real screenshot.

## Constraints

**Only `README.md` and one original lightweight SVG media asset.** Maintain WEB-11 approved up-front simulator/download/photos and WEB-12 original hardware assets, BOM/physical safety. The preview points to the site; no Web Bluetooth, host HID, physical mouse, firmware, UF2, release, JavaScript embed, workflow or site change.

**Visual caveat:** direct live site/browser GET could not be verified through the available web retrieval environment. The GitHub Pages deployment success is evidence of publication, **not** a real screenshot or exhaustive client validation. An original **representative, explicitly illustrated** SVG is appropriate; document this rather than claiming browser pixel capture.
