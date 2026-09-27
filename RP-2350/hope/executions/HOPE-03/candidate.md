# HOPE-03 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@1ffffebc0e9fabc55d981b7dcfbf7bba80bde78a`
- branch: `hope/hope-03-home-connected`
- candidate commit: `e5ba33b2c5a6b027e0277dfd05e610a8fe569efb`
- draft PR: `#12`
- PR remains unmerged until operator physical acceptance.

## HOME replacement

The existing `BLU2USB_SCREEN_HOME` slot was transformed in-place into Mouse UI v1 `home-connected`.

Legacy HOME copy removed from this flow point:

~~~text
HOME
 STATUS
 MOUSE OPTIONS
 OTHER OPTIONS
 LEARN THE KEYS
...
~~~

No parallel `HOME_CONNECTED` enum/screen was introduced.

Canonical HOME-connected shell:

~~~text
<CONNECTED MOUSE TITLE>
 <PROFILE SUMMARY>
 SAVED DEVICES
 PAIR NEW MOUSE
 LEARN THE KEYS

JOY UP / DOWN: SELECT
JOY PRESS: ACCESS
KEY X: HELP TO REMOVE
~~~

## Dynamic Mouse title

The connected Mouse name follows Mouse UI v1 display rules:

- uppercase ASCII;
- only renderer-supported characters retained;
- display base bounded to first 15 supported characters;
- trailing spaces trimmed;
- standalone `MOUSE` is detected in the full bounded original name;
- ` MOUSE` appended only when standalone `MOUSE` is absent;
- empty/unusable name falls back to `UNKNOWN MOUSE`.

Automated examples frozen:

- `LIFT` -> `LIFT MOUSE`
- `mouse generic` -> `MOUSE GENERIC`
- `XPTO ULTRA 2714` -> `XPTO ULTRA 2714 MOUSE`
- `ABCDEFGHIJKLMNOP` -> `ABCDEFGHIJKLMNO MOUSE`
- `ABCDEFGHIJKLMNO MOUSE` -> `ABCDEFGHIJKLMNO`
- `MOUSEPAD` -> `MOUSEPAD MOUSE`
- empty/unusable -> `UNKNOWN MOUSE`

## Real BLE Device Name

G06 did not carry the peripheral name into UI state. HOPE-03 adds only a best-effort identity read inside the existing BLE HOGP module:

- after security completes and before HIDS setup, query GAP Device Name UUID `0x2A00`;
- current and Pair New candidate have separate name buffers/states;
- missing/failed Device Name read never blocks HIDS: firmware immediately continues with HIDS and HOME uses `UNKNOWN MOUSE`;
- saved reconnect also reads Device Name after successful re-encryption;
- Pair New candidate name is not authoritative until the existing atomic promotion;
- promotion copies candidate handle, CID, parser **and name** into the current G06 session.

No mouse-core/contracts architecture was introduced.

## Profile summary

HOME row 1 is derived from the accepted active profile:

- Passthrough -> ` NO REMAP PASSTHROUGH`
- Standard -> ` REMAPPED TO STANDARD`
- Escape -> ` REMAPPED TO ESCAPE`
- Custom -> ` REMAPPED TO CUSTOM`

HOME options always use ordinary action tone. Selected option is white. No HOME option/profile summary is cyan.

## Navigation

Four selections:

1. profile summary -> existing Mouse Options destination, to be replaced in-place by HOPE-10;
2. `SAVED DEVICES` -> current Saved Devices destination pending its gate;
3. `PAIR NEW MOUSE` -> accepted Pair New;
4. `LEARN THE KEYS` -> current instructional destination pending its gate.

- Up/Down wraps.
- Joy Press accesses.
- KEY X is displayed but inert until HOPE-28.
- Global KEY Y lock remains active when a Mouse is saved even though the hint is not printed.

## HOME resolver / disconnect

The established resolver remains:

- live Mouse -> transformed `BLU2USB_SCREEN_HOME` (home-connected);
- saved offline -> accepted `home-searching`;
- no saved Mouse -> accepted searching-first.

Normal saved reconnect and Pair New promotion therefore land on home-connected.

When the current Mouse disconnects while HOME is visible, UI immediately transitions to `home-searching`; accepted G06 saved reconnect behavior remains underneath.

## Bundled accepted post-HOPE-27 improvement

Per operator instruction, this candidate also changes only the accepted HOPE-27 title:

~~~text
MOUSE NOT FOUND HELP
~~~

The HOPE-27 body, final-row-only hint region, Any-Key Back behavior, Y Help ownership, and retry return behavior are unchanged.

## Changed files

- `include/blu2usb/ble_hogp/ble_hogp.h`
- `include/blu2usb/ux_model/ux_model.h`
- `src/app/main.c`
- `src/ble_hogp/ble_hogp_pico.c`
- `src/renderer/renderer.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_g02.c`
- `tests/test_g03_renderer.c`
- `tests/test_hope03_home_connected.c`
- `tests/test_hope03_home_connected_source.py`
- `tests/test_hope27_help_retry_pair_new.c`
- `tests/test_hope27_help_retry_pair_new_source.py`

## Automated verification

GitHub Actions run: `35831004718` — **SUCCESS**.

### host-architecture — SUCCESS

- inherited G02–G06 tests: PASS;
- all accepted HOPE regressions: PASS;
- HOPE-03 exact shell/title/profile/navigation tests: PASS;
- HOPE-03 source/runtime integration tests: PASS;
- accepted HOPE-27 title-improvement regression: PASS;
- architecture/screen-contract tests: PASS.

The tests freeze:

1. no parallel `HOME_CONNECTED` enum;
2. old HOME literal absent;
3. canonical HOME static rows;
4. exact name formatting examples;
5. all four profile summaries;
6. HOME never uses cyan status tone;
7. four-option navigation/order;
8. HOPE-28 X remains inert;
9. HOME resolver states;
10. real Device Name read after security and before HIDS;
11. best-effort name fallback;
12. separate Pair New candidate name until promotion;
13. disconnect HOME -> home-searching;
14. `MOUSE NOT FOUND HELP` title improvement.

### pico2-w-production — SUCCESS

- pinned ARM toolchain: PASS;
- pinned Pico SDK: PASS;
- Pico 2 W configure: PASS;
- Device Name/GATT + HIDS firmware build/link: PASS;
- UF2 verification: PASS;
- artifact upload: PASS.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10736409149`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: **330,127 bytes**
- ZIP digest: `sha256:a24c89a66752903bd602951424b57b812b50b02838adfac2e80d0bb296fabdef`

Extracted firmware:

- file: `HOPE-03-home-connected-pico2w.uf2`
- size: **896,000 bytes**
- SHA-256: `25dac527c1a5ba6061181350605a4d292cc83b6070c15daa5d05512714a88dd2`

## Gate state

HOPE-03 is **not ACCEPTED** until the operator validates this exact candidate on hardware.
