# HOPE-09 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@aa6abb2294248aa8eabc4918eae1bdcfef26a959`
- branch: `hope/hope-09-home-retry`
- candidate commit: `c6cbea7d00e2a2a38de2a78a22fc1126ff4a1670`
- draft PR: `#6`
- PR must remain unmerged until operator physical acceptance.

## Canonical screen

~~~text
DEVICE NOT FOUND
 SAVED DEVICES
 PAIR NEW MOUSE
 LEARN THE KEYS

KEY A: RETRY SEARCH
JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP
~~~

## Flow closed by this gate

The inherited G06 HOME retry placeholder is removed from the three accepted retry paths:

- saved-only 8-second timeout -> `home-retry`;
- `KEY B: CANCEL SEARCH` from `home-searching` -> `home-retry`;
- Any Key Back from `home-searching-help` -> `home-retry`.

The old G06 HOME no longer appears at those retry points.

## Controls

- three selectable options with Up/Down wrap;
- Joy Press routes to the same current incremental destinations as HOPE-08;
- KEY A enters accepted `home-searching`; the existing HOPE-08 app hook starts a fresh saved-only 8-second search;
- KEY B is explicitly inert;
- KEY X is visible but intentionally inert until HOPE-25 introduces `home-retry-help`;
- KEY Y remains the global lock action because saved state exists;
- unlock interaction is consumed and HOME resolution returns to `home-searching` while still offline, starting a fresh saved-only search.

## Rendering

- black body;
- dark-magenta hint area beginning at row 5;
- title magenta;
- selected option white;
- other options/action hints light gray;
- standard held-feedback behavior retained.

## Changed files

- `include/blu2usb/ux_model/ux_model.h`
- `src/app/main.c`
- `src/renderer/renderer.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_hope08_home_searching.c`
- `tests/test_hope09_flow_source.py`
- `tests/test_hope09_home_retry.c`
- `tests/test_hope24_home_searching_help.c`

No BLE implementation file changed in HOPE-09.

## Automated verification

GitHub Actions run: `35820554223` — **SUCCESS**.

- `host-architecture`: **SUCCESS**
  - inherited G02–G06 tests: PASS
  - HOPE-01/02/08/24 regressions: PASS
  - HOPE-09 focused UX/render tests: PASS
  - HOPE-09 source-flow assertion: PASS
  - architecture/screen-contract tests: PASS
- `pico2-w-production`: **SUCCESS**
  - pinned ARM toolchain: PASS
  - pinned Pico SDK: PASS
  - Pico 2 W configure/build: PASS
  - UF2 verification: PASS
  - artifact upload: PASS

Focused verification proves:

1. exact `DEVICE NOT FOUND` layout;
2. row-5 hint split;
3. three-option selection/wrap;
4. B inert;
5. X does not introduce HOPE-25 early;
6. A transitions to `home-searching`;
7. Joy Press destinations are preserved;
8. Y locks and unlock resolves saved/offline HOME to `home-searching`;
9. search cancel and Help return both target `home-retry`;
10. production source routes saved-search timeout directly to `home-retry`.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10733380857`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: 325,244 bytes
- ZIP digest: `sha256:3fbd6dc8f267d9b3573dc47d2f2ee1df55d30eb9efa3047ea58fed6edd9cd77a`

Extracted firmware:

- file: `HOPE-09-home-retry-pico2w.uf2`
- size: **882,688 bytes**
- SHA-256: `7de8be1f50858a8ed62408a90f3a9ab86fdf5de10d6cd4c636a1d453737289f3`

## Gate state

HOPE-09 is **not ACCEPTED** until the operator validates this exact candidate on hardware.
