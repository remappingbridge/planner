# Experimental MBR-06/07/08 integrated recovery — candidate evidence

Status: **IMPLEMENTED THROUGH MBR-08 / PHYSICAL ACCEPTANCE PENDING**

Date: 2026-09-20

## Isolation

This execution is intentionally isolated from the accepted baseline.

- product branch: `experimental/mbr08-integrated-recovery-20260920`
- planner branch: `experimental/mbr08-integrated-recovery-20260920`
- base: MBR-05 `7f294a7fac9eebe226ad66c6b572582c5e483421`
- integrated implementation commit: `f13611d9bc6d28c54250445cbb268271f58c8efa`
- integrated firmware/manifest head before simulator tooling: `4297054d0573ce908ec81b2e2b82d9d428a5eee8`
- current product branch HEAD with desktop + static web simulators: `93f4fa3a7eb792c3f32ba431252485b142eee063`
- no merge into `main`, `mbr/rebuild-00-through-04`, or `mbr/mbr-05-ble-mouse`

The user explicitly authorized bypassing intermediate physical-gate dependency so MBR-06, MBR-07 and MBR-08 could be implemented and corrected together. That bypass permits implementation sequencing only; it does not declare physical PASS.

## Implemented scope

### MBR-05 recovery items
- BLE discovery accepts HID evidence split between advertisement and scan response.
- Mouse appearance may qualify discovery without requiring the HID UUID in one packet.
- FIRST 8-second renewal no longer cancels in-flight connection/security/HIDS qualification.
- identity/public address aliases are normalized for saved/new filtering.
- ancillary non-keyboard HID collections no longer cause a valid Mouse to be rejected.
- USB mount/resume releases output without tearing down Bluetooth.
- radio initialization retry and late-cancellation safety are implemented.

### MBR-06
- Passthrough, Standard, Escape and Custom runtime mappings.
- per-Mouse confirmed profile, global applied Custom template, persistent dirty draft.
- source ownership/refcounts and release-safe profile changes.
- dual-slot versioned CRC32 product storage with integrity fallback and write verification.
- product state separated from BTstack credentials.
- bounded saved reconnect support.
- Logitech HID++ Forward diversion/hold/release adaptation with generic fallback.

### MBR-07
- repeated FIRST search cycles, 8-second SEARCH_SAVED, 15-second Pair New.
- one authoritative Mouse plus one non-authoritative replacement transport.
- saved peers ignored as Pair New winners.
- old Mouse remains usable while new Mouse is discovered/qualified.
- release/disconnect/persist/promote handoff.
- persistent registry up to 16 mice.
- transactional removal with pending tombstone and credential-cleanup recovery.
- last saved removal returns to first-Mouse search.
- stale/late session completion isolation.

### MBR-08
- real profile, Custom draft/apply and removal requests wired to runtime/storage.
- real asynchronous connection/search state projection.
- Saved Devices live/disconnected projection without stealing the current page.
- Help ownership/return and preserved search deadline.
- HOME resolver, Pair New flow, Lock/Learn behavior and existing 30-screen literal/layout contract retained.
- HOME title/suffix and gray/white action styling retained.

## Final automated verification

GitHub Actions run: `35535753460`
Final product HEAD: `4297054d0573ce908ec81b2e2b82d9d428a5eee8`

Host:
- **14/14 PASS**
- core
- ux
- renderer
- usb
- hogp
- output
- bridge
- storage
- profiles
- integrated
- radio_adapter (real adapter compiled against pinned BTstack headers/event utilities with simulated controller/GATT/security events)
- qualification
- architecture
- canonical_screens

Pico 2 W:
- Pico SDK 2.2.0, SHA `a1438dff1d38bd9c65dbd693f0e5db4b9ae91779`
- BTstack `501e6d2b86e6c92bfb9c390bcf55709938e25ac1`
- ARM GCC 13.2.1
- Release build: PASS
- production UF2 verification: PASS
- qualification UF2 verification: PASS

Final Actions artifact:
- name: `mbr-08-experimental-pico2w-production-and-qualification`
- artifact ID: `10612770836`
- archive size: 1,965,187 bytes
- archive SHA-256: `23cb18fd27ec2956c5fcf47a2326e1b5f2336874da34e61a94d10522ef101bf3`

Production:
- file: `mouse_bridge_remapper.uf2`
- size: **880,640 bytes**
- SHA-256: `c9ded48b8c4e61459829eaa8cb2db777d8a2bd246ea57055aeedcde25846427e`

Qualification:
- file: `mouse_bridge_remapper_qualification.uf2`
- size: 96,256 bytes
- SHA-256: `97836b2e2db8670ff8b6ef3759afa37e9a97fb86d1656436f52d24a331e8b2ba`

The final documentation-only manifest commit rebuilt to the same UF2 hashes as the integrated implementation commit.

## Physical acceptance

Physical acceptance remains pending. Execute the 37 numbered scenarios in product repository
`docs/implementation/08-manual-tests.md` using the production UF2 above.

MBR-09 and MBR-10 are outside this recovery and remain backlog.


## Host virtual LCD/HAT simulator

The experimental branch now contains an interactive host simulator that directly reuses the production application state machine, UI projector and RGB565 renderer.

- backend: `tools/lcd_simulator/mbr_lcd_simulator.c`
- GUI: `tools/lcd_simulator.py`
- documentation: `docs/implementation/09-host-lcd-simulator.md`
- default virtual LCD scale: 300% = 720x720; presets 75/100/125/150/200/300%
- HAT controls: keyboard arrows, Enter/Space and A/B/X/Y, plus on-screen buttons
- deterministic event injection: Mouse READY/disconnect, +1s/+8s/+15s, HOME, reboot and factory-reset
- simulated profile/draft/removal operations are auto-confirmed so complete UI flows can be exercised
- final simulator host CI run: `35539637957`
- host result: **17/17 PASS**, including `lcd_simulator_smoke`, `lcd_simulator_gui_syntax` and `lcd_simulator_scale_presets`

The simulator does not emulate RP2350, CYW43/BTstack, TinyUSB, physical flash interruption or ST7789 electrical/SPI timing; physical-gate acceptance remains unchanged.


### Backlight simulation

The virtual LCD now separates the logical RGB565 framebuffer from display illumination.

- 100% = digital RGB565 reference;
- 0–1000% global virtual backlight gain, applied equally to all RGB channels;
- values above 100% are inspection gain only, useful for the frozen dark-magenta `0x0801` that is nearly black at digital reference;
- black remains black;
- channel values saturate at 255;
- Lock on a screen that owns `KEY Y: LOCK` forces effective backlight to 0% while preserving the selected gain and logical framebuffer;
- unlock restores the selected gain;
- desktop GUI uses a dark theme and exposes 100/300/500/750/1000% backlight presets plus a 0–1000% slider.
- LCD visual scale presets are 75%, 100%, 125%, 150%, 200% and 300% (180, 240, 300, 360, 480 and 720 px respectively for the 240 px panel).

Current host verification run: `35539637957`.
Host result: **17/17 PASS**, including simulator smoke, GUI syntax, scale-preset contract, architecture and canonical screens.

This is a visual inspection model, not a photometrically calibrated model of Waveshare backlight PWM/nits.


## Static browser simulator

A fully static browser simulator now lives under `web/`.

Runtime:
- `web/index.html`
- `web/simulator.css`
- `web/simulator-core.js`
- `web/simulator.js`

Properties:
- no backend, framework, WebAssembly or network dependency;
- works from local static files and may also be served by any static HTTP server;
- 240×240 canvas with ported canonical 5×7 glyph renderer and RGB565 palette;
- all 30 canonical screen templates;
- virtual HAT + keyboard controls;
- virtual Mouse connect/disconnect, deterministic +1/+8/+15 second clock controls;
- HOME, Pair New, Saved Devices/removal, profile/Custom UI state, Help and Lock flows;
- global backlight gain 0–1000%, with Lock forcing effective 0%;
- visual scale presets 75/100/125/150/200/300%;
- optional browser localStorage persistence for simulated product state;
- screen inspector and event/state panels.

Final product HEAD: `93f4fa3a7eb792c3f32ba431252485b142eee063`.
GitHub Actions run: `35540203883`.

Host:
- **19/19 PASS**
- `web_simulator_core_contract`: PASS
- `web_simulator_ui_syntax`: PASS
- all existing host/radio/architecture/canonical tests: PASS

Pico 2 W:
- build + UF2 verification: PASS
- production UF2 unchanged: 880,640 bytes, SHA-256 `c9ded48b8c4e61459829eaa8cb2db777d8a2bd246ea57055aeedcde25846427e`
- qualification UF2 unchanged: 96,256 bytes, SHA-256 `97836b2e2db8670ff8b6ef3759afa37e9a97fb86d1656436f52d24a331e8b2ba`
- artifact ID: `10614686174`
- artifact archive SHA-256: `56c1551a52f66ef9d3ca491434c9eddb29084b5a5df847523652917b39f47820`

The web simulator is an inspection target and does not replace physical acceptance.
