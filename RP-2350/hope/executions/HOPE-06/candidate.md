# HOPE-06 — candidate

Status: **REWORK CANDIDATE READY / PHYSICAL RE-TEST PENDING**.

Date: 2026-09-23.

## Product candidate

- repository: `remappingbridge/remappingbridge`
- accepted base: `main@def2743022c3b522190eac06b97af0d4148348bd`
- branch: `hope/hope-06-pair-new`
- candidate commit: `6f4d8890a6011e679efb56bc098f81844632074a`
- draft PR: `#8`
- PR remains unmerged until operator physical acceptance.

## Canonical Pair New screen

~~~text
PAIR NEW MOUSE
TRYING TO CONNECT
A NEW MOUSE THAT
IS NOT LISTED
IN SAVED DEVICES

KEY B: CANCEL
KEY X: HELP
KEY Y: LOCK
~~~

The legacy Pair Mouse visual and its legacy Help screen were removed from this flow in-place.

## Pair New runtime

The existing G06 authoritative Mouse session remains unchanged while Pair New searches.

A bounded candidate session was added inside the existing BLE HOGP module with its own:

- BLE connection handle;
- HIDS CID;
- HID parser;
- candidate address;
- 15-second timer.

The candidate is not authoritative and its HID reports are discarded until promotion.

## Unsaved-only filtering

Pair New:

- ignores exact peers already present in the LE device database before connecting;
- treats candidate re-encryption as evidence that the peer is already saved and resumes the same Pair New window;
- requires a new pairing/bond plus Mouse descriptor qualification before handoff;
- rejects explicit non-Mouse HID appearance candidates;
- removes a newly-created candidate bond if candidate qualification fails or Pair New is canceled/times out before handoff.

## Atomic handoff

Only after the candidate completes security, HIDS connection, descriptor parsing and `parser_has_mouse` does handoff begin.

The BLE module then:

1. keeps the current session authoritative until candidate qualification is complete;
2. stops Pair New timing;
3. closes the old authoritative session if one exists;
4. promotes candidate handle/CID/parser/address into the existing authoritative G06 session;
5. publishes `PAIR_NEW_PROMOTED`.

The app handles `PAIR_NEW_PROMOTED` by releasing the existing Mouse and synthetic/remap HID aggregator sources before consuming input from the promoted session, preventing held button/Escape state from leaking across the handoff.

## Cancel / timeout

- Pair New timeout is exactly **15,000 ms**.
- cancel or timeout before promotion does not replace the current session;
- current Mouse continues to forward while candidate discovery/qualification is pending;
- if current Mouse is manually disconnected during Pair New, the product does not fabricate a replacement or start saved reconnect in the background;
- HOPE-07 owns the canonical retry screen, so HOPE-06 timeout stops Pair New while retaining the Pair New presentation.

## Controls

- KEY B: cancels Pair New; UI returns through the current HOME resolver;
- KEY X: visible but inert until HOPE-26;
- KEY Y: locks presentation; app cancels Pair New on lock;
- no legacy Pair Mouse retry/error action remains.

## Changed files

- `include/blu2usb/ble_hogp/ble_hogp.h`
- `include/blu2usb/ux_model/ux_model.h`
- `src/app/main.c`
- `src/ble_hogp/ble_hogp.c`
- `src/ble_hogp/ble_hogp_pico.c`
- `src/ux_model/ux_model.c`
- `tests/CMakeLists.txt`
- `tests/test_g03_renderer.c`
- `tests/test_g05_ble_mouse.c`
- `tests/test_g06_profile_ui.c`
- `tests/test_hope06_pair_new.c`
- `tests/test_hope06_pair_new_source.py`

## Automated verification

GitHub Actions run: `35822821677` — **SUCCESS**.

### host-architecture — SUCCESS

- inherited G02–G06 tests: PASS;
- accepted HOPE regressions: PASS;
- HOPE-06 Pair New UX test: PASS;
- HOPE-06 runtime source-invariant test: PASS;
- runtime event decode for STARTED/TIMEOUT/PROMOTED: PASS;
- architecture/screen-contract tests: PASS.

The source-invariant test explicitly freezes:

- 15-second timeout;
- separate candidate handle/CID/parser;
- saved-address filtering;
- candidate re-encryption handling;
- HIDS callback routing by CID;
- candidate HID report suppression;
- Mouse descriptor qualification before handoff;
- promotion into the authoritative G06 session;
- app-side HID source release during promotion;
- request/cancel hooks;
- absence of legacy Pair Mouse Help and legacy Pair Mouse visual copy.

### pico2-w-production — SUCCESS

- pinned ARM toolchain: PASS;
- pinned Pico SDK: PASS;
- Pico 2 W configure: PASS;
- production firmware build: PASS;
- UF2 verification: PASS;
- artifact upload: PASS.

This confirms that the BTstack APIs used for multi-HIDS CID routing and per-connection security routing compile against the pinned production Pico SDK.

## Candidate UF2

GitHub Actions artifact:

- artifact id: `10734160455`
- name: `blu2usb-picow-production-pico2w`
- ZIP size: **328,135 bytes**
- ZIP digest: `sha256:bd0f1301ea3e6c53a2d08980037f6e34f737f7bdbcca4e470a56ec41c0bd1a30`

Extracted firmware:

- file: `HOPE-06-pair-new-pico2w.uf2`
- size: **890,368 bytes**
- SHA-256: `e118c3e2bd17f60b9315d7159ae11fb4c052103ba723a55f60b0dfcd3d3b9f02`

## Gate state

HOPE-06 is **not ACCEPTED**.

The concurrent-current/candidate behavior, saved-candidate rejection and atomic handoff require the operator physical matrix below before PR #8 may be promoted.


## Rework after first physical failure

First physical candidate `6f4d8890a6011e679efb56bc098f81844632074a` failed because a new Mouse did not pair.

The failure was traced to the static BTstack pool configuration, not to the future Saved Devices UI:

~~~text
MAX_NR_GATT_CLIENTS 1
MAX_NR_HCI_CONNECTIONS 1
MAX_NR_HIDS_CLIENTS 1
~~~

This made the intended current+candidate Pair New runtime impossible on hardware even though the code compiled.

Corrected candidate:

- commit: `ac685b6d05de20706aa40c3c04591aab0639c98e`
- `MAX_NR_GATT_CLIENTS 2`
- `MAX_NR_HCI_CONNECTIONS 2`
- `MAX_NR_HIDS_CLIENTS 2`
- test now freezes all three values at 2
- GitHub Actions run: `35823937034` — **SUCCESS**
- host-architecture: **SUCCESS**
- Pico 2 W configure/build/UF2/upload: **SUCCESS**

Corrected artifact:

- artifact id: `10734381302`
- ZIP size: **328,135 bytes**
- ZIP digest: `sha256:d3af896dee6949a506cb6904c48eb79e0eafccb3de55f78aee98ebb08bc94e0b`
- UF2: `HOPE-06-pair-new-rework-pico2w.uf2`
- UF2 size: **890,368 bytes**
- UF2 SHA-256: `1fab62b23d68e28432a311b3f0bcddca9e9b3c320e90aca7222e3bbc2ebaab27`

`saved-devices` remains HOPE-04 and is not a prerequisite for Pair New classification: Pair New reads the LE device DB directly.
