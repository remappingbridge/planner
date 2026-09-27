# HOPE-27 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@a4ce8cc7d3be425152bfb825c9b282d8ee510bd8`
- branch: `hope/hope-27-help-retry-pair-new`
- candidate commit: `96fff0d5c304166883419c11693e3dba4e10b556`
- draft PR: `#11`
- PR must remain unmerged until operator physical acceptance.

## Canonical screen

~~~text
DEVICE NOT FOUND HELP
TO CONNECT A SAVED
DEVICE FIRST UNPLUG
CURRENTLY CONNECTED
MOUSE AND PRESS THE
KEY B TO BACK UNTIL
SEARCHING APPEARS.

ANY KEY: BACK
~~~

## Behavior implemented

- KEY X from accepted `NEW MOUSE NOT FOUND` opens this Help;
- every complete HAT interaction returns to `retry-pair-new` and is consumed;
- KEY Y is owned by Help and never locks/backlight-off;
- no Pair New search starts on Help entry or exit;
- current/saved Mouse state is preserved;
- KEY A on retry remains the only action that starts a fresh Pair New operation.

## Rendering

The accepted HOPE-26 layout correction pattern is applied explicitly:

- rows 0–7 remain the black body region;
- `KEY B TO BACK UNTIL` is explanatory body text, not a hint;
- `SEARCHING APPEARS.` remains body text;
- only row 8 `ANY KEY: BACK` is the dark-magenta hint region;
- `hint_start_row = 8`.

## Changed files

- `include/blu2usb/ux_model/ux_model.h`
- `src/renderer/renderer.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_hope07_retry_pair_new.c`
- `tests/test_hope07_retry_pair_new_source.py`
- `tests/test_hope26_help_pair_new_source.py`
- `tests/test_hope27_help_retry_pair_new.c`
- `tests/test_hope27_help_retry_pair_new_source.py`

No BLE implementation or app lifecycle file changed.

## Automated verification

GitHub Actions run: `35829305959` — **SUCCESS**.

- `host-architecture`: **SUCCESS**
  - inherited G02–G06 tests: PASS
  - accepted HOPE regressions: PASS
  - HOPE-07 retry regression: PASS
  - HOPE-27 focused UX/render test: PASS
  - HOPE-27 source lifecycle/layout test: PASS
  - architecture/screen-contract tests: PASS
- `pico2-w-production`: **SUCCESS**
  - pinned ARM toolchain: PASS
  - pinned Pico SDK: PASS
  - Pico 2 W configure/build: PASS
  - UF2 verification: PASS
  - artifact upload: PASS

The first CI attempt failed only because historical HOPE-26/07 source tests still asserted that the future HOPE-27 screen must not exist. Those future-gate prohibitions were removed; no product behavior rollback was required.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10735499386`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: **328,426 bytes**
- ZIP digest: `sha256:b4b283b53c00a831b3a5029efd82dacbd517e1b8af577a2482215688167473b7`

Extracted firmware:

- file: `HOPE-27-help-retry-pair-new-pico2w.uf2`
- size: **891,392 bytes**
- SHA-256: `8a308b70d5b284f3c84ce7f6141be8f59f5d43eba5848e34485cdc1ff68971ed`

## Gate state

HOPE-27 is **not ACCEPTED** until the operator validates this exact candidate on hardware.
