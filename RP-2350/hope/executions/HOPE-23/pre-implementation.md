# HOPE-23 — remove learn-the-keys

Status: **IMPLEMENTATION ACTIVE / PLANNED LEARN-THE-KEYS FEATURE CANCELLED**.

Operator decision: **2026-09-26**.

## Replaced scope

The previously planned implementation of the user-facing `learn-the-keys` feature is cancelled.

HOPE-23 now means:

- remove the `LEARN THE KEYS` option from every HOME variant;
- `home-connected` exposes only:
  1. remapping options;
  2. saved devices;
  3. pair new Mouse;
- `home-searching` exposes only:
  1. saved devices;
  2. pair new Mouse;
- `home-retry` exposes only:
  1. saved devices;
  2. pair new Mouse;
- reduce selection counts and wrap behavior to those real options;
- remove every manual HOME destination that points to the old learn-the-keys route;
- preserve `SEARCHING FIRST MOUSE` as the automatic zero-saved-device bootstrap flow. The current legacy internal enum name `BLU2USB_SCREEN_LEARN_KEYS` represents that accepted automatic searching-first screen and is not a user-facing HOME option;
- do not implement the previously planned learn-the-keys screen/feature;
- preserve all previously accepted pairing, saved-device, remapping, Help and Lock behavior.

## Implementation branch

- repository: `remappingbridge/remappingbridge`
- accepted base: `25670c9692aaaf709912e2d6bb87c27c10b25b4e`
- branch: `hope/hope-23-remove-learn-the-keys`

## Execution boundary

After HOPE-23 is implemented/tested, return to operator HOLD. **Do not start HOPE-31 or any other gate without a new explicit operator order.**
