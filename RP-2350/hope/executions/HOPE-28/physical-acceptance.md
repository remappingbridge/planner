# HOPE-28 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-28-help-home-connected`
- commit: `8dacad0a34a78ec89e74454f1b6d09d71eae01ae`
- draft PR: `#13`
- UF2: `HOPE-28-help-home-connected-current-v1-copy-pico2w.uf2`
- size: **896,512 bytes**
- SHA-256: `6f11f76d05249f6989106a5f8346dffea76873b0ddb32cff2776296c0dc8a807`

## Required physical scenarios

1. Reach accepted home-connected with a live saved Mouse.
2. Move the HOME selection to a nonzero row.
3. Press/release KEY X.
4. Exact Help must appear:

~~~text
REMOVE CONNECTED HELP
TO DISCONNECT THE
CURRENTLY CONNECTED
MOUSE NAVIGATE TO:
STEP 1. SAVED DEVICES
STEP 2. REMOVE DEVICE
STEP 3. KEY A: REMOVE

ANY KEY: BACK
~~~

5. Verify rows 0–7 use black background and only `ANY KEY: BACK` uses dark-magenta hint background.
6. Press/release KEY Y while Help is visible. It must return from Help and must **not** lock or switch off backlight.
7. Confirm the same HOME selection from step 2 is restored.
8. Re-enter Help and exit with another HAT control; the interaction must be consumed and must not activate the selected HOME option.
9. Confirm no Pair New, remap apply, profile change, removal, or saved-device mutation occurs from Help entry/exit.
10. Open Help again and power off/disconnect the current Mouse.
11. Help may remain visible after disconnect.
12. Exit Help. It must return to accepted `SEARCHING SAVED MOUSE`, not stale home-connected.
13. Confirm accepted 8-second saved reconnect/search behavior continues.
14. If the Mouse reconnects while Help is still visible, dismiss Help and confirm return is live home-connected, not stale searching.
15. Confirm HOME name/profile summary remain correct after reconnect.
16. Confirm Mouse movement/buttons, profiles/remap, Escape output, Pair New and persistence remain functional.
17. Confirm no Bluetooth Keyboard/Composite behavior was introduced.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Replacement candidate `8dacad0a34a78ec89e74454f1b6d09d71eae01ae` with current Mouse UI v1 copy is the physically accepted HOPE-28 implementation.


## Copy-correction supersession

Do not use the previous HOPE-28 UF2. Its behavior was valid, but the visible Help copy was stale relative to current Mouse UI v1 source.

Physical acceptance must use the replacement candidate generated after synchronizing with `mouse-ui/src/projector/screens.c@5f269e9625ae0d02a85b5d39eb87026edc448068`.


## Replacement candidate

Use only:

- commit: `8dacad0a34a78ec89e74454f1b6d09d71eae01ae`
- CI: `35832917577` — PASS
- UF2: `HOPE-28-help-home-connected-current-v1-copy-pico2w.uf2`
- SHA-256: `6f11f76d05249f6989106a5f8346dffea76873b0ddb32cff2776296c0dc8a807`

The previous HOPE-28 UF2 is superseded and must not be accepted physically.


## Promotion

- final current-v1 PR #13 candidate physically accepted and promoted.
- accepted main SHA: `46e501f13784d3ef94e3d4213596b25afa731347`
- next eligible gate: **HOPE-10 — remapper-options**.
