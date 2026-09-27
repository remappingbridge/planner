# MBR-02 connected HOME amendment record

Gate: `mbr-02 — Interaction engine, UI projector and golden screen model`

## Product decision

On 2026-09-20 the user amended `home-connected` so the current connected Mouse name is the dynamic title and the visible options are:

1. `PAIR NEW MOUSE`
2. current confirmed remap summary
3. `SAVED DEVICES`
4. `LEARN THE KEYS`

The first option opens `pair-new` without disconnecting the current Mouse.

The remap summary opens `remapper-options` for the same current Mouse.

## Reason

The amendment closes the MBR-02 reachability contradiction discovered during executable state modeling. The previous canonical screen had no visible connected-Mouse entry into Pair New, despite the product requiring Pair New to operate while the current Mouse remains live.

No hidden control is introduced.

## Scope preserved

- one authoritative live Mouse maximum;
- optional non-authoritative Pair New candidate;
- Pair New remains unsaved-only and 15 seconds;
- current Mouse remains authoritative during discovery;
- old session is released/disconnected only at successful handoff;
- Pair New timeout/cancel before handoff leaves the current Mouse live;
- Pair New Help text remains unchanged;
- BLE HOGP-only Mouse transport remains unchanged;
- Keyboard/Composite Bluetooth scope remains excluded.

## Implementation impact

- `app.c`: connected HOME option count becomes four and maps selection 0 to Pair New, 1 to remapper, 2 to Saved Devices, 3 to Learn.
- `ui_projector.c`: connected Mouse name becomes title; Pair New is first option; remap summary is second.
- golden tests update exact connected HOME rows/colors;
- behavior tests prove Pair New is reachable from connected HOME while a live Mouse remains ready;
- product/manual/architecture/planner contract documents are amended.

## Acceptance

This amendment itself requires no physical test. MBR-02 acceptance remains conditional on exact-head host/architecture and Pico structural CI, PR integration, and post-merge revalidation.

