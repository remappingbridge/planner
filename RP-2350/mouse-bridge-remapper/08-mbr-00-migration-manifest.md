# MBR-00 G06 migration manifest

Status: **FROZEN / INPUT TO MBR-01+**.

## Baseline

- Repository: `tiagooliveirajs/blu2usb`
- Accepted G06 source SHA: `7eee024ad4ee726c5a85ffa2f32b9f47187878af`
- Accepted UF2 SHA-256: `d32819b99ec349cc36882aaeaf9e84000a98dc3dcd86238ed364fd01301c8f88`
- Accepted source tree inspected at that exact SHA.
- Toolchain evidence inherited from G06 planning/validation: Pico SDK 2.2.0, ARM GCC 13.2.Rel1; mbr-01 must revalidate exact environment rather than assume installation state.

This is a behavior/reuse manifest, not permission to copy the tree wholesale.

Classification:

- `PORT/ADAPT` — implementation concepts/behavior are expected to be ported into MBR boundaries.
- `REUSE-REFERENCE` — use as evidence/tests/build pattern; do not copy blindly as product implementation.
- `EXCLUDE` — intentionally not carried into production MBR.

## Accepted G06 source areas observed

At accepted SHA, the source tree contains Mouse-relevant directories including:

- `src/app`
- `src/ble_hogp`
- `src/bt_runtime`
- `src/domain`
- `src/hat`
- `src/hid_aggregator`
- `src/interaction`
- `src/logitech_hidpp`
- `src/profiles`
- `src/remap`
- `src/renderer`
- `src/storage`
- corresponding headers under `include/blu2usb/...`
- USB/TinyUSB ownership and application integration present in the accepted G06 tree and build composition.

The accepted tree also contains authoritative supporting documents:

- `docs/product/00-product-contract.md`
- `docs/technical/00-architecture-contract.md`
- `docs/technical/01-build-and-toolchain.md`
- `docs/technical/02-g04-fixed-usb-validation.md`
- `docs/technical/03-g05-canonical-hid-validation.md`
- `docs/technical/04-g06-profiles-remap-hidpp-validation.md`
- `docs/ux/00-interaction-visual-contract.md`
- `docs/ux/01-screen-layouts.md`
- `.github/workflows/ci.yml`
- `ci/toolchain.env`
- `cmake/Blu2UsbModules.cmake`
- root `CMakeLists.txt`.

## PORT/ADAPT

| G06 area | MBR target concept | Required adaptation |
|---|---|---|
| `domain` | `domain` | Remove Keyboard/Composite product types; use MouseId/MouseSessionId and STANDARD vocabulary. |
| `ble_hogp` | `ble_hogp` | Preserve HOGP parsing/security/report-map behavior; enforce Mouse-only scope and authoritative/candidate handoff model. |
| `bt_runtime` | `bt_runtime` | Preserve single CYW43/BTstack lifecycle ownership and bounded behavior. |
| `hid_aggregator` | `output_state` | Preserve idempotent held ownership/backpressure/release safety, but remove cross-device generality not needed by one authoritative Mouse; retain same-Mouse multiple-source-to-one-target safety. |
| `profiles` | `profiles` | Preserve exact mappings/persistence semantics; rename canonical Default→Standard in new product vocabulary. |
| `remap` | `remap` | Preserve canonical mapping and synthetic Escape intent; bind only to authoritative Mouse state. |
| `logitech_hidpp` | `logitech_hidpp` | Preserve feature 0x1b04 / CID 0x0056 Forward true hold/release correction and generic fail-safe; current/candidate session scoped. |
| `storage` | `product_storage` | Preserve version/integrity/alternating generations and dirty Custom draft; new schema stores multiple saved Mouse records, not Keyboard/Composite state. |
| `interaction` | `interaction` | Preserve release-triggered actions, Help ownership and lock lessons; replace old screen hierarchy with frozen MBR control table. |
| `renderer` | `renderer` | Preserve ST7789 geometry/pixel relocation/colors; render frozen MBR screens/columns. |
| `hat` | `hat` | Preserve accepted Waveshare GPIO/active-low/debounce behavior. |
| USB/TinyUSB owner | `usb_hid` | Preserve fixed-from-boot/no-reenumeration structure; use MBR VID/PID/strings and Mouse + minimal Escape Keyboard interfaces. |
| `app` | `application` | Recompose around unified HOME resolver, bounded transactions and Pair New replacement handoff; do not copy old navigation/status orchestration. |

## REUSE-REFERENCE

Use these as validation/build/research evidence:

- G06/G05/G04 validation documents listed above;
- G06 UX contracts for physical pixel/color/release behavior;
- CMake/module composition patterns;
- `ci/toolchain.env` and build-toolchain documentation;
- CI workflow structure;
- accepted G06 physical acceptance records and PR #8 history;
- G01/G02/G03 historical corrections already summarized in `01-g06-migration-ledger.md`.

They are not authority to restore superseded user-visible text or old product hierarchy.

## EXCLUDE

Do not import into production MBR:

- Bluetooth Keyboard transport/input/product domain;
- Bluetooth Composite Mouse+Keyboard product domain;
- Keyboard/Composite saved/preferred/active registries;
- Pair Keyboard / Pair Composite / Other Devices screens;
- BLU2USB G07+ Classic Keyboard branches/runtime as implementation base;
- `classic_hid` / `keyboard_transport` concepts;
- old BLU2USB product strings/PID;
- old HOME/STATUS/OTHER DEVICES hierarchy where current MBR screen reference replaces it;
- simultaneous-authoritative-Mouse manager/aggregation/focus/capacity machinery;
- diagnostic CDC/debug product personality.

## MBR-specific NEW work rather than G06 port

These behaviors must be designed/implemented from the frozen MBR contract, not inferred from G06:

- multiple saved Mouse registry under one authoritative live slot;
- unified HOME resolver;
- 8-second saved-search policy;
- 15-second Pair New new-only search;
- non-authoritative replacement-candidate state;
- Pair New handoff that leaves current Mouse live until replacement-ready;
- exact new Pair New Help text and saved-reconnect instructions;
- STANDARD visible vocabulary;
- Saved Devices DISCONNECTED word/name policy;
- fixed MBR USB identity PID/strings;
- frozen new didactic coordinates/control semantics.

## Revalidation rule

Before porting a listed G06 area, the executing gate must inspect the exact source at accepted SHA again, identify exact files/declarations used, and record them in that gate completion report. This manifest is the classification boundary, not a substitute for gate-level source inspection.
