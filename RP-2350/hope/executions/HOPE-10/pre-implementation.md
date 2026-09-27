# HOPE-10 — pre-implementation

Status: **IN PROGRESS — IMPLEMENTATION NOT YET PHYSICALLY ACCEPTED**.

Date: 2026-09-23.

## Objective

Replace the legacy `HOME > MOUSE OPTIONS` visual in-place with current Mouse UI v1 `remapper-options`, preserving the already-working profile/remap functions underneath.

Accepted product base:

- repository: `remappingbridge/remappingbridge`
- base: `main@46e501f13784d3ef94e3d4213596b25afa731347`
- branch: `hope/hope-10-remapper-options`

Current Mouse UI v1 source authority consulted:

- `mouse-ui/src/projector/screens.c@5f269e9625ae0d02a85b5d39eb87026edc448068`
- `mouse-ui/src/navigation/navigation.c@5f269e9625ae0d02a85b5d39eb87026edc448068`

## Canonical screen

~~~text
MOUSE OPTIONS
 PASSTHROUGH
 STANDARD REMAP
 ESCAPE REMAP
 CUSTOM REMAP

JOY PRESS: ACCESS
KEY B: BACK
KEY X: HELP
~~~

## Behavior

- exactly four selectable profile rows;
- Up/Down wraps;
- current applied profile row is cyan;
- selected row is white and takes precedence over cyan;
- Joy Press opens:
  1. Passthrough active/not-active according to current profile;
  2. Standard active/not-active according to current profile;
  3. Escape active/not-active according to current profile;
  4. Custom edit;
- KEY B returns through HOME resolver;
- KEY X is visible but remains inert until HOPE-29;
- global KEY Y lock remains available because a saved Mouse exists, even though no Y hint is printed;
- legacy `PAIR MOUSE` option disappears from this screen; Pair New remains available from accepted home-connected.

## Replacement rule

Reuse `BLU2USB_SCREEN_MOUSE_OPTIONS` in-place. Do not create a parallel remapper-options screen and do not preserve the old five-row Mouse Options visual.

## Out of scope

- help-remapper-options (HOPE-29);
- replacing profile detail screens (HOPE-11/14/12/13/15/16/17);
- changing remap logic, persistence or USB forwarding;
- applying remappingbridge-only improvements back into mouse-ui before HOPE series completion.

## Automated verification

Tests must prove:

1. exact current-v1 literal;
2. exactly four options;
3. no legacy Pair Mouse row;
4. active profile cyan row mapping 1..4;
5. selected row white overrides cyan;
6. Joy Press routes to accepted legacy functional destinations based on active profile;
7. B returns HOME;
8. X is inert until HOPE-29;
9. global Y lock remains functional;
10. Pair New remains reachable through HOME, not remapper-options;
11. accepted HOPE regressions remain green.
