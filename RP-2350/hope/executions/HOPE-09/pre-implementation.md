# HOPE-09 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement Mouse UI v1 `home-retry` as the HOME-family state shown after the accepted HOPE-08 saved-only search expires or is canceled.

This gate removes the inherited G06 HOME placeholder previously used temporarily by HOPE-08 and HOPE-24.

## Dependency

- HOPE-00: ACCEPTED
- HOPE-01: ACCEPTED
- HOPE-02: ACCEPTED
- HOPE-08: ACCEPTED
- HOPE-24: ACCEPTED
- accepted destination base: `remappingbridge/remappingbridge@aa6abb2294248aa8eabc4918eae1bdcfef26a959`
- branch: `hope/hope-09-home-retry`

## Pinned provenance

- Mouse UI Layout 1.0: `e8adad7919e931c92515bf655ef4050876a8e7a9`

## Canonical screen

~~~text
DEVICE NOT FOUND
 SAVED DEVICES
 PAIR NEW MOUSE
 LEARN THE KEYS

KEY A: RETRY SEARCH
JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP
~~~

## Flow integration

All previously accepted temporary retry exits must now converge on `home-retry`:

- HOPE-08 saved-search 8-second timeout -> `home-retry`;
- HOPE-08 `KEY B: CANCEL SEARCH` -> `home-retry`;
- HOPE-24 Any Key Back from `home-searching-help` -> `home-retry`.

The old G06 HOME must no longer appear at any of these retry points.

## Controls

- three selectable rows: SAVED DEVICES, PAIR NEW MOUSE, LEARN THE KEYS;
- Joy Up/Down wraps selection;
- Joy Press uses the same current incremental destinations as HOPE-08;
- KEY A starts a fresh saved-only 8-second search and enters `home-searching`;
- KEY B is inert because it is not an action on Mouse UI v1 `home-retry`;
- KEY X remains visible but its canonical `home-retry-help` destination belongs to HOPE-25 and is not introduced early;
- KEY Y remains a global lock action because at least one saved Mouse exists, although it is not printed on this HOME screen;
- unlocking resolves HOME; while saved Mouse remains offline that means `home-searching` and a fresh saved-only search.

## Rendering

- exact 9-row literal;
- black body;
- dark-magenta hint area beginning at row 5;
- selected option white;
- non-selected options light gray;
- title magenta;
- hint controls light gray with normal held feedback.

## Minimal implementation

Expected product changes:

- add `BLU2USB_SCREEN_HOME_RETRY`;
- add exact template and 3-option selection;
- include it in renderer selection highlighting;
- replace HOPE-08 B-cancel placeholder with `home-retry`;
- replace HOPE-08 timeout placeholder with `home-retry`;
- replace HOPE-24 Help return placeholder with `home-retry`;
- KEY A transitions to `home-searching`; the accepted HOPE-08 app transition hook starts the actual saved-only search;
- explicitly keep KEY B inert on `home-retry`.

No BLE search implementation changes are expected.

## Out of scope

- `home-retry-help` (HOPE-25);
- canonical Pair New (HOPE-06);
- canonical Saved Devices (HOPE-04);
- canonical Learn the Keys (HOPE-23);
- canonical `home-connected` (HOPE-03);
- architecture/contracts/Core changes.

## Automated verification

Tests must prove:

1. exact 9-row literal;
2. hint boundary starts at row 5;
3. black body / dark-magenta hints;
4. three-option selection and Up/Down wrap;
5. B is inert;
6. A transitions to `home-searching`;
7. Help return target is `home-retry`;
8. cancel target from `home-searching` is `home-retry`;
9. timeout target in app source is `home-retry`;
10. Y locks and unlock HOME-resolution returns to `home-searching` when saved/offline;
11. Joy Press destinations remain incremental equivalents;
12. inherited G02–G06 and HOPE-01/02/08/24 regressions remain green.

## Physical acceptance

1. with saved Mouse offline, allow `SEARCHING SAVED MOUSE` to expire -> exact `DEVICE NOT FOUND`;
2. repeat and press B during search -> exact `DEVICE NOT FOUND`;
3. open `HOME SEARCHING HELP`, then Any Key Back -> exact `DEVICE NOT FOUND`;
4. old G06 HOME must not appear in any of those three flows;
5. verify exact layout, black body, magenta hints and selection;
6. verify Up/Down wrap among three options;
7. verify B is inert on `DEVICE NOT FOUND`;
8. press A -> immediately enter `SEARCHING SAVED MOUSE` and begin a fresh 8-second saved-only search;
9. let retry expire again -> return to `DEVICE NOT FOUND`;
10. verify Joy Press routes the three options to their current incremental destinations;
11. verify X does not introduce HOPE-25 early;
12. verify Y lock/backlight-off; unlock interaction consumed and HOME resolves to `SEARCHING SAVED MOUSE` while offline;
13. turn bonded Mouse on during a retried saved search -> reconnect remains functional;
14. verify accepted HOPE-01/02/08/24 and G06 forwarding/remap/persistence regressions.

## Risks

- generic KEY B handling accidentally reopening saved search;
- A changing screen without triggering the accepted HOPE-08 search request hook;
- Help return retaining the old placeholder;
- timeout and manual cancel resolving differently;
- accidentally introducing HOPE-25 Help early.
