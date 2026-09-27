# HOPE-23 — remove learn-the-keys candidate

Status: **IMPLEMENTED / AUTOMATED PASS / PHYSICAL ACCEPTANCE PENDING**.

- accepted base: `25670c9692aaaf709912e2d6bb87c27c10b25b4e`
- branch: `hope/hope-23-remove-learn-the-keys`
- draft PR: `#19`
- candidate head: `0c12061f010bbd5416808643d843d64f9bf89b73`

## Replaced gate behavior

The previously planned user-facing `learn-the-keys` implementation is cancelled.

Implemented instead:

- `home-connected` no longer displays or navigates to `LEARN THE KEYS`;
- `home-connected` has exactly 3 selectable routes: remapping options, saved devices, Pair New Mouse;
- `home-searching` no longer displays or navigates to `LEARN THE KEYS`;
- `home-searching` has exactly 2 selectable routes: saved devices, Pair New Mouse;
- `home-retry` no longer displays or navigates to `LEARN THE KEYS`;
- `home-retry` has exactly 2 selectable routes: saved devices, Pair New Mouse;
- selection wrapping/counts were reduced so no empty HOME option can be selected;
- contextual HOME Help selection restoration now clamps to the new 3-option connected HOME;
- all manual HOME destination arrays no longer contain the legacy searching-first enum;
- automatic `SEARCHING FIRST MOUSE` is preserved when there is no saved Mouse. The internal legacy symbol `BLU2USB_SCREEN_LEARN_KEYS` still names that accepted automatic bootstrap screen only; it is not exposed as a HOME option.

## Automated evidence

- GitHub Actions CI: `#96` / run `36271915605`
- host/architecture: **PASS**
- host suite: **43/43 PASS**
- Pico 2 W production: **PASS**
- UF2: `HOPE-23-remove-learn-home-0c12061-pico2w.uf2`
- size: **912,384 bytes**
- SHA-256: `22e6ff36fcca0ae2cd6f7696cde31d0998dbf7a895fc034213f8a096a0ee706f`

No HOPE-31 or other gate work is included. Execution returns to HOLD after this gate.
