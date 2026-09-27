# HOPE-27 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement Mouse UI v1 `help-retry-pair-new` as the contextual Help screen for accepted HOPE-07 `retry-pair-new`.

## Dependency

Accepted gates: HOPE-00, HOPE-01, HOPE-02, HOPE-08, HOPE-24, HOPE-09, HOPE-25, HOPE-06, HOPE-26, HOPE-07.

Accepted product base:

- repository: `remappingbridge/remappingbridge`
- base: `main@a4ce8cc7d3be425152bfb825c9b282d8ee510bd8`
- branch: `hope/hope-27-help-retry-pair-new`

## Canonical screen

~~~text
DEVICE NOT FOUND HELP
TO CONNECT A SAVED
DEVICE FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
~~~

## Observable behavior

- opened by `KEY X` from accepted `NEW MOUSE NOT FOUND` retry screen;
- retry screen has no active Pair New search, so entering Help starts/cancels no BLE operation;
- one complete HAT interaction returns to `retry-pair-new` and is consumed;
- KEY Y is owned by Help and must not lock/backlight-off;
- current/saved Mouse state remains unchanged;
- returning from Help must not start Pair New;
- KEY A on the retry screen remains the only action that starts a fresh 15-second Pair New operation.

## Rendering

- exact 9-row literal;
- rows 0–7 are body region on black background;
- title magenta;
- explanatory body yellow/static;
- only row 8 `ANY KEY: BACK` is the hint region on dark-magenta background;
- the explanatory line `KEY B TO BACK UNTIL` must **not** be mistaken for a hint merely because it begins with `KEY`.

The renderer must explicitly force `hint_start_row = 8` for this screen, matching the accepted HOPE-26 layout correction pattern.

## Minimal implementation

- add `BLU2USB_SCREEN_HELP_RETRY_PAIR_NEW`;
- add exact canonical template;
- include it in Help semantics;
- route KEY X from `retry-pair-new` to this Help;
- set return target to `retry-pair-new`;
- reuse generic Help Any-Key return behavior;
- extend renderer special-case so only the last row is a hint;
- no BLE or app search lifecycle changes expected.

## Out of scope

- home-connected (HOPE-03);
- Pair New runtime changes;
- Saved Devices;
- remapper screens;
- architecture/contracts/Core changes.

## Automated verification

Tests must prove:

1. exact 9-row literal;
2. hint starts only at row 8;
3. `KEY B TO BACK UNTIL` and `SEARCHING APPEARS.` remain black-body text;
4. KEY X from retry opens Help;
5. Help has zero options;
6. every HAT control returns to retry and is consumed;
7. KEY Y does not lock;
8. returning from Help does not enter active Pair New;
9. no Pair New request is caused by Help entry/exit;
10. accepted HOPE-07 behavior remains intact;
11. inherited regressions remain green.

## Physical acceptance

1. Reach accepted `NEW MOUSE NOT FOUND`.
2. Press/release KEY X.
3. Exact `DEVICE NOT FOUND HELP` screen must appear.
4. Verify rows through `SEARCHING APPEARS.` remain on black background.
5. Specifically verify `KEY B TO BACK UNTIL` is **not** treated as a hint.
6. Verify only `ANY KEY: BACK` has dark-magenta hint background.
7. Press/release KEY Y: it must act only as Any Key Back and must not lock/off.
8. Re-enter Help and exit using another HAT control; interaction must be consumed.
9. Return must land on accepted `NEW MOUSE NOT FOUND`.
10. No Pair New search may start on Help entry or exit.
11. Press A from retry afterward and confirm that only then a fresh Pair New operation starts.
12. Current Mouse/saved state remains intact.
13. No Keyboard/Composite behavior is introduced.

## Risks

- generic hint detection misclassifies `KEY B TO BACK UNTIL`;
- global KEY Y lock runs before Help handling;
- Help return accidentally enters active Pair New;
- a screen transition hook accidentally starts Pair New.
