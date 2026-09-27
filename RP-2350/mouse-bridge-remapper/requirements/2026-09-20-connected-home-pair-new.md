# 2026-09-20 — Connected HOME Pair New entry amendment

Status: **CURRENT PRODUCT DECISION / MBR-02 AMENDMENT**

This requirement supersedes only the former `home-connected` screen layout and connected-HOME navigation rules. All other current Mouse Bridge Remapper rules remain in force.

## 1. Connected HOME title

`home-connected` must present the dynamically projected name of the single authoritative connected Mouse as the screen title.

The full stored normalized name remains subject to the existing 21-character projection rule and `UNKNOWN MOUSE` fallback.

## 2. Connected HOME visible options

The canonical screen is:

```text
LOGITECH LIFT
 PAIR NEW MOUSE
 REMAPPED TO ESCAPE
 SAVED DEVICES
 LEARN THE KEYS

JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP TO REMOVE
```

The four visible options are ordered:

1. `PAIR NEW MOUSE`
2. current confirmed remap summary
3. `SAVED DEVICES`
4. `LEARN THE KEYS`

The remap summary continues to use the canonical values:

- `NO REMAP PASSTHROUGH`
- `REMAPPED TO STANDARD`
- `REMAPPED TO ESCAPE`
- `REMAPPED TO CUSTOM`

The `T0` spelling in the user amendment is normalized to the already-established canonical `TO` spelling.

## 3. Connected HOME -> Pair New

Selecting `PAIR NEW MOUSE` and pressing the joystick opens `pair-new`.

This is the normal visible connected-Mouse entry into Pair New. It does not disconnect the current Mouse merely because the search begins.

While Pair New is active:

- the current Mouse remains authoritative and usable;
- Pair New searches only for an unsaved BLE HOGP Mouse;
- an already-saved candidate is ignored as a Pair New winner;
- the first fully qualified unsaved candidate becomes replacement-ready;
- handoff releases/disconnects the old session only after the new candidate is ready;
- timeout/cancel before handoff leaves the current Mouse connected.

## 4. Connected HOME -> remapper

Selecting the current remap summary opens `remapper-options` for the same connected Mouse.

## 5. Other HOME options

`SAVED DEVICES` and `LEARN THE KEYS` retain their existing destinations and semantics.

## 6. Reachability consequence

The canonical transition is now explicitly:

```text
home-connected
  -- select PAIR NEW MOUSE + JOY PRESS -->
pair-new
```

Therefore the former MBR-02 acceptance blocker about an unreachable connected-Mouse Pair New entry is closed.

No hidden control is introduced.

## 7. Scope boundary

This amendment does not change:

- the one-authoritative-Mouse invariant;
- multiple saved Mouse records;
- Pair New 15-second timing;
- saved-device HOME search;
- Pair New Help text;
- BLE HOGP-only Mouse transport;
- profiles/persistence/USB identity;
- Bluetooth Keyboard/Composite exclusions.
