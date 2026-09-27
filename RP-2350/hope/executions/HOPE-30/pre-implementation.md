# HOPE-30 — pre-implementation

Status: **ACTIVE / IMPLEMENTATION IN PROGRESS**.

- accepted base: `remappingbridge/remappingbridge@07abebc67d202ad67c52f325d6153b9ed0d90ab6`
- implementation branch: `hope/hope-30-help-remove-this`

## Scope

Implement only Mouse UI v1 `help-remove-this`, the final gate of the current HOPE series.

Canonical screen:

```text
REMOVE MOUSE HELP
COMPLETELY REMOVE THE
AUTOMATIC CONNECTION
WHEN TURNING ON THE
DEVICE AND DELETE ITS
BUTTON REMAPPING
PROFILE.

ANY KEY: BACK
```

Required behavior:

- `KEY X` from `remove-this` opens `help-remove-this` before removal starts;
- every complete HAT interaction returns to the same `remove-this`;
- `KEY Y` acts as `ANY KEY: BACK` on Help and never locks;
- the pinned `remove_target_bond` from HOPE-05 survives the Help round-trip;
- reconnect/order changes while Help is visible must not change the Mouse targeted by the confirmation screen;
- Help is not entered after a physical removal has already started;
- no HOPE-23/HOPE-31 work is started here; those gates were explicitly deferred to a new feature/series.

## Acceptance rule

This is the final gate of the current HOPE series. Do not promote before the operator physically tests and accepts the exact candidate UF2.
