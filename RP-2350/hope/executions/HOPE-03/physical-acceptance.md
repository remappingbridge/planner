# HOPE-03 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-03-home-connected`
- commit: `e5ba33b2c5a6b027e0277dfd05e610a8fe569efb`
- draft PR: `#12`
- UF2: `HOPE-03-home-connected-pico2w.uf2`
- size: **896,000 bytes**
- SHA-256: `25dac527c1a5ba6061181350605a4d292cc83b6070c15daa5d05512714a88dd2`

## Required physical scenarios

1. Boot with at least one saved Mouse and allow the saved Mouse to reconnect.
2. After the Mouse reaches READY, HOME must be the new home-connected layout; the old `HOME / STATUS / MOUSE OPTIONS / OTHER OPTIONS` presentation must never appear.
3. Confirm the title uses the actual GAP Device Name when exposed by the Mouse. If the peripheral genuinely does not expose/read Device Name, `UNKNOWN MOUSE` is the allowed fallback.
4. Confirm title is uppercase and follows the 15-supported-character rule.
5. A name without standalone `MOUSE` must gain ` MOUSE`; a name already containing standalone `MOUSE` must not gain a second suffix.
6. Confirm row 1 matches the current profile exactly:
   - `NO REMAP PASSTHROUGH`
   - `REMAPPED TO STANDARD`
   - `REMAPPED TO ESCAPE`
   - `REMAPPED TO CUSTOM`
   according to the actual profile.
7. Confirm the four selectable HOME rows are profile summary, SAVED DEVICES, PAIR NEW MOUSE, LEARN THE KEYS.
8. Up/Down must wrap all four selections.
9. Unselected HOME options must be ordinary light gray; selected row white; no HOME row may appear cyan merely because it is the current profile.
10. Joy Press on the profile summary must reach the existing Mouse Options flow (HOPE-10 will replace that destination later).
11. Joy Press on SAVED DEVICES must reach the current Saved Devices destination.
12. Joy Press on PAIR NEW MOUSE must enter accepted Pair New and leave the current Mouse authoritative during candidate search.
13. Cancel/return from Pair New and confirm HOME restores the same current Mouse title/profile.
14. Complete a successful Pair New handoff and confirm HOME title changes to the newly promoted Mouse name (or UNKNOWN fallback only if that peripheral has no readable Device Name).
15. Unplug the current Mouse while home-connected is visible. UI must immediately become `SEARCHING SAVED MOUSE`, and accepted saved-only reconnect behavior must run.
16. Reconnect a saved Mouse and confirm home-connected returns with the appropriate title.
17. Press/release KEY X on home-connected. HOPE-28 Help must **not** appear yet.
18. Press/release KEY Y on home-connected. Global lock must still work even though no Y hint is printed.
19. Unlock with one complete HAT interaction. It must be consumed and HOME resolver must return to home-connected while the Mouse remains live.
20. Reach retry-pair-new Help and confirm its title is now **`MOUSE NOT FOUND HELP`**.
21. On that Help screen, verify accepted HOPE-27 behavior remains unchanged: `KEY B TO BACK UNTIL` is body text, only `ANY KEY: BACK` has magenta hint background, Y exits Help rather than locking, and return lands on `NEW MOUSE NOT FOUND`.
22. Confirm Mouse movement/buttons, remap profiles, Escape synthetic keyboard output, persistence and Pair New still work.
23. Confirm no Bluetooth Keyboard/Composite Pair New behavior was introduced.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Candidate `e5ba33b2c5a6b027e0277dfd05e610a8fe569efb` is the physically accepted HOPE-03 implementation, including the bundled `MOUSE NOT FOUND HELP` title improvement.


## Promotion

- PR #12 candidate physically accepted and promoted.
- accepted main SHA: `95b8e6fab1710f562b7ce1ead629a9cca2734c17`
- next eligible gate: **HOPE-28 — help-home-connected**.
