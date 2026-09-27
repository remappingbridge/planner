# HOPE implemented-screen copy audit against Mouse UI v1

Date: 2026-09-23.

Status: **COMPLETE — NO UNINTENTIONAL STALE COPY REMAINS IN THE CURRENT HOPE-28 CANDIDATE**.

## Authority audited

Mouse UI v1 source of truth:

- repository: `remappingbridge/mouse-ui`
- branch: `release/ui-layout-v1.0`
- commit: `e8adad7919e931c92515bf655ef4050876a8e7a9`
- source: `src/projector/screens.c`
- source blob: `0cecfd8e802047673cb6d2d4b866c11bd6137b45`

Current firmware candidate audited:

- repository: `remappingbridge/remappingbridge`
- branch: `hope/hope-28-help-home-connected`
- commit: `8dacad0a34a78ec89e74454f1b6d09d71eae01ae`
- source: `src/ux_model/ux_model.c`
- source blob: `0312910824af0d9cbb849529149f2bf7d32ba935`

The audit compared all nine display rows, including blank-row positions, for every Mouse UI screen already introduced by accepted/current HOPE gates.

## Results

| HOPE screen | Result | Notes |
| --- | --- | --- |
| `searching-first` | exact v1 parity | all 9 rows identical |
| `first-mouse-connected` | exact v1 parity | all 9 rows identical |
| `home-searching` | exact v1 parity | all 9 rows identical |
| `home-searching-help` | exact v1 parity | all 9 rows identical |
| `home-retry` | exact v1 parity | all 9 rows identical |
| `home-retry-help` | exact v1 parity | all 9 rows identical |
| `pair-new` | exact v1 parity | all 9 rows identical |
| `help-pair-new` | exact v1 parity | all 9 rows identical |
| `retry-pair-new` | intentional operator override | only row 0 differs: firmware uses `NEW MOUSE NOT FOUND` instead of v1 `PAIR NEW MOUSE` |
| `help-retry-pair-new` | intentional operator override | only row 0 differs: firmware uses `MOUSE NOT FOUND HELP` instead of v1 `DEVICE NOT FOUND HELP` |
| `home-connected` | dynamic v1 implementation | static rows 2–8 match v1 exactly; rows 0–1 are runtime Mouse name/profile values rather than the v1 example `LOGITECH LIFT / REMAPPED TO ESCAPE` |
| `help-home-connected` | exact v1 parity after correction | all 9 rows now identical |

## Corrected stale copy found during audit

The original HOPE-28 candidate used an older `help-home-connected` literal:

~~~text
HOME CONNECTED HELP
TO DISCONNECT THE
CURRENTLY CONNECTED
MOUSE, NAVIGATE TO:
SAVED DEVICES >
(MOUSE PAGE) > REMOVE
DEVICE > REMOVE

ANY KEY: BACK
~~~

Current Mouse UI v1 requires:

~~~text
REMOVE CONNECTED HELP
TO DISCONNECT THE
CURRENTLY CONNECTED
MOUSE NAVIGATE TO:
STEP 1. SAVED DEVICES
STEP 2. REMOVE DEVICE
STEP 3. KEY A: REMOVE

ANY KEY: BACK
~~~

The HOPE-28 branch, focused tests, planner evidence, physical matrix and replacement UF2 have already been updated to the current v1 literal.

## Intentional differences that must NOT be reverted

These are explicit operator improvements made after the Mouse UI v1 literal and are therefore not stale-copy defects:

1. `retry-pair-new` title:
   - Mouse UI v1: `PAIR NEW MOUSE`
   - accepted operator override: `NEW MOUSE NOT FOUND`

2. `help-retry-pair-new` title:
   - Mouse UI v1: `DEVICE NOT FOUND HELP`
   - accepted operator override: `MOUSE NOT FOUND HELP`

They are the only static textual deviations among already implemented HOPE screens.

## Dynamic home-connected rows

Mouse UI v1 uses example values in its projector source:

- row 0: `LOGITECH LIFT`
- row 1: ` REMAPPED TO ESCAPE`

The firmware correctly renders these rows dynamically from the live Mouse identity and confirmed profile. This is not a copy mismatch.

The static HOME rows and hints match v1 exactly.

## Physical-test candidate after audit

Use only the corrected HOPE-28 replacement candidate:

- commit: `8dacad0a34a78ec89e74454f1b6d09d71eae01ae`
- canonical CI: `35832917577` — **SUCCESS**
- host-architecture: **SUCCESS**
- pico2-w-production: **SUCCESS**
- artifact id: `10737842468`
- UF2: `HOPE-28-help-home-connected-current-v1-copy-pico2w.uf2`
- size: **896,512 bytes**
- SHA-256: `6f11f76d05249f6989106a5f8346dffea76873b0ddb32cff2776296c0dc8a807`

The earlier HOPE-28 UF2 with SHA-256 `1d8a5799ca8bf0690a1e48c42e5674b7f5435b122010b8231646fef6e6ccb9e7` is superseded and must not be used for physical acceptance.
