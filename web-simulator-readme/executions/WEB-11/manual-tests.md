# WEB-11 — Manual acceptance scenarios

**Status:** PENDING. Test the *rendered* README in GitHub, not merely raw Markdown. [Firmware README](https://github.com/remappingbridge/remappingbridge#readme) · [Product simulator](https://remappingbridge.github.io/).

1. **Nontechnical first impression:** in 20–30 seconds, can a new reader identify what RemappingBridge connects (**BLE mouse → Pico 2 W → USB HID computer**) and that the computer does not require a dedicated RemappingBridge app? The mouse is paired to the **Pico**, not the host Bluetooth stack.
2. **Value without inflated claims:** productivity, mouse-control customization, different workstations and accessibility examples are understandable yet qualified; README does not imply every host, mouse, disability, OS or shortcut is supported.
3. **Architecture SVG:** preview appears in GitHub README, not as XML/source. Zoom in and out and check arrowheads/labels. SVG alternative includes a meaningful alt and its own `title`/`desc`; a text-only one-line flow exists if the image cannot be read.
4. **Narrow/mobile/zoom:** check GitHub README at narrow mobile screen, desktop 100%, 200% and 400% zoom if available, with font enlargement/low-vision settings. Main text does not force horizontal scrolling; SVG diagram remains legible through image opening/zoom.
5. **Current functions:** verify Passthrough, Custom, single Modifier, 12 combinations, 30 actions, separate H/V DPI and rotation, per-mouse profiles, Help/Lock. No legacy Standard/Escape presets reappear as current UI.
6. **Current interface vs website:** the "Try" link opens the full single-page simulator, with 45 firmware screens and the WEB-09 approved demo buttons/Virtual Mouse Lab. README never implies live pairing, flashing or HID action from the website.
7. **Physical transport:** the copy identifies a **Pico 2 W with BLE HOGP mouse** and **USB HID Mouse/Keyboard/Consumer** host endpoints. It does not claim generic Bluetooth Classic/keyboard/composite pairing, gamepad, or host file access.
8. **Host/application caveats:** confirm Zoom In Ctrl+Equal without Shift and variability of terminal/application shortcuts; Lock is only for the HAT/LCD while normal input continues.
9. **Stable download:** "Current stable" links to v3.2.4; the separate `releases/latest` resolves to the current official release. No outdated v3.2.3 download masquerades as latest. Direct version-specific UF2 and checksum procedure remains reserved for WEB-14.
10. **Safe updates and history:** v2→v3 migration, downgrade incompatibility, bond preservation and **no routine flash_nuke** caution remain visible; any wording suggesting guaranteed migration of damaged or unknown schemas should be rejected.
11. **Docs and license:** open links to v3.2.4 docs, v3.0 contract, planner Movement, Modifier, maintenance, license, issues, sources and tests. Images are original, readable, with clear semantics; no unlicensed photograph was added.
12. **Final scope and acceptance:** diff must touch **only README.md + original SVG**; no firmware or GitHub release changes. Report any broken link, screenshot/zoom issue, confusing product claim or inaccurate capability. WEB-11 is accepted only after explicit operator approval; do not start WEB-12 before it.

## Evidence

Record browser name/version, zoom/viewport, whether SVG is visible, and exact link or sentence needing correction. Automatic static QA does not prove human comprehension or mobile accessibility.
