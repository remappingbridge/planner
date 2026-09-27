# HOPE-26 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-26-help-pair-new`
- commit: `60c9050095603712baae61dfb12766b1ba46b67f`
- draft PR: `#9`
- UF2: `HOPE-26-help-pair-new-layout-fix-pico2w.uf2`
- size: **890,880 bytes**
- SHA-256: `a8d32a529883dded80e3d169bc22e2a207b434e8a8ac37b7dc8f6875bdc22ccd`

## Required physical scenarios

1. Keep a saved/current Mouse connected and working.
2. Enter accepted `PAIR NEW MOUSE`; confirm normal Pair New starts.
3. While Pair New is active, press/release KEY X.
4. Exact `PAIR NEW DEVICE HELP` must appear.
5. Confirm exact text: rows through `SEARCHING APPEARS.` stay on black body; specifically `KEY B TO BACK UNTIL` must **not** start the hint background. Only `ANY KEY: BACK` uses the dark-magenta hint field.
6. Confirm entering Help cancels the active Pair New operation.
7. While Help is visible, keep an unsaved Mouse advertising/pairable; it must not be accepted.
8. Press/release KEY Y while Help is visible; it must behave only as Any Key Back and must not lock or turn off the display.
9. Re-enter Help and exit using another HAT control; the complete interaction must be consumed.
10. After Help exit, current incremental HOPE-26 must show the Pair New visual as the temporary retry placeholder.
11. Critically, no new 15-second Pair New search may start automatically after that Help return.
12. Keep an unsaved Mouse advertising after Help return; it must not pair automatically.
13. Current Mouse must remain connected/usable through Help entry and exit.
14. Start Pair New again through a normal valid route and confirm accepted HOPE-06 pairing still works.
15. Confirm no Keyboard/Composite behavior was introduced.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Corrected candidate `60c9050095603712baae61dfb12766b1ba46b67f` is the physically accepted HOPE-26 implementation.


## Superseded layout candidate

The original HOPE-26 physical candidate was invalidated by an operator-reported layout bug: the generic renderer mistook `KEY B TO BACK UNTIL` for the start of the hint region.

Use only corrected candidate `60c9050095603712baae61dfb12766b1ba46b67f` and SHA-256 `a8d32a529883dded80e3d169bc22e2a207b434e8a8ac37b7dc8f6875bdc22ccd`.


## Promotion

- corrected PR #9 candidate physically accepted and promoted.
- accepted main SHA: `4a1451e5ce25573734fc6179c45867588b76bbb0`
- next eligible gate: **HOPE-07 — retry-pair-new**.
