# WEB-13 — Manual acceptance after operator correction

**Status: PENDING.** Review the [GitHub-rendered README](https://github.com/remappingbridge/remappingbridge#readme) and [live simulator](https://remappingbridge.github.io/). The operator **removed the optional static preview** and it must **not** reappear.

1. The README introductory text and three features now flow directly into the next section, with **no "Curious?" paragraph**, large simulator image, secondary clickable-preview CTA or duplicated disclaimer.
2. The original prominent **OPEN LIVE SIMULATOR** and exact **v3.2.4 UF2 download** links still appear at the top, with the two accepted Pico 2 W and Waveshare Pico-LCD-1.3 photographs and captions.
3. The original standalone `docs/assets/simulator-preview-v3.2.4.svg` is deleted from main; neither the README nor any link refers to it.
4. The later **Try it in your browser** paragraph links straight to `https://remappingbridge.github.io/` and does **not** refer to an image or preview above. State clearly that the simulator does not run inside the README.
5. The **five-step HOME → virtual pairing → Movement → Modifier → Shortcuts** walk-through remains available lower down, including **KEY A**, **KEY B**, **JOY PRESS**, the virtual-only data caveat and no real USB/HID output.
6. In a real Firefox/Chromium browser, click the text link from README and verify the simulator fully loads, including its 240×240 LCD HAT and Virtual Mouse Lab. GitHub deployment/CI status alone does not prove a successful live click.
7. With a temporary virtual mouse saved in-browser, manually exercise HOME → Movement and Custom Modifier → Modifier Shortcuts; confirm only local simulation data changes and physical firmware is not touched.
8. Check README at mobile widths and at larger zoom sizes; it no longer needs to render or scale the removed illustrative SVG. Verify accepted hardware photos, assembly SVG, controls map and technical tables are still legible.
9. Confirm **14/14 relative Markdown resource paths** resolve in the corrected tree; safe-assembly, compatibility, release, checksum and no-flash_nuke warnings remain intact.
10. Verify firmware [PR #50](https://github.com/remappingbridge/remappingbridge/pull/50) contains only README copy changes and deleting the unused SVG, without modifying any code, binary, build workflow or release.
11. Operator explicitly **accepts WEB-13** or requests further corrections. Do **not** accept automatically or begin WEB-14 just because publication succeeds.

When reporting, note browser, viewport and zoom and any broken link or wording. The operator's removal request is **feedback**, not a statement of gate acceptance.
