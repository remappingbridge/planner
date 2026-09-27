# HOPE-01 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement only the Mouse UI Layout 1.0 screen `searching-first` on top of the accepted HOPE-00/G06 product, preserving the existing BLU2USB pairing/input architecture.

## Dependency

- HOPE-00: **ACCEPTED**
- accepted destination base: `remappingbridge/remappingbridge@16b9a3a2f164f08e3a9c25fc39a4767b04f48f39`
- planned branch: `hope/hope-01-searching-first`

## Pinned provenance

- destination base: `16b9a3a2f164f08e3a9c25fc39a4767b04f48f39`
- BLU2USB G06: `7eee024ad4ee726c5a85ffa2f32b9f47187878af`
- Mouse UI Layout 1.0: `e8adad7919e931c92515bf655ef4050876a8e7a9`

Mouse UI documents consulted for this gate:

- `docs/product/ui-layout-v1.0.md`
- `docs/spec/01-screen-reference.md`
- `docs/spec/03-first-start-and-pairing.md`
- `src/projector/screens.c`
- `src/projector/projector.c`
- `src/renderer/renderer.c`
- `tests/goldens/mui-04/screens.txt`

## Old screen / new screen

Old inherited first-start presentation:

- `BLU2USB_SCREEN_LEARN_KEYS`
- title `PRESS TO LEARN A KEY`
- full dark-magenta didactic background
- existing automatic BLE Mouse discovery already runs independently of that screen.

New screen introduced by this gate:

~~~text
SEARCHING FIRST MOUSE
PRESS TO LEARN KEYS
WHILE WAIT CONNECTION
       JOY UP
  JOY    JOY    JOY
  LEFT  PRESS  RIGHT
      JOY DOWN
 KEY A         KEY X
 KEY B         KEY Y
~~~

## Observable rules to implement

- use the exact 9 semantic rows above;
- 21-column layout;
- full-screen dark-magenta background;
- title uses the existing title tone;
- `PRESS TO LEARN KEYS` and `WHILE WAIT CONNECTION` use the system body/yellow tone;
- resting HAT labels use action/light-gray;
- while a displayed HAT control is held, only that control's visible token(s) become white;
- release restores the resting tone;
- joystick, A, B, X and Y are all didactic on this screen;
- `KEY B` does not navigate;
- `KEY Y` does not lock;
- no HAT control cancels discovery.

Frozen 0-based columns used by the existing renderer implementation:

- `JOY UP`: 7;
- top three `JOY`: 2 / 9 / 16;
- `LEFT` / `PRESS` / `RIGHT`: 2 / 8 / 15;
- `JOY DOWN`: 6;
- `KEY A` / `KEY X`: 1 / 15;
- `KEY B` / `KEY Y`: 1 / 15.

The G06 didactic renderer already uses title Y=8, body Y=39 and 25-pixel didactic advance, matching Mouse UI v1. This gate reuses those renderer primitives rather than importing mouse-ui architecture.

## In-place replacement rule

The inherited `BLU2USB_SCREEN_LEARN_KEYS` slot is the old first-start presentation used by G06. HOPE-01 **transforms that slot in-place** into `searching-first`.

There is no parallel `BLU2USB_SCREEN_SEARCHING_FIRST` screen-id and there is no runtime branch that chooses between the old and new visual layouts.

Therefore:

- every route that reaches the inherited first-screen slot now renders the Mouse UI v1 `searching-first` layout;
- stored BLE bonds may still affect the underlying G06 reconnect behavior, but they do **not** restore the old `LEARN THE KEYS` presentation;
- state-specific HOME variants remain future gates and are not introduced here.

## Temporary post-success bridge

Mouse UI v1 requires `first-mouse-connected` after first success, but that screen belongs to **HOPE-02** and must not be anticipated.

For this gate, when a fully ready BLE HOGP Mouse connects while `searching-first` is visible, the product transitions to the existing inherited G06 `HOME`. HOPE-02 will replace this temporary inherited successor with the canonical `first-mouse-connected` feedback.

The BLE `CONNECTED` event already means the HIDS descriptor has been accepted, a Mouse parser exists and the BLE state is READY; no earlier advertisement/connection event is used.

## Files expected to change

- `include/blu2usb/ux_model/ux_model.h`
- `src/ux_model/ux_model.c`
- `src/renderer/renderer.c`
- `src/app/main.c`
- `tests/CMakeLists.txt`
- one focused HOPE-01 host test.

## Reused

- G06 BLE HOGP discovery, security, HIDS qualification and bonded reconnect;
- G06 HAT input/press tracking;
- G06 ST7789 renderer, glyphs, palette and didactic Y geometry;
- G06 USB HID Mouse/Keyboard identity and Mouse forwarding/remapping;
- G06 persistent BTstack bond/reconnect behavior, without using it to select a legacy visual fallback.

## Explicit removals

The legacy visual presentation of the inherited `LEARN THE KEYS` slot is removed from this point of the flow:

- `PRESS TO LEARN A KEY`;
- the old joystick/key geometry;
- `LOCK SCREEN    KEY B`;
- `AND UNLOCK    KEY X`;
- `OPEN HOME -> KEY Y`.

The internal screen slot/name may remain as an implementation detail, but it no longer exposes the legacy layout. HOPE-23 will later introduce the canonical Mouse UI v1 `learn-the-keys` screen as its own product screen.

## Out of scope

- `first-mouse-connected` (HOPE-02);
- new HOME states (HOPE-08/09/03);
- Pair New;
- Saved Devices registry;
- removal flow;
- changing profiles/remap;
- UI↔Core contracts;
- mouse-core architecture;
- Bluetooth Keyboard/Composite pairing;
- architectural refactor.

## Automated verification

Run the inherited host suite and focused HOPE-01 tests, then the unchanged Pico 2 W production build.

The focused tests must prove:

1. exact 9-row `searching-first` text;
2. full didactic dark-magenta background;
3. prompt rows use system yellow/body tone;
4. HAT resting labels are light gray;
5. each HAT press produces white didactic feedback at the frozen coordinates;
6. release returns to normal;
7. B is inert;
8. Y is inert and does not lock;
9. no control leaves `searching-first`.

## Physical scenarios

1. boot into the inherited first-screen slot -> it must always render exact `SEARCHING FIRST MOUSE`, never the old `LEARN THE KEYS` layout;
2. verify full dark-magenta background and exact text/geometry;
3. verify prompt text is yellow;
4. press/release each joystick direction, joystick press, A/B/X/Y and verify only the corresponding label becomes white while held;
5. verify B does not navigate;
6. verify Y does not turn off the backlight/lock;
7. pair a BLE HOGP Mouse from this screen;
8. after the Mouse becomes ready, verify the temporary inherited G06 HOME appears;
9. verify X/Y movement;
10. verify Left/Right/Middle and supported wheel/Forward/Backward;
11. verify previously accepted G06 remap/persistence behavior is not regressed;
12. reboot with an already bonded Mouse and verify that bonded reconnect still works underneath **without ever restoring the old first-screen layout**;
13. verify no Bluetooth Keyboard/Composite pairing was added.

## Risks

- a connection-ready event arriving while the first screen is being initialized;
- accidental retention of the old Learn visual as a fallback or parallel screen;
- treating press feedback as navigation;
- introducing future HOPE screens early;
- pairing/input regression from changing startup ordering.

The implementation must keep the adaptation minimal and preserve the accepted G06 runtime.


## Correction after failed candidate

The first candidate incorrectly created a parallel `searching-first` screen and retained the legacy first screen as a bond-dependent fallback. The operator rejected that interpretation.

The corrected implementation follows the program-wide rule: **reuse means reuse internals; the visual screen itself is replaced in-place**.
