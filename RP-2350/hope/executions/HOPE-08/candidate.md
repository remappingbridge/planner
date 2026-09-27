# HOPE-08 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@d13f905fc2a817f464f3683edd4bf689247c30ed`
- branch: `hope/hope-08-home-searching`
- candidate commit: `b7ee92c841f4f3edbfdd73e2c9e9f146b5ccdeab`
- draft PR: `#4`
- PR must remain unmerged until operator physical acceptance.

## Canonical HOME-searching state

~~~text
SEARCHING SAVED MOUSE
 SAVED DEVICES
 PAIR NEW MOUSE
 LEARN THE KEYS

KEY B: CANCEL SEARCH
JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP
~~~

This screen is selected whenever the product knows at least one Mouse is persisted in the existing BTstack LE bond DB and no Mouse is currently live.

It does not replace the already accepted `searching-first`: zero saved Mouse still resolves to that accepted first-start state.

## Saved-only search

HOPE-08 reuses the G06 bonded whitelist reconnect and its 8-second timer.

Changes make that behavior explicit:

- runtime event: saved-search started;
- runtime event: saved-search timeout;
- timeout ends in idle instead of falling through to general unsaved scanning;
- UI may safely request/cancel saved search through small Pico glue hooks;
- cancel/timeout races disconnect an in-flight candidate rather than accepting it after the search ended;
- saved search remains active through connection qualification until READY.

The persistent bond DB is used only as the minimal saved-Mouse source until HOPE-04 introduces the canonical Saved Devices implementation.

## HOME resolution

Current incremental resolution:

- zero saved + no live Mouse -> accepted HOPE-01 `searching-first`;
- saved + no live Mouse -> `home-searching`;
- live Mouse -> inherited G06 HOME placeholder until HOPE-03 `home-connected`;
- saved-search timeout/cancel -> inherited G06 HOME placeholder until HOPE-09 `home-retry`.

The inherited placeholders are future HOME states; they are not fallbacks while `home-searching` is active.

## Controls

- 3 selectable rows with wrapping Joy Up/Down;
- selected option is white;
- Key B cancels saved search and exits the searching state without deleting the saved count/bond;
- Joy Press routes to the existing temporary destination for Saved Devices, Pair Mouse or the current didactic slot;
- Key X has visual feedback but canonical help is deferred to HOPE-24;
- global Key Y lock remains available when a saved Mouse exists; locking cancels saved search, and unlock HOME-resolution returns to `home-searching` while still offline.

## Changed files

- `include/blu2usb/ble_hogp/ble_hogp.h`
- `include/blu2usb/ux_model/ux_model.h`
- `src/app/main.c`
- `src/ble_hogp/ble_hogp.c`
- `src/ble_hogp/ble_hogp_pico.c`
- `src/renderer/renderer.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_g05_ble_mouse.c`
- `tests/test_hope08_home_searching.c`

## Automated verification

GitHub Actions run: `35818658066` — **SUCCESS**.

- `host-architecture`: **SUCCESS**
  - inherited G02–G06 tests: PASS
  - HOPE-01 regression: PASS
  - HOPE-02 regression: PASS
  - HOPE-08 focused UX/render test: PASS
  - BLE saved-search runtime event decode tests: PASS
  - architecture/screen-contract tests: PASS
- `pico2-w-production`: **SUCCESS**
  - pinned ARM toolchain: PASS
  - pinned Pico SDK: PASS
  - Pico 2 W configure/build: PASS
  - UF2 verification: PASS
  - artifact upload: PASS

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10732632075`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: 325,191 bytes
- ZIP digest: `sha256:7b64216ba01123a5bd7eca258ef0beb9cc4bd025ef9a0dd5ee25b3cd852b38e9`

Extracted firmware:

- file: `blu2usb_picow.uf2`
- size: **882,176 bytes**
- SHA-256: `1b6d5d9cab934774f24ad5dfb3bfec1944cf6a94116d83253efe12e05805230e`

## Gate state

HOPE-08 is **not ACCEPTED** until the operator validates this exact candidate on hardware.
