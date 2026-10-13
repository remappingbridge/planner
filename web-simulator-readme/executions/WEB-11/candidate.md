# WEB-11 — Product README candidate

**Status:** README/artwork candidate prepared; **OPERATOR ACCEPTANCE PENDING**. **WEB-12 NOT STARTED.**

## Changes

- Rewrote only `remappingbridge/remappingbridge/README.md`, opening with a succinct physical product description and prominent working live simulator/latest release/technical doc links.
- Added a high-contrast original **SVG** `docs/assets/remappingbridge-flow.svg` mapping *BLE HOGP mouse → Pico 2 W/remap/movement/shortcuts/LCD → USB HID mouse/keyboard/consumer → host*. The SVG includes semantic `<title>` and `<desc>` text; README Markdown supplies meaningful image alt and a one-line textual alternative. Hardware photos/assembly/BOM are intentionally deferred to WEB-12.
- Explained concrete optional uses in productivity, mouse input customization and accessibility, and carrying external per-mouse settings between compatible hosts.
- Described current firmware Passthrough/Custom, five physical button sources with one Modifier, 12 combinations/30 actions, movement H/V 0.25×..3× and 0°/90°/180°/270°, saved mice and UI Help/Lock.
- Clarified the simulator's full WEB-10 features and limits (45 canonical screens, demo states, in-browser local profiles and diagnostics, no real Bluetooth/USB/HID/firmware flashing).
- Preserved/strengthened nonnegotiable limitations: BLE HID-over-GATT, **Pico 2 W**, USB HID host; no universal mouse/app/OS support; Logitech Lift specific handling not a compatibility promise; Lock does not disable mouse output; MNT-15 Zoom In Ctrl+Equal without Shift still conflicts with some terminal bindings; v2→v3 migration/downgrade risks, no routine flash_nuke, no production debug USB/UART.
- Corrected outdated "WEB-01 baseline preview" and version-inconsistent v3.2.3 UF2 link in the latest-stable section. Kept the **stable /releases/latest landing page** and up-to-date v3.2.4 release description, reserving exact UF2 + SHA256 + installation instructions for WEB-14.

## Automated and source checks

- Confirmed latest v3.2.4 release from GitHub API, release notes, firmware source and planner gate scope.
- **8/8 relative README Markdown link targets** resolve in the candidate's real Git tree, including new SVG and local release docs; external target URLs have known route/repo source but actual remote browser clicking remains operator work.
- SVG includes original vector geometry, proper title/description and no external script/image requests, active content or `foreignObject`. Alt text and visible textual fallback exist.
- Documentation-only Git diff: `README.md` plus `docs/assets/remappingbridge-flow.svg`. No firmware/build/workflow/UF2/release changes. No browser-based screenshot, mobile display, screen-reader or human readability acceptance is falsely claimed.

## Publication boundary

Firmware documentation [PR #46](https://github.com/remappingbridge/remappingbridge/pull/46) contains the candidate. Firmware PR #46 **merged to public firmware `main`** for README rendering and operator review on October 12, 2026 (local date), commit **`efc2ab938a7e6c4e844c5c74903b5390acadd716`**. Exactly **2 files changed** (README and original SVG), no C, CMake, CI workflow or firmware assets. This publication **does not record WEB-11 acceptance**. Canonical CI [run #38326176242](https://github.com/remappingbridge/remappingbridge/actions/runs/38326176242) **completed successfully** for the unchanged-docs-only PR head SHA `04d1086046038c9a7fa428b55aa4cbdbbfc8373f`: both `host-architecture` and `pico2-w-production` checks reported `success`. This is only a CI regression check; it does **not** constitute a new firmware release or the operator's README visual approval. Rollback target is the pre-WEB-11 firmware-repository `main` SHA `3cb74cd04c674803ec109b694fbc3f10a114bad5` (README-level revert only; never firmware flash).

WEB-12 cannot begin until the operator explicitly accepts WEB-11.

## Operator-requested WEB-11 visual quick-start revision

After the first WEB-11 README candidate was published, the operator asked: **place the simulator and download links at the very beginning, add actual pictures of RP2350/Pico 2 W and the Waveshare LCD HAT at the beginning, prioritize the visually interesting/actionable content, and move long explanations below.** This is a **revision inside WEB-11**, not acceptance and not authorization for WEB-12.

Implemented through [firmware PR #47](https://github.com/remappingbridge/remappingbridge/pull/47), merged to firmware `main` at **`ba21e0ef3228adf6e083c134f0a01053942308bc`**. The README now opens with a concise product line, **live simulator CTA**, actual verified v3.2.4 **direct UF2 download CTA**, stable `/releases/latest` and matching v3.2.4 SHA256SUMS, followed by **two hardware photos side-by-side**, with links to manufacturer information, explicit sources, descriptive alt text, and 3 quick benefits (shortcuts, movement, mouse-specific settings). Old architecture SVG was moved down to `How it works`, before the technical detail. The photos are **source-hosted external hotlinks** (Raspberry Pi official and Welectron's Waveshare display photo), not copied files owned by the project. Confirm visible imagery in the GitHub-rendered README; remote servers may change assets.

Verified direct v3.2.4 UF2 and checksum filenames exist as actual latest release assets through the GitHub release API; verified **both photo URLs display the correct boards** from source pages; checked **7/7 local README paths**, the compatibility-section anchor, source model names Pico 2 W/RP2350 and Waveshare Pico-LCD-1.3 SKU 19650, and preserved the full technical/safety content. The Pico 2 W **board** contains the RP2350 chip; the correct Pico-LCD-1.3 has **one joystick and four A/B/X/Y keys**, and is distinct from the 40-pin Raspberry Pi Linux LCD HAT. No hardware images were cloned into the repository, no new firmware, release, binary, build scripts or site changes. Site images and button rendering still need **operator browser inspection**. **WEB-11 remains PENDING; WEB-12 remains NOT STARTED.**
