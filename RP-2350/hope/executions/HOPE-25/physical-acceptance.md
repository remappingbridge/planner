# HOPE-25 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-25-home-retry-help`
- commit: `69570808a1c7e1ef82094e4dc63623716fe8e833`
- draft PR: `#7`
- UF2: `HOPE-25-home-retry-help-pico2w.uf2`
- size: **883,200 bytes**
- SHA-256: `b77528faa63554c6fc410ad38f4b61ebc37c5e953d741905e422df3f14b98f04`

## Required physical scenarios

1. Reach accepted `DEVICE NOT FOUND` with a saved Mouse offline.
2. Press/release `KEY X`.
3. Exact `HOME RETRY HELP` must appear.
4. Confirm the full literal text and exact layout.
5. Confirm explanatory body is black and `ANY KEY: BACK` field is dark magenta.
6. Confirm no saved-only search starts simply by opening Help.
7. Press/release `KEY Y`: it must act only as Any Key Back; display must not lock or turn off.
8. Re-enter Help and use another HAT control; the complete interaction must return to `DEVICE NOT FOUND` and be consumed.
9. After returning from Help, remain on `DEVICE NOT FOUND`; `SEARCHING SAVED MOUSE` must not start automatically.
10. Press A from `DEVICE NOT FOUND`; only then must accepted `SEARCHING SAVED MOUSE` start a fresh 8-second saved-only attempt.
11. Confirm saved bond remains intact.
12. Confirm HOPE-01/02/08/24/09 behavior remains intact.
13. Confirm Mouse X/Y, Left/Right/Middle, supported wheel/Forward/Backward, remap and persistence remain functional.
14. Confirm no Bluetooth Keyboard/Composite pairing was added.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Candidate `69570808a1c7e1ef82094e4dc63623716fe8e833` is the physically accepted HOPE-25 implementation.


## Promotion

- PR #7 promoted after operator acceptance.
- accepted main SHA: `def2743022c3b522190eac06b97af0d4148348bd`
- next eligible gate: **HOPE-06 — pair-new**.
