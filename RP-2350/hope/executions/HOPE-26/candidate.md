# HOPE-26 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@90e6e1884aa109cdf1dfd48c5e5762226d0e29ba`
- branch: `hope/hope-26-help-pair-new`
- candidate commit: `60c9050095603712baae61dfb12766b1ba46b67f`
- draft PR: `#9`
- PR must remain unmerged until operator physical acceptance.

## Canonical screen

~~~text
PAIR NEW DEVICE HELP
TO CONNECT A SAVED
DEVICE FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
~~~

## Behavior implemented

- KEY X from accepted `PAIR NEW MOUSE` opens this Help;
- entering Help leaves Pair New and therefore triggers the accepted HOPE-06 cancel hook;
- no BLE Pair New runtime source was modified;
- every complete HAT interaction exits Help and is consumed;
- KEY Y is owned by Help and never locks presentation;
- saved/current Mouse state is preserved;
- after Help, HOPE-26 temporarily returns to the Pair New visual as the future retry placeholder;
- that return explicitly does **not** request/restart the 15-second Pair New operation;
- HOPE-07 will replace that placeholder with canonical `retry-pair-new`.

## Rendering

- black body;
- dark-magenta hint field beginning at row 8;
- title magenta;
- explanatory text static/yellow;
- `ANY KEY: BACK` actionable/light gray.

## Changed files

- `include/blu2usb/ux_model/ux_model.h`
- `src/app/main.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_g03_renderer.c`
- `tests/test_hope06_pair_new.c`
- `tests/test_hope06_pair_new_source.py`
- `tests/test_hope26_help_pair_new.c`
- `tests/test_hope26_help_pair_new_source.py`

No BLE implementation file changed.

## Automated verification

GitHub Actions run: `35826910007` — **SUCCESS**.

- `host-architecture`: **SUCCESS**
  - inherited G02–G06 tests: PASS
  - accepted HOPE regressions: PASS
  - HOPE-06 Pair New regression: PASS
  - HOPE-26 focused UX/render test: PASS
  - HOPE-26 source lifecycle test: PASS
  - architecture/screen-contract tests: PASS
- `pico2-w-production`: **SUCCESS**
  - pinned ARM toolchain: PASS
  - pinned Pico SDK: PASS
  - Pico 2 W configure/build: PASS
  - UF2 verification: PASS
  - artifact upload: PASS

The first CI attempt failed only because the historical HOPE-06 test still asserted that future Pair New Help must not exist. That obsolete future-gate assertion was removed; no product rollback was needed.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10735512100`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: **328,150 bytes**
- ZIP digest: `sha256:53f127c844980a856d179e3467f0c613f6f1e76a8475b302fccc4c38621e66cf`

Extracted firmware:

- file: `HOPE-26-help-pair-new-layout-fix-pico2w.uf2`
- size: **890,880 bytes**
- SHA-256: `a8d32a529883dded80e3d169bc22e2a207b434e8a8ac37b7dc8f6875bdc22ccd`

## Gate state

HOPE-26 is **not ACCEPTED** until the operator validates this exact candidate on hardware.


## Layout correction after operator report

The first HOPE-26 candidate incorrectly let the renderer infer the hint region from the explanatory line `KEY B TO BACK UNTIL`.

That line is **body text**, not a hint.

Corrected renderer semantics for `BLU2USB_SCREEN_HELP_PAIR_NEW`:

- rows 0–7 remain in the black body region;
- explanatory lines, including `KEY B TO BACK UNTIL` and `SEARCHING APPEARS.`, remain static/yellow body text;
- only row 8, `ANY KEY: BACK`, starts the dark-magenta hint region;
- corrected `hint_start_row = 8`.

The previous candidate `45dab4093d1b99ddd7cabba98322bfd8b3d14ee8` and UF2 hash `d5127a85...` are superseded and must not be used for physical acceptance.
