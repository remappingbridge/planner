# HOPE-02 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@4b0ebe933721895488a38f84c03f009c0d30cb32`
- branch: `hope/hope-02-first-mouse-connected`
- candidate commit: `e8b66a324ba74ab41a5538299accced28d1f2add`
- draft PR: `#3`
- PR must remain unmerged until operator physical acceptance.

## In-place replacement

The inherited G06 success slot `BLU2USB_SCREEN_MOUSE_SAVED` is now visually replaced by Mouse UI v1 `first-mouse-connected`.

There is no legacy success fallback. Product-source verification found no `MOUSE PAIRED` or `READY TO USE` copy in the changed product implementation.

Canonical screen:

~~~text
FIRST MOUSE CONNECTED
       JOY UP
  JOY    JOY    JOY
  LEFT  PRESS  RIGHT
      JOY DOWN
 KEY A         KEY X
 KEY B         KEY Y

 KEY Y: LOCK
~~~

## Flow integration

The accepted HOPE-01 READY transition now enters the replaced success slot instead of the inherited HOME.

The existing old Pair Mouse route also points at the same internal success slot and therefore cannot expose the removed G06 success visual.

## Observable behavior implemented

- black instructional body;
- dark-magenta hint field beginning at row 8;
- title magenta;
- instructional controls light gray at rest;
- exact Mouse UI v1 didactic geometry with 25px vertical advance;
- Joy/A/B/X press feedback only;
- B release is inert;
- Y becomes white while held and locks only on release;
- backlight-off behavior continues through the existing device loop;
- first complete HAT interaction while locked unlocks, is consumed and resolves to inherited HOME;
- no HOPE-08/03 HOME screen was introduced early.

## Minimal renderer change

The existing frame now distinguishes:

- `learn_background`: whether the complete screen background is dark magenta;
- `didactic_layout`: whether didactic 25px vertical text geometry is used.

This permits:

- HOPE-01 `searching-first`: didactic geometry + full magenta background;
- HOPE-02 `first-mouse-connected`: didactic geometry + black body / magenta hint.

No mouse-ui renderer module or external UI architecture was imported.

## Changed files

- `include/blu2usb/renderer/renderer.h`
- `src/app/main.c`
- `src/renderer/profile_feedback.c`
- `src/renderer/renderer.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_g06_profile_ui.c`
- `tests/test_hope02_first_mouse_connected.c`

The G06 UI regression was updated only where its old success-screen visual expectation was intentionally replaced by this gate.

## Automated verification

GitHub Actions run: `35817278498` — **SUCCESS**.

- `host-architecture`: **SUCCESS**
  - host configure: PASS
  - host build: PASS
  - G02–G06 regressions: PASS
  - HOPE-01 regression: PASS
  - HOPE-02 focused tests: PASS
  - architecture/screen-contract tests: PASS
- `pico2-w-production`: **SUCCESS**
  - pinned ARM toolchain: PASS
  - pinned Pico SDK: PASS
  - Pico 2 W configure: PASS
  - production build: PASS
  - UF2 verification: PASS
  - artifact upload: PASS

Focused tests prove:

1. exact 9-row screen;
2. black body + dark-magenta hint;
3. separator boundary at Y=203;
4. didactic text Y positions 8 / 39 / 64 ... / 214;
5. held feedback for all controls;
6. B inert;
7. Y lock-on-release;
8. unlock requires a complete interaction and is consumed;
9. unlock resolves HOME with selection reset;
10. legacy success copy absent from the replaced screen template.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10732161814`
- artifact name: `blu2usb-picow-production-pico2w`
- ZIP size: 323,927 bytes
- ZIP digest reported by GitHub: `sha256:869357a49a7e7d348d566f0179a3d6300461e6cc114cd573900aa2e49170656e`

Extracted firmware:

- file: `blu2usb_picow.uf2`
- size: **880,128 bytes**
- SHA-256: `348077b46a5b74a5df547f00cdac28df1bb32dd4aeb50df6fc2bcd1188276589`

## Gate state

HOPE-02 is **not ACCEPTED**.

It may be promoted only after the operator physically validates this exact candidate.
