# HOPE-26 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement Mouse UI v1 `help-pair-new` as the contextual Help screen for accepted HOPE-06 `pair-new`.

## Dependency

Accepted gates: HOPE-00, HOPE-01, HOPE-02, HOPE-08, HOPE-24, HOPE-09, HOPE-25, HOPE-06.

Accepted product base:

- repository: `remappingbridge/remappingbridge`
- base: `main@90e6e1884aa109cdf1dfd48c5e5762226d0e29ba`
- branch: `hope/hope-26-help-pair-new`

## Canonical screen

~~~text
PAIR NEW DEVICE HELP
TO CONNECT A SAVED
DEVICE FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
~~~

## Observable behavior

- opened by `KEY X` from accepted `PAIR NEW MOUSE`;
- entering Help cancels the active Pair New operation;
- body background black;
- `ANY KEY: BACK` hint field dark magenta;
- title magenta;
- explanatory body yellow/static;
- Help owns every HAT control, including `KEY Y`; no control locks presentation while Help is visible;
- one complete HAT interaction leaves Help and is consumed;
- the final Mouse UI v1 navigation model resolves this canceled Pair New flow to `retry-pair-new`;
- HOPE-07 is the immediately following gate and owns that canonical screen;
- therefore HOPE-26 returns temporarily to the existing `PAIR NEW MOUSE` visual as the retry placeholder, **without restarting the 15-second Pair New search**;
- HOPE-07 must replace that placeholder on the next accepted gate.

This reconciles the literal screen-reference wording (`ANY KEY: BACK`) with the frozen navigation test, which expects Help entry to cancel Pair New and return into the retry state.

## Replacement rule

No legacy Pair Mouse Help layout may reappear.

A dedicated `BLU2USB_SCREEN_HELP_PAIR_NEW` state is added for this canonical contextual Help only.

## Minimal implementation

Expected changes:

- add `BLU2USB_SCREEN_HELP_PAIR_NEW`;
- add exact 9-row Mouse UI v1 template;
- include it in Help semantics so `KEY Y` never locks there;
- route `KEY X` from `PAIR NEW MOUSE` to this Help;
- entering Help relies on the accepted HOPE-06 app transition hook to cancel Pair New;
- Any Key returns to `BLU2USB_SCREEN_PAIR_MOUSE` as the temporary HOPE-07 retry placeholder;
- app must **not** request Pair New when that return transition originated from `HELP_PAIR_NEW`;
- no BLE Pair New runtime implementation changes are expected.

## Out of scope

- canonical `retry-pair-new` presentation/actions (HOPE-07);
- `help-retry-pair-new` (HOPE-27);
- changing accepted Pair New pairing/handoff behavior;
- Saved Devices;
- home-connected;
- architecture/contracts/Core changes.

## Automated verification

Tests must prove:

1. exact 9-row literal;
2. hint starts at row 8;
3. black body and dark-magenta hint;
4. KEY X from Pair New opens Help;
5. Help has zero options;
6. every HAT control exits Help and is consumed;
7. KEY Y does not lock;
8. saved/current state is preserved;
9. Help return lands on Pair New placeholder;
10. Help return does not request/restart Pair New;
11. entering Help causes the accepted HOPE-06 cancel hook to run;
12. inherited G02–G06 and accepted HOPE regressions remain green.

## Physical acceptance

1. with current Mouse connected, enter accepted `PAIR NEW MOUSE`;
2. while its 15-second search is active, press/release X;
3. exact `PAIR NEW DEVICE HELP` must appear;
4. verify exact text, black body and dark-magenta `ANY KEY: BACK` field;
5. verify entering Help cancels Pair New;
6. keep a new unsaved Mouse advertising while Help is visible: it must not pair;
7. press/release Y: it must act only as Any Key Back and must not lock/backlight-off;
8. repeat Help and exit with another HAT control; the interaction must be consumed;
9. after Help exit, current incremental HOPE-26 must show the Pair New visual as the temporary retry placeholder, but no new 15-second search may start;
10. a new Mouse advertising after Help return must not pair unless Pair New is explicitly started again through a valid route/retry action available after HOPE-07;
11. current Mouse must remain connected/usable throughout;
12. accepted HOPE-06 Pair New behavior must remain functional when Pair New is explicitly started normally;
13. no Keyboard/Composite behavior may be introduced.

## Risks

- Help return accidentally restarts Pair New because screen becomes Pair New again;
- KEY Y global lock running before Help handling;
- candidate completion racing with Help cancellation;
- introducing HOPE-07 visual early.
