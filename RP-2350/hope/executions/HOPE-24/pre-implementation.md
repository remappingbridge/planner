# HOPE-24 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement Mouse UI v1 `home-searching-help` as the contextual Help screen for accepted HOPE-08 `home-searching`.

## Dependency

- HOPE-00: ACCEPTED
- HOPE-01: ACCEPTED
- HOPE-02: ACCEPTED
- HOPE-08: ACCEPTED
- accepted destination base: `remappingbridge/remappingbridge@c88ebacdeb8265c9b8bd82882f97d9b8c960493a`
- branch: `hope/hope-24-home-searching-help`

## Pinned provenance

- Mouse UI Layout 1.0: `e8adad7919e931c92515bf655ef4050876a8e7a9`

## Canonical screen

~~~text
HOME SEARCHING HELP
THE MATCHING ATTEMPT
TOOK PLACE ONLY FOR
DEVICES ALREADY SAVED
IN THE PREFERENCES,
BUT NOT FOR DEVICES
THAT WERE NOT SAVED.

ANY KEY: BACK
~~~

## Observable behavior

- opened by `KEY X` from accepted `home-searching`;
- entering Help cancels the active 8-second saved-only search;
- body background black;
- `ANY KEY: BACK` hint field dark magenta;
- title magenta;
- explanatory body yellow/static;
- Help owns every HAT control, including `KEY Y`; no control locks presentation while Help is visible;
- one complete HAT interaction leaves Help and is consumed;
- canonical destination is `home-retry`;
- because HOPE-09 is the next gate and `home-retry` does not exist yet, this gate returns to the existing inherited HOME placeholder that already represents retry after HOPE-08 timeout/cancel;
- leaving Help must not restart the saved-only search.

## Replacement rule

No legacy Help layout may be used as a fallback for this point of the flow.

A dedicated `BLU2USB_SCREEN_HOME_SEARCHING_HELP` state is allowed because G06 has no equivalent canonical Help screen to transform in-place. It is reached only from `home-searching`.

## Minimal implementation

Expected changes:

- add `BLU2USB_SCREEN_HOME_SEARCHING_HELP`;
- add exact 9-row Mouse UI v1 template;
- include it in Help semantics so Y never locks there;
- route `KEY X` from `home-searching` to this Help;
- return any HAT control to the temporary retry placeholder, not back to active `home-searching`;
- rely on the accepted HOPE-08 app transition hook to cancel the active saved search when screen changes away from `home-searching`.

## Out of scope

- canonical `home-retry` layout/action (HOPE-09);
- `home-retry-help` (HOPE-25);
- changing the 8-second search implementation;
- Pair New or Saved Devices canonical migrations;
- architecture/contracts/Core changes.

## Automated verification

Tests must prove:

1. exact 9-row literal;
2. hint starts on row 8;
3. black explanatory body and dark-magenta hint;
4. KEY X from home-searching opens Help;
5. Help receives no selection behavior;
6. every HAT control exits to the retry placeholder;
7. KEY Y in Help does not lock;
8. exit interaction is consumed;
9. saved count remains unchanged;
10. inherited G02–G06 and HOPE-01/02/08 tests remain green.

## Physical acceptance

1. boot/re-enter accepted `SEARCHING SAVED MOUSE` with a saved Mouse offline;
2. while saved search is active, press/release X;
3. exact `HOME SEARCHING HELP` must appear;
4. verify exact explanatory text, black body, magenta hint field and `ANY KEY: BACK`;
5. confirm the active saved search was cancelled when Help opened;
6. while Help is visible, KEY Y must act as Any Key Back and must not lock/backlight-off;
7. test another HAT control: one complete interaction exits Help and is consumed;
8. after exit, current gate lands on the inherited retry placeholder and must not silently restart saved search;
9. returning to HOME/search flow through an existing route may start a fresh saved search as defined by accepted HOPE-08;
10. confirm saved bond remains intact;
11. confirm accepted HOPE-01/02/08 and G06 Mouse forwarding/remap/persistence are not regressed.

## Risks

- generic Help return accidentally restoring `home-searching` and restarting the search;
- global KEY Y handling running before Help handling;
- canceled BLE candidate completing after Help is shown;
- introducing HOPE-09 visual early.
