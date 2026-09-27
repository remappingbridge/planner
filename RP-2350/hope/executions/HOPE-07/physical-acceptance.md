# HOPE-07 — physical acceptance

Status: **ACCEPTED — OPERATOR PHYSICAL PASS**.

Candidate:

- branch: `hope/hope-07-retry-pair-new`
- commit: `1f7c7d7b35faffad55bb52dab0155ba95f626174`
- draft PR: `#10`
- UF2: `HOPE-07-retry-pair-new-new-title-pico2w.uf2`
- size: **891,392 bytes**
- SHA-256: `095eece4b490274f3ae9f697bdee2e9b80461bf32897deffdb870656cb7fdb2e`

## Required physical scenarios

1. Keep a current saved Mouse connected and usable.
2. Enter accepted `PAIR NEW MOUSE` active search.
3. Let the full 15-second window expire without a new unsaved Mouse.
4. Exact retry screen must appear:
   `NEW MOUSE NOT FOUND / NO NEW MOUSE OUTSIDE / THE LIST OF SAVED / DEVICES WAS FOUND`.
5. Confirm the active searching copy `TRYING TO CONNECT / A NEW MOUSE THAT ...` is no longer shown after timeout.
6. Verify black body and dark-magenta hint region beginning at `KEY A: RETRY NEW PAIR`.
7. Current Mouse must remain connected and usable.
8. Press A. Active `PAIR NEW MOUSE / TRYING TO CONNECT ...` must appear and a fresh 15-second Pair New operation must start.
9. Let that new attempt expire; retry screen must appear again.
10. Start Pair New, open `PAIR NEW DEVICE HELP` with X, then exit Help with any key. It must land directly on canonical retry screen.
11. On retry with current Mouse live, press B. Current HOME resolver placeholder must be reached and Mouse remains usable.
12. Repeat with current Mouse unplugged but still saved; B must enter `SEARCHING SAVED MOUSE` and start accepted saved-only search.
13. Press/release X on retry. HOPE-27 Help must not appear yet; retry screen remains.
14. Press/release Y on retry. Presentation must lock/off.
15. Unlock with one complete HAT interaction. It must be consumed and HOME must resolve normally.
16. Confirm a successful Pair New still performs the accepted HOPE-06 handoff.
17. Confirm no Keyboard/Composite Pair New behavior was introduced.

## Operator result

Operator declaration: **PASS / GATE ACCEPTED**.

Declaration received from the operator on 2026-09-23: `gate aceito`.

Final candidate `1f7c7d7b35faffad55bb52dab0155ba95f626174`, including the approved title `NEW MOUSE NOT FOUND`, is the physically accepted HOPE-07 implementation.


## Promotion

- final title-improved PR #10 candidate physically accepted and promoted.
- accepted main SHA: `a4ce8cc7d3be425152bfb825c9b282d8ee510bd8`
- next eligible gate: **HOPE-27 — help-retry-pair-new**.
