# WEB-12 — Operator acceptance

**Status: ACCEPTED by operator on October 12, 2026 (Brazil local time).** After reviewing the hardware BOM, original Pico 2 W + Waveshare Pico-LCD-1.3 assembly illustration, nine-control map and safe assembly notes in the published README, the operator explicitly said **"gate aceito. prossiga"**.

## Accepted publication and evidence

- Firmware [PR #48](https://github.com/remappingbridge/remappingbridge/pull/48) merged the WEB-12 docs-only candidate to `main`, commit `131b30758e4f5993f64480e2eadafff28699a570`.
- Preserved WEB-11 front-loaded live simulator, direct UF2 download and product photos.
- Source-audited 9/9 HAT inputs, 6/6 ST7789 display GPIOs, and 14/14 local README references. Firmware canonical [CI run #38328001418](https://github.com/remappingbridge/remappingbridge/actions/runs/38328001418) passed the architecture and Pico production jobs without publishing a firmware build.
- Two original accessible SVGs, required/conditional parts and power-off connection warnings. GitHub publication and automatic source checks are separate from the operator's explicit gate approval; no unstated physical assembly test is invented.

**Next authorized: WEB-13** — static clickable simulator preview, textual CTA and guided HOME → Movement → Modifier walkthrough for README. **WEB-14 NOT STARTED.**
