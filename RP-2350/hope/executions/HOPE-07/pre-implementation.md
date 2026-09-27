# HOPE-07 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement Mouse UI v1 `retry-pair-new` and replace the temporary stopped `PAIR NEW MOUSE` placeholder used after Pair New timeout or Pair New Help cancellation.

## Dependency

Accepted gates: HOPE-00, HOPE-01, HOPE-02, HOPE-08, HOPE-24, HOPE-09, HOPE-25, HOPE-06, HOPE-26.

Accepted product base:

- repository: `remappingbridge/remappingbridge`
- base: `main@4a1451e5ce25573734fc6179c45867588b76bbb0`
- branch: `hope/hope-07-retry-pair-new`

## Canonical screen

~~~text
PAIR NEW MOUSE
NO NEW MOUSE OUTSIDE
THE LIST OF SAVED
DEVICES WAS FOUND

KEY A: RETRY NEW PAIR
KEY B: BACK TRY SAVED
KEY X: HELP
KEY Y: LOCK
~~~

## Observable behavior

- shown after the accepted 15-second Pair New window expires without a new candidate;
- also becomes the owner/return target when accepted `help-pair-new` cancels Pair New;
- if the original Mouse stayed connected, it remains current and usable;
- KEY A starts a fresh 15-second Pair New operation and enters canonical `PAIR NEW MOUSE`;
- KEY B leaves through the HOME resolver:
  - live Mouse -> current connected HOME placeholder until HOPE-03;
  - no live Mouse but saved Mouse -> `home-searching`, immediately starting accepted saved-only 8-second search;
  - no saved Mouse -> accepted searching-first resolver;
- KEY X is visible but its canonical `help-retry-pair-new` destination belongs to HOPE-27 and must not be introduced early;
- KEY Y locks presentation. There is no active Pair New search while retry is visible.

## Flow integration

- `PAIR_NEW_TIMEOUT` -> `retry-pair-new`;
- `help-pair-new` Any Key -> `retry-pair-new`;
- KEY A from retry -> `pair-new` and the existing HOPE-06 app transition starts a new 15-second candidate search;
- KEY B -> HOME resolver;
- successful Pair New remains unchanged and resolves through current HOME behavior.

## Replacement rule

The temporary post-timeout/post-help Pair New placeholder disappears from these retry points.

The canonical active Pair New screen remains only while an actual 15-second Pair New operation is running.

## Rendering

- exact 9-row literal;
- black body;
- dark-magenta hint field beginning at row 5;
- title magenta;
- explanatory body static/yellow;
- action hints light gray with normal held feedback.

## Minimal implementation

Expected changes:

- add `BLU2USB_SCREEN_RETRY_PAIR_NEW`;
- add exact canonical template;
- route Pair New timeout event to retry screen;
- make `help-pair-new` return target retry screen;
- KEY A transitions retry -> Pair New;
- KEY B transitions through HOME resolver;
- KEY X remains inert until HOPE-27;
- no BLE Pair New implementation change.

## Automated verification

Tests must prove:

1. exact 9-row literal;
2. hint begins at row 5;
3. black body / dark-magenta hints;
4. Pair New timeout targets retry;
5. Pair New Help returns to retry;
6. KEY A transitions to Pair New;
7. retry -> Pair New triggers the existing app request hook;
8. KEY B uses HOME resolver with live, saved-offline, and no-saved cases;
9. KEY X does not introduce HOPE-27;
10. KEY Y locks;
11. no Pair New search starts merely by entering retry;
12. old stopped Pair New placeholder is absent from timeout/help-return points;
13. accepted HOPE-06/26 and inherited regressions remain green.

## Physical acceptance

1. With current Mouse connected, enter Pair New and allow the full 15 seconds to expire.
2. Exact `PAIR NEW MOUSE / NO NEW MOUSE OUTSIDE ...` retry screen must appear.
3. Confirm the active Pair New searching text is no longer used after timeout.
4. Verify exact layout: black body and dark-magenta hint region starting at KEY A.
5. Current Mouse must remain connected and usable.
6. Press A; canonical active `PAIR NEW MOUSE / TRYING TO CONNECT ...` must appear and a fresh 15-second Pair New operation must start.
7. Let the fresh attempt expire; retry screen must appear again.
8. From active Pair New, open Help and exit with Any Key; it must now land on canonical retry screen, not the active Pair New searching screen.
9. On retry with live Mouse, press B; HOME resolver must preserve the live Mouse.
10. Repeat with current Mouse unplugged but saved; B must resolve to `home-searching` and start saved-only search.
11. Press/release X on retry; HOPE-27 Help must not appear yet.
12. Press/release Y on retry; presentation must lock. Unlock interaction must be consumed and normal HOME resolution must occur.
13. Confirm accepted HOPE-06 Pair New pairing/handoff still works.
14. Confirm no Keyboard/Composite behavior was introduced.

## Risks

- KEY A changes screen but fails to trigger Pair New request;
- Help return still lands on active Pair New;
- timeout event leaves the active Pair New visual;
- B bypasses HOME resolver;
- X introduces HOPE-27 early;
- lock/unlock unexpectedly restarts Pair New.
