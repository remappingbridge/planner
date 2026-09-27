# HOPE-25 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement Mouse UI v1 `home-retry-help` as the contextual Help screen for accepted HOPE-09 `home-retry`.

## Dependency

- HOPE-00: ACCEPTED
- HOPE-01: ACCEPTED
- HOPE-02: ACCEPTED
- HOPE-08: ACCEPTED
- HOPE-24: ACCEPTED
- HOPE-09: ACCEPTED
- accepted destination base: `remappingbridge/remappingbridge@b883353bb654826d4c960513e72182d2b35b4c6a`
- branch: `hope/hope-25-home-retry-help`

## Pinned provenance

- Mouse UI Layout 1.0: `e8adad7919e931c92515bf655ef4050876a8e7a9`

## Canonical screen

~~~text
HOME RETRY HELP
THE MATCHING ATTEMPT
TOOK PLACE ONLY FOR
DEVICES ALREADY SAVED
IN THE PREFERENCES,
BUT NOT FOR DEVICES
THAT WERE NOT SAVED.

ANY KEY: BACK
~~~

## Observable behavior

- opened by `KEY X` from accepted `home-retry`;
- no saved-only search is running while `home-retry` is visible, so opening this Help must not start or restart search;
- body background black;
- `ANY KEY: BACK` hint field dark magenta;
- title magenta;
- explanatory body yellow/static;
- Help owns every HAT control, including `KEY Y`; no control locks presentation while Help is visible;
- one complete HAT interaction returns to `home-retry` and is consumed;
- returning from Help must preserve the selected retry state semantics and must not transition to `home-searching`;
- saved count/bond state remains intact.

## Replacement rule

No legacy Help screen may be used as a fallback for this point of the flow.

A dedicated `BLU2USB_SCREEN_HOME_RETRY_HELP` state is appropriate because G06 has no canonical equivalent to replace in-place.

## Minimal implementation

Expected product changes:

- add `BLU2USB_SCREEN_HOME_RETRY_HELP`;
- add exact 9-row Mouse UI v1 template;
- include it in Help semantics so global `KEY Y` lock never runs there;
- route `KEY X` from `home-retry` to this Help;
- set return target to `home-retry`;
- reuse existing generic Help Any-Key return behavior;
- make no BLE or search-lifecycle changes.

## Out of scope

- Pair New (HOPE-06);
- `help-pair-new` (HOPE-26);
- changing `home-retry` actions;
- changing the accepted 8-second saved-only search;
- `home-connected` or its Help;
- Saved Devices canonical migration;
- architecture/contracts/Core changes.

## Automated verification

Tests must prove:

1. exact 9-row literal;
2. hint starts on row 8;
3. black explanatory body and dark-magenta hint;
4. KEY X from `home-retry` opens this Help;
5. Help has zero selectable options;
6. every HAT control returns to `home-retry`;
7. KEY Y does not lock;
8. exit interaction is consumed;
9. saved count remains unchanged;
10. returning from Help does not enter `home-searching`;
11. inherited G02–G06 and HOPE-01/02/08/24/09 tests remain green.

## Physical acceptance

1. reach accepted `DEVICE NOT FOUND` with a saved Mouse offline;
2. press/release `KEY X`;
3. exact `HOME RETRY HELP` must appear;
4. verify exact explanatory text, black body, magenta hint field and `ANY KEY: BACK`;
5. confirm no saved search starts merely by entering Help;
6. press/release `KEY Y`: it must act only as Any Key Back and must not lock/backlight-off;
7. repeat Help and use another HAT control: one complete interaction returns to `DEVICE NOT FOUND` and is consumed;
8. after returning, the screen must stay `DEVICE NOT FOUND`; search must not restart automatically;
9. confirm `KEY A` from `DEVICE NOT FOUND` still starts accepted `SEARCHING SAVED MOUSE`;
10. confirm saved bond remains intact;
11. confirm accepted HOPE-01/02/08/24/09 and G06 forwarding/remap/persistence behavior remain intact.

## Risks

- generic Help return accidentally resolving HOME and restarting saved search;
- KEY Y global lock running before Help handling;
- return_screen not set to `home-retry`;
- introducing BLE/search side effects into a pure contextual Help gate.
