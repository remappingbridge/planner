# WEB-15 — Integrated final audit candidate

**Status: PUBLISHED CANDIDATE — OPERATOR ACCEPTANCE PENDING.** All intended WEB gates have reached this final review. No further implementation gate is authorized automatically.

## Published changes

- Firmware [PR #52](https://github.com/remappingbridge/remappingbridge/pull/52) merged to firmware main **`dd401996f6ab72ef1babb475dc0575fdd89e0052`**. Exactly one file changed: **README.md**, adding **Table of contents** after the already-accepted two hardware photographs/3 benefits and immediately before `## Why use it?`. Its **8/8 internal section heading anchors** match real GitHub-style heading slugs; **15/15 local Markdown resource links resolve** in the actual git tree. The accepted hero and body are byte-for-byte unchanged apart from inserting the TOC. This change did **not** reintroduce “Curious?” / redundant static simulator preview.
- Simulator [PR #14](https://github.com/remappingbridge/remappingbridge.github.io/pull/14) merged to website main **`4b9b4892b52dc2005f73c7d0594ac512bc96f668`**. Corrected one inaccurate historical phrase in site README saying WEB-10 still awaited approval. A recursive git tree comparison to WEB-10 accepted source `26aaac5c7939ddc8883aa756c6a575a3d36b808a` confirms **README.md is the only changed blob**: exact same HTML, CSS, JS and test fixtures.
- The current website GitHub Pages [deploy run #38387175118](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38387175118) **completed SUCCESS** against the docs-only website main SHA `4b9b4892...`; the earlier WEB-10 accepted source [deploy #38325202264](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38325202264) also succeeded.
- Firmware main's `pico2-w-production` and `host-architecture` checks **completed SUCCESS** against the README-only gate commit `dd401996...`; no binary published and release remains v3.2.4.

## Cross-repository/static audit matrix

| Topic | Actual source check | Outcome |
| --- | --- | --- |
| Source release | Official GitHub Releases API latest `v3.2.4`; original release source `69a640d9...` | **MATCH** |
| Download | Direct UF2 asset `remappingbridge-v3.2.4-pico2w.uf2`; 953,344 bytes | **MATCH** |
| Integrity | Official GitHub UF2 asset digest `56d2eeaf96b2579e34b85333274a4bf1652b6bf33384d1b275eee36aa06f88f2` and companion `SHA256SUMS.txt` | **MATCH metadata**; checksum text/bytes not independently downloaded or recalculated |
| Stable links | `/releases/latest` alongside release-locked direct download | **PRESENT**; README clearly warns versioned direct link requires updating |
| README navigation | Table of contents immediately before “Why use it?” with 8 anchor targets | **8/8 PASS** |
| README relative paths | 15 internal Markdown paths exist in actual firmware tree, including all three allowed local SVG diagrams | **15/15 PASS** |
| Original images | `remappingbridge-flow.svg`, `pico-2w-lcd-assembly.svg`, `pico-lcd-controls-map.svg`; accepted externally hosted hardware photographs with provenance | **PRESENT**; remote photo availability/browser loading requires manual inspection |
| Retired media | Deleted optional `simulator-preview-v3.2.4.svg`; no redundant "Curious?" content or duplicate preview | **ABSENT as requested** |
| Site code baseline | WEB-10 accepted `26aaac...`, WEB-15 `4b9b...`; only website `README.md` changed | **NO RUNTIME DRIFT** |
| Screen source | `assets/js/screens.js` defines **45 distinct screen IDs**; `assets/js/app.js` pins v3.2.4 and firmware `69a640d9...` | **45/45 source IDs and version MATCH**; historical detailed literal parity evidence in WEB-10 |
| Input controls | Published website `index.html` defines JOY four directions + PRESS and four A/B/X/Y actions | **9/9 controls present** |
| Local flows | Website markup has Home Connected, Pair New, Remove, Factory Reset Virtual Mice and Virtual Mouse Lab; source code distinguishes virtual data from real BLE/HID | **PRESENT**; real browser state tests remain manual |
| Retired display controls | Site `index.html` has no DISPLAY CONTROLS, brightness/density sliders, iframe or 100%+ brightness capability | **NO RETIRED UI** |
| Flash safety | README Pico 2 W/BOOTSEL, `RP2350` or `RPI-RP2`, no formatting or routine `flash_nuke`, v2/v3 downgrade warning | **PRESENT** |
| Production deployments | Accepted WEB-10 web [run #38325202264](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38325202264) and docs-only WEB-15 site [run #38387175118](https://github.com/remappingbridge/remappingbridge.github.io/actions/runs/38387175118) | **SUCCESS** |
| Firmware CI | Host architecture and Pico 2 W production checks on current documentation-only firmware main | **SUCCESS**, no new UF2 release |

## Important limits

The live Pages URLs could **not** be fetched through this assistant's available HTTP inspection interface (tool returned disabled/unavailable). Successful official GitHub Pages deployments and source parity are valuable evidence but **not** a real browser session on desktop/mobile; do not claim a successful end-to-end browser click, screenshot, clipboard/export, touch or localStorage test. No actual hardware BOOTSEL copy, mouse pairing, host USB HID validation or all-platform checksum comparison was performed in this final documentation gate. No unverified release asset body was used.

The operator must explicitly accept WEB-15 for full WEB program closure. Keep final planner PR draft while pending.
