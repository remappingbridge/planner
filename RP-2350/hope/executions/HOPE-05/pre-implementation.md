# HOPE-05 — pre-implementation

Status: **ACTIVE / IMPLEMENTATION IN PROGRESS**.

- accepted base: `remappingbridge/remappingbridge@a459316fd2c9eefb9fc85e6656cd96134f22d0a0`
- implementation branch: `hope/hope-05-remove-this`
- draft PR: `#17`

## Scope

Implement only Mouse UI v1 `remove-this` on top of the accepted HOPE-04 saved-device identity model.

Canonical screen:

```text
REMOVE THIS MOUSE
<SELECTED MOUSE NAME>

PAIRING AND MAPPINGS
WILL BE DELETED

KEY A: REMOVE
KEY B: CANCEL
KEY X: HELP
```

Required behavior:

- `JOY PRESS` on the current `saved-devices` page opens `remove-this` without changing the selected saved page;
- target name follows the same canonical Mouse-name formatting used by HOME/saved-devices;
- `KEY B` cancels back to the same Saved Devices page before physical removal starts;
- `KEY A` issues exactly one removal for the selected logical saved Mouse and remains on the confirmation page until the BTstack-side removal succeeds;
- if the target is connected, held HID output is released and the Mouse is disconnected before its saved identity is deleted;
- removal deletes all equivalent Bluetooth bond entries for the selected BLE identity/IRK and deletes its persisted saved-name association;
- removal of a disconnected Mouse must not disconnect a different current Mouse;
- after success, if saved Mice remain, return to a valid `saved-devices` page;
- if the last saved Mouse was removed, enter `searching-first` and resume first-Mouse search;
- repeated `KEY A` while the removal is pending must not enqueue a second deletion;
- `KEY X: HELP` is visible because it belongs to the canonical screen, but Help navigation is **not implemented in HOPE-05**. It belongs to HOPE-30.

## Architecture note

The current remapping implementation stores one global remapping configuration rather than per-Mouse mapping records. HOPE-05 therefore removes the selected Mouse's product association (saved identity/name) and matching Bluetooth credential relationship without deleting the global remapping configuration used by other saved Mice.

## Acceptance rule

Do not promote before the operator physically tests and accepts the exact candidate UF2.
