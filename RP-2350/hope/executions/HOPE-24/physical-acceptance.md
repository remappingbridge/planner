# HOPE-24 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-24-home-searching-help`
- commit: `81d76a862b2d6e6e3dc55abe055a7e0fb3d1a58a`
- draft PR: `#5`
- UF2: `HOPE-24-home-searching-help-pico2w.uf2`
- size: 882,688 bytes
- SHA-256: `984d9615d0abb7dabbe77851a8fb86fd30843f782c9c7b8eeee58f560f5daddc`

## Required physical scenarios

1. Enter accepted `SEARCHING SAVED MOUSE` with at least one saved Mouse offline.
2. While saved search is active, press/release `KEY X`.
3. Exact `HOME SEARCHING HELP` must appear.
4. Confirm the full literal text and exact layout.
5. Confirm explanatory body is black and `ANY KEY: BACK` field is dark magenta.
6. Confirm opening Help cancels the active saved-only search.
7. Keep an unsaved Mouse discoverable while Help is open; it must not be accepted.
8. Press/release `KEY Y`: it must act only as Any Key Back; display must not lock or turn off.
9. Repeat Help and use another HAT control; the complete interaction must exit and be consumed.
10. After Help exit, the current incremental implementation must land on the inherited retry placeholder, not restart `SEARCHING SAVED MOUSE` automatically.
11. Confirm the saved Mouse/bond remains intact.
12. Return to HOME/search flow through an existing route and confirm accepted HOPE-08 can start a fresh saved-only search.
13. Confirm HOPE-01 `searching-first` and HOPE-02 `first-mouse-connected` are unchanged.
14. Confirm Mouse forwarding, buttons, scroll/extra buttons, remap and persistence regressions remain functional.
15. Confirm no Bluetooth Keyboard/Composite pairing was introduced.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Candidate `81d76a862b2d6e6e3dc55abe055a7e0fb3d1a58a` is the physically accepted HOPE-24 implementation.


## Promotion

- PR #5 promoted after operator acceptance.
- accepted main SHA: `aa6abb2294248aa8eabc4918eae1bdcfef26a959`
- next eligible gate: **HOPE-09 — home-retry**.
