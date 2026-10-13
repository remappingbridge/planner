# WEB-15 — Integrated manual acceptance and regression scenarios

**Status: PENDING OPERATOR REVIEW.** Test on the published [firmware README](https://github.com/remappingbridge/remappingbridge#readme) and [virtual simulator](https://remappingbridge.github.io/), using the existing published [browser-only tests page](https://remappingbridge.github.io/tests/). Pages deployment success and static checks do not replace real visual testing.

1. **First impression:** open firmware README on desktop. Confirm live simulator CTA, direct UF2 download, Pico 2 W and Waveshare Pico-LCD-1.3 photos, and three short benefits appear **before** Table of contents.
2. **Exact TOC location:** confirm `## Table of contents` is **immediately before `## Why use it?`**, with no intervening content other than the eight TOC links.
3. **All eight anchors:** click each TOC link on GitHub; headings Why use it, How it works, Features, Try it in your browser, Hardware and safe assembly, Compatibility, Download/install, Docs/support/license should be scrolled into view.
4. **No old preview:** no "Curious?" duplicate CTA or deleted illustration/media; still exactly one visual-hero simulator CTA.
5. **Mobile accessibility:** check GitHub README and heading navigation at 320px/375px/768px, at 100%, 200% and 400% zoom; text/alt descriptions and hardware SVGs remain legible without unexpected clipping.
6. **Product imagery:** two externally hosted photos load on GitHub; captions point to the correct Raspberry Pi Pico 2 W and Waveshare Pico-LCD-1.3 SKU 19650, not a Linux Pi 40-pin HAT.
7. **Site opens:** click README simulator link and observe the actual Pages HTML, CSS, JS and Canvas app render. A successful deployment is not by itself evidence of live browser rendering.
8. **Initial states:** on the live simulator exercise Searching First Mouse, First Mouse Connected and Home Connected demo states. Demo buttons should not silently create/erase virtual saved mice.
9. **Virtual mouse lifecycle:** Pair New → Complete Successfully → Search/Reconnect → Disconnect/Remove; verify saved-device counts and transitions are coherent. Use only temporary testing data.
10. **Movement:** with a saved connected virtual mouse, use H/V gains and rotation, Apply, Back and Reset; verify that the active mouse profile changes locally, not the physical Pico or the host pointer.
11. **Custom and Modifier:** apply CUSTOM, choose at most one modifier, see proper cyan conditions and 12 combinations/30 shortcuts. Verify unavailable modifier button combo, KEY A apply/back and per-mouse saved profile behavior.
12. **Help/Lock:** HAT/keyboard KEY X Help, KEY Y LCD Lock, unlock behavior and first-mouse tutorial exceptions must mirror firmware screen instructions.
13. **Real UI scope:** look for retired DISPLAY CONTROLS, brightness/density panel, 100%+ LCD brightness or old `>` selection glyph; none should appear. Selection marker pipe remains in applicable source screens.
14. **Sticky/keyboard/touch:** desktop scrolling keeps physical-HAT-inspired simulator visible, but not blocking menus; keyboard Arrow/Enter/Space/A/B/X/Y and large mobile touch controls work at practical zoom.
15. **Isolated browser regression page:** run `/tests/` in a real browser; ensure its temporary Factory Reset does **not** erase saved virtual mice from the main simulator. Record result count only if actually observed.
16. **Diagnostics:** open optional Inspector, run deterministic scenarios, inspect glyph reference, try JSON/TXT/PNG export if permitted; these remain browser-only and must not claim physical-device evidence.
17. **Release URL:** inspect `/releases/latest`; current release should be v3.2.4 and asset names match README, or fix README **within WEB-15** if another release appears.
18. **UF2 checksum:** download the exact release UF2 and `SHA256SUMS.txt`, check 64-character SHA-256 `56d2eeaf96b2579e34b85333274a4bf1652b6bf33384d1b275eee36aa06f88f2`; record actual OS/hash only if verified. Do not mislabel CI hash as physical download.
19. **Hardware BOOTSEL** *(optional physical test)*: on Pico **2 W**, use data-capable Micro-USB and physical BOOTSEL; RP2350/RPI-RP2 appears, copying UF2 reboots. Normal updates never require `flash_nuke` or formatting. If no hardware test, say not tested.
20. **Documentation provenance:** check three original SVGs and their alt/source claims; ensure site README now says WEB-01–WEB-10 **accepted** rather than pending, without changes to the site app source.
21. **Scope:** firmware PR #52 only README; website PR #14 only site README; planner records source traceability. No new release, UF2, code behavior or workflows were changed in this gate.
22. **Final gate:** operator explicitly says **WEB-15 accepted** or requests correction. Do **not** mark accepted automatically because documentation CI and Pages deploy passed.

When reporting a manual result, record browser/version, viewport, zoom, platform and whether a physical Pico was connected. Keep unperformed checks **NOT RUN**, not implicitly PASS.
