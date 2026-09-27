# HOPE-01 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

## Invalidated candidate

- old commit: `987afd16e951160860c77bd9f304dca586c339d0`
- result: **FAIL**
- reason: legacy `LEARN THE KEYS` visual remained available as a fallback.
- old UF2: invalidated and must not be used for acceptance.

## Corrected candidate

- branch: `hope/hope-01-searching-first`
- commit: `5c686c57efd794c08b4212736709b4825d22aa21`
- draft PR: `#2`
- UF2: `HOPE-01-searching-first-corrected-pico2w.uf2`
- size: **878,592 bytes**
- SHA-256: `cd8074d4adb680011a8e1c469ec26220edf925d2b31974512621c5260bd4b6d8`

## Required retest

1. Boot and confirm the first-screen slot shows exactly `SEARCHING FIRST MOUSE`.
2. Confirm that **`PRESS TO LEARN A KEY` never appears**, including when the device already has a bonded Mouse.
3. Confirm there is no bond-dependent or other fallback to the old `LEARN THE KEYS` visual.
4. Confirm the exact 9-row Mouse UI v1 layout and frozen positions.
5. Confirm full dark-magenta background.
6. Confirm the two instruction rows are yellow.
7. Confirm HAT labels are light gray at rest.
8. Press/release Joy Up/Down/Left/Right/Press and A/B/X/Y; only the corresponding visible token(s) become white while held.
9. Confirm B does not navigate or cancel discovery.
10. Confirm Y does not lock or turn off the backlight.
11. Pair/reconnect a valid BLE HOGP Mouse from this screen.
12. On READY, confirm the gate may transition to the inherited G06 HOME; `first-mouse-connected` is HOPE-02.
13. Confirm Mouse X/Y movement.
14. Confirm Left/Right/Middle and supported wheel/Forward/Backward.
15. Confirm accepted G06 profile/remap/persistence behavior remains functional.
16. Reboot with an already bonded Mouse: reconnect must continue working underneath, but the old first-screen layout must **never** reappear.
17. Confirm no Bluetooth Keyboard/Composite pairing was introduced.

## Operator result

Operator declaration for corrected candidate: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

The corrected candidate `5c686c57efd794c08b4212736709b4825d22aa21` is the physically accepted HOPE-01 implementation.


## Promotion

- PR #2 promoted after operator acceptance.
- accepted main SHA: `4b0ebe933721895488a38f84c03f009c0d30cb32`
- next eligible gate: **HOPE-02 — first-mouse-connected**.
