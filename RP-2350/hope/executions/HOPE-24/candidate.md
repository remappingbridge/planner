# HOPE-24 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@c88ebacdeb8265c9b8bd82882f97d9b8c960493a`
- branch: `hope/hope-24-home-searching-help`
- candidate commit: `81d76a862b2d6e6e3dc55abe055a7e0fb3d1a58a`
- draft PR: `#5`
- PR must remain unmerged until operator physical acceptance.

## Canonical screen

~~~text
HOME SEARCHING HELP
THE MATCHING ATTEMPT
TOOK PLACE ONLY FOR
DEVICES ALREADY SAVED
IN THE PREFERENCES,
BUT NOT FOR DEVICES
THAT WERE NOT SAVED.

ANY KEY: BACK
~~~

## Behavior implemented

- `KEY X` from accepted `home-searching` opens `home-searching-help`;
- screen transition away from `home-searching` reuses the accepted HOPE-08 app hook to cancel the active saved-only search;
- no BLE search implementation was changed in this gate;
- Help has zero selectable options;
- every complete HAT interaction exits Help and is consumed;
- `KEY Y` is owned by Help and never locks presentation;
- saved count/bond state is preserved;
- exit lands on the inherited G06 HOME placeholder that currently represents the future `home-retry` state;
- exiting Help does not restart saved search;
- HOPE-09 will replace that placeholder with the canonical `home-retry` screen.

## Rendering

- black body;
- dark-magenta hint field beginning at row 8;
- title uses title/magenta tone;
- explanatory body uses static/yellow tone;
- `ANY KEY: BACK` uses actionable/light-gray tone.

## Changed files

Only four product/test files changed:

- `include/blu2usb/ux_model/ux_model.h`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_hope24_home_searching_help.c`

No BLE source file changed.

## Automated verification

GitHub Actions run: `35819444313` — **SUCCESS**.

- `host-architecture`: **SUCCESS**
  - inherited G02–G06 tests: PASS
  - HOPE-01/02/08 regressions: PASS
  - HOPE-24 focused tests: PASS
  - architecture/screen-contract tests: PASS
- `pico2-w-production`: **SUCCESS**
  - pinned ARM toolchain: PASS
  - pinned Pico SDK: PASS
  - Pico 2 W configure/build: PASS
  - UF2 verification: PASS
  - artifact upload: PASS

Focused HOPE-24 tests prove:

1. exact 9-row literal;
2. hint starts at row 8;
3. black body and dark-magenta hint;
4. KEY X opens Help;
5. Help has no option selection;
6. every HAT control exits on complete interaction;
7. KEY Y does not lock;
8. exit is consumed;
9. saved count remains intact.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10732891273`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: 325,065 bytes
- ZIP digest: `sha256:930c62652c7403fe1fef308fb9190b453e1bd6fe49e2bd1c2131932fcedcc7ac`

Extracted firmware:

- file: `blu2usb_picow.uf2`
- size: **882,688 bytes**
- SHA-256: `984d9615d0abb7dabbe77851a8fb86fd30843f782c9c7b8eeee58f560f5daddc`

## Gate state

HOPE-24 is **not ACCEPTED** until the operator validates this exact candidate on hardware.
