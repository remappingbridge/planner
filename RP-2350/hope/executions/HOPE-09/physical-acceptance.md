# HOPE-09 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-09-home-retry`
- commit: `c6cbea7d00e2a2a38de2a78a22fc1126ff4a1670`
- draft PR: `#6`
- UF2: `HOPE-09-home-retry-pico2w.uf2`
- size: **882,688 bytes**
- SHA-256: `7de8be1f50858a8ed62408a90f3a9ab86fdf5de10d6cd4c636a1d453737289f3`

## Required physical scenarios

1. With a saved Mouse offline, allow `SEARCHING SAVED MOUSE` to expire after the accepted 8-second window.
2. The next screen must be exactly `DEVICE NOT FOUND`; old G06 HOME must not appear.
3. Repeat saved search and press B before timeout; next screen must again be exactly `DEVICE NOT FOUND`.
4. From `SEARCHING SAVED MOUSE`, open `HOME SEARCHING HELP`; Any Key Back must now land exactly on `DEVICE NOT FOUND`.
5. Verify exact 9-row layout, black body and dark-magenta hint region.
6. Verify initial selection is SAVED DEVICES and Up/Down wraps across the three rows.
7. Press B on `DEVICE NOT FOUND`; it must be inert.
8. Press/release X; HOPE-25 Help must not appear yet and the screen must remain `DEVICE NOT FOUND`.
9. Press A; it must immediately enter `SEARCHING SAVED MOUSE` and start a new saved-only 8-second attempt.
10. Keep Mouse offline; after the retried window, return to `DEVICE NOT FOUND`.
11. During a retried saved search, power on the bonded Mouse; reconnect must remain functional.
12. Verify Joy Press on SAVED DEVICES / PAIR NEW MOUSE / LEARN THE KEYS reaches the current incremental destinations.
13. Press/release Y on `DEVICE NOT FOUND`; display must lock/off.
14. Unlock using one complete HAT interaction; it must be consumed and, while Mouse remains offline, HOME must resolve to `SEARCHING SAVED MOUSE` with a fresh saved-only search.
15. Confirm accepted HOPE-01/02/08/24 behavior remains intact.
16. Confirm Mouse X/Y, Left/Right/Middle, supported wheel/Forward/Backward, remap and persistence remain functional.
17. Confirm no Bluetooth Keyboard/Composite pairing was added.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Candidate `c6cbea7d00e2a2a38de2a78a22fc1126ff4a1670` is the physically accepted HOPE-09 implementation.


## Promotion

- PR #6 promoted after operator acceptance.
- accepted main SHA: `b883353bb654826d4c960513e72182d2b35b4c6a`
- next eligible gate: **HOPE-25 — home-retry-help**.
