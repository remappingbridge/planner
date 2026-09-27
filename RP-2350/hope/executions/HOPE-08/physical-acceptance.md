# HOPE-08 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-08-home-searching`
- commit: `b7ee92c841f4f3edbfdd73e2c9e9f146b5ccdeab`
- draft PR: `#4`
- UF2: `HOPE-08-home-searching-pico2w.uf2`
- size: 882,176 bytes
- SHA-256: `1b6d5d9cab934774f24ad5dfb3bfec1944cf6a94116d83253efe12e05805230e`

## Required physical scenarios

1. First establish at least one accepted/bonded Mouse, then power the Mouse off and reboot the Pico.
2. Boot must show exactly `SEARCHING SAVED MOUSE`; it must not show `SEARCHING FIRST MOUSE` and must not show old HOME while saved search is active.
3. Verify exact copy, geometry, black body and dark-magenta hint region.
4. Verify three selectable rows, white selection, Up/Down wrap and press behavior.
5. During the 8-second window, power on the already bonded Mouse: it must reconnect and leave `home-searching` for the current inherited connected-HOME placeholder.
6. Repeat with the bonded Mouse kept off for the complete window: after approximately 8 seconds the search must end; an unsaved BLE Mouse nearby must **not** be accepted as a fallback.
7. Start saved search again, press B before timeout: search must cancel immediately, leave `home-searching`, and preserve the bond.
8. Re-enter HOME while the saved Mouse remains offline (for example through an existing temporary destination/back path): HOME must resolve to `home-searching` and begin a new saved-only attempt.
9. From `home-searching`, press/release Y: presentation must lock and the saved search must be cancelled.
10. Unlock with one complete HAT interaction: that interaction must be consumed; while still offline HOME must resolve back to `home-searching` and start saved search again.
11. Verify `SAVED DEVICES`, `PAIR NEW MOUSE`, and `LEARN THE KEYS` selections reach their current incremental destinations; their canonical layouts remain future gates.
12. Verify a zero-saved-device/clean first-pair flow still shows accepted `SEARCHING FIRST MOUSE` -> `FIRST MOUSE CONNECTED`.
13. Confirm Mouse X/Y, Left/Right/Middle, supported wheel/Forward/Backward and G06 remap/persistence remain functional.
14. Confirm no Bluetooth Keyboard/Composite pairing was added.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Candidate `b7ee92c841f4f3edbfdd73e2c9e9f146b5ccdeab` is the physically accepted HOPE-08 implementation.


## Promotion

- PR #4 promoted after operator acceptance.
- accepted main SHA: `c88ebacdeb8265c9b8bd82882f97d9b8c960493a`
- next eligible gate: **HOPE-24 — home-searching-help**.
