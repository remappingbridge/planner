# MBR-02 pre-implementation record

Gate: `mbr-02 — Interaction engine, UI projector and golden screen model`  
Status: **IN PROGRESS**

## Entry validation

- Accepted predecessor: `mbr-01 — COMPLETE / ACCEPTED`.
- Product base: `tiagooliveirajs/mouse-bridge-remapper@cee10ee157ce0d7f6655df203327422c3c40e6b3`.
- Planner base: `tiagooliveirajs/repo-planner@fe885d3cc37ac174413b52987a1597f6fbdd7f4f`.
- Historical behavior reference where relevant: `tiagooliveirajs/blu2usb@7eee024ad4ee726c5a85ffa2f32b9f47187878af`.
- Product branch: `mbr/mbr-02-host-ux-model`.
- Planner branch: `mbr/mbr-02-host-ux-model`.

## Objective

Implement the frozen MBR-00 UX as host-pure domain/interaction/projection logic before renderer, USB and Bluetooth integration. The gate must make every canonical screen, control map, HOME/search transition, Pair New projection, name/profile/status projection and stale-event rule executable and testable on a host build.

## Frozen product decisions used

- actions execute on release;
- Help owns every HAT input and consumes the returning interaction;
- lock is presentation-only and the first complete interaction while locked unlocks and is consumed;
- `searching-first` is fully didactic and cannot navigate/cancel/lock;
- `first-mouse-connected` and `learn-the-keys` use instructional B/X/Y semantics exactly as documented;
- HOME resolves `no saved -> searching-first`, `saved + live -> home-connected`, `saved + no live -> home-searching`;
- FIRST_MOUSE and SEARCH_SAVED policy duration is 8 seconds; PAIR_NEW is 15 seconds;
- SEARCH_SAVED expiry/cancel projects `home-retry`;
- Pair New is new-only, can coexist with one authoritative Mouse and an optional non-authoritative candidate, and cannot create a second authoritative ready Mouse;
- stale search transaction/session completions are ignored by ID/generation;
- `STANDARD` is the canonical visible profile vocabulary;
- Mouse names project first 21 renderer-supported characters with fallback `UNKNOWN MOUSE`;
- Saved Devices uses exact `STATUS: CONNECTED` / `STATUS: DISCONNECTED`, with only the sole authoritative Mouse name marked connected/cyan;
- Custom source-editor changes update the draft immediately; full Custom Apply is only projected successful after confirmation;
- exact Pair New Help literals are immutable;
- `escape-active` `JOY LEFT: GO TO HOME` is intentional;
- no Keyboard/Composite/multi-connected UI state exists.

## Expected implementation changes

Primary modules:

- `domain`: shared UX identifiers/enums/constants needed by pure modules;
- `mouse_registry`: host-pure saved-Mouse records, names, profiles and pagination data;
- `mouse_session`: authoritative live identity/session truth used by projector;
- `profiles`: profile/custom-draft vocabulary and pure state;
- `pairing_coordinator`: transaction IDs/purposes/timings/candidate projection and stale-event filters;
- `interaction`: release-triggered control state, lock/help behavior and per-screen semantic commands;
- `ui_projector`: canonical screen model, rows/tokens/colors/dynamic fields and HOME resolver;
- `app`: host-pure UX aggregate/orchestration only if needed; no transport/HAL calls.

Tests/build:

- extend CMake host test composition;
- add golden screen tests covering every canonical screen;
- add transition/async tests including HOME resolver, search expiry/cancel, Pair New states, stale transaction/session filtering, instructional controls, lock/help consumption, Custom drafts, names, Saved Devices and color priority;
- retain and pass mbr-01 bootstrap/architecture guards;
- retain successful Pico 2 W structural build as predecessor regression evidence, without claiming new physical behavior.

## Out of scope

This gate must not implement or claim:

- ST7789 drawing, framebuffer or physical HAT GPIO/debounce;
- real USB descriptors/report submission;
- TinyUSB behavior;
- CYW43/BTstack/HOGP runtime behavior;
- real BLE pairing/reconnect/handoff;
- flash persistence or Bluetooth credential mutation;
- Logitech HID++;
- physical acceptance or usable firmware behavior;
- Bluetooth Keyboard/Composite/Classic Mouse;
- more than one authoritative live Mouse.

## Regression risks to control

- accidentally executing on press instead of release;
- hidden Key Y Lock or hidden navigation inherited from BLU2USB;
- Help input leaking through to underlying page actions;
- stale async search/session completion changing a newer transaction;
- Pair New falsely replacing current-Mouse truth before committed handoff;
- historical `DEFAULT` vocabulary leaking into visible UI;
- long names exceeding 21 visible characters or ellipsis being introduced;
- selection/pressed white not overriding cyan current state;
- exact Pair New Help literals or didactic token columns drifting;
- reintroducing Keyboard/Composite/multi-connected screens.

## Verification plan

Host acceptance:

```text
cmake -S . -B build-host -DMBR_BUILD_PICO=OFF -DMBR_BUILD_TESTS=ON -DCMAKE_BUILD_TYPE=Release
cmake --build build-host --parallel
ctest --test-dir build-host --output-on-failure
```

Required host evidence includes all predecessor tests plus new golden/transition tests.

Architecture/static acceptance:

- mbr-01 `architecture_contract` remains green;
- new source remains host-pure in the modules owned by mbr-02;
- canonical screen inventory contains no forbidden Keyboard/Composite/multi-connected states.

Pico predecessor regression:

```text
PICO_SDK_PATH=<pico-sdk-2.2.0> cmake -S . -B build-pico -DMBR_BUILD_PICO=ON -DMBR_BUILD_TESTS=OFF -DPICO_BOARD=pico2_w -DCMAKE_BUILD_TYPE=Release
cmake --build build-pico --parallel
```

CI must validate exact implementation head before integration.

## Physical acceptance

Not required for mbr-02. No physical PASS will be claimed.

## Rollback / recovery

No descriptor or persistence schema changes are authorized in this gate. If the frozen UX contract proves contradictory, stop dependent implementation, update documentation/planning first, and do not silently choose an interpretation.
