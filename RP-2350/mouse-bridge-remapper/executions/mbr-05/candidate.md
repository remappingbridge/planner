# MBR-05 candidate evidence

Gate: `mbr-05 — Canonical Mouse core and one BLE HOGP passthrough`

Status: **IMPLEMENTED / PHYSICAL ACCEPTANCE PENDING**

## Candidate

- repository: `tiagooliveirajs/mouse-bridge-remapper`
- branch: `mbr/mbr-05-ble-hogp-mouse`
- implementation SHA: `85537913154fb2c3cab9fbe5d0101b4ee01f70fc`
- PR: #5
- base integrated MBR-04 main: `1062974972ab11c6500489e181e2e7f6488c9ccc`

## Automated evidence

Final CI run: `35483841205` — SUCCESS.

- host-architecture: SUCCESS
- pico2-w-production: SUCCESS
- host tests: all 8 PASS, including `ble_hogp_contract`, `output_state_contract` and architecture contract
- Pico 2 W production build: SUCCESS
- UF2 verification: SUCCESS
- artifact upload: SUCCESS

Artifact:

- name: `mbr-04-pico2w-usb-hid-uf2`
- ID: `10596882258`
- archive digest: `sha256:76958bafae1e9b491d024e5dfe319af1f7734dea8a08ac425f1359d6708dbd84`

The artifact name remains inherited from the existing workflow; its `mouse_bridge_remapper.uf2` content is the MBR-05 production candidate.

## Production UF2

- file: `mouse_bridge_remapper.uf2`
- size: 875520 bytes
- SHA-256: `6c400704a2868989b988c6fee682f1ecdbc8bedb20023463cf7776fa5b17a9ae`
- purpose: exact MBR-05 physical candidate

The artifact also contains the older MBR-04 qualification UF2 because the workflow artifact name/path has not yet been renamed. That qualification image is not the MBR-05 physical image.

## Implemented behavior

- one authoritative Mouse session;
- canonical Mouse event boundary;
- host-pure HOGP Report Map parser;
- five buttons, relative X/Y, wheel and Consumer AC Pan;
- optional duplicated Report-ID framing normalization;
- malformed/truncated report rejection;
- keyboard-only Report Map rejection;
- bounded runtime queue with overflow signal;
- BLE session generation and stale-event filtering;
- BLE HOGP security/bonding and HIDS Report Protocol;
- bonded reconnect through LE device database/resolving/whitelist with 8-second attempt bound;
- deterministic advertised-name capture with `UNKNOWN MOUSE` fallback;
- fixed USB Mouse forwarding through MBR-04;
- held-output release and pending-relative-state cleanup on disconnect/overflow;
- UI/Mouse processing remains active without diagnostic USB/UART stdio.

## Physical closure scenarios

Use only the exact production UF2 above.

1. **Baseline identity regression** — flash the MBR-05 production UF2 and confirm the MBR-04 USB identity remains `CAFE:4011`, manufacturer `tiagooliveirajs`, product `Mouse Bridge Remapper`, exactly two HID interfaces and no CDC/debug interface.
2. **Display/HAT remains alive** — confirm the Waveshare 240x240 UI still renders and HAT navigation works after BLE runtime startup.
3. **Fresh BLE HOGP Mouse pairing** — with the intended BLE HOGP Mouse not already connected, allow the firmware to discover it, complete security/bonding and reach the connected Mouse UI.
4. **Mouse name** — confirm the connected Mouse title uses the advertised name when present; otherwise the documented `UNKNOWN MOUSE` fallback is used.
5. **Left/Right/Middle** — physically press/release the Mouse's Left, Right and Middle buttons and confirm matching USB Mouse down/up events.
6. **Forward/Back** — if the physical Mouse exposes Forward/Back, confirm both are forwarded as USB Mouse buttons with correct hold/release behavior.
7. **Relative movement** — move the Mouse on X and Y and confirm host pointer movement in both axes without stuck deltas.
8. **Wheel/pan** — use vertical wheel and, if available, horizontal pan and confirm matching host scroll events.
9. **Held-button safety** — hold a Mouse button, keep moving/scrolling, and release it; confirm the button releases and no stale held state remains.
10. **Disconnect while held** — disconnect/power off the Mouse while a button is held; confirm USB output is released immediately and the UI does not freeze.
11. **Bonded reconnect** — reconnect/power-cycle the same bonded Mouse and confirm it can return through the bounded bonded-reconnect path without fresh product USB enumeration.
12. **UI responsiveness during Mouse traffic** — operate HAT navigation while moving the Mouse continuously; confirm UI input remains responsive and Mouse output continues.
13. **Lock safety** — while the UI is locked, confirm Mouse traffic continues and disconnect still releases output.
14. **USB stability** — during pairing, movement, buttons, wheel/pan and reconnect, confirm there is no spontaneous USB disconnect/re-enumeration and the fixed USB descriptor remains unchanged.
15. **Generic fail-safe** — after a failed/disrupted BLE connection attempt, confirm no stale Mouse button or relative movement remains active and the firmware returns to a usable search/connection state.

## Acceptance boundary

CI/build success is not physical acceptance. MBR-05 remains open until the operator reports PASS/FAIL for the numbered scenarios on the exact production UF2. A failure requires a corrected candidate and rerun of affected scenarios.
