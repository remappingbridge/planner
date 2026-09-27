# HOPE-27 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-27-help-retry-pair-new`
- commit: `96fff0d5c304166883419c11693e3dba4e10b556`
- draft PR: `#11`
- UF2: `HOPE-27-help-retry-pair-new-pico2w.uf2`
- size: **891,392 bytes**
- SHA-256: `8a308b70d5b284f3c84ce7f6141be8f59f5d43eba5848e34485cdc1ff68971ed`

## Required physical scenarios

1. Reach accepted `NEW MOUSE NOT FOUND`.
2. Press/release KEY X.
3. Exact `DEVICE NOT FOUND HELP` screen must appear.
4. Verify `KEY B TO BACK UNTIL` remains explanatory body text on black background.
5. Verify `SEARCHING APPEARS.` also remains on black body.
6. Verify only `ANY KEY: BACK` has the dark-magenta hint background.
7. Press/release KEY Y in Help; it must act only as Any Key Back and must not lock or turn off the display.
8. Re-enter Help and exit with another HAT control; interaction must be consumed.
9. Return must land on accepted `NEW MOUSE NOT FOUND`.
10. No Pair New operation may start merely by entering or leaving Help.
11. Keep an unsaved Mouse advertising while entering/exiting Help; it must not pair.
12. Press A from retry afterward; only then must a fresh 15-second Pair New operation start.
13. Current Mouse and saved/bond state must remain intact.
14. Confirm accepted HOPE-06/26/07 behavior remains functional.
15. Confirm no Bluetooth Keyboard/Composite behavior was introduced.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Candidate `96fff0d5c304166883419c11693e3dba4e10b556` is the physically accepted HOPE-27 implementation.

A cosmetic title improvement from `DEVICE NOT FOUND HELP` to `MOUSE NOT FOUND HELP` was requested after acceptance. Per operator instruction, that improvement is intentionally carried into the next gate rather than reopening HOPE-27.


## Promotion

- PR #11 candidate physically accepted and promoted.
- accepted main SHA: `1ffffebc0e9fabc55d981b7dcfbf7bba80bde78a`
- cosmetic title improvement `MOUSE NOT FOUND HELP` is intentionally bundled into HOPE-03 per operator instruction.
- next eligible gate: **HOPE-03 — home-connected**.
