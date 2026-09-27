# HOPE-23 — remove learn-the-keys physical acceptance

Status: **ACCEPTED BY OPERATOR / READY FOR PROMOTION**.

Candidate:

- branch: `hope/hope-23-remove-learn-the-keys`
- commit: `0c12061f010bbd5416808643d843d64f9bf89b73`
- draft PR: `#19`
- accepted base: `25670c9692aaaf709912e2d6bb87c27c10b25b4e`
- UF2: `HOPE-23-remove-learn-home-0c12061-pico2w.uf2`
- size: **912,384 bytes**
- SHA-256: `22e6ff36fcca0ae2cd6f7696cde31d0998dbf7a895fc034213f8a096a0ee706f`
- CI run: `36271915605` — 43/43 host tests PASS; Pico 2 W production PASS.

## Required physical scenarios

1. With a connected saved Mouse, open HOME and confirm there is no `LEARN THE KEYS` option.
2. Confirm connected HOME exposes only remapping options, saved devices and Pair New Mouse.
3. Use Joy Up/Down repeatedly and confirm selection wraps only among those 3 options; no blank fourth option is selectable.
4. Open each of the 3 options with Joy Press and confirm their original destinations still work.
5. Disconnect a saved Mouse and enter `home-searching`; confirm there is no `LEARN THE KEYS` option.
6. Confirm `home-searching` selection wraps only between Saved Devices and Pair New Mouse.
7. Reach `home-retry`; confirm there is no `LEARN THE KEYS` option and selection wraps only between Saved Devices and Pair New Mouse.
8. Confirm KEY A retry, KEY B search cancellation semantics, HOME Help and global Lock continue to behave as previously accepted.
9. With zero saved Mice, reboot/resolve HOME and confirm the automatic `SEARCHING FIRST MOUSE` bootstrap still appears and can pair the first Mouse.
10. Regression: Saved Devices, remove-this/help-remove-this, Pair New, reconnect, movement/buttons/scroll and all remapping profiles remain functional.
11. Confirm no HOPE-31 or other new gate behavior was introduced.

## Operator result

**ACCEPTED** by the operator on 2026-09-26.

Accepted exact candidate:
- commit: `0c12061f010bbd5416808643d843d64f9bf89b73`
- UF2 SHA-256: `22e6ff36fcca0ae2cd6f7696cde31d0998dbf7a895fc034213f8a096a0ee706f`

Operator declaration: HOPE-23 accepted after physical testing.

After this gate, remain on HOLD. Do not start any subsequent gate without a new explicit operator order.


Promotion:
- merged PR: `#19`
- main commit: `8aa50611bcaf1a0091de6b111de0c6b7e4a67646`
