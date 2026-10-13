# WEB-12 — Preflight and frozen scope

**Date:** 2026-10-12 (Brazil local). **Status:** WEB-11 accepted by explicit operator message **"gate aceito. prossiga"** after the visual-first hardware-photo README revision. Planner WEB-11 evidence and acceptance PR #30 merged at **`caa6042282c0bdddd27a9cdee8f40d7d7a6b8f85`**.

## Baseline and source of authority

- Firmware repo `remappingbridge/remappingbridge` original `main` before WEB-12: **`ba21e0ef3228adf6e083c134f0a01053942308bc`**. Its README already has front-loaded live simulator/direct UF2, side-by-side Pico 2 W and Waveshare Pico-LCD-1.3 photographs, three quick features, and long-form compatibility warnings below.
- Last officially published firmware remains [v3.2.4](https://github.com/remappingbridge/remappingbridge/releases/tag/v3.2.4), pointing to source `69a640d9767ec7198572eb9b5073ed71f8f3d202` (not to be rebuilt or flashed for documentation).
- Physical input GPIO authority: [`include/blu2usb/hat/hat.h`](https://github.com/remappingbridge/remappingbridge/blob/main/include/blu2usb/hat/hat.h) Git blob **`d4d11b5c7c0204938ffd0f6aafdcd1a13708e45d`**. All 9 definitions audited.
- ST7789 SPI LCD GPIO authority: [`src/renderer/st7789_pico.c`](https://github.com/remappingbridge/remappingbridge/blob/main/src/renderer/st7789_pico.c) Git blob **`6bff1400437fa8dccf84a12da872eb80ed78b1a6`**. Signals GP8–GP13 audited.
- Manufacturer specifications: [Raspberry Pi Pico 2 W official](https://www.raspberrypi.com/products/raspberry-pi-pico-2/), [Pico-family documentation](https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html), [Waveshare **Pico-LCD-1.3** / **SKU 19650**](https://www.waveshare.com/Pico-LCD-1.3.htm). Product: 240×240 IPS ST7789 via SPI, female Pico headers, one joystick and four A/B/X/Y keys; LCD product does not ship with the Pico board.

## Scope/limits

Implement the [WEB-12 gate](../../gates/WEB-12.md) exclusively inside **README.md and original locally owned SVG diagrams**, not hardware firmware. Identify required vs optional BOM components, provide mechanical/alignment safety guidance, preserve the accepted quick-action hero, and clearly distinguish the **Raspberry Pi Pico 2 W** from the RP2350 *chip* and from the non-wireless Pico 2, and the **Pico-LCD-1.3** from a Linux Raspberry Pi 40-pin LCD HAT. Describe 9 HAT buttons with real GPIO names and SPI pins from source.

Do **not** copy unlicensed product photos into this repo; existing externally linked attributed product photos stay as approved in WEB-11. Do not change C/CMake/USB/BLE, release assets, firmware, UF2, tags, build workflows, or run physical flash. **WEB-13 screenshot/interactive README preview and WEB-14 installation guide are not authorized yet.**

Firmware documentation branch: `docs/web-12-hardware-assembly-and-controls`; planner evidence branch: `web/web-12-evidence`.
