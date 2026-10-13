# WEB-12 — Hardware diagrams, BOM and safe assembly candidate

**Gate state:** CANDIDATE PUBLISHED, **operator acceptance PENDING**. **WEB-13 NOT STARTED**.

## Observed delivery

[Firmware PR #48](https://github.com/remappingbridge/remappingbridge/pull/48) integrates strictly **3 documentation files** into firmware `main`, commit **`131b30758e4f5993f64480e2eadafff28699a570`** (source branch `docs/web-12-hardware-assembly-and-controls`, candidate `cd1977578dd62559437a4069227ef880b3b98a11`).

1. **README.md:** a new “Hardware and safe assembly” section **below** the approved headline/demo/download/photos. A clear required/conditional/optional components table includes Pico **2 W** (RP2350 + BLE), Waveshare **Pico-LCD-1.3** (SKU 19650, 240×240 ST7789 SPI), BLE HOGP mouse, Micro-USB **data** cable, host USB HID support, correctly mounted 2×20 male headers if needed, and optional insulation/spacers. Explicitly rejects Pico 2 (no W) and misleading 40-pin Raspberry Pi Linux LCD HAT.
2. **Original diagram** [`docs/assets/pico-2w-lcd-assembly.svg`](https://github.com/remappingbridge/remappingbridge/blob/main/docs/assets/pico-2w-lcd-assembly.svg): Pico 2 W, RP2350, BLE section and Micro-USB alongside Waveshare LCD front, joystick/keys, female Pico sockets, 2×20 header concept and USB-off alignment warnings. It is **not** a pin-1 orientation or electrical engineering drawing.
3. **Original diagram** [`docs/assets/pico-lcd-controls-map.svg`](https://github.com/remappingbridge/remappingbridge/blob/main/docs/assets/pico-lcd-controls-map.svg): clearly labeled HAT joystick UP/DOWN/LEFT/RIGHT/PRESS and A/B/X/Y with **exact firmware GPIO pins** from the C `hat.h` header. Direct full-size image links and descriptive Markdown alt plus SVG title/description provided.
4. **Five ordered mechanical safety steps:** unpowered/dry work surface, check installed pins/pre-header alternative, verify full connector rows and pin-1/silkscreen orientation (never offset or rotate), gently seat without force/bent pins, Micro-USB data to host/antenna clearance. Do not mandate soldering for pre-header boards; no BOOTSEL flashing instructions or erase.
5. **Nerd-only GitHub `<details>`:** button pins GP2/3/16/18/20 and 15/17/19/21, and LCD SPI1 SCK GP10, MOSI GP11, D/C GP8, CS GP9, RESET GP12, backlight GP13. Source files linked; no invented explicit external wiring plan.
6. New vector assets are **original, self-contained**, do not incorporate embedded third-party pictures; existing vendor photographs stay **externally hosted/attributed**. Earlier WEB-11 visual-first CTAs and release assets remain unchanged.

## Executed nonbrowser verification

- Input GPIO mapping **9/9 source definitions match actual `hat.h`**; LCD driver signals **6/6 match actual `st7789_pico.c`**.
- Existing and new **14/14 local README link references** resolve in GitHub candidate tree; original source diagram and product hero still present.
- Both SVG files have exactly one `<svg>`, one `<title>`, one `<desc>`, balanced generic/text tags, descriptive alt text in README and separate enlarging links. Source check also found **no active scripts, external image elements, foreign objects or event handlers**.
- Static contract/source checks passed. **Canonical CI completed successfully** for the WEB-12 candidate commit `cd1977578dd62559437a4069227ef880b3b98a11`: both `host-architecture` and `pico2-w-production` checks **PASS**, [run #38328001418](https://github.com/remappingbridge/remappingbridge/actions/runs/38328001418). This build verification does **not** mean new firmware was released or physically flashed. No browser-rendered SVG/layout screenshots or physical assembly were tested in the tool environment; do not claim those.

## State boundary

Publishing firmware README/docs to `main` enables GitHub visual verification, **not operator acceptance**. The physical unit is unchanged; original code to restore if rejected: **`ba21e0ef3228adf6e083c134f0a01053942308bc`** (revert documentation-only changes, never flash Pico). WEB-13 remains blocked.
