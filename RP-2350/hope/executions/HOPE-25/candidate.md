# HOPE-25 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@b883353bb654826d4c960513e72182d2b35b4c6a`
- branch: `hope/hope-25-home-retry-help`
- candidate commit: `69570808a1c7e1ef82094e4dc63623716fe8e833`
- draft PR: `#7`
- PR must remain unmerged until operator physical acceptance.

## Canonical screen

~~~text
HOME RETRY HELP
THE MATCHING ATTEMPT
TOOK PLACE ONLY FOR
DEVICES ALREADY SAVED
IN THE PREFERENCES,
BUT NOT FOR DEVICES
THAT WERE NOT SAVED.

ANY KEY: BACK
~~~

## Behavior implemented

- `KEY X` from accepted `home-retry` opens `home-retry-help`;
- no BLE/search implementation changed;
- Help has zero selectable options;
- every complete HAT interaction returns to `home-retry` and is consumed;
- `KEY Y` is owned by Help and never locks presentation;
- return from Help does not enter `home-searching` and therefore does not restart saved-only search;
- saved count/bond state remains intact.

## Rendering

- black explanatory body;
- dark-magenta hint field beginning at row 8;
- title magenta;
- explanatory body static/yellow;
- `ANY KEY: BACK` actionable/light gray.

## Changed files

- `include/blu2usb/ux_model/ux_model.h`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_hope09_home_retry.c`
- `tests/test_hope25_home_retry_help.c`

No BLE source or app runtime file changed.

## Automated verification

GitHub Actions run: `35821366186` — **SUCCESS**.

- `host-architecture`: **SUCCESS**
  - inherited G02–G06 tests: PASS
  - HOPE-01/02/08/24/09 regressions: PASS
  - HOPE-25 focused test: PASS
  - architecture/screen-contract tests: PASS
- `pico2-w-production`: **SUCCESS**
  - pinned ARM toolchain: PASS
  - pinned Pico SDK: PASS
  - Pico 2 W configure/build: PASS
  - UF2 verification: PASS
  - artifact upload: PASS

Focused HOPE-25 tests prove:

1. exact 9-row literal;
2. hint starts on row 8;
3. black body + dark-magenta hint;
4. KEY X opens retry Help;
5. Help has no option selection;
6. every HAT control returns to `home-retry`;
7. KEY Y does not lock;
8. exit is consumed;
9. saved count remains intact;
10. Help return does not restart search;
11. KEY A still starts search only from `home-retry`.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10732998533`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: 325,431 bytes
- ZIP digest: `sha256:646d629af07042c2c60d9fe900175a0cf464297b81624224bbfc2656b8ac08c4`

Extracted firmware:

- file: `HOPE-25-home-retry-help-pico2w.uf2`
- size: **883,200 bytes**
- SHA-256: `b77528faa63554c6fc410ad38f4b61ebc37c5e953d741905e422df3f14b98f04`

## Gate state

HOPE-25 is **not ACCEPTED** until the operator validates this exact candidate on hardware.
