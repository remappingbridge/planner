# HOPE-30 — help-remove-this physical acceptance

Status: **ACCEPTED BY OPERATOR / READY FOR PROMOTION**.

Candidate:

- branch: `hope/hope-30-help-remove-this`
- commit: `956906c2320c99937875bbbb95e6372945898424`
- draft PR: `#18`
- accepted base: `07abebc67d202ad67c52f325d6153b9ed0d90ab6`
- UF2: `HOPE-30-help-remove-this-956906c-pico2w.uf2`
- size: **912,384 bytes**
- SHA-256: `3de284a57a243759839f3b427f9d4a6060b11c0ecae64ba337099b08209b8a5f`
- CI run: `35995034296` — 41/41 host tests PASS; Pico 2 W production PASS.

## Required physical scenarios

1. Enter `saved-devices`, choose a saved Mouse, open `remove-this`, then press `KEY X`.
2. Confirm the Help screen text exactly matches Mouse UI v1, ending in `ANY KEY: BACK`.
3. Press each available HAT control from Help in separate attempts; every one must return to `remove-this`.
4. Specifically press `KEY Y` in Help and confirm it returns instead of locking the display.
5. Confirm returning from Help preserves the same Mouse target/name selected before opening Help.
6. With two saved Mice, open Help for one Mouse, cause connected-first reordering while Help is visible, return, and confirm the original target is unchanged.
7. After returning from Help, `KEY B` must still cancel to the correct saved-device page.
8. After returning from Help, `KEY A` must still remove exactly the selected Mouse through the accepted HOPE-05 flow.
9. Regression: saved-device names/order, Pair New, reconnection, movement/buttons/scroll, PASSTHROUGH/STANDARD/ESCAPE/CUSTOM and Lock outside Help remain functional.
10. Confirm no user-visible HOPE-23/HOPE-31 flow was introduced.

## Operator result

**ACCEPTED** by the operator on 2026-09-24.

Accepted exact candidate:
- commit: `956906c2320c99937875bbbb95e6372945898424`
- UF2 SHA-256: `3de284a57a243759839f3b427f9d4a6060b11c0ecae64ba337099b08209b8a5f`

Operator declaration: HOPE-30 accepted after physical testing.

Upon physical acceptance, HOPE-30 can be promoted and the current HOPE series is complete.


Promotion:
- merged PR: `#18`
- main commit: `25670c9692aaaf709912e2d6bb87c27c10b25b4e`
- series state: **COMPLETE / EXECUTION PAUSED BY OPERATOR**
- hold: **do not execute any new gate until a new explicit operator order**
