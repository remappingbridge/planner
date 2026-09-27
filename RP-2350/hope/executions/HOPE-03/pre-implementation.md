# HOPE-03 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Implement Mouse UI v1 `home-connected` by replacing the legacy `BLU2USB_SCREEN_HOME` visual in-place, while preserving the accepted G06/HOPE runtime underneath.

This gate also carries the operator-approved post-HOPE-27 cosmetic improvement:

- `DEVICE NOT FOUND HELP` -> `MOUSE NOT FOUND HELP`.

HOPE-27 remains accepted; the title change is delivered in the HOPE-03 candidate as explicitly requested by the operator.

## Dependency

Accepted gates: HOPE-00, HOPE-01, HOPE-02, HOPE-08, HOPE-24, HOPE-09, HOPE-25, HOPE-06, HOPE-26, HOPE-07, HOPE-27.

Accepted product base:

- repository: `remappingbridge/remappingbridge`
- base: `main@1ffffebc0e9fabc55d981b7dcfbf7bba80bde78a`
- branch: `hope/hope-03-home-connected`

## Canonical home-connected layout

~~~text
LOGITECH LIFT
 REMAPPED TO ESCAPE
 SAVED DEVICES
 PAIR NEW MOUSE
 LEARN THE KEYS

JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP TO REMOVE
~~~

The title and row 1 are dynamic.

## Dynamic Mouse title

Match Mouse UI v1 exactly:

1. use the bounded original Mouse name;
2. uppercase ASCII letters;
3. keep renderer-supported characters only;
4. inspect the full bounded uppercase original for standalone word `MOUSE`, ignoring case;
5. truncate displayed base name to the first 15 renderer-supported characters;
6. trim trailing spaces;
7. append ` MOUSE` only when the full bounded original did not already contain standalone word `MOUSE`;
8. fallback to `UNKNOWN MOUSE` for empty/unusable names.

Examples:

- `LIFT` -> `LIFT MOUSE`
- `MOUSE GENERIC` -> `MOUSE GENERIC`
- `XPTO ULTRA 2714` -> `XPTO ULTRA 2714 MOUSE`
- `ABCDEFGHIJKLMNOP` -> `ABCDEFGHIJKLMNO MOUSE`

Stored/raw names are not modified by display formatting.

## Obtaining the real connected Mouse name

G06 currently carries no Mouse name into the UX model.

HOPE-03 adds only the minimum BLE identity read needed for the title:

- after security succeeds and before HIDS setup, read GAP Device Name characteristic UUID `0x2A00`;
- read is best-effort;
- if Device Name read fails or is absent, HIDS setup continues normally and UI falls back to `UNKNOWN MOUSE`;
- both ordinary/saved reconnect and Pair New candidate perform the same name read;
- Pair New keeps a separate candidate name until atomic promotion;
- successful promotion copies candidate name into the existing authoritative session;
- no new product/core/contracts architecture is introduced.

This ordering avoids concurrent use of the same GATT client transaction during HIDS setup.

## Profile summary

HOME row 1 reflects `ux.active_profile`:

- Passthrough -> ` NO REMAP PASSTHROUGH`
- Standard/default remap -> ` REMAPPED TO STANDARD`
- Escape -> ` REMAPPED TO ESCAPE`
- Custom -> ` REMAPPED TO CUSTOM`

All HOME rows remain ordinary action tone; no current-profile cyan is used on HOME.

## Navigation

HOME-connected has exactly four selectable rows:

1. remap summary -> existing legacy Mouse Options destination until HOPE-10 replaces that destination in-place;
2. Saved Devices -> existing Saved Devices destination until its own gate;
3. Pair New Mouse -> accepted Pair New flow;
4. Learn The Keys -> existing learn/instruction destination until its own gate.

- Joy Up/Down selects with wrap.
- Joy Press accesses.
- KEY X is visible but remains inert until HOPE-28.
- Global KEY Y lock remains available because a Mouse is saved, even though no Y hint is printed.

## HOME resolver

The existing unified HOME resolver remains authoritative:

- current Mouse live -> `BLU2USB_SCREEN_HOME`, now visually home-connected;
- saved Mouse offline -> accepted `home-searching`;
- no saved Mouse -> accepted searching-first flow.

Flow points that already resolve HOME after connection or Pair New promotion therefore automatically land on canonical home-connected.

If the live Mouse disconnects while HOME-connected is visible:

- UI immediately leaves HOME for `home-searching`;
- accepted G06 reconnect logic starts/continues the saved-only 8-second reconnect;
- old connected HOME visual must not remain.

## Frozen replacement rule

The legacy HOME copy:

~~~text
HOME
 STATUS
 MOUSE OPTIONS
 OTHER OPTIONS
 LEARN THE KEYS
...
~~~

must disappear from the HOME flow point completely.

The enum/slot `BLU2USB_SCREEN_HOME` is reused in-place; no parallel `HOME_CONNECTED` screen is added.

## HOPE-27 title improvement bundled here

Only the title changes:

~~~text
MOUSE NOT FOUND HELP
~~~

All accepted HOPE-27 body, hint region, Any-Key behavior and flow remain unchanged.

## Out of scope

- canonical help-home-connected (HOPE-28); KEY X remains inert here;
- replacing legacy Mouse Options with remapper-options (HOPE-10);
- Saved Devices canonical redesign;
- learn-the-keys canonical redesign;
- per-Mouse profile architecture beyond accepted G06;
- Keyboard/Composite pairing.

## Automated verification

Tests must prove:

1. legacy HOME literal absent at HOME flow point;
2. exact canonical home-connected static rows/hints;
3. title formatter examples and standalone `MOUSE` word semantics;
4. empty/unusable name -> `UNKNOWN MOUSE`;
5. all four profile summaries;
6. HOME options are action tone, selected row white, never cyan;
7. four-option Up/Down wrap;
8. Joy Press destinations map summary/Saved/Pair New/Learn correctly;
9. KEY X does not introduce HOPE-28 early;
10. global KEY Y lock remains functional;
11. HOME resolver live/saved/no-saved behavior remains correct;
12. connection and Pair New promotion update UX name from authoritative BLE name;
13. BLE name query happens after security and before HIDS setup;
14. failed/missing name read does not block HIDS;
15. Pair New candidate name stays separate until promotion;
16. disconnect from HOME resolves to saved search;
17. HOPE-27 title is `MOUSE NOT FOUND HELP`;
18. inherited G02-G06 and accepted HOPE regressions remain green.

## Physical acceptance

1. Reboot with one saved Mouse and let it reconnect.
2. Confirm HOME shows the actual connected Mouse name formatted by the 15-character rule, or `UNKNOWN MOUSE` only if the peripheral exposes no GAP Device Name.
3. Verify `LIFT`-style name receives ` MOUSE` suffix; a device name already containing standalone `MOUSE` does not receive a second suffix.
4. Verify the correct profile summary.
5. Verify four rows: summary, SAVED DEVICES, PAIR NEW MOUSE, LEARN THE KEYS.
6. Verify Up/Down wrap and white selection; no HOME option is cyan.
7. Enter Pair New from HOME; current Mouse remains authoritative during search.
8. Cancel/back to HOME and confirm title/profile preserved.
9. Complete successful Pair New and confirm HOME title switches to the newly promoted Mouse.
10. Unplug current Mouse while HOME is visible; UI must immediately become `SEARCHING SAVED MOUSE` and accepted saved search must run.
11. Reconnect and confirm HOME-connected returns.
12. KEY X on HOME must not open HOPE-28 yet.
13. KEY Y must still lock globally; unlock interaction must be consumed and return through HOME resolver.
14. Reach retry-pair-new Help and verify its title is now `MOUSE NOT FOUND HELP`, with all accepted HOPE-27 behavior unchanged.
15. Confirm profiles/remap/forwarding/persistence remain functional.
16. Confirm no Bluetooth Keyboard/Composite behavior was introduced.

## Risks

- GATT Device Name read delaying or blocking HIDS;
- candidate/current name cross-assignment;
- title formatting diverging from Mouse UI v1;
- dynamic profile summary being accidentally cyan;
- old HOME route remaining reachable;
- disconnect leaving stale HOME-connected presentation.
