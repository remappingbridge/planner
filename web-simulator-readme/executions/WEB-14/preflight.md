# WEB-14 — Preflight and authorized scope

**Date:** October 13, 2026 (Brazil local). **State:** WEB-13 accepted explicitly by operator (“gate aceito. prossiga”). Planner WEB-13 [PR #32](https://github.com/remappingbridge/planner/pull/32) merged **`28a1548ba3ee209dbd19d633ef99f34fbd494bfc`** before this WEB-14 branch was created.

## Repositories and release baseline

- Firmware `remappingbridge/remappingbridge` accepted `main` at gate start **`d4b1e3a822f710907b8b14f80b4f67119d8e8aef`** (user-approved intro with one simulator link, real board photographs and no redundant static preview image). This gate must preserve all WEB-11/12/13 documentation outside its release/installation section.
- Latest GitHub release was verified through the official [GitHub Releases API](https://api.github.com/repos/remappingbridge/remappingbridge/releases/latest): **`v3.2.4`**, published 2026-10-12 19:58:10 UTC. Actual assets:
  - [`remappingbridge-v3.2.4-pico2w.uf2`](https://github.com/remappingbridge/remappingbridge/releases/download/v3.2.4/remappingbridge-v3.2.4-pico2w.uf2), **953,344 bytes**, official GitHub release asset digest **SHA-256 `56d2eeaf96b2579e34b85333274a4bf1652b6bf33384d1b275eee36aa06f88f2`**.
  - [`SHA256SUMS.txt`](https://github.com/remappingbridge/remappingbridge/releases/download/v3.2.4/SHA256SUMS.txt), **100 bytes**, companion text checksum.
  - Persistent latest release page [`/releases/latest`](https://github.com/remappingbridge/remappingbridge/releases/latest). Versioned URL cannot automatically track future tags.
- Official Raspberry Pi documentation [Pico-series Microcontrollers](https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html) and [C SDK](https://www.raspberrypi.com/documentation/microcontrollers/c_sdk.html) confirm BOOTSEL hold-while-connecting, removable volume `RPI-RP2` on Pico or `RP2350` on Pico 2-series, UF2 copy to volume, automatic disconnect/reboot. Do not assume Pico 2 W always presents the older `RPI-RP2` label.
- Existing firmware [`docs/releases/v3.2.4.md`](https://github.com/remappingbridge/remappingbridge/blob/main/docs/releases/v3.2.4.md) cautions that candidate UF2 hash differs from final release. Refer users to official release hash/checksum.

## Scope and limits

Implement [WEB-14](../../gates/WEB-14.md) only within firmware **`README.md`**: correct URL/filename, same-release checksums, host verification commands, physical BOOTSEL/USB guide, safe updating/downgrade guidance, error handling without flash erase, and operator manual checks. Do not modify firmware source, build CI/workflows, website, UF2, release, license or assets. No physical flash is run as part of this documentation gate. **WEB-15 NOT STARTED**.
