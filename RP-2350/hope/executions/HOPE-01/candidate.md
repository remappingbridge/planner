# HOPE-01 — candidate

Status: **CORRECTED CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Superseded failed candidate

The previous candidate at `987afd16e951160860c77bd9f304dca586c339d0` is **INVALIDATED**.

Failure: it created `searching-first` as a parallel screen while retaining the legacy `LEARN THE KEYS` presentation as a saved-bond fallback.

That interpretation is now forbidden program-wide.

## Corrected product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@16b9a3a2f164f08e3a9c25fc39a4767b04f48f39`
- branch: `hope/hope-01-searching-first`
- corrected candidate commit: `5c686c57efd794c08b4212736709b4825d22aa21`
- draft PR: `#2`
- PR remains unmerged until operator physical acceptance.

## Replacement semantics

HOPE-01 now transforms the inherited first-screen slot `BLU2USB_SCREEN_LEARN_KEYS` **in-place**.

There is no separate `BLU2USB_SCREEN_SEARCHING_FIRST` screen-id.

The legacy visual content was removed from the implementation:

- `PRESS TO LEARN A KEY`
- `LOCK SCREEN    KEY B`
- `OPEN HOME -> KEY Y`
- bond-dependent legacy visual fallback.

Every route to that inherited screen slot now renders only:

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

## Observable behavior

- full 240x240 dark-magenta didactic background;
- title in title/magenta tone;
- rows `PRESS TO LEARN KEYS` and `WHILE WAIT CONNECTION` in body/yellow;
- HAT labels resting in light gray;
- held control tokens turn white;
- release restores resting tone;
- joystick and A/B/X/Y are didactic only;
- B does not navigate/cancel;
- Y does not lock;
- discovery continues independently underneath.

A stored BLE bond may influence the existing G06 reconnect behavior, but it cannot restore the old visual screen.

## Post-success bridge

`first-mouse-connected` belongs to HOPE-02 and is not introduced early.

When the existing G06 BLE HOGP pipeline reports a fully qualified READY Mouse while the replaced first-screen slot is visible, the current gate transitions to the inherited G06 HOME. That HOME is a different future migration point and remains unchanged until its own HOPE gate.

## Automated verification

GitHub Actions run: `35816267180` — **SUCCESS**.

- `host-architecture`: **SUCCESS**
  - host configure: PASS
  - inherited G02–G06 tests: PASS
  - architecture/screen-contract tests: PASS
  - HOPE-01 focused tests: PASS
- `pico2-w-production`: **SUCCESS**
  - pinned ARM toolchain: PASS
  - pinned Pico SDK: PASS
  - configure: PASS
  - production build: PASS
  - UF2 verification: PASS
  - artifact upload: PASS

Additional source verification on the corrected branch found no occurrence of:

- `BLU2USB_SCREEN_SEARCHING_FIRST`;
- `PRESS TO LEARN A KEY`;
- `LOCK SCREEN    KEY B`;
- `OPEN HOME -> KEY Y`;
- `blu2usb_ble_hogp_pico_has_bonded_mouse`.

## Corrected candidate UF2

GitHub Actions artifact:

- artifact id: `10731942224`
- artifact name: `blu2usb-picow-production-pico2w`
- ZIP size: 323,486 bytes
- ZIP digest reported by GitHub: `sha256:bccc82bcd759e39ebeaa7682fbbd862a08cfd6d615ccd315ad940b73d90d56cc`

Extracted firmware:

- file: `blu2usb_picow.uf2`
- size: **878,592 bytes**
- SHA-256: `cd8074d4adb680011a8e1c469ec26220edf925d2b31974512621c5260bd4b6d8`

## Gate state

HOPE-01 remains **NOT ACCEPTED** until the operator physically validates this corrected candidate.
