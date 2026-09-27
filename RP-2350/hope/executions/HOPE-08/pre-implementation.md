# HOPE-08 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement Mouse UI v1 `home-searching` as the HOME-family state used whenever at least one Mouse is already saved/bonded and no Mouse is currently connected.

## Dependency

- HOPE-00: ACCEPTED
- HOPE-01: ACCEPTED
- HOPE-02: ACCEPTED
- accepted destination base: `remappingbridge/remappingbridge@d13f905fc2a817f464f3683edd4bf689247c30ed`
- branch: `hope/hope-08-home-searching`

## Pinned provenance

- BLU2USB G06: `7eee024ad4ee726c5a85ffa2f32b9f47187878af`
- Mouse UI Layout 1.0: `e8adad7919e931c92515bf655ef4050876a8e7a9`

## Canonical screen

~~~text
SEARCHING SAVED MOUSE
 SAVED DEVICES
 PAIR NEW MOUSE
 LEARN THE KEYS

KEY B: CANCEL SEARCH
JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP
~~~

## Replacement / state rule

`home-searching` is a distinct state of the HOME family, not a parallel legacy/new duplicate.

- when no Mouse is saved, the accepted HOPE-01 `searching-first` remains authoritative;
- when at least one Mouse is saved and none is live, HOME resolves to `home-searching`;
- when a saved Mouse becomes ready, the current gate temporarily resolves to inherited G06 HOME because canonical `home-connected` belongs to HOPE-03;
- when the 8-second saved search is cancelled or expires, the current gate temporarily resolves to inherited G06 HOME because canonical `home-retry` belongs to HOPE-09.

Those inherited HOME uses are different future HOME states, not fallbacks for `home-searching` itself. The `home-searching` layout must never fall back to old HOME while saved search is active.

## Saved-device source

Until HOPE-04 introduces canonical `saved-devices`, the existing persistent BTstack LE bond database remains the minimal source of truth for “at least one Mouse saved”.

The G06 stack already performs a whitelist/bonded reconnect with an 8-second timer. HOPE-08 reuses that mechanism and makes it explicit/observable as saved-only HOME search.

## BLE search behavior

- saved search duration: exactly the existing G06 8-second bonded reconnect window;
- only already-bonded peers are eligible during this window;
- expiry must not silently fall through to general unsaved scanning;
- cancellation by HOME action/lock must stop the saved search;
- entering/re-entering `home-searching` must be able to request a new saved-only search;
- READY saved Mouse ends saved search and returns the HOME family to the connected placeholder state.

## Controls

- 3 selectable rows: SAVED DEVICES, PAIR NEW MOUSE, LEARN THE KEYS;
- Joy Up/Down wraps selection;
- Joy Press accesses the selected destination using existing product screens until those later gates replace them;
- Key B cancels saved search and leaves `home-searching` to the temporary inherited HOME placeholder for future `home-retry`;
- Key X visually responds but its canonical help destination belongs to HOPE-24 and is not introduced early;
- global Key Y lock remains active because a saved Mouse exists, even though it is not printed on this HOME screen; locking cancels current saved search and unlock HOME-resolution restarts it when still offline.

Temporary destinations before their gates:

- SAVED DEVICES -> existing G06 saved-devices implementation;
- PAIR NEW MOUSE -> existing G06 pair-mouse implementation;
- LEARN THE KEYS -> current didactic implementation slot until HOPE-23 replaces it canonically.

## Minimal implementation

Expected product changes:

- add `BLU2USB_SCREEN_HOME_SEARCHING` as the explicit HOME-family state;
- add exact Mouse UI v1 template and selection behavior;
- resolve HOME entries to `home-searching` when saved count > 0 and no live Mouse;
- synchronize UX saved count from the persistent LE bond DB;
- add BLE runtime events for saved-search started/timeout;
- prevent bonded-search timeout from falling through to general unsaved scan;
- add safe request/cancel hooks for saved-only reconnect without introducing a new architecture layer;
- update runtime transitions on connect/disconnect/lock/unlock.

## Out of scope

- `home-searching-help` (HOPE-24);
- `home-retry` (HOPE-09);
- `home-connected` (HOPE-03);
- canonical Pair New behavior (HOPE-06);
- canonical Saved Devices behavior (HOPE-04);
- canonical Learn the Keys (HOPE-23);
- new UI/Core architecture or contracts.

## Automated verification

Tests must prove:

1. exact 9-row `home-searching` template;
2. black body + dark-magenta hint field beginning at row 5;
3. 3-row selection and wrap behavior;
4. B leaves this state without deleting saved state;
5. Y locks when a saved Mouse exists;
6. unlock HOME-resolution returns to `home-searching` when still offline;
7. HOME-resolution chooses accepted `searching-first` when saved count is zero;
8. HOME-resolution keeps inherited connected HOME placeholder when a Mouse is live;
9. BLE decoder exposes saved-search started/timeout events;
10. legacy G02–G06 + HOPE-01/02 regressions remain green.

## Physical acceptance

1. boot with an already bonded Mouse powered off -> exact `SEARCHING SAVED MOUSE`, not `SEARCHING FIRST MOUSE` and not old HOME;
2. verify exact layout, colors, hint region and selection;
3. power the bonded Mouse during the 8-second window -> reconnect and leave searching state to current connected HOME placeholder;
4. repeat with Mouse kept off for the full window -> search must stop after 8 seconds and must not pair an unsaved nearby Mouse;
5. press B during search -> cancel immediately and leave searching state; saved bond remains intact;
6. re-enter HOME while still offline -> `home-searching` starts saved search again;
7. verify Y lock cancels the saved search; unlock interaction is consumed and HOME resolves back to `home-searching` while still offline;
8. verify selectable rows wrap Up/Down and press routes to existing temporary destinations;
9. confirm accepted `searching-first` and `first-mouse-connected` still behave correctly for first pairing;
10. verify movement/buttons/remap/persistence regressions;
11. no Bluetooth Keyboard/Composite pairing added.

## Risks

- continuing general BLE scan after saved-search timeout;
- rendering old HOME during an active saved search;
- restarting the 8-second timer on every UI redraw/selection;
- allowing the unlock control release to leak into HOME navigation;
- confusing future `home-retry`/`home-connected` placeholders with `home-searching` itself.
