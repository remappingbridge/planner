# WEB-11 — Preflight

**Gate:** WEB-11 — human-first README and product value, authorized by the operator's explicit **"gate aceito. prossiga"** for WEB-10. **Status:** implementation underway; operator WEB-11 acceptance not yet given.

## Baselines verified

- WEB-10 was accepted and planner evidence PR #29 merged at `100303557514b2566c5cf33ed594168dd87af320`. The web simulator accepted website main remains `26aaac5c7939ddc8883aa756c6a575a3d36b808a`, with successful Pages deploy of that SHA.
- Firmware repository `remappingbridge/remappingbridge` before WEB-11: `main` `3cb74cd04c674803ec109b694fbc3f10a114bad5`. Its latest published firmware release remains **v3.2.4** (published October 12, 2026), tag target `69a640d9767ec7198572eb9b5073ed71f8f3d202`.
- Authoritative current source: firmware v3.2.4 release docs, on-device HAT pin header and C firmware data flow; historic HOPE architecture and mouse-ui v1 screens are **not** used to restore v1 keyboard pairing or deprecated Standard/Escape preset screens.
- Source root README was accurate about firmware details but buried the product purpose, contained an obsolete `WEB-01` preview description, and offered outdated **v3.2.3** direct UF2 links beneath "Latest stable" v3.2.4. These discrepancies are documentation-only.
- [Gate definition](../../gates/WEB-11.md) requires value story, beginner-friendly problem/solution, current functions, qualified compatibility, original high-level architectural drawing and links to existing public simulator/docs.

## Constraints

**English-only public README.** Do not change firmware C, CMake, HID transport, saved data, flash updates, build/test workflows, tags, releases or produce UF2. Do not introduce detailed hardware BOM, assembly steps, animated browser preview, or direct current-version UF2 installation; these belong to WEB-12, WEB-13 and WEB-14, respectively. Do not promise universal BLE, operating-system, application or accessibility compatibility.

Branch: `docs/web-11-product-readme` at the firmware repository. Planner evidence branch: `web/web-11-evidence`. Operator acceptance remains pending after publishing a reviewable document.
