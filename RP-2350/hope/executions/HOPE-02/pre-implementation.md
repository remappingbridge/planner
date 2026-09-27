# HOPE-02 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Replace the inherited G06 first-pair success presentation with Mouse UI v1 `first-mouse-connected`, reusing the accepted HOPE-01 search/pairing/runtime underneath.

## Dependency

- HOPE-00: ACCEPTED
- HOPE-01: ACCEPTED
- accepted destination base: `remappingbridge/remappingbridge@4b0ebe933721895488a38f84c03f009c0d30cb32`
- branch: `hope/hope-02-first-mouse-connected`

## Pinned provenance

- BLU2USB G06: `7eee024ad4ee726c5a85ffa2f32b9f47187878af`
- Mouse UI Layout 1.0: `e8adad7919e931c92515bf655ef4050876a8e7a9`

## Replacement rule

This gate follows the program-wide rule: **reuse/adapt means replace in-place**.

The old success presentation `BLU2USB_SCREEN_MOUSE_SAVED` is reused as the internal slot and visually replaced by the canonical Mouse UI v1 screen. The legacy `MOUSE PAIRED / MOUSE CONNECTED / READY TO USE` layout must not remain as a fallback or parallel presentation.

## Canonical screen

~~~text
FIRST MOUSE CONNECTED
       JOY UP
  JOY    JOY    JOY
  LEFT  PRESS  RIGHT
      JOY DOWN
 KEY A         KEY X
 KEY B         KEY Y

 KEY Y: LOCK
~~~

## Observable rules

- shown only after the BLE HOGP pipeline reports a fully qualified READY Mouse from the accepted first-search flow;
- instructional body background: black;
- row 8 hint field: dark magenta;
- title: magenta;
- resting instructional controls: light gray;
- joystick directions/press and A/B/X: didactic only;
- B is deliberately inert;
- Y becomes white while held; on release it locks;
- while locked the backlight is 0/off;
- the first complete HAT interaction unlocks, is consumed and resolves HOME;
- with the first Mouse still connected, current accepted implementation resolves to inherited G06 HOME until the later HOME gates replace it;
- no legacy success screen may appear.

Frozen 0-based columns:

- JOY UP: 7;
- three JOY: 2 / 9 / 16;
- LEFT / PRESS / RIGHT: 2 / 8 / 15;
- JOY DOWN: 6;
- KEY A / KEY X: 1 / 15;
- KEY B / KEY Y: 1 / 15;
- KEY Y: LOCK: 1.

## Minimal implementation

- reuse `BLU2USB_SCREEN_MOUSE_SAVED` as the internal screen slot;
- route HOPE-01 READY transition to that slot instead of HOME;
- transform that slot's screen template to Mouse UI v1;
- extend the existing renderer minimally so this screen uses didactic 25px vertical geometry while retaining black body + magenta hint field;
- reuse the existing interaction lock/unlock primitive.

## Files expected to change

- `src/ux_model/ux_model.c`
- `include/blu2usb/renderer/renderer.h`
- `src/renderer/renderer.c`
- `src/app/main.c`
- `tests/CMakeLists.txt`
- one focused HOPE-02 host test.

## Explicit removals

The old visible success copy/layout is removed:

- `MOUSE PAIRED`
- `MOUSE CONNECTED`
- `READY TO USE`
- old Back/Lock success-screen presentation.

## Out of scope

- home-connected;
- home-searching/home-retry;
- pair-new/retry;
- saved-devices;
- profile screen migrations;
- new UI architecture/contracts/Core.

## Automated acceptance

Focused tests must prove:

1. exact 9 semantic rows;
2. black body + dark-magenta hint field;
3. didactic 25px vertical geometry;
4. all instructional controls have white held feedback;
5. A/B/X/joystick release does not navigate;
6. B is inert;
7. Y release locks;
8. first complete interaction unlocks and is consumed;
9. unlock resolves HOME;
10. legacy `MOUSE PAIRED` success copy is absent.

Inherited G02–G06 + HOPE-01 tests and Pico 2 W production build must remain green.

## Physical acceptance

1. start from HOPE-01 `SEARCHING FIRST MOUSE`;
2. pair a valid BLE HOGP Mouse;
3. READY must show exact `FIRST MOUSE CONNECTED`, never the old success screen;
4. verify black body, magenta hint field and exact geometry/colors;
5. verify joystick/A/B/X are didactic only and B does not navigate;
6. verify Y held feedback then release locks/backlight off;
7. use any HAT control to unlock; interaction must be consumed and current gate resolves to inherited HOME;
8. verify Mouse movement/buttons continue working before/after lock;
9. verify G06 profiles/remap/persistence regressions;
10. reboot/reconnect behavior must not reveal the old success layout;
11. no Bluetooth Keyboard/Composite pairing added.

## Risks

- conflating full-screen didactic background from HOPE-01 with split background required here;
- old `MOUSE_SAVED` routes exposing legacy copy;
- Y press locking too early instead of release;
- unlock interaction leaking into HOME navigation.
