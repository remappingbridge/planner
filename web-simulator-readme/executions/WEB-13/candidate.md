# WEB-13 — Clickable static simulator preview candidate

**State:** README candidate published; **OPERATOR ACCEPTANCE PENDING**. **WEB-14 NOT STARTED**.

## Published delivery

[Firmware PR #49](https://github.com/remappingbridge/remappingbridge/pull/49) integrated two docs-only changes into firmware `main` at **`c06c585ecc7411e930d30457795366c4a869a262`**:

1. `docs/assets/simulator-preview-v3.2.4.svg` — **original ~7.8 KB standalone 1280×720 vector illustration**, no scripts/external requests or active links. Its UI layout is source-derived from the deployed static website `index.html`, `assets/css/app.css`, `assets/js/screens.js`: REMAPPINGBRIDGE brand upper left, yellow VIRTUAL DEVICE lower left, left cross joystick, central dark-magenta HOME screen, A/B/X/Y vertical right keys, Pico 2 W/LCD/9 controls in right panel, 3 real demo-state names, and Virtual Mouse Lab. An example DEMO MOUSE label substitutes the dynamic connected-device name; eight nonempty LCD HOME lines preserve source literals and focus pipe. **Not a real live screenshot** and never represented as one; visually labeled STATIC PREVIEW and explicitly described as illustrative. SVG `title`, `desc` and detailed Markdown alt provide alternatives; no dependency on external raster image copyright.
2. `README.md` — preserve previously accepted hero with visible live simulator/download buttons and real Pico/HAT photos. Add a clickable Markdown image linked directly to **https://remappingbridge.github.io/** near the top, plus redundant **textual** CTA for assistive technology / blocked image loads. Browser section now contains a guided **HOME → Virtual Mouse Lab pairing → Movement → Custom Modifier → Combinations/30 Shortcuts** walkthrough and HAT navigation/lock/help hints, without implying that preview or GitHub can execute the actual app. Browser profile state is local only, and no Bluetooth pairing, USB HID action or flash can occur from the simulator.

## Executed checks

- **12/12 static assertions passed**: self-contained well-balanced SVG tree, title/desc and no active/script/external content; real clickable Markdown image link and independent textual CTA; 8 nonblank HOME firmware source rows, correct keyboard/HAT/demo/Virtual Mouse Lab vocabulary; complete guided flow and no physical HID claims; all local Markdown paths exist in candidate git tree; existing hero and v3.2.4 release remain in correct sequence.
- Source web GitHub Pages last successful deploy and exact SHA checked. A successful deploy does not establish a live browser GET or an actual screenshot.
- The PR changes **only `README.md` and one original SVG**; no firmware, CMake, UF2, tag, release, website, JS or workflow changes.

## Manual evidence boundary

An operator should open the rendered GitHub README on desktop/mobile, verify vector loads at 100–400% zoom, click both image and text into the **real interactive website**, and actually walk HOME → Movement → Modifier on a paired **virtual mouse**. No remote live browser run is claimed by the static checks. If SVG needs different positioning or word sizes, correct within WEB-13 before acceptance.

Rollback reference for README documentation only: firmware `main` before gate `131b30758e4f5993f64480e2eadafff28699a570`. **Do not start WEB-14 until explicit operator acceptance.**
