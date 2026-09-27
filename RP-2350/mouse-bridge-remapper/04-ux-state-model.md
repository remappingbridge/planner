# UX state model and layout planning

Status: **FROZEN BY MBR-00**.

Canonical literal/control authority is `tiagooliveirajs/mouse-bridge-remapper/docs/manual/06-screen-reference.md`. This document freezes state/transition semantics for implementation.

## 1. Global interaction

- actions execute on release;
- visible held control feedback is white;
- selected/current cyan becomes white while selected, then returns cyan;
- Help owns every HAT input and `ANY KEY: BACK` consumes it;
- no hidden controls are inherited from historical BLU2USB;
- lock is presentation-only;
- UI reacts to semantic async state events;
- screen code emits semantic commands and never calls Bluetooth/storage/USB primitives.

## 2. HOME resolver

```text
registry empty
  -> searching-first + repeated FIRST_MOUSE cycles

saved mice + authoritative Mouse
  -> home-connected

saved mice + no authoritative Mouse
  -> home-searching + 8s SEARCH_SAVED

SEARCH_SAVED expiry/cancel
  -> home-retry / DEVICE NOT FOUND
```

If disconnect occurs while HOME is visible, resolve immediately. If another page owns presentation, update connection state and resolve on next HOME access.

## 3. No-saved onboarding

### `searching-first`

- root only when registry empty;
- FIRST_MOUSE uses repeated 8-second cycles until success;
- all HAT labels are didactic visual feedback only;
- no hidden Lock/Cancel/navigation.

### `first-mouse-connected`

- appears only after first Mouse is authenticated/classified/persisted/ready;
- joystick + Key A didactic;
- Key B Lock;
- Key X Unlock only while this page is locked and consumes event;
- Key Y HOME.

## 4. Saved HOME

### `home-searching`

Preconditions: saved records, no authoritative Mouse. Entry starts 8-second SEARCH_SAVED.

- B cancels search -> `home-retry`;
- X -> help;
- option access works while search is active.

### `home-retry`

- A -> new SEARCH_SAVED + `home-searching`;
- options remain available;
- X -> help.

## 5. Pair New

### `pair-new`

PAIR_NEW = 15 seconds, unsaved BLE HOGP only.

A healthy current authoritative Mouse remains live/usable while search runs. Saved candidates are ignored for Pair New acceptance.

First unsaved candidate fully qualified becomes non-authoritative replacement-ready. Handoff then release-cleans/disconnects old Mouse, preserves its saved record/bond, confirms new state, and promotes new Mouse. Never two authoritative mice.

Timeout/cancel before handoff leaves current Mouse live.

Controls:

- B -> cancel Pair New -> HOME resolver;
- X -> `help-pair-new`;
- Y -> Lock.

### `help-pair-new`

Exact frozen literal block:

```text
PAIR NEW DEVICE HELP
TO CONNECT A SAVED
DEVICE, FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
```

Any key -> `pair-new`, consumed.

### `retry-pair-new`

Shown after Pair New expiry.

- A -> new 15-second Pair New;
- B -> HOME resolver (`home-connected` if current Mouse remains; `home-searching` if user unplugged it);
- X -> `help-retry-pair-new`;
- Y -> Lock.

### `help-retry-pair-new`

```text
DEVICE NOT FOUND HELP
TO CONNECT A SAVED
DEVICE, FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
```

Any key -> `retry-pair-new`, consumed.

If the user manually unplugs current Mouse while Pair New/help/retry is visible, connection truth changes immediately but navigation is not forcibly stolen; Pair New stays new-only until canceled/expired/retried. HOME later starts saved search.

## 6. Connected HOME / remapper

`home-connected` requires exactly one authoritative Mouse. Its projected name is the dynamic title. Its four visible options are:

1. `PAIR NEW MOUSE` -> `pair-new`;
2. current confirmed remap summary -> `remapper-options`;
3. `SAVED DEVICES`;
4. `LEARN THE KEYS`.

Selecting Pair New is the normal visible connected-Mouse entry into the existing 15-second new-only replacement transaction. The current Mouse remains authoritative/usable until handoff.

Canonical profile vocabulary:

- PASSTHROUGH
- STANDARD
- ESCAPE
- CUSTOM

`STANDARD REMAP` is the menu label. Historical `DEFAULT REMAP` is not canonical UI text.

Profile Apply success is shown only after runtime+persistence confirmation.

`escape-active` deliberately keeps `JOY LEFT: GO TO HOME`, which invokes HOME resolver directly.

No hidden lock controls exist on screens where Lock is not printed.

## 7. Custom

Source editors update/persist draft and immediately reproject `custom-edit`. Full `APPLY CUSTOM` requires runtime+persistent confirmation.

Global Custom template remains shared across saved Custom-profile mice.

## 8. Saved Devices

One saved Mouse per page.

- authoritative Mouse: cyan name + `STATUS: CONNECTED`;
- all others: normal name + `STATUS: DISCONNECTED`;
- profile text: PASSTHROUGH/STANDARD/ESCAPE/CUSTOM;
- name display first 21 supported characters; fallback `UNKNOWN MOUSE`.

Removal is transactional; live target is release-cleaned/disconnected before commit. Last saved removal -> `searching-first`; otherwise return valid Saved Devices page.

## 9. Learn

`learn-the-keys` is never boot root.

- joystick + Key A didactic;
- B Lock;
- X Unlock while this page is locked;
- Y HOME resolver.

## 10. Frozen didactic columns

1-based:

- JOY UP 8
- JOY row 3/10/17
- LEFT/PRESS/RIGHT 3/9/16
- JOY DOWN 7
- searching-first KEY A/X 2/16
- searching-first KEY B/Y 2/16
- instructional KEY A/B/X 16
- LOCK SCREEN 1
- AND UNLOCK 2
- OPEN HOME -> KEY Y 3

## 11. Async events

At minimum:

```text
MouseReady(mouse_id, session_id)
MouseDisconnected(mouse_id, session_id, reason)
SavedSearchExpired(transaction_id)
PairNewCandidateReady(transaction_id, session_id)
PairNewExpired(transaction_id)
ProfileApplyConfirmed(mouse_id, profile)
ProfileApplyFailed(mouse_id, reason)
RemoveConfirmed(mouse_id)
RemoveFailed(mouse_id, reason)
PersistenceRecovered(generation)
```

Stale transaction/session completions are ignored by ID/generation.

## 12. Golden-test obligation

mbr-02 must assert exact rows, control maps, transitions, dynamic fields, token columns, color priority, Pair New handoff state projections, long-name policy, and absence of Keyboard/Composite/multi-connected states.


## 13. Home searching Help layout amendment

The current literal for `home-searching-help` is the 2026-09-20 product amendment:

```text
HOME SEARCHING HELP
THE MATCHING ATTEMPT
TOOK PLACE ONLY FOR
DEVICES ALREADY SAVED
IN THE PREFERENCES,
BUT NOT FOR DEVICES
THAT WERE NOT SAVED.

ANY KEY: BACK
```

This changes only the rendered wording. The page remains Help-owned, any HAT input returns to `home-searching` and is consumed, and the underlying `SEARCH_SAVED` transaction remains an automatic 8-second saved-device search.
