# HOPE-28 — candidate

Status: **CANDIDATE READY / PHYSICAL ACCEPTANCE PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@95b8e6fab1710f562b7ce1ead629a9cca2734c17`
- branch: `hope/hope-28-help-home-connected`
- candidate commit: `8dacad0a34a78ec89e74454f1b6d09d71eae01ae`
- draft PR: `#13`
- PR remains unmerged until operator physical acceptance.

## Canonical screen

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

## Behavior implemented

- KEY X from accepted home-connected opens Help.
- Help has zero selectable options.
- Help owns KEY Y, so Y acts only as Any Key Back and never locks.
- every complete HAT interaction returns from Help and is consumed;
- normal return restores the HOME selection that was active before Help opened;
- entry/exit emits no pairing/remap command and does not alter current profile, saved devices, current Mouse, or Pair New state.

## Disconnect/reconnect while Help is open

Mouse UI v1 behavior is preserved:

- if the current Mouse disconnects while Help is visible, the Help remains visible;
- its return target is retargeted from HOME to accepted `home-searching`;
- Any Key Back after that disconnect returns to `SEARCHING SAVED MOUSE`, never stale home-connected;
- accepted G06 reconnect/search behavior continues underneath;
- if a saved Mouse reconnects before Help is dismissed, the return target is restored to live HOME so exiting Help cannot send a connected Mouse into stale searching UI.

## Rendering

- exact 9-row literal;
- body rows 0–7 are black;
- only row 8 `ANY KEY: BACK` is dark-magenta hint region;
- title is magenta;
- explanatory body is static yellow;
- no additional Help-specific renderer exception was required because the canonical body contains no control-prefixed line before row 8.

## Changed files

- `include/blu2usb/ux_model/ux_model.h`
- `src/app/main.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_hope03_home_connected.c`
- `tests/test_hope03_home_connected_source.py`
- `tests/test_hope28_help_home_connected.c`
- `tests/test_hope28_help_home_connected_source.py`

No BLE, remap, profile, storage, USB HID or pairing implementation file changed.

## Automated verification

Canonical Canonical GitHub Actions run: `35832917577` — **SUCCESS**.

### host-architecture — SUCCESS

All **31/31** tests pass, including:

- inherited G02–G06 tests;
- all accepted HOPE regressions;
- accepted HOPE-03 HOME regression evolved through the new Help;
- HOPE-28 exact literal/render test;
- HOPE-28 all-control Any-Key return semantics;
- KEY Y no-lock Help ownership;
- HOME selection preservation;
- disconnect return retargeting;
- source/runtime integration assertions;
- architecture/screen-contract tests.

The first CI attempt `35832105183` compiled successfully and had 30/31 runtime tests green; the single failure was an invalid textual assertion inside the newly written HOPE-28 source test. That assertion was removed without changing product behavior. The canonical final run above is fully green.

### pico2-w-production — SUCCESS

- pinned ARM toolchain: PASS;
- pinned Pico SDK: PASS;
- Pico 2 W configure/build: PASS;
- UF2 verification: PASS;
- artifact upload: PASS.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10737842468`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: **330,407 bytes**
- ZIP digest: `sha256:d1b15989d58cffadfae5209324ac9f698d7eb1af5ca5c49aae7d6971adfb98c4`

Extracted firmware:

- file: `HOPE-28-help-home-connected-current-v1-copy-pico2w.uf2`
- size: **896,512 bytes**
- SHA-256: `6f11f76d05249f6989106a5f8346dffea76873b0ddb32cff2776296c0dc8a807`

## Gate state

HOPE-28 is **not ACCEPTED** until the operator validates this exact candidate on hardware.


## Copy correction before physical acceptance

The first candidate used stale documentation copy. Current Mouse UI v1 executable source at `src/projector/screens.c@5f269e9625ae0d02a85b5d39eb87026edc448068` defines `help-home-connected` with the updated `REMOVE CONNECTED HELP` / numbered-step text.

The previous candidate `aa7c5ce7080793b83490aaf275d8cee7fb6878e6` and UF2 hash `1d8a5799...` remain invalidated. The replacement candidate above is the only physical-acceptance target.


## Final current-v1 source synchronization

The replacement candidate was validated against the executable Mouse UI v1 catalog, not the stale prose spec:

- `remappingbridge/mouse-ui`
- `src/projector/screens.c`
- ref `5f269e9625ae0d02a85b5d39eb87026edc448068`
- `MUI_SCREEN_HELP_HOME_CONNECTED`

Final literal:

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

The final CI run `35832917577` passed host/architecture and Pico 2 W.


## Full implemented-screen text audit

Before physical acceptance, all Mouse UI screens already introduced by the HOPE series were compared row-by-row against current Mouse UI v1 source, including blank-row positions.

Audit record:

- `hope/audits/2026-09-23-mouse-ui-v1-text-parity.md`
- Mouse UI v1: `release/ui-layout-v1.0@e8adad7919e931c92515bf655ef4050876a8e7a9`
- source blob: `src/projector/screens.c@0cecfd8e802047673cb6d2d4b866c11bd6137b45`

Result: no unintentional stale screen copy remains in candidate `8dacad0a34a78ec89e74454f1b6d09d71eae01ae`.

The only static text differences from Mouse UI v1 are the two explicit operator overrides already accepted:

- `NEW MOUSE NOT FOUND`;
- `MOUSE NOT FOUND HELP`.

The dynamic name/profile rows of home-connected are runtime implementations of the v1 example fields, not copy mismatches.
